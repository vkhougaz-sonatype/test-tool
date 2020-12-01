#!/usr/bin/env bash

dir=$1
commit=$2
cmd=$3

function version() {
	echo 1
}

function applicable() {
	echo "true"
}

function run() {
	grep -rnP "^$BUG_PATTERN$" $dir \
	  | sed -E "s/$FILE_PATTERN/$SUB_EXPRESSION/g" \
		| sed '1s/^/[\n/; $!s/$/,/; $s/$/\n]/'
}

BUG_PATTERN="#bug:(.*?) - (.*)"
FILE_PATTERN="(.*?):([0-9]*):$BUG_PATTERN"
SUB_EXPRESSION='{"file": "\1","line": \2,"type": "\3","message": "\4"}'

if [[ "$cmd" = "run" ]] ; then
	run
fi
if [[ "$cmd" = "applicable" ]] ; then
	applicable
fi
if [[ "$cmd" = "version" ]] ; then
	version
fi

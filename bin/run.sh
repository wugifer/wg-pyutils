#!/bin/sh

ROOT=$(cd "$(dirname "$0")"; cd ..; pwd)

CMD=$1

shift
ALL=$*

function check()
{
	if [[ "${CMD}" ==  "$1" ]]; then
		false
	else
		echo "Available command: $1"
	fi
}

function do_docker()
{
	docker run -it --rm -v ${ROOT}:/src wg/python bash
}

function do_mypy()
{
	(cd ${ROOT}; mypy --ignore-missing-imports $1)
}

function do_test()
{
	(cd ${ROOT}; python ${ROOT}/test/main.py)
}

check 'docker' || do_docker
check 'mypy'   || do_mypy wg_pyutils/binary_mapping.py
check 'test'   || do_test

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48A994qTSoqj1H++NnWf5IY6Ae2lRkkIhkICavq4Hy30eyuQEqcZTm+awr9sHa5MfWbY5Kr
ARC-Seal: i=1; a=rsa-sha256; t=1524228992; cv=none;
        d=google.com; s=arc-20160816;
        b=UFzOzCK0gjQGhgxJShqKaAjWkQwOZiq40OZ2NYYwRJXORrPuoNVrp1h2ci4vagoLey
         Ho/VI7Wb1t1XHdSUGtp1fIZwAxTEUdGBSN+2nCzuwFnJQyHZ8F4c7C7Rjiz+VVO1DlDl
         QmFEWH4EVYn+wCJ9ingv5yo5bQ4lOTGo9wTDw6QCEe88Vt4JIuERdzU25DJi8n/f3cqj
         W0Q+E8ecV0mq1jaXXsKZfdnbIPilpPYKZwKN7S8rO/GH5r7EQ05JU2gqx/XEY/zR0j7/
         X0T2p6GP/bnhgz/GwIF3IQsow9zpOrLNWdusNHWtymGNLmDAps/8v96fNlQlycV+LLbS
         HSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=VdQFOwf/zdD95Sk6k/FcsTU5CjzUejNbqn4Jn5+szAg=;
        b=q1+6deZzCxyMe8h+bXnszg7wY6niOtsiGQSPS7XiuQfNrkoEQm4BiTDT0ueBwzJgEZ
         Kz/0kg8s1GR21WcbmWaV/sQGEp4gyjPeK+cmsp1Xz4xcM37TODkMQ+vU2hGAdidtCKDN
         Alq1m1X7ISLQtlAoUAO1sJJsv2OjAhMpLSwVGkYnybAIoAqMVWcTXu8nptDdCv3uYtHP
         04TWSU7/vqlumJsFKEbHssLFSoUtxTgcR6uHhvEk/Rt4R4AC+7L2BUs6i3QiZQ8h8u7u
         CO2FRltS/9ju+BtA2wEktxEYqqACGH3leolMq3USzsiIIfCIwqBGO5kTriPr4bbLFpuZ
         ExlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbeDTM4L (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 20 Apr 2018 08:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754786AbeDTM4H (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Apr 2018 08:56:07 -0400
Date: Fri, 20 Apr 2018 14:56:05 +0200
From: Libor Pechacek <lpechacek@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1598269939907137723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Joe,

I know I am late to the party, yet have some questions about the code.

On Thu 12-04-18 10:54:31, Joe Lawrence wrote:
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
[...]
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> new file mode 100644
> index 000000000000..7aaef80e9edb
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -0,0 +1,196 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> +
> +# Shell functions for the rest of the scripts.
> +
> +MAX_RETRIES=600
> +RETRY_INTERVAL=".1"	# seconds
> +
> +# die(msg) - game over, man
> +#	msg - dying words
> +function die() {
> +	echo "ERROR: $1" >&2
> +	exit 1
> +}
> +
> +# set_dynamic_debug() - setup kernel dynamic debug
> +#	TODO - push and pop this config?
> +function set_dynamic_debug() {
> +	cat << EOF > /sys/kernel/debug/dynamic_debug/control
> +file kernel/livepatch/* +p
> +func klp_try_switch_task -p
> +EOF
> +}
> +
> +# wait_for_transition(modname)
> +#	modname - livepatch module name
> +wait_for_transition() {
> +	local mod="$1"; shift

Why is the function waiting for a concrete module to finish the transition?
Wouldn't checking all modules, and therefore watching the global transition
state, be equally efficient without the need to provide module name?

> +
> +	# Wait for livepatch transition  ...
> +	local i=0
> +	while [[ $(cat /sys/kernel/livepatch/"$mod"/transition) != "0" ]]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to complete transition for module $mod"

FWIW, qa_test_klp tests dump blocking processes' stacks at this place for more
efficient information exchange between tester and developer.
(klp_dump_blocking_processes() in https://github.com/lpechacek/qa_test_klp,
file klp_tc_functions.sh)

> +		fi
> +		sleep $RETRY_INTERVAL
> +	done
> +}
> +
> +# load_mod(modname, params) - load a kernel module
> +#	modname - module name to load
> +#       params  - module parameters to pass to modprobe
> +function load_mod() {
> +	local mod="$1"; shift
> +	local args="$*"
> +
> +	local msg="% modprobe $mod $args"
> +	echo "${msg%% }" > /dev/kmsg
> +	ret=$(modprobe "$mod" "$args" 2>&1)
> +	if [[ "$ret" != "" ]]; then
> +		echo "$ret" > /dev/kmsg
> +		die "$ret"
> +	fi
> +
> +	# Wait for module in sysfs ...
> +	local i=0
> +	while [ ! -e /sys/module/"$mod" ]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to load module $mod"
> +		fi
> +		sleep $RETRY_INTERVAL
> +	done
> +
> +	# Wait for livepatch ...
> +	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
> +
> +		# Wait for livepatch in sysfs ...
> +		local i=0
> +		while [ ! -e /sys/kernel/livepatch/"$mod" ]; do

Hmmm! Good test! Never came to my mind...

> +			i=$((i+1))
> +			if [[ $i -eq $MAX_RETRIES ]]; then
> +				die "failed to load module $mod (sysfs)"
> +			fi
> +			sleep $RETRY_INTERVAL
> +		done
> +	fi
> +}
> +
> +# load_failing_mod(modname, params) - load a kernel module, expect to fail
> +#	modname - module name to load
> +#       params  - module parameters to pass to modprobe
> +function load_failing_mod() {
> +	local mod="$1"; shift
> +	local args="$*"
> +
> +	local msg="% modprobe $mod $args"
> +	echo "${msg%% }" > /dev/kmsg
> +	ret=$(modprobe "$mod" "$args" 2>&1)
> +	if [[ "$ret" == "" ]]; then
> +		echo "$mod unexpectedly loaded" > /dev/kmsg
> +		die "$mod unexpectedly loaded"

I'm wondering why is the same message being logged to kernel buffer and console
when in other cases it's written to console only.

> +	fi
> +	echo "$ret" > /dev/kmsg
> +}
> +
> +# unload_mod(modname) - unload a kernel module
> +#	modname - module name to unload
> +function unload_mod() {
> +	local mod="$1"
> +
> +	# Wait for module reference count to clear ...
> +	local i=0
> +	while [[ $(cat /sys/module/"$mod"/refcnt) != "0" ]]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to unload module $mod (refcnt)"
> +		fi
> +		sleep $RETRY_INTERVAL
> +	done

The repeating pattern of "while <some test>; do <count>; if <count beyond max
retries>; then <die>..." seems to ask for encapsulation.

> +
> +	echo "% rmmod $mod" > /dev/kmsg
> +	ret=$(rmmod "$mod" 2>&1)
> +	if [[ "$ret" != "" ]]; then
> +		echo "$ret" > /dev/kmsg
> +		die "$ret"

Similarly "echo <message> > /dev/kmsg; die <message>" is a repeating pattern.
How about introducing "klp_log_messsage()" or something like that?

> +	fi
> +
> +	# Wait for module in sysfs ...
> +	local i=0
> +	while [ -e /sys/module/"$mod" ]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to unload module $mod (/sys/module)"
> +		fi
> +		sleep $RETRY_INTERVAL
> +	done
> +
> +	# Wait for livepatch sysfs if applicable ...
> +	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
> +
> +		local i=0
> +		while [ -e /sys/kernel/livepatch/"$mod" ]; do
> +			i=$((i+1))
> +			if [[ $i -eq $MAX_RETRIES ]]; then
> +				die "failed to unload module $mod (/sys/livepatch)"
> +			fi
> +			sleep $RETRY_INTERVAL
> +		done
> +	fi
> +}
> +
> +# display_lp(modname) - disable a livepatch
     ^^^^^^^ typo

> +#	modname - module name to unload
> +function disable_lp() {
> +	local mod="$1"

   ^^^VVVV - mixed indentation with tabs and spaces. Intentional?
	     (same in set_pre_patch_ret and several other places)

> +
> +        echo "% echo 0 > /sys/kernel/livepatch/$mod/enabled" > /dev/kmsg
> +        echo 0 > /sys/kernel/livepatch/"$mod"/enabled

How about folding disable_lp functionality into module unload function? That
would save extra invocation of disable_lp in test scripts.

> +
> +	# Wait for livepatch enable to clear ...
> +	local i=0
> +	while [[ $(cat /sys/kernel/livepatch/"$mod"/enabled) != "0" ]]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to disable livepatch $mod"
> +		fi
> +		sleep $RETRY_INTERVAL
> +	done
> +}
> +
> +# set_pre_patch_ret(modname, pre_patch_ret)
> +#	modname - module name to set
> +#	pre_patch_ret - new pre_patch_ret value
> +function set_pre_patch_ret {

This function is used by single test in this patch set. Are there plans for
reuse in other tests?

> +	local mod="$1"; shift
> +        local ret="$1"
> +
> +        echo "% echo $1 > /sys/module/$mod/parameters/pre_patch_ret" > /dev/kmsg
> +        echo "$1" > /sys/module/"$mod"/parameters/pre_patch_ret
> +
> +	local i=0
> +	while [[ $(cat /sys/module/"$mod"/parameters/pre_patch_ret) != "$1" ]]; do
> +		i=$((i+1))
> +		if [[ $i -eq $MAX_RETRIES ]]; then
> +			die "failed to set pre_patch_ret parameter for $mod module"
> +		fi
> +		sleep $RETRY_INTERVAL
> +	done
> +}
> +
> +# filter_dmesg() - print a filtered dmesg
> +#	TODO - better filter, out of order msgs, etc?

      ^^^VVV - Mismatch between comment and function.

> +function check_result {
> +	local expect="$*"
> +	local result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
> +
> +	if [[ "$expect" == "$result" ]] ; then
> +		echo "ok"
> +	else
> +		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
> +		die "livepatch kselftest(s) failed"
> +	fi
> +}
> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> new file mode 100755
> index 000000000000..739d09bb3cff
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -0,0 +1,607 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> +
> +. functions.sh

This assumes functions.sh is in $CWD.

The rest looks good to me at the moment.

Thanks!

Libor

> +
> +MOD_LIVEPATCH=test_klp_callbacks_demo
> +MOD_LIVEPATCH2=test_klp_callbacks_demo2
> +MOD_TARGET=test_klp_callbacks_mod
> +MOD_TARGET_BUSY=test_klp_callbacks_busy
> +
> +set_dynamic_debug
> +
> +
> +# TEST: target module before livepatch
> +#
> +# Test a combination of loading a kernel module and a livepatch that
> +# patches a function in the first module.  Load the target module
> +# before the livepatch module.  Unload them in the same order.
> +#
> +# - On livepatch enable, before the livepatch transition starts,
> +#   pre-patch callbacks are executed for vmlinux and $MOD_TARGET (those
> +#   klp_objects currently loaded).  After klp_objects are patched
> +#   according to the klp_patch, their post-patch callbacks run and the
> +#   transition completes.
> +#
> +# - Similarly, on livepatch disable, pre-patch callbacks run before the
> +#   unpatching transition starts.  klp_objects are reverted, post-patch
> +#   callbacks execute and the transition completes.
> +
> +echo -n "TEST: target module before livepatch ... "
> +dmesg -C
> +
> +load_mod $MOD_TARGET
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH

wait_for_transition is not needed here and at other few places. disable_lp
waits for the transition to complete.

> +disable_lp $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +unload_mod $MOD_TARGET
> +
> +check_result "% modprobe $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit"
> +
> +
> +# TEST: module_coming notifier
> +#
> +# This test is similar to the previous test, but (un)load the livepatch
> +# module before the target kernel module.  This tests the livepatch
> +# core's module_coming handler.
> +#
> +# - On livepatch enable, only pre/post-patch callbacks are executed for
> +#   currently loaded klp_objects, in this case, vmlinux.
> +#
> +# - When a targeted module is subsequently loaded, only its
> +#   pre/post-patch callbacks are executed.
> +#
> +# - On livepatch disable, all currently loaded klp_objects' (vmlinux and
> +#   $MOD_TARGET) pre/post-unpatch callbacks are executed.
> +
> +echo -n "TEST: module_coming notifier ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +load_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +unload_mod $MOD_TARGET
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% modprobe $MOD_TARGET
> +livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit"
> +
> +
> +# TEST: module_going notifier
> +#
> +# Test loading the livepatch after a targeted kernel module, then unload
> +# the kernel module before disabling the livepatch.  This tests the
> +# livepatch core's module_going handler.
> +#
> +# - First load a target module, then the livepatch.
> +#
> +# - When a target module is unloaded, the livepatch is only reverted
> +#   from that klp_object ($MOD_TARGET).  As such, only its pre and
> +#   post-unpatch callbacks are executed when this occurs.
> +#
> +# - When the livepatch is disabled, pre and post-unpatch callbacks are
> +#   run for the remaining klp_object, vmlinux.
> +
> +echo -n "TEST: module_going notifier ... "
> +dmesg -C
> +
> +load_mod $MOD_TARGET
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: module_coming and module_going notifiers
> +#
> +# This test is similar to the previous test, however the livepatch is
> +# loaded first.  This tests the livepatch core's module_coming and
> +# module_going handlers.
> +#
> +# - First load the livepatch.
> +#
> +# - When a targeted kernel module is subsequently loaded, only its
> +#   pre/post-patch callbacks are executed.
> +#
> +# - When the target module is unloaded, the livepatch is only reverted
> +#   from the $MOD_TARGET klp_object.  As such, only pre and
> +#   post-unpatch callbacks are executed when this occurs.
> +
> +echo -n "TEST: module_coming and module_going notifiers ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +load_mod $MOD_TARGET
> +unload_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% modprobe $MOD_TARGET
> +livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: target module not present
> +#
> +# A simple test of loading a livepatch without one of its patch target
> +# klp_objects ever loaded ($MOD_TARGET).
> +#
> +# - Load the livepatch.
> +#
> +# - As expected, only pre/post-(un)patch handlers are executed for
> +#   vmlinux.
> +
> +echo -n "TEST: target module not present ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: pre-patch callback -ENODEV
> +#
> +# Test a scenario where a vmlinux pre-patch callback returns a non-zero
> +# status (ie, failure).
> +#
> +# - First load a target module.
> +#
> +# - Load the livepatch module, setting its 'pre_patch_ret' value to -19
> +#   (-ENODEV).  When its vmlinux pre-patch callback executes, this
> +#   status code will propagate back to the module-loading subsystem.
> +#   The result is that the insmod command refuses to load the livepatch
> +#   module.
> +
> +echo -n "TEST: pre-patch callback -ENODEV ... "
> +dmesg -C
> +
> +load_mod $MOD_TARGET
> +load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
> +unload_mod $MOD_TARGET
> +
> +check_result "% modprobe $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% modprobe $MOD_LIVEPATCH pre_patch_ret=-19
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> +livepatch: pre-patch callback failed for object '$MOD_TARGET'
> +livepatch: failed to enable patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit"
> +
> +
> +# TEST: module_coming + pre-patch callback -ENODEV
> +#
> +# Similar to the previous test, setup a livepatch such that its vmlinux
> +# pre-patch callback returns success.  However, when a targeted kernel
> +# module is later loaded, have the livepatch return a failing status
> +# code.
> +#
> +# - Load the livepatch, vmlinux pre-patch callback succeeds.
> +#
> +# - Set a trap so subsequent pre-patch callbacks to this livepatch will
> +#   return -ENODEV.
> +#
> +# - The livepatch pre-patch callback for subsequently loaded target
> +#   modules will return failure, so the module loader refuses to load
> +#   the kernel module.  No post-patch or pre/post-unpatch callbacks are
> +#   executed for this klp_object.
> +#
> +# - Pre/post-unpatch callbacks are run for the vmlinux klp_object.
> +
> +echo -n "TEST: module_coming + pre-patch callback -ENODEV ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +set_pre_patch_ret $MOD_LIVEPATCH -19
> +load_failing_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% echo -19 > /sys/module/$MOD_LIVEPATCH/parameters/pre_patch_ret
> +% modprobe $MOD_TARGET
> +livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +livepatch: pre-patch callback failed for object '$MOD_TARGET'
> +livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
> +modprobe: ERROR: could not insert '$MOD_TARGET': No such device
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: multiple target modules
> +#
> +# Test loading multiple targeted kernel modules.  This test-case is
> +# mainly for comparing with the next test-case.
> +#
> +# - Load a target "busy" kernel module which kicks off a worker function
> +#   that immediately exits.
> +#
> +# - Proceed with loading the livepatch and another ordinary target
> +#   module.  Post-patch callbacks are executed and the transition
> +#   completes quickly.
> +
> +echo -n "TEST: multiple target modules ... "
> +dmesg -C
> +
> +load_mod $MOD_TARGET_BUSY sleep_secs=0
> +# give $MOD_TARGET_BUSY::busymod_work_func() a chance to run
> +sleep 5
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +load_mod $MOD_TARGET
> +unload_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +unload_mod $MOD_TARGET_BUSY
> +
> +check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=0
> +$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
> +$MOD_TARGET_BUSY: busymod_work_func, sleeping 0 seconds ...
> +$MOD_TARGET_BUSY: busymod_work_func exit
> +% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% modprobe $MOD_TARGET
> +livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH
> +% rmmod $MOD_TARGET_BUSY
> +$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
> +
> +
> +
> +# TEST: busy target module
> +#
> +# A similar test as the previous one, but force the "busy" kernel module
> +# to do longer work.
> +#
> +# The livepatching core will refuse to patch a task that is currently
> +# executing a to-be-patched function -- the consistency model stalls the
> +# current patch transition until this safety-check is met.  Test a
> +# scenario where one of a livepatch's target klp_objects sits on such a
> +# function for a long time.  Meanwhile, load and unload other target
> +# kernel modules while the livepatch transition is in progress.
> +#
> +# - Load the "busy" kernel module, this time make it do 10 seconds worth
> +#   of work.
> +#
> +# - Meanwhile, the livepatch is loaded.  Notice that the patch
> +#   transition does not complete as the targeted "busy" module is
> +#   sitting on a to-be-patched function.
> +#
> +# - Load a second target module (this one is an ordinary idle kernel
> +#   module).  Note that *no* post-patch callbacks will be executed while
> +#   the livepatch is still in transition.
> +#
> +# - Request an unload of the simple kernel module.  The patch is still
> +#   transitioning, so its pre-unpatch callbacks are skipped.
> +#
> +# - Finally the livepatch is disabled.  Since none of the patch's
> +#   klp_object's post-patch callbacks executed, the remaining
> +#   klp_object's pre-unpatch callbacks are skipped.
> +
> +echo -n "TEST: busy target module ... "
> +dmesg -C
> +
> +load_mod $MOD_TARGET_BUSY sleep_secs=10
> +load_mod $MOD_LIVEPATCH
> +# Don't wait for transition, load $MOD_TARGET while the transition
> +# is still stalled in $MOD_TARGET_BUSY::busymod_work_func()
> +sleep 5
> +load_mod $MOD_TARGET
> +unload_mod $MOD_TARGET
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +unload_mod $MOD_TARGET_BUSY
> +
> +check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=10
> +$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
> +$MOD_TARGET_BUSY: busymod_work_func, sleeping 10 seconds ...
> +% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +% modprobe $MOD_TARGET
> +livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> +$MOD_TARGET: ${MOD_TARGET}_init
> +% rmmod $MOD_TARGET
> +$MOD_TARGET: ${MOD_TARGET}_exit
> +livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH
> +% rmmod $MOD_TARGET_BUSY
> +$MOD_TARGET_BUSY: busymod_work_func exit
> +$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
> +
> +
> +# TEST: multiple livepatches
> +#
> +# Test loading multiple livepatches.  This test-case is mainly for comparing
> +# with the next test-case.
> +#
> +# - Load and unload two livepatches, pre and post (un)patch callbacks
> +#   execute as each patch progresses through its (un)patching
> +#   transition.
> +
> +echo -n "TEST: multiple livepatches ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +load_mod $MOD_LIVEPATCH2
> +wait_for_transition $MOD_LIVEPATCH2
> +disable_lp $MOD_LIVEPATCH2
> +wait_for_transition $MOD_LIVEPATCH2
> +disable_lp $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH2
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% modprobe $MOD_LIVEPATCH2
> +livepatch: enabling patch '$MOD_LIVEPATCH2'
> +livepatch: '$MOD_LIVEPATCH2': initializing patching transition
> +$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': starting patching transition
> +livepatch: '$MOD_LIVEPATCH2': completing patching transition
> +$MOD_LIVEPATCH2: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
> +livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
> +$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
> +$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': unpatching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH2
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: atomic replace
> +#
> +# Load multiple livepatches, but the second as an 'atomic-replace'
> +# patch.  When the latter laods, the original livepatch should be
> +# disabled and *none* of its pre/post-unpatch callbacks executed.  On
> +# the other hand, when the atomic-replace livepatch is disabled, its
> +# pre/post-unpatch callbacks *should* be executed.
> +#
> +# - Load and unload two livepatches, the second of which has its
> +#   .replace flag set true.
> +#
> +# - Pre and post patch callbacks are executed for both livepatches.
> +#
> +# - Once the atomic replace module is loaded, only its pre and post
> +#   unpatch callbacks are executed.
> +
> +echo -n "TEST: atomic replace ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +load_mod $MOD_LIVEPATCH2 replace=1
> +wait_for_transition $MOD_LIVEPATCH2
> +disable_lp $MOD_LIVEPATCH2
> +wait_for_transition $MOD_LIVEPATCH2
> +unload_mod $MOD_LIVEPATCH2
> +unload_mod $MOD_LIVEPATCH
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% modprobe $MOD_LIVEPATCH2 replace=1
> +livepatch: enabling patch '$MOD_LIVEPATCH2'
> +livepatch: '$MOD_LIVEPATCH2': initializing patching transition
> +$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': starting patching transition
> +livepatch: '$MOD_LIVEPATCH2': completing patching transition
> +$MOD_LIVEPATCH2: post_patch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
> +livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
> +$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
> +$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
> +livepatch: '$MOD_LIVEPATCH2': unpatching complete
> +% rmmod $MOD_LIVEPATCH2
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +exit 0
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> new file mode 100755
> index 000000000000..3e4b8072da84
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -0,0 +1,173 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> +
> +. functions.sh
> +
> +MOD_LIVEPATCH=test_klp_livepatch
> +MOD_REPLACE=test_klp_atomic_replace
> +
> +set_dynamic_debug
> +
> +
> +# TEST: basic function patching
> +# - load a livepatch that modifies the output from /proc/cmdline and
> +#   verify correct behavior
> +# - unload the livepatch and make sure the patch was removed
> +
> +echo -n "TEST: basic function patching ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +
> +if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: multiple livepatches
> +# - load a livepatch that modifies the output from /proc/cmdline and
> +#   verify correct behavior
> +# - load another livepatch and verify that both livepatches are active
> +# - unload the second livepatch and verify that the first is still active
> +# - unload the first livepatch and verify none are active
> +
> +echo -n "TEST: multiple livepatches ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +load_mod $MOD_REPLACE replace=0
> +wait_for_transition $MOD_REPLACE
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +disable_lp $MOD_REPLACE
> +unload_mod $MOD_REPLACE
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_mod $MOD_LIVEPATCH
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +$MOD_LIVEPATCH: this has been live patched
> +% modprobe $MOD_REPLACE replace=0
> +livepatch: enabling patch '$MOD_REPLACE'
> +livepatch: '$MOD_REPLACE': initializing patching transition
> +livepatch: '$MOD_REPLACE': starting patching transition
> +livepatch: '$MOD_REPLACE': completing patching transition
> +livepatch: '$MOD_REPLACE': patching complete
> +$MOD_LIVEPATCH: this has been live patched
> +$MOD_REPLACE: this has been live patched
> +% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
> +livepatch: '$MOD_REPLACE': initializing unpatching transition
> +livepatch: '$MOD_REPLACE': starting unpatching transition
> +livepatch: '$MOD_REPLACE': completing unpatching transition
> +livepatch: '$MOD_REPLACE': unpatching complete
> +% rmmod $MOD_REPLACE
> +$MOD_LIVEPATCH: this has been live patched
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +
> +# TEST: atomic replace livepatch
> +# - load a livepatch that modifies the output from /proc/cmdline and
> +#   verify correct behavior
> +# - load an atomic replace livepatch and verify that only the second is active
> +# - remove the first livepatch and verify that the atomic replace livepatch
> +#   is still active
> +# - remove the atomic replace livepatch and verify that none are active
> +
> +echo -n "TEST: atomic replace livepatch ... "
> +dmesg -C
> +
> +load_mod $MOD_LIVEPATCH
> +wait_for_transition $MOD_LIVEPATCH
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +load_mod $MOD_REPLACE replace=1
> +wait_for_transition $MOD_REPLACE
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +unload_mod $MOD_LIVEPATCH
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +disable_lp $MOD_REPLACE
> +unload_mod $MOD_REPLACE
> +
> +grep 'live patched' /proc/cmdline > /dev/kmsg
> +grep 'live patched' /proc/meminfo > /dev/kmsg
> +
> +check_result "% modprobe $MOD_LIVEPATCH
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +$MOD_LIVEPATCH: this has been live patched
> +% modprobe $MOD_REPLACE replace=1
> +livepatch: enabling patch '$MOD_REPLACE'
> +livepatch: '$MOD_REPLACE': initializing patching transition
> +livepatch: '$MOD_REPLACE': starting patching transition
> +livepatch: '$MOD_REPLACE': completing patching transition
> +livepatch: '$MOD_REPLACE': patching complete
> +$MOD_REPLACE: this has been live patched
> +% rmmod $MOD_LIVEPATCH
> +$MOD_REPLACE: this has been live patched
> +% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
> +livepatch: '$MOD_REPLACE': initializing unpatching transition
> +livepatch: '$MOD_REPLACE': starting unpatching transition
> +livepatch: '$MOD_REPLACE': completing unpatching transition
> +livepatch: '$MOD_REPLACE': unpatching complete
> +% rmmod $MOD_REPLACE"
> +
> +
> +exit 0
> diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
> new file mode 100755
> index 000000000000..96390a21b15d
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> +
> +. functions.sh
> +
> +MOD_TEST=test_klp_shadow_vars
> +
> +set_dynamic_debug
> +
> +
> +# TEST: basic shadow variable API
> +# - load a module that exercises the shadow variable API
> +
> +echo -n "TEST: basic shadow variable API ... "
> +dmesg -C
> +
> +load_mod $MOD_TEST
> +unload_mod $MOD_TEST
> +
> +check_result "% modprobe $MOD_TEST
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
> +$MOD_TEST:   got expected NULL result
> +$MOD_TEST: shadow_ctor: PTR6 -> PTR1
> +$MOD_TEST: klp_shadow_alloc(obj=PTR5, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR1 = PTR6
> +$MOD_TEST: shadow_ctor: PTR8 -> PTR2
> +$MOD_TEST: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR2 = PTR8
> +$MOD_TEST: shadow_ctor: PTR10 -> PTR3
> +$MOD_TEST: klp_shadow_alloc(obj=PTR5, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR3 = PTR10
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR6
> +$MOD_TEST:   got expected PTR6 -> PTR1 result
> +$MOD_TEST: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
> +$MOD_TEST:   got expected PTR8 -> PTR2 result
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
> +$MOD_TEST:   got expected PTR10 -> PTR3 result
> +$MOD_TEST: shadow_ctor: PTR11 -> PTR4
> +$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
> +$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
> +$MOD_TEST:   got expected PTR11 -> PTR4 result
> +$MOD_TEST: shadow_dtor(obj=PTR5, shadow_data=PTR6)
> +$MOD_TEST: klp_shadow_free(obj=PTR5, id=0x1234, dtor=PTR13)
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
> +$MOD_TEST:   got expected NULL result
> +$MOD_TEST: shadow_dtor(obj=PTR9, shadow_data=PTR8)
> +$MOD_TEST: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR13)
> +$MOD_TEST: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
> +$MOD_TEST:   got expected NULL result
> +$MOD_TEST: shadow_dtor(obj=PTR12, shadow_data=PTR11)
> +$MOD_TEST: klp_shadow_free(obj=PTR12, id=0x1234, dtor=PTR13)
> +$MOD_TEST: klp_shadow_get(obj=PTR12, id=0x1234) = PTR0
> +$MOD_TEST:   got expected NULL result
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
> +$MOD_TEST:   got expected PTR10 -> PTR3 result
> +$MOD_TEST: shadow_dtor(obj=PTR5, shadow_data=PTR10)
> +$MOD_TEST: klp_shadow_free_all(id=0x1235, dtor=PTR13)
> +$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
> +$MOD_TEST:   shadow_get() got expected NULL result
> +% rmmod test_klp_shadow_vars"
> +
> +exit 0
> -- 
> 1.8.3.1
> 
> 

-- 
Libor Pechacek
SUSE Labs

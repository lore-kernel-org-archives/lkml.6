Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeCZSMG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:12:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751964AbeCZSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:12:05 -0400
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com>
 <1520881024-29386-1-git-send-email-joe.lawrence@redhat.com>
 <20180326105610.fzjfotkaljbuoa57@pathway.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <6b1c58e4-9dc3-36bd-1fb6-e136605d0c66@redhat.com>
Date: Mon, 26 Mar 2018 14:12:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180326105610.fzjfotkaljbuoa57@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 06:56 AM, Petr Mladek wrote:
> On Mon 2018-03-12 14:57:04, Joe Lawrence wrote:
>> Hi Petr,
>>
>> These are the callback tests that I hacked up into a livepatch
>> kselftest.  (Basically I copied a bunch of the sample modules and
>> verified the expected dmesg output as I had listed in in the
>> Documentation/livepatch/callbacks.txt file.)  The script is still a
>> little rough and maybe this isn't the direction we want to go for proper
>> kselftests, but perhaps it saves you some time/sanity for verifying this
>> patchset.
> 
> 
> 
>> Hope this helps,
>>
>> -- Joe
>>
>> -- >8 -- >8 -- >8 -- >8 --
>>
>> >From 0364430c53e12e21923bed20cb651374b4cf9ba9 Mon Sep 17 00:00:00 2001
>> From: Joe Lawrence <joe.lawrence@redhat.com>
>> Date: Tue, 6 Mar 2018 17:32:25 -0500
>> Subject: WIP - livepatch kselftest
>>
>> CONFIG_TEST_LIVEPATCH=m
>> % make -C tools/testing/selftests TARGETS=livepatch run_tests
>>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
>>  lib/Kconfig.debug                                |  11 +
>>  lib/Makefile                                     |   9 +
>>  lib/test_klp_callbacks_busy.c                    |  58 ++
>>  lib/test_klp_callbacks_demo.c                    | 205 +++++++
>>  lib/test_klp_callbacks_demo2.c                   | 149 +++++
>>  lib/test_klp_callbacks_mod.c                     |  39 ++
> 
> I would suggest to put it into lib/livepatch/ subdirectory. I hope
> that we will add more tests in the long term.

Good idea, we should encourage more tests in a livepatch/ subdir and not
clutter up the lib/ directory.

>> diff --git a/tools/testing/selftests/livepatch/livepatch-test b/tools/testing/selftests/livepatch/livepatch-test
>> new file mode 100755
>> index 000000000000..798317bf69f6
>> --- /dev/null
>> +++ b/tools/testing/selftests/livepatch/livepatch-test
> 
> s/livepatch-test/livepatch-test.sh/  ?
> 
> It seems to be common to add .sh suffix for bash script names.

I'll rename with the suffix.

>> @@ -0,0 +1,658 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
>> +
>> +MAX_RETRIES=30
>> +RETRY_INTERVAL=2	# seconds
>> +BETWEEN_TESTS=20	# seconds
> 
> These 20 seconds kept me in a tense (waiting for the final result)
> for a very long time ;-) Is there any particular reason for such
> a long delay?

It certainly builds suspense :)

> I wonder if we need a delay at all or if let's say 2 seconds might
> be enough.

I removed the delays completely and the tests ran successfully.   What
might be better than a between test delay would be some kind of
initial-condition verification, ie, make sure that the test starts/ends
with none of the livepatch test modules loaded.

For the test cases which load multiple livepatches, is there an easy way
to determine the patch stack order from userspace?  I think that would
be helpful when trying to remove all of them.

>> +echo -n "TEST1 ... "
>> +dmesg -C
>> +
>> +load_mod $MOD_TARGET
>> +load_mod $MOD_LIVEPATCH
>> +wait_for_transition $MOD_LIVEPATCH
>> +disable_lp $MOD_LIVEPATCH
>> +unload_mod $MOD_LIVEPATCH
>> +unload_mod $MOD_TARGET
>> +
>> +check_result "% modprobe $MOD_TARGET
>> +$MOD_TARGET: livepatch_callbacks_mod_init
>> +% modprobe $MOD_LIVEPATCH
>> +livepatch: enabling patch '$MOD_LIVEPATCH'
>> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
>> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
>> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
>> +livepatch: '$MOD_LIVEPATCH': starting patching transition
>> +livepatch: '$MOD_LIVEPATCH': completing patching transition
>> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
>> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
>> +livepatch: '$MOD_LIVEPATCH': patching complete
>> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
>> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
>> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
>> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
>> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
>> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
>> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
>> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
>> +livepatch: '$MOD_LIVEPATCH': unpatching complete
>> +% rmmod $MOD_LIVEPATCH
>> +% rmmod $MOD_TARGET
>> +$MOD_TARGET: livepatch_callbacks_mod_exit"
> 
> I was a bit surprised when seeing this way of checking results.
> But on the other hand, it looks pretty effective, especially for
> the callbacks. And the 3rd look, any patched function might write
> something into the log when called.

This was a quickly scripted version of what I was manually verifying
with the sample example livepatches.  I don't know if it will scale, but
it was pretty easy to add tests this way.

I wonder though if better dmesg filters will be required as the
livepatch core adds more debug msgs?

> I like it. Let's see how it works in the long term. But I am rather
> positive.
> 
> Thanks a lot for working on it.

Thanks for taking a look and running the tests.  I'll make some of your
suggested changes and send it up for a proper review soon.

-- Joe

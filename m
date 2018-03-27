Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeC0IWk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:22:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33839 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeC0IWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:22:38 -0400
Date: Tue, 27 Mar 2018 10:22:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
Message-ID: <20180327082235.eyujcqkcp4ccvkpk@pathway.suse.cz>
References: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com>
 <1520881024-29386-1-git-send-email-joe.lawrence@redhat.com>
 <20180326105610.fzjfotkaljbuoa57@pathway.suse.cz>
 <6b1c58e4-9dc3-36bd-1fb6-e136605d0c66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1c58e4-9dc3-36bd-1fb6-e136605d0c66@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-26 14:12:03, Joe Lawrence wrote:
> On 03/26/2018 06:56 AM, Petr Mladek wrote:
> > On Mon 2018-03-12 14:57:04, Joe Lawrence wrote:
> >> diff --git a/tools/testing/selftests/livepatch/livepatch-test b/tools/testing/selftests/livepatch/livepatch-test
> >> new file mode 100755
> >> index 000000000000..798317bf69f6
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/livepatch/livepatch-test
> >> @@ -0,0 +1,658 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> >> +
> >> +MAX_RETRIES=30
> >> +RETRY_INTERVAL=2	# seconds
> >> +BETWEEN_TESTS=20	# seconds
> > 
> > These 20 seconds kept me in a tense (waiting for the final result)
> > for a very long time ;-) Is there any particular reason for such
> > a long delay?
> 
> It certainly builds suspense :)
> 
> > I wonder if we need a delay at all or if let's say 2 seconds might
> > be enough.
> 
> I removed the delays completely and the tests ran successfully.   What
> might be better than a between test delay would be some kind of
> initial-condition verification, ie, make sure that the test starts/ends
> with none of the livepatch test modules loaded.

We could check is /sys/kernel/livepatch directory is empty.

Also we could run modinfo on all modules printed by lsmod
and check for the livepatch flag.


> For the test cases which load multiple livepatches, is there an easy way
> to determine the patch stack order from userspace?  I think that would
> be helpful when trying to remove all of them.

I am not aware about any easy way. Only the following hacks come
to my mind:

One possibility would be to use the creation time of the directories
under /sys/kernel/livepatch.

Or I wonder if the output from lsmod is sorted by the order in which
the modules were loaded.


> >> +echo -n "TEST1 ... "
> >> +dmesg -C
> >> +
> >> +load_mod $MOD_TARGET
> >> +load_mod $MOD_LIVEPATCH
> >> +wait_for_transition $MOD_LIVEPATCH
> >> +disable_lp $MOD_LIVEPATCH
> >> +unload_mod $MOD_LIVEPATCH
> >> +unload_mod $MOD_TARGET
> >> +
> >> +check_result "% modprobe $MOD_TARGET
> >> +$MOD_TARGET: livepatch_callbacks_mod_init
> >> +% modprobe $MOD_LIVEPATCH
> >> +livepatch: enabling patch '$MOD_LIVEPATCH'
> >> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> >> +$MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> >> +$MOD_LIVEPATCH: pre_patch_callback: vmlinux
> >> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> >> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> >> +$MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> >> +$MOD_LIVEPATCH: post_patch_callback: vmlinux
> >> +livepatch: '$MOD_LIVEPATCH': patching complete
> >> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> >> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> >> +$MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> >> +$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> >> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> >> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> >> +$MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
> >> +$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> >> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> >> +% rmmod $MOD_LIVEPATCH
> >> +% rmmod $MOD_TARGET
> >> +$MOD_TARGET: livepatch_callbacks_mod_exit"
> > 
> > I was a bit surprised when seeing this way of checking results.
> > But on the other hand, it looks pretty effective, especially for
> > the callbacks. And the 3rd look, any patched function might write
> > something into the log when called.
> 
> This was a quickly scripted version of what I was manually verifying
> with the sample example livepatches.  I don't know if it will scale, but
> it was pretty easy to add tests this way.
> 
> I wonder though if better dmesg filters will be required as the
> livepatch core adds more debug msgs?

Let's see. Most of the messages seem to be from the test modules
itself, so it should not be that bad.


> > I like it. Let's see how it works in the long term. But I am rather
> > positive.
> > 
> > Thanks a lot for working on it.
> 
> Thanks for taking a look and running the tests.  I'll make some of your
> suggested changes and send it up for a proper review soon.

Great.

Best Regards,
Petr

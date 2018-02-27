Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeB0Mgr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:36:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:49701 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeB0Mgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:36:45 -0500
Date: Tue, 27 Feb 2018 13:36:42 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 2/3] livepatch: update documentation/samples for
 callbacks
In-Reply-To: <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018, Joe Lawrence wrote:

> Update livepatch callback documentation and samples with respect to new
> atomic replace / cumulative patch functionality.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  Documentation/livepatch/callbacks.txt         | 102 ++++++++++++++++
>  samples/livepatch/Makefile                    |   1 +
>  samples/livepatch/livepatch-callbacks-demo2.c | 162 ++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 samples/livepatch/livepatch-callbacks-demo2.c
> 
> diff --git a/Documentation/livepatch/callbacks.txt b/Documentation/livepatch/callbacks.txt
> index c9776f48e458..b5e67975c5a9 100644
> --- a/Documentation/livepatch/callbacks.txt
> +++ b/Documentation/livepatch/callbacks.txt
> @@ -86,6 +86,13 @@ If the object did successfully patch, but the patch transition never
>  started for some reason (e.g., if another object failed to patch),
>  only the post-unpatch callback will be called.
>  
> +If a livepatch is replaced by a cumulative patch, then only the
> +callbacks belonging to the cumulative patch will be executed.  This
> +simplifies the livepatching core for it is the responsibility of the
> +cumulative patch to safely revert whatever needs to be reverted.  See
> +Documentation/livepatch/cumulative.txt for more information on such
> +patches.

s/cumulative/atomic replace/ almost everywhere?

'Documentation/livepatch/cumulative.txt' should be 
'Documentation/livepatch/cumulative-patches.txt' and we may rename it 
atomic-replace-patches.txt. I don't know. Cumulative patches forms a 
subset of atomic replace patches in my understanding. The feature itself 
is more general. Even if practically used for cumulative patches only. But 
it is for you and Petr to decide.

>  Example Use-cases
>  =================
> @@ -603,3 +610,98 @@ pre-unpatch callbacks are skipped:
>    % rmmod samples/livepatch/livepatch-callbacks-busymod.ko
>    [  141.279111] livepatch_callbacks_busymod: busymod_work_func exit
>    [  141.279760] livepatch_callbacks_busymod: livepatch_callbacks_mod_exit
> +
> +
> +Test 10
> +-------
> +
> +Test loading multiple livepatch modules containing callback routines.
> +The livepatching core executes callbacks for all modules.
> +
> +- load livepatch
> +- load second livepatch
> +- disable livepatch
> +- disable second livepatch
> +- unload livepatch
> +- unload second livepatch
> +
> +  % insmod samples/livepatch/livepatch-callbacks-demo.ko
> +  [  216.448208] livepatch: enabling patch 'livepatch_callbacks_demo'
> +  [  216.448211] livepatch: 'livepatch_callbacks_demo': initializing patching transition
> +  [  216.448330] livepatch_callbacks_demo: pre_patch_callback: vmlinux
> +  [  216.448341] livepatch: 'livepatch_callbacks_demo': starting patching transition
> +  [  218.720099] livepatch: 'livepatch_callbacks_demo': completing patching transition
> +  [  218.720179] livepatch_callbacks_demo: post_patch_callback: vmlinux
> +  [  218.720180] livepatch: 'livepatch_callbacks_demo': patching complete
> +
> +  % insmod samples/livepatch/livepatch-callbacks-demo2.ko
> +  [  220.126552] livepatch: enabling patch 'livepatch_callbacks_demo2'
> +  [  220.126554] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
> +  [  220.126592] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
> +  [  220.126593] livepatch: 'livepatch_callbacks_demo2': starting patching transition
> +  [  221.728091] livepatch: 'livepatch_callbacks_demo2': completing patching transition
> +  [  221.728254] livepatch_callbacks_demo2: post_patch_callback: vmlinux
> +  [  221.728255] livepatch: 'livepatch_callbacks_demo2': patching complete
> +
> +  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
> +  [  223.434556] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
> +  [  223.434616] livepatch_callbacks_demo2: pre_unpatch_callback: vmlinux
> +  [  223.434617] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
> +  [  224.736159] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
> +  [  224.736660] livepatch_callbacks_demo2: post_unpatch_callback: vmlinux
> +  [  224.736662] livepatch: 'livepatch_callbacks_demo2': unpatching complete
> +
> +  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
> +  [  227.284070] livepatch: 'livepatch_callbacks_demo': initializing unpatching transition
> +  [  227.284111] livepatch_callbacks_demo: pre_unpatch_callback: vmlinux
> +  [  227.284112] livepatch: 'livepatch_callbacks_demo': starting unpatching transition
> +  [  228.704142] livepatch: 'livepatch_callbacks_demo': completing unpatching transition
> +  [  228.704215] livepatch_callbacks_demo: post_unpatch_callback: vmlinux
> +  [  228.704216] livepatch: 'livepatch_callbacks_demo': unpatching complete
> +
> +  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
> +  % rmmod samples/livepatch/livepatch-callbacks-demo.ko
> +
> +
> +Test 11
> +-------
> +
> +A similar test as the previous one, except this time load the second
> +callback demo module as a cumulative (ie, replacement) patch.  The
> +livepatching core will only execute klp_object callbacks for the latest
> +cumulative patch on the patch stack.
> +
> +- load livepatch
> +- load second livepatch (atomic replace)
> +- disable livepatch

Not needed.

Miroslav

> +- disable second livepatch
> +- unload livepatch
> +- unload second livepatch
> +
> +  % insmod samples/livepatch/livepatch-callbacks-demo.ko
> +  [16435.711175] livepatch: enabling patch 'livepatch_callbacks_demo'
> +  [16435.711185] livepatch: 'livepatch_callbacks_demo': initializing patching transition
> +  [16435.711271] livepatch_callbacks_demo: pre_patch_callback: vmlinux
> +  [16435.711297] livepatch: 'livepatch_callbacks_demo': starting patching transition
> +  [16436.704092] livepatch: 'livepatch_callbacks_demo': completing patching transition
> +  [16436.704363] livepatch_callbacks_demo: post_patch_callback: vmlinux
> +  [16436.704364] livepatch: 'livepatch_callbacks_demo': patching complete
> +
> +  % insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=1
> +  [16442.760963] livepatch: enabling patch 'livepatch_callbacks_demo2'
> +  [16442.760966] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
> +  [16442.761018] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
> +  [16442.761018] livepatch: 'livepatch_callbacks_demo2': starting patching transition
> +  [16444.704092] livepatch: 'livepatch_callbacks_demo2': completing patching transition
> +  [16444.704181] livepatch_callbacks_demo2: post_patch_callback: vmlinux
> +  [16444.704181] livepatch: 'livepatch_callbacks_demo2': patching complete
> +
> +  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
> +  [16448.434672] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
> +  [16448.434712] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
> +  [16449.760134] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
> +  [16449.760338] livepatch: 'livepatch_callbacks_demo2': unpatching complete
> +  ** TODO ** where are the demo2 unpatch callbacks?
> +
> +  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
> +  % rmmod samples/livepatch/livepatch-callbacks-demo.ko

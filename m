Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeBWUkk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:40:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:44294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753426AbeBWUki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:40:38 -0500
Date: Fri, 23 Feb 2018 21:40:36 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/8] livepatch: Atomic replace and cumulative patches
 documentation
In-Reply-To: <a50b564b-e0c8-321f-cf90-8c001e52499b@redhat.com>
Message-ID: <alpine.LSU.2.21.1802232125070.26550@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <20180221132914.4809-9-pmladek@suse.com> <alpine.LSU.2.21.1802231139030.26550@pobox.suse.cz> <a50b564b-e0c8-321f-cf90-8c001e52499b@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018, Joe Lawrence wrote:

> On 02/23/2018 05:41 AM, Miroslav Benes wrote:
> > On Wed, 21 Feb 2018, Petr Mladek wrote:
> > 
> >> User documentation for the atomic replace feature. It makes it easier
> >> to maintain livepatches using so-called cumulative patches.
> >>
> >> Signed-off-by: Petr Mladek <pmladek@suse.com>
> > 
> > Acked-by: Miroslav Benes <mbenes@suse.cz>
> > 
> > Joe, are you planning to extend shadow vars documentation you mentioned 
> > before (v7), or do you want Petr to do it?
> 
> I created a sample cumulative patch for testing (I can post later),
> but I had a quick question regarding the callbacks...
> 
> >From v8 of the patch:
> 
>   + Only the (un)patching callbacks from the _new_ cumulative livepatch are
>     executed. Any callbacks from the replaced patches are ignored.
> 
> maybe I'm not testing this as intended, but I'm not seeing this
> behavior with the latest version of the patch.  See below.

No, you found a bug, I think. I didn't test callbacks and missed this 
during the review. 
 
> Test 2
> ======
> 
> Make the second livepatch a cumulative one:
> 
> diff -upr samples/livepatch/livepatch-callbacks-{demo.c,demo2.c}
> --- samples/livepatch/livepatch-callbacks-demo.c        2018-02-23 09:42:10.370223095 -0500
> +++ samples/livepatch/livepatch-callbacks-demo2.c       2018-02-23 11:16:20.557557153 -0500
> @@ -191,6 +191,7 @@ static struct klp_object objs[] = {
>  static struct klp_patch patch = {
>         .mod = THIS_MODULE,
>         .objs = objs,
> +       .replace = true,
>  };

The problem is that there are no new/patch functions defined for vmlinux 
and livepatch-callbacks-mod objects. There are only callbacks. Only 
livepatch-callbacks-busymod module has a replacement function. I'll focus 
on vmlinux only. 

No nop functions are added by klp_add_nops(). vmlinux object is empty. 
Then it is destroyed in 
klp_complete_transition()->klp_free_objects(klp_transition_patch, 
KLP_FUNC_NOP). In the end only livepatch-callbacks-busymod is preserved 
regardless the callbacks.

Had you load livepatch-callbacks-busymod module, its callback would be 
called.

Petr, we cannot free the "nop-only" objects if there is a callback defined 
there (an unpatch callback).
  
>  static int livepatch_callbacks_demo_init(void)
> 
> Load the two modules, disable and unload:
> 
>   % dmesg -C
>   % insmod samples/livepatch/livepatch-callbacks-demo.ko
>   % insmod samples/livepatch/livepatch-callbacks-demo2.ko
>   % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
>   % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
>   % rmmod samples/livepatch/livepatch-callbacks-demo.ko
> 
> Pre and post patch callbacks are called for both modules (expected), but
> *no* unpatch callbacks are executed:
> 
>   % dmesg
>   [ 5442.244332] livepatch: enabling patch 'livepatch_callbacks_demo'
>   [ 5442.244334] livepatch: 'livepatch_callbacks_demo': initializing patching transition
> > [ 5442.244372] livepatch_callbacks_demo: pre_patch_callback: vmlinux
>   [ 5442.244372] livepatch: 'livepatch_callbacks_demo': starting patching transition
>   [ 5444.704089] livepatch: 'livepatch_callbacks_demo': completing patching transition
> > [ 5444.704183] livepatch_callbacks_demo: post_patch_callback: vmlinux
>   [ 5444.704184] livepatch: 'livepatch_callbacks_demo': patching complete
>   [ 5448.567820] livepatch: enabling patch 'livepatch_callbacks_demo2'
>   [ 5448.567823] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
> > [ 5448.567860] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
>   [ 5448.567861] livepatch: 'livepatch_callbacks_demo2': starting patching transition
>   [ 5451.744131] livepatch: 'livepatch_callbacks_demo2': completing patching transition
> > [ 5451.744212] livepatch_callbacks_demo2: post_patch_callback: vmlinux
>   [ 5451.744213] livepatch: 'livepatch_callbacks_demo2': patching complete
>   [ 5455.002339] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
>   [ 5455.002378] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
>   [ 5456.736068] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
>   [ 5456.736132] livepatch: 'livepatch_callbacks_demo2': unpatching complete
> 
> 
> BTW, should we just add this test-case to the doc / samples?

Why not. I think we need to transform the samples into a testsuite or 
selftests, because their role has changed.

Thanks for the report. The atomic replace patch set has become a nightmare 
for me :). So many tiny corner cases everywhere and I'm not capable to 
hold every detail in my brain during the review.

Miroslav

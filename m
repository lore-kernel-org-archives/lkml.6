Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934314AbeCHPBz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:01:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:58761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756024AbeCHPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:01:53 -0500
Date: Thu, 8 Mar 2018 16:01:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
Message-ID: <20180308150150.guwwj2exrymugoeq@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <45877626-2d41-4af8-a8ff-5897585122ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45877626-2d41-4af8-a8ff-5897585122ad@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-03-07 16:55:53, Joe Lawrence wrote:
> On 03/07/2018 03:20 AM, Petr Mladek wrote:
> > The atomic replace allows to create cumulative patches. They
> > are useful when you maintain many livepatches and want to remove
> > one that is lower on the stack. In addition it is very useful when
> > more patches touch the same function and there are dependencies
> > between them.
> > 
> > 
> > Changes against v9:
> > 
> >   + Fixed check of valid NOPs for already loaded objects,
> >     regression introduced in v9 [Joe, Mirek]
> >   + Allow to replace even disabled patches [Evgenii]
> > 
> > Changes against v8:
> > 
> >   + Fixed handling of statically defined struct klp_object
> >     with empty array of functions [Joe, Mirek]
> >   + Removed redundant func->new_func assignment for NOPs [Mirek]
> >   + Improved some wording [Mirek]
> >
> > [ ... snip ... ]
> 
> Hi Petr,
> 
> I tried updating the test cases I was adding in "[PATCH v0 0/3]
> additional cumulative livepatch doc/samples" and although one of the
> cases is better than before, I'm running into a new issue:  an expected
> pre-unpatch callback is not executed (its obj->patched is false).
> 
> Here's the updated test case:
> 
> Test 11
> -------
> 
> - load livepatch
> - load second livepatch (atomic replace)     <- callbacks ok
> - disable second livepatch                   <- pre-unpatch skipped
> - unload livepatch
> - unload second livepatch
> 
>   % insmod samples/livepatch/livepatch-callbacks-demo.ko
>   [ 2306.806046] livepatch: enabling patch 'livepatch_callbacks_demo'
>   [ 2306.806048] livepatch: 'livepatch_callbacks_demo': initializing patching transition
>   [ 2306.806083] livepatch_callbacks_demo: pre_patch_callback: vmlinux
>   [ 2306.806083] livepatch: 'livepatch_callbacks_demo': starting patching transition
>   [ 2307.743170] livepatch: 'livepatch_callbacks_demo': completing patching transition
>   [ 2307.743317] livepatch_callbacks_demo: post_patch_callback: vmlinux
>   [ 2307.743319] livepatch: 'livepatch_callbacks_demo': patching complet
> 
>   % insmod samples/livepatch/livepatch-callbacks-demo2.ko replace=1
>   [ 2316.161804] livepatch: enabling patch 'livepatch_callbacks_demo2'
>   [ 2316.161807] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
>   [ 2316.161842] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
>   [ 2316.161843] livepatch: 'livepatch_callbacks_demo2': starting patching transition
>   [ 2317.727141] livepatch: 'livepatch_callbacks_demo2': completing patching transition
>   [ 2317.727254] livepatch_callbacks_demo2: post_patch_callback: vmlinux
>   [ 2317.727255] livepatch: 'livepatch_callbacks_demo2': patching complete
> 
>   % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
>   [ 2328.995854] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
>   [ 2328.995898] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
>   [ 2330.719234] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
>   [ 2330.719597] livepatch_callbacks_demo2: post_unpatch_callback: vmlinux
>   [ 2330.719599] livepatch: 'livepatch_callbacks_demo2': unpatching complete
> 
>   % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
>   % rmmod samples/livepatch/livepatch-callbacks-demo.ko
> 
> Running against v10, callbacks seem to be good up until I disable an
> atomic replace patch.  My understanding is that the original patch's
> unpatch callbacks should be skipped (as they were).  I was surprised to
> see that atomic replacement patch only ran it's post-unpatch callback.

Great catch!

I guess that it is caused by the heuristic used in
klp_unpatch_object() to decide whether the object is patched
or not.

We need to change the state only when manipulating the
statically defined functions.

Thanks a lot for so extensive testing!!!

Best Regards,
Petr

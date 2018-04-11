Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeDKORQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbeDKORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:17:14 -0400
Date: Wed, 11 Apr 2018 16:17:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180411141711.cwceg7o5ttjgebii@pathway.suse.cz>
References: <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
 <20180410174206.l3uk6lchhzxvn75x@treble>
 <alpine.LSU.2.21.1804110956430.28885@pobox.suse.cz>
 <20180411123214.mfpkbrirze32phrb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411123214.mfpkbrirze32phrb@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-11 07:32:14, Josh Poimboeuf wrote:
> On Wed, Apr 11, 2018 at 10:07:31AM +0200, Miroslav Benes wrote:
> > > > I was confused by wording "in the middle". It suggested that there
> > > > might had been enabled patches on the top and the bottom of the stack
> > > > and some disabled patches in between at the same time (or vice versa).
> > > > This was not true.
> > > 
> > > That *was* what I meant.  Consider the following sequence of events:
> > > 
> > > - Register patch 1
> > > - Enable patch 1
> > > - Register patch 2
> > > - Enable patch 2
> > > - Disable patch 2
> > > - Register patch 3
> > > - Enable patch 3
> > > 
> > > Notice that patch 2 (in the middle) is disabled, whereas patch 1 (on the
> > > bottom) and patch 3 (on the top) are enabled.
> > 
> > This should not be possible at all.
> > 
> > __klp_enable_patch:
> > 
> >         if (patch->list.prev != &klp_patches &&
> >             !list_prev_entry(patch, list)->enabled)
> >                 return -EBUSY;
> > 
> > When patch 3 is enabled, list_prev_entry() returns patch 2 and its 
> > ->enabled is false.
> 
> Hm, you're right.  I'm not sure how I got that idea...

It is great that we finally understand each other.

> I still agree with my original conclusion that enforcing stack order no
> longer makes sense though.

The question is what we will get if we remove the stack. Will it
really make the code easier and livepatching more safe?

First, note that stack is the main trick used by the ftrace handler.
It gets the patch from top of the stack and use the new_addr from
that patch.

If we remove the stack, we still need to handle 3 possibilities.
The handler will need to continue either with original_code,
old_patch or new_patch.

Now, just imagine the code. We will need variables orig_addr,
old_addr, new_addr or so which might be confusing. It will be
even more confusion if we do revert/disable. Also new_addr will
become old_addr if we install yet another patch.

We had exactly this in kGraft and it was a mess. I said "wow,
that is genius" when I saw the stack approach in the upstream
code proposal.


Second, unrelated patches must never patch the same functions.
Otherwise we would not be able to define which implementation
should be used. This is especially important when a patch is
removed and we need to fallback either to another patch or
original code. Yes, it makes perfect sense. But it needs code
that will check it, refuse loading the patch, ... It is not
complicated. But it is rather additional code than
simplification. I might make livepatching more safe
but probably not simplify the code.


> > > > Another possibility would be to get rid of the enable/disable states.
> > > > I mean that the patch will be automatically enabled during
> > > > registration and removed during unregistration.
> > > 
> > > I don't see how disabling during unregistration would be possible, since
> > > the unregister is called from the patch module exit function, which
> > > can only be called *after* the patch is disabled.
> > > 
> > > However, we could unregister immediately after disabling (i.e., in
> > > enabled_store context).
> > 
> > I think this is what Petr meant. So there would be nothing in the patch 
> > module exit function. Well, not exactly. We'd need to remove sysfs dir and 
> > maybe something more.
> 
> Sounds good to me, though aren't the livepatch sysfs entries removed by
> klp during unregister?

This is why I asked in my earlier mail if we need to keep sysfs
entries for unused patches. We could remove them when the patch
gets disabled (transition finishes). Then we do not need to
do anything in module_exit().

The patch module can be removed only when the transition is not
forced and we call module_put().

Best Regards,
Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPO6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:58:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57993 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeDPO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:58:14 -0400
Date: Mon, 16 Apr 2018 16:58:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180416145811.x4lvtm5kxyigbp56@pathway.suse.cz>
References: <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
 <20180410174206.l3uk6lchhzxvn75x@treble>
 <alpine.LSU.2.21.1804110956430.28885@pobox.suse.cz>
 <20180411123214.mfpkbrirze32phrb@treble>
 <20180411141711.cwceg7o5ttjgebii@pathway.suse.cz>
 <20180411154852.3yjab3ot76qicw6m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411154852.3yjab3ot76qicw6m@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-11 10:48:52, Josh Poimboeuf wrote:
> On Wed, Apr 11, 2018 at 04:17:11PM +0200, Petr Mladek wrote:
> > > I still agree with my original conclusion that enforcing stack order no
> > > longer makes sense though.
> > 
> > The question is what we will get if we remove the stack. Will it
> > really make the code easier and livepatching more safe?
> > 
> > First, note that stack is the main trick used by the ftrace handler.
> > It gets the patch from top of the stack and use the new_addr from
> > that patch.
> > 
> > If we remove the stack, we still need to handle 3 possibilities.
> > The handler will need to continue either with original_code,
> > old_patch or new_patch.
> > 
> > Now, just imagine the code. We will need variables orig_addr,
> > old_addr, new_addr or so which might be confusing. It will be
> > even more confusion if we do revert/disable. Also new_addr will
> > become old_addr if we install yet another patch.
> > 
> > We had exactly this in kGraft and it was a mess. I said "wow,
> > that is genius" when I saw the stack approach in the upstream
> > code proposal.
> 
> You're confusing the func stack with the patch stack.
>
> My proposal is to get rid of the patch stack.

The are related from my POV. The patches have the same ordering
in both patch and function stacks. The patch ordering is checked
when the patches are enabled and disabled.


> We can keep the func stack.  It will be needed anyway for the 'replace'
> case, where the stack may be of size 2.

OK, you want to keep the func stack because it is useful from the
implementation point of view.


> > Second, unrelated patches must never patch the same functions.
> > Otherwise we would not be able to define which implementation
> > should be used. This is especially important when a patch is
> > removed and we need to fallback either to another patch or
> > original code. Yes, it makes perfect sense. But it needs code
> > that will check it, refuse loading the patch, ... It is not
> > complicated. But it is rather additional code than
> > simplification. I might make livepatching more safe
> > but probably not simplify the code.
> 
> We don't need to enforce that.  The func stack can stay.  If somebody
> wants to patch the same function multiple times (without using
> 'replace'), that's inadvisable, but it's also their business.  They're
> responsible for the tooling to ensure the patch stack order is sane.


While it might make sense to ignore the patch stack (ordering) for
the enable operation. Do we really want to ignore it when disabling
a patch.

By other words, do we want to allow disabling a patch that is in
the middle of the stack, only partly in use? Does not this allow
some other crazy scenarios? Is it really the user business?
Will it make our life easier?

This will not happen if we refuse to load non-replace patches
that touch an already patches fucntion. Then the patch stack
might become only implementation detail. It will not define
the ordering any longer.


> > > > > > Another possibility would be to get rid of the enable/disable states.
> > > > > > I mean that the patch will be automatically enabled during
> > > > > > registration and removed during unregistration.
> > > > > 
> > > > > I don't see how disabling during unregistration would be possible, since
> > > > > the unregister is called from the patch module exit function, which
> > > > > can only be called *after* the patch is disabled.
> > > > > 
> > > > > However, we could unregister immediately after disabling (i.e., in
> > > > > enabled_store context).
> > > > 
> > > > I think this is what Petr meant. So there would be nothing in the patch 
> > > > module exit function. Well, not exactly. We'd need to remove sysfs dir and 
> > > > maybe something more.
> > > 
> > > Sounds good to me, though aren't the livepatch sysfs entries removed by
> > > klp during unregister?
> > 
> > This is why I asked in my earlier mail if we need to keep sysfs
> > entries for unused patches.
> 
> If they are permanently disabled then I think the sysfs entries should
> be removed.
> 
> > We could remove them when the patch gets disabled (transition
> > finishes). Then we do not need to do anything in module_exit().
> 
> Agreed, though what happens if the transition finishes while still
> running in the context of the write to the sysfs entry?  Can we remove a
> sysfs entry while executing code associated with it?

I would need to test it to be sure. But I believe that it will be
possible to remove sysfs entry from its own callback. All this code
heavily uses reference counters and callbacks called when the count
reaches zero.

OK. What about the following solution?

   + Enable patch directly from klp_register_patch()
   + Unregister the patch directly from klp_complete_transition()
     when the patch is disabled.
   + Put the module later when all sysfs entries are removed
     in klp_unregister_patch().

As a result:

   + module_init() will need to call only klp_register_patch()
   + module_exit() will do nothing
   + the module can be removed only when it is not longer needed


Some other ideas:

   + rename /sys/kernel/livepatch/<patch>/enable -> unregister
     allow to write into /sys/kernel/livepatch/<patch>/transition

     + echo 1 >unregistrer  to disable&unregister the patch
     + echo 0 >transition   to revert the running transition


The question is what to do with the stack of patches. It will have
no meaning for the enable operation because it will be done
automatically. But what about the disable/unregistrer operation?


Anyway, this looks like a revolution. Do we want to do all these
changes, including atomic replace, in a single patchset?

In each case, the atomic replace must be a pre-requisite. It will
become the only way to handle dependent patches.

Best Regards,
Petr

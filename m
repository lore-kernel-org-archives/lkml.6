Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCVPnU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:43:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52503 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeCVPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:43:13 -0400
Date: Thu, 22 Mar 2018 16:43:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 06/10] livepatch: Add atomic replace
Message-ID: <20180322154311.eosu7udehilywlfb@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-7-pmladek@suse.com>
 <20180313224804.hvqngflltznjtttw@treble>
 <20180320143501.j66vjipux2fedz5j@pathway.suse.cz>
 <20180320212619.3rb6lfbtrjkfe4id@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320212619.3rb6lfbtrjkfe4id@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-20 16:26:19, Josh Poimboeuf wrote:
> On Tue, Mar 20, 2018 at 03:35:01PM +0100, Petr Mladek wrote:
> > On Tue 2018-03-13 17:48:04, Josh Poimboeuf wrote:
> > > On Wed, Mar 07, 2018 at 09:20:35AM +0100, Petr Mladek wrote:
> > > > This patch adds a new "replace" flag to struct klp_patch. When it is
> > > > enabled, a set of 'nop' klp_func will be dynamically created for all
> > > > functions that are already being patched but that will no longer be
> > > > modified by the new patch. They are temporarily used as a new target
> > > > during the patch transition.
> > > > 
> > > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > > index fd0296859ff4..ad508a86b2f9 100644
> > > > --- a/kernel/livepatch/core.c
> > > > +++ b/kernel/livepatch/core.c
> > > > +static int klp_add_nops(struct klp_patch *patch)
> > > > +{
> > > > +	struct klp_patch *old_patch;
> > > > +	struct klp_object *old_obj;
> > > > +	int err = 0;
> > > > +
> > > > +	if (WARN_ON(!patch->replace))
> > > > +		return -EINVAL;
> > > 
> > > IMO, this is another one of those overly paranoid warnings that isn't
> > > really needed.  Why would we call klp_add_nops() for a non-replace
> > > patch?
> > 
> > Just to be sure. What is the difference, for example, against the following
> > checks in __klp_enable_patch() from your point of view, please?
> > 
> > 	if (klp_transition_patch)
> > 		return -EBUSY;
> > 
> > 	if (WARN_ON(patch->enabled))
> > 		return -EINVAL;
> > 
> > One difference is that klp_enable_patch() is exported symbol. One the
> > other hand, livepatch code developers could do mistakes as well.
> > Adding nops sounds like an innoncent operation after all ;-)
> 
> But klp_enable_patch() being an exported symbol is an important
> difference.  It catches a patch author abusing the interface.  Which is
> much more likely than one of us accidentally calling klp_add_nops().
> Have you not noticed how thorough our code reviews are? ;-)
> 
> Anyway, I suppose it's a harmless check and I don't feel very strongly
> about it, it just seems unnecessary.

I have removed the check.


> > > > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > > > index 6917100fbe79..d6af190865d2 100644
> > > > --- a/kernel/livepatch/transition.c
> > > > +++ b/kernel/livepatch/transition.c
> > > > @@ -87,6 +87,36 @@ static void klp_complete_transition(void)
> > > >  		 klp_transition_patch->mod->name,
> > > >  		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > > >  
> > > > +	/*
> > > > +	 * For replace patches, we disable all previous patches, and replace
> > > > +	 * the dynamic no-op functions by removing the ftrace hook.
> > > > +	 */
> > > > +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
> > > > +		/*
> > > > +		 * Make sure that no ftrace handler accesses any older patch
> > > > +		 * on the stack.  This might happen when the user forced the
> > > > +		 * transaction while some running tasks were still falling
> > > > +		 * back to the old code.  There might even still be ftrace
> > > > +		 * handlers that have not seen the last patch on the stack yet.
> > > > +		 *
> > > > +		 * It probably is not necessary because of the rcu-safe access.
> > > > +		 * But better be safe than sorry.
> > > > +		 */
> > > > +		if (klp_forced)
> > > > +			klp_synchronize_transition();
> > > 
> > > I don't like this.  Hopefully we can get just rid of it, if we also get
> > > rid of the concept of "throwing away" patches like I proposed.
> > 
> > What exactly you do not like about it, please?
> > 
> > It is not needed if all processes were migrated using the consistency
> > model, definitely.
> > 
> > If the transition has been forced then the barrier should be needed from
> > similar reasons as the barrier after klp_unpatch_objects() below.
> > We basically want to be sure what ftrace handlers see on the stack.
> > 
> > Will it help, when I remove the last paragraph where the formulation
> > is quite uncertain?
> 
> Well, the last paragraph doesn't inspire a lot of confidence ;-)  It
> sounds like voodoo.

Races are never easy area. You are right that I was not completely
confident and wanted to be on the safe side. Your questions helped
me to realize that the synchronization is not neeeded.


> Also the comment just seems very confusing to me:
> 
> - What specifically is it protecting against, e.g., _why_ should no
>   ftrace handler access any old patch on the stack, and when shouldn't
>   it do so?  Is the barrier needed before func->transition is cleared,
>   or what?

I was afraid of invalid memory accessed in klp_ftrace_handler().
I simply underestimated the power of RCU. I am not that familiar
with it. Also the following is a bit non-standard:

	func = list_entry_rcu(func->stack_node.next,
			      struct klp_func, stack_node);

Anyway, you made me to check it. All looks safe after all.

> - Does RCU make it safe, or doesn't it?  If yes, why is this needed?  If
>   no, why not?

Yes. I removed the synchronization. Instead, I explained the situation
in a comment above klp_discard_replaced_patches().


 
> > > > +
> > > > +		klp_throw_away_replaced_patches(klp_transition_patch,
> > > > +						klp_forced);
> > > > +
> > > > +		/*
> > > > +		 * There is no need to synchronize the transition after removing
> > > > +		 * nops. They must be the last on the func_stack. Ftrace
> > > > +		 * gurantees that nobody will stay in the trampoline after
> > > 
> > > "guarantees"
> > > 
> > > > +		 * the ftrace handler is unregistered.
> > > > +		 */
> > > > +		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
> > > > +	}
> > > > +
> > > >  	if (klp_target_state == KLP_UNPATCHED) {
> > > >  		/*
> > > >  		 * All tasks have transitioned to KLP_UNPATCHED so we can now
> > > > @@ -143,6 +173,15 @@ static void klp_complete_transition(void)
> > > >  	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
> > > >  		module_put(klp_transition_patch->mod);
> > > >  
> > > > +	/*
> > > > +	 * We do not need to wait until the objects are really freed.
> > > > +	 * The patch must be on the bottom of the stack. Therefore it
> > > > +	 * will never replace anything else. The only important thing
> > > > +	 * is that we wait when the patch is being unregistered.
> > > > +	 */
> > > > +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
> > > > +		klp_free_objects(klp_transition_patch, KLP_FUNC_NOP);
> > > > +
> > > 
> > > This makes me a bit nervous.  What happens if the patch is enabled, then
> > > disabled, then enabled again?  Then klp_free_objects() wouldn't do
> > > anything, because the ops would already be freed.
> > 
> > They are not necessary when all replaced patches are removed from
> > the stack. There will be no livepatch if this one gets disabled.
> 
> My point was that if you enable, then disable, then enable again,
> klp_free_objects() will get called again, and it will do nothing the
> second time around.

> Maybe that's safe in this instance, but in general, it's easy to forget
> the re-enable case when adding special cases for 'patch->replace'.

Yes, it is safe.


> I get the feeling that it would be safer to just clear 'patch->replace'
> after this step to avoid such scenarios.  After all, when re-enabling a
> 'replace' patch, it's no longer replacing anything (assuming here that a
> replace patch will permanently disable all previous patches).

I am not completely comfortable with touching item that is set by the
author of the patch. On the other hand, I do not see how it could
harm. I have just added the line to disable the flag.

Best Regards,
Petr

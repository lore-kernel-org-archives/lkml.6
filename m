Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCTOfO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:35:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:37098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeCTOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:35:05 -0400
Date: Tue, 20 Mar 2018 15:35:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 06/10] livepatch: Add atomic replace
Message-ID: <20180320143501.j66vjipux2fedz5j@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-7-pmladek@suse.com>
 <20180313224804.hvqngflltznjtttw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313224804.hvqngflltznjtttw@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-13 17:48:04, Josh Poimboeuf wrote:
> On Wed, Mar 07, 2018 at 09:20:35AM +0100, Petr Mladek wrote:
> > From: Jason Baron <jbaron@akamai.com>
> > 
> > Sometimes we would like to revert a particular fix. Currently, this
> > is not easy because we want to keep all other fixes active and we
> > could revert only the last applied patch.
> > 
> > One solution would be to apply new patch that implemented all
> > the reverted functions like in the original code. It would work
> > as expected but there will be unnecessary redirections. In addition,
> > it would also require knowing which functions need to be reverted at
> > build time.
> > 
> > Another problem is when there are many patches that touch the same
> > functions. There might be dependencies between patches that are
> > not enforced on the kernel side. Also it might be pretty hard to
> > actually prepare the patch and ensure compatibility with
> > the other patches.
> > 
> > A better solution would be to create cumulative patch and say that
> > it replaces all older ones.
> > 
> > This patch adds a new "replace" flag to struct klp_patch. When it is
> > enabled, a set of 'nop' klp_func will be dynamically created for all
> > functions that are already being patched but that will no longer be
> > modified by the new patch. They are temporarily used as a new target
> > during the patch transition.
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index fd0296859ff4..ad508a86b2f9 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > +static int klp_add_nops(struct klp_patch *patch)
> > +{
> > +	struct klp_patch *old_patch;
> > +	struct klp_object *old_obj;
> > +	int err = 0;
> > +
> > +	if (WARN_ON(!patch->replace))
> > +		return -EINVAL;
> 
> IMO, this is another one of those overly paranoid warnings that isn't
> really needed.  Why would we call klp_add_nops() for a non-replace
> patch?

Just to be sure. What is the difference, for example, against the following
checks in __klp_enable_patch() from your point of view, please?

	if (klp_transition_patch)
		return -EBUSY;

	if (WARN_ON(patch->enabled))
		return -EINVAL;

One difference is that klp_enable_patch() is exported symbol. One the
other hand, livepatch code developers could do mistakes as well.
Adding nops sounds like an innoncent operation after all ;-)


> > +	list_for_each_entry(old_patch, &klp_patches, list) {
> > +		klp_for_each_object(old_patch, old_obj) {
> > +			err = klp_add_object_nops(patch, old_obj);
> > +			if (err)
> > +				return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}

[...]

> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index 6917100fbe79..d6af190865d2 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -87,6 +87,36 @@ static void klp_complete_transition(void)
> >  		 klp_transition_patch->mod->name,
> >  		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> >  
> > +	/*
> > +	 * For replace patches, we disable all previous patches, and replace
> > +	 * the dynamic no-op functions by removing the ftrace hook.
> > +	 */
> > +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
> > +		/*
> > +		 * Make sure that no ftrace handler accesses any older patch
> > +		 * on the stack.  This might happen when the user forced the
> > +		 * transaction while some running tasks were still falling
> > +		 * back to the old code.  There might even still be ftrace
> > +		 * handlers that have not seen the last patch on the stack yet.
> > +		 *
> > +		 * It probably is not necessary because of the rcu-safe access.
> > +		 * But better be safe than sorry.
> > +		 */
> > +		if (klp_forced)
> > +			klp_synchronize_transition();
> 
> I don't like this.  Hopefully we can get just rid of it, if we also get
> rid of the concept of "throwing away" patches like I proposed.

What exactly you do not like about it, please?

It is not needed if all processes were migrated using the consistency
model, definitely.

If the transition has been forced then the barrier should be needed from
similar reasons as the barrier after klp_unpatch_objects() below.
We basically want to be sure what ftrace handlers see on the stack.

Will it help, when I remove the last paragraph where the formulation
is quite uncertain?


> > +
> > +		klp_throw_away_replaced_patches(klp_transition_patch,
> > +						klp_forced);
> > +
> > +		/*
> > +		 * There is no need to synchronize the transition after removing
> > +		 * nops. They must be the last on the func_stack. Ftrace
> > +		 * gurantees that nobody will stay in the trampoline after
> 
> "guarantees"
> 
> > +		 * the ftrace handler is unregistered.
> > +		 */
> > +		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
> > +	}
> > +
> >  	if (klp_target_state == KLP_UNPATCHED) {
> >  		/*
> >  		 * All tasks have transitioned to KLP_UNPATCHED so we can now
> > @@ -143,6 +173,15 @@ static void klp_complete_transition(void)
> >  	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
> >  		module_put(klp_transition_patch->mod);
> >  
> > +	/*
> > +	 * We do not need to wait until the objects are really freed.
> > +	 * The patch must be on the bottom of the stack. Therefore it
> > +	 * will never replace anything else. The only important thing
> > +	 * is that we wait when the patch is being unregistered.
> > +	 */
> > +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
> > +		klp_free_objects(klp_transition_patch, KLP_FUNC_NOP);
> > +
> 
> This makes me a bit nervous.  What happens if the patch is enabled, then
> disabled, then enabled again?  Then klp_free_objects() wouldn't do
> anything, because the ops would already be freed.

They are not necessary when all replaced patches are removed from
the stack. There will be no livepatch if this one gets disabled.


> Either way, I guess freeing the nops is optional here, since they would
> also get freed on patch unregister?

If we keep NOPs here, they will be necessary also by the next
cumulative patch. By other words, if we want to get rid of the ftrace
handler when it is not needed, we need to remove the NOPs as well.


> Anyway, all my points here would be moot if we made the nops more
> permanent and allowedd the 'replace' patch to be rolled back to the
> previous patch.

Yes, for v11, I moved all these changes to the followup patch
that removes the replaced patches.

Best Regards,
Petr

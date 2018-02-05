Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeBEOPz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:15:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:40917 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeBEOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:15:47 -0500
Date: Mon, 5 Feb 2018 15:15:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 6/6] livepatch: Add atomic replace
Message-ID: <20180205141544.owio5bulhv6debya@pathway.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com>
 <20180125160203.28959-7-pmladek@suse.com>
 <alpine.LSU.2.21.1802011423300.26656@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1802011423300.26656@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-01 14:49:24, Miroslav Benes wrote:
> 
> > -struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
> > +static struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
> >  						struct klp_object *old_obj)
> 
> A nit, but this change belongs to 3/6, doesn't it?
> 
> >  {
> >  	struct klp_object *obj;
> > @@ -708,6 +764,102 @@ struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
> >  	return obj;
> >  }
> 
> [...]
> 
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index 6917100fbe79..3f6cf5b9e048 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -87,6 +87,33 @@ static void klp_complete_transition(void)
> >  		 klp_transition_patch->mod->name,
> >  		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> >  
> > +	/*
> > +	 * For replace patches, we disable all previous patches, and replace
> > +	 * the dynamic no-op functions by removing the ftrace hook.
> > +	 */
> > +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
> > +		/*
> > +		 * Make sure klp_ftrace_handler() can no longer see functions
> > +		 * from the replaced patches.  Then all functions will be
> > +		 * redirected using klp_transition_patch.  They will use
> > +		 * either a new code or they will stay in the original code
> > +		 * because of the nop funcs' structures.
> > +		 */
> > +		if (klp_forced)
> > +			klp_synchronize_transition();
> 
> I'm not sure why this is here. klp_forced should not be so special that it 
> would warrant a synchronization. However, I'm also not sure that it would 
> be safe to remove it from the patch.
> 
> Is this because "force" is the only one who can clear TIF_PATCH_PENDING of 
> other tasks? So, there could be a task running in klp_ftrace_handler(), 
> its TIF_PATCH_PENDING is cleared by force and we could have a problem 
> because of that since we're throwing away replaced patches.

Yes. I was deep in the paranoid mode when I added this synchronization ;-)

A reckless user might force the transaction anytime. There might
be running tasks that are still falling back to an older patch.
In fact, there might even be ftrace handlers that have not seen
the new patch on the stack yet.

It still should be safe because of the rcu list access. But
better be safe than sorry. Then we do not to take care
about this and simply remove the old patches in
klp_throw_away_replaced_patches().


> Ok, that sounds viable. I'd welcome a comment on that in the code.

I am going to use the following comment in v7:

		/*
		 * Make sure that no ftrace handler accesses any older patch
		 * on the stack.  This might happen when the user forced the
		 * transaction while some running tasks were still falling
		 * back to the old code.  There might even still be ftrace
		 * handlers that have not seen the last patch on the stack yet.
		 *
		 * It probably is not necessary because of the rcu-safe access.
		 * But better be safe than sorry.
		 */
		if (klp_forced)
			klp_synchronize_transition();
> > +
> > +		klp_throw_away_replaced_patches(klp_transition_patch,
> > +						klp_forced);
> > +
> > +		/*
> > +		 * There is no need to synchronize the transition after removing
> > +		 * nops. They must be the last on the func_stack. Ftrace
> > +		 * gurantees that nobody will stay in the trampoline after
> > +		 * the ftrace handler is unregistered.
> > +		 */
> > +		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
> > +	}
> > +

Best Regards,
Petr

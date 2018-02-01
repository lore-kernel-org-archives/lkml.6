Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeBANtb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:49:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeBANt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:49:26 -0500
Date: Thu, 1 Feb 2018 14:49:24 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 6/6] livepatch: Add atomic replace
In-Reply-To: <20180125160203.28959-7-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802011423300.26656@pobox.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com> <20180125160203.28959-7-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
> +static struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
>  						struct klp_object *old_obj)

A nit, but this change belongs to 3/6, doesn't it?

>  {
>  	struct klp_object *obj;
> @@ -708,6 +764,102 @@ struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
>  	return obj;
>  }

[...]

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 6917100fbe79..3f6cf5b9e048 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -87,6 +87,33 @@ static void klp_complete_transition(void)
>  		 klp_transition_patch->mod->name,
>  		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
>  
> +	/*
> +	 * For replace patches, we disable all previous patches, and replace
> +	 * the dynamic no-op functions by removing the ftrace hook.
> +	 */
> +	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
> +		/*
> +		 * Make sure klp_ftrace_handler() can no longer see functions
> +		 * from the replaced patches.  Then all functions will be
> +		 * redirected using klp_transition_patch.  They will use
> +		 * either a new code or they will stay in the original code
> +		 * because of the nop funcs' structures.
> +		 */
> +		if (klp_forced)
> +			klp_synchronize_transition();

I'm not sure why this is here. klp_forced should not be so special that it 
would warrant a synchronization. However, I'm also not sure that it would 
be safe to remove it from the patch.

Is this because "force" is the only one who can clear TIF_PATCH_PENDING of 
other tasks? So, there could be a task running in klp_ftrace_handler(), 
its TIF_PATCH_PENDING is cleared by force and we could have a problem 
because of that since we're throwing away replaced patches.

Ok, that sounds viable. I'd welcome a comment on that in the code.

Thanks,
Miroslav

> +
> +		klp_throw_away_replaced_patches(klp_transition_patch,
> +						klp_forced);
> +
> +		/*
> +		 * There is no need to synchronize the transition after removing
> +		 * nops. They must be the last on the func_stack. Ftrace
> +		 * gurantees that nobody will stay in the trampoline after
> +		 * the ftrace handler is unregistered.
> +		 */
> +		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
> +	}
> +
>  	if (klp_target_state == KLP_UNPATCHED) {
>  		/*
>  		 * All tasks have transitioned to KLP_UNPATCHED so we can now

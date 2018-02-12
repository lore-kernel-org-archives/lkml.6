Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964931AbeBLQ3G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:29:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:52173 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964886AbeBLQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:29:04 -0500
Date: Mon, 12 Feb 2018 16:54:35 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] livepatch: Add atomic replace
In-Reply-To: <20180206103424.10829-7-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802121428000.28621@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com> <20180206103424.10829-7-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> Sometimes we would like to revert a particular fix. Currently, this
> is not easy because we want to keep all other fixes active and we
> could revert only the last applied patch.
> 
> One solution would be to apply new patch that implemented all
> the reverted functions like in the original code. It would work
> as expected but there will be unnecessary redirections. In addition,
> it would also require knowing which functions need to be reverted at
> build time.
> 
> Another problem is when there are many patches that touch the same
> functions. There might be dependencies between patches that are
> not enforced on the kernel side. Also it might be pretty hard to
> actually prepare the patch and ensure compatibility with
> the other patches.
> 
> A better solution would be to create cumulative patch and say that
> it replaces all older ones.
> 
> This patch adds a new "replace" flag to struct klp_patch. When it is
> enabled, a set of 'nop' klp_func will be dynamically created for all
> functions that are already being patched but that will not longer be
> modified by the new patch. They are temporarily used as a new target
> during the patch transition.
> 
> There are used several simplifications:
> 
>   + nops' structures are generated already when the patch is registered.
>     All registered patches are taken into account, even the disabled ones.
>     As a result, there might be more nops than are really needed when
>     the patch is enabled and some disabled patches were removed before.
>     But we are on the safe side and it simplifies the implementation.
>     Especially we could reuse the existing init() functions. Also freeing
>     is easier because the same nops are created and removed only once.
> 
>     Alternative solution would be to create nops when the patch is enabled.
>     But then we would need to complicated to reuse the init() functions

I cannot parse this.

>     and error paths. It would increase the risk of errors because of
>     late kobject initialization. It would need tricky waiting for
>     freed kobjects when finalizing a reverted enable transaction.
> 
>   + The replaced patches are removed from the stack and cannot longer
>     be enabled directly. Otherwise, we would need to implement a more
>     complex logic of handling the stack of patches. It might be hard
>     to come with a reasonable semantic.
> 
>     A fallback is to remove (rmmod) the replaced patches and register
>     (insmod) them again.
> 
>   + Nops are handled like normal function patches. It reduces changes
>     in the existing code.
> 
>     It would be possible to copy internal values when they are allocated
>     and make short cuts in init() functions. It would be possible to use
>     the fact that old_func and new_func point to the same function and
>     do not init new_func and new_size at all. It would be possible to
>     detect nop func in ftrace handler and just leave. But all these would
>     just complicate the code and maintenance.
> 
>   + The callbacks from the replaced patches are not called. It would be
>     pretty hard to define a reasonable semantic and implement it.
> 
>     It might even be counter-productive. The new patch is cumulative.
>     It is supposed to include most of the changes from older patches.
>     In most cases, it will not want to call pre_unpatch() post_unpatch()
>     callbacks from the replaced patches. It would disable/break things
>     for no good reasons. Also it should be easier to handle various
>     scenarios in a single script in the new patch than think about
>     interactions caused by running many scripts from older patches.
>     No to say that the old scripts even would not expect to be called
>     in this situation.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Split, reuse existing code, simplified]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Petr Mladek <pmladek@suse.com>

[...]

> +/*
> + * This function removes replaced patches from both func_stack
> + * and klp_patches stack.
> + *
> + * We could be pretty aggressive here. It is called in situation
> + * when these structures are not longer accessible. All functions

...are no longer... :)

> + * are redirected using the klp_transition_patch. They use either
> + * a new code or they in the original code because of the special

...or they are... ?

> + * nop function patches.
> + */

[...]

> +static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
> +					   struct klp_object *obj)
> +{
> +	struct klp_func *func;
> +
> +	func = kzalloc(sizeof(*func), GFP_KERNEL);
> +	if (!func)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (old_func->old_name) {
> +		func->old_name = kstrdup(old_func->old_name, GFP_KERNEL);
> +		if (!func->old_name) {
> +			kfree(func);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +	func->old_sympos = old_func->old_sympos;
> +	/* NOP func is the same as using the original implementation. */
> +	func->new_func = (void *)old_func->old_addr;
> +	func->ftype = KLP_FUNC_NOP;
> +
> +	return func;
> +}
> +
> +static int klp_add_func_nop(struct klp_object *obj,
> +			    struct klp_func *old_func)
> +{
> +	struct klp_func *func;
> +
> +	func = klp_find_func(obj, old_func);
> +
> +	if (func)
> +		return 0;
> +
> +	func = klp_alloc_func_nop(old_func, obj);
> +	if (IS_ERR(func))
> +		return PTR_ERR(func);
> +
> +	klp_init_func_list(obj, func);
> +
> +	return 0;
> +}
> +
> +static int klp_add_object_nops(struct klp_patch *patch,
> +			       struct klp_object *old_obj)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *old_func;
> +	int err = 0;
> +
> +	obj = klp_get_or_add_object(patch, old_obj);
> +	if (IS_ERR(obj))
> +		return PTR_ERR(obj);
> +
> +	klp_for_each_func(old_obj, old_func) {
> +		err = klp_add_func_nop(obj, old_func);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Add 'nop' functions which simply return to the caller to run
> + * the original function. The 'nop' functions are added to a
> + * patch to facilitate a 'replace' mode
> + *
> + * The nops are generated for all patches on the stack when
> + * the new patch is initialized. It is safe even though some
> + * older patches might get disabled and removed before the
> + * new one is enabled. In the worst case, there might be nops
> + * there will not be really needed. But it does not harm and

s/there/which/ ?

> + * simplifies the implementation a lot. Especially we could
> + * use the init functions as is.
> + */
> +static int klp_add_nops(struct klp_patch *patch)
> +{
> +	struct klp_patch *old_patch;
> +	struct klp_object *old_obj;
> +	int err = 0;
> +
> +	if (WARN_ON(!patch->replace))
> +		return -EINVAL;
> +
> +	list_for_each_entry(old_patch, &klp_patches, list) {
> +		klp_for_each_object(old_patch, old_obj) {
> +			err = klp_add_object_nops(patch, old_obj);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}

So again only nits. Otherwise I think the patch does what is supposed to.

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav

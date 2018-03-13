Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeCMWqV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeCMWqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:46:16 -0400
Date: Tue, 13 Mar 2018 17:46:13 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180313224613.sdkdkcvhpqv54s6c@treble>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307082039.10196-6-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:20:34AM +0100, Petr Mladek wrote:
> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> 
> The replaced patches will stay registered because they are typically
> unregistered by some package uninstall scripts. But we will remove
> these patches from @klp_patches list to keep the enabled patch
> on the bottom of the stack. Otherwise, we would need to implement
> rather complex logic for moving the patches on the stack. Also
> it would complicate implementation of the atomic replace feature.
> It is not worth it.
> 
> As a result, we will have patches that are registered but that
> are no longer usable. Let's get prepared for this and use
> a better descriptive name for klp_is_patch_registered() function.
> 
> Also create separate list for the replaced patches and allow to
> unregister them. Alternative solution would be to add a flag
> into struct klp_patch. Note that patch->kobj.state_initialized
> is not safe because it can be cleared outside klp_mutex.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Split and renamed klp_is_patch_usable()]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  kernel/livepatch/core.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index ab1f6a371fc8..fd0296859ff4 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -47,6 +47,13 @@ DEFINE_MUTEX(klp_mutex);
>  
>  static LIST_HEAD(klp_patches);
>  
> +/*
> + * List of 'replaced' patches that have been replaced by a patch that has the
> + * 'replace' bit set. When they are added to this list, they are disabled and
> + * can not be re-enabled, but they can be unregistered().
> + */
> +static LIST_HEAD(klp_replaced_patches);

Can someone remind me why we're permanently disabling replaced patches?
I seem to remember being involved in that decision, but at least with
this latest version of the patches, it seems like it would be simpler to
just let 'replace' patches be rolled back to the previous state when
they're unpatched.  Then we don't need two lists of patches, the nops
can become more permanent, the replaced patches remain "enabled" but
inert, and the unpatching behavior is less surprising to the user, more
like a normal rollback.

Along those lines, I'd also propose that we constrain our existing patch
stacking even further.  Right now we allow a new patch to be registered
on top of a disabled patch, though we don't allow the new patch to be
enabled until the previous patch gets enabled.  I'd propose we no longer
allow that condition.  We should instead enforce that all existing
patches are *enabled* before allowing a new patch to be registered on
top.  That way the patch stacking is even more sane, and there are less
"unusual" conditions to worry about.  We have enough of those already.
Each additional bit of flexibility has a maintenance cost, and this one
isn't worth it IMO.

The downside of the above proposals is that now you can't remove an old
patch after it's been replaced, but IMO that's a small price to pay for
code sanity.  Every additional bit of flexibility has a maintenance
cost, and this one isn't worth it IMO.  Just force the user to leave the
old inert patches loaded.  They shouldn't take up much memory anyway,
and they might come in handy should a revert be needed.

> +
>  static struct kobject *klp_root_kobj;
>  
>  static void klp_init_func_list(struct klp_object *obj, struct klp_func *func)
> @@ -108,17 +115,28 @@ static void klp_find_object_module(struct klp_object *obj)
>  	mutex_unlock(&module_mutex);
>  }
>  
> -static bool klp_is_patch_registered(struct klp_patch *patch)
> +static bool klp_is_patch_in_list(struct klp_patch *patch,
> +				 struct list_head *head)
>  {
>  	struct klp_patch *mypatch;
>  
> -	list_for_each_entry(mypatch, &klp_patches, list)
> +	list_for_each_entry(mypatch, head, list)
>  		if (mypatch == patch)
>  			return true;
>  
>  	return false;
>  }
>  
> +static bool klp_is_patch_usable(struct klp_patch *patch)
> +{
> +	return klp_is_patch_in_list(patch, &klp_patches);
> +}
> +
> +static bool klp_is_patch_replaced(struct klp_patch *patch)
> +{
> +	return klp_is_patch_in_list(patch, &klp_replaced_patches);
> +}
> +
>  static bool klp_initialized(void)
>  {
>  	return !!klp_root_kobj;
> @@ -375,7 +393,7 @@ int klp_disable_patch(struct klp_patch *patch)
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> +	if (!klp_is_patch_usable(patch)) {

This is another case where a wrapper function hurts readability.  What
does "usable" even mean to the reader of this code?  Every time I see
it, I have to do a double take.  I think getting rid of the wrapper in
favor of just doing

	if (!klp_is_patch_in_list(patch, &klp_patches))

would be much more obvious.

>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -475,7 +493,7 @@ int klp_enable_patch(struct klp_patch *patch)
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> +	if (!klp_is_patch_usable(patch)) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -516,7 +534,7 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> +	if (!klp_is_patch_usable(patch)) {
>  		/*
>  		 * Module with the patch could either disappear meanwhile or is
>  		 * not properly initialized yet.
> @@ -971,7 +989,7 @@ int klp_unregister_patch(struct klp_patch *patch)
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> +	if (!klp_is_patch_usable(patch) && !klp_is_patch_replaced(patch)) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
> -- 
> 2.13.6
> 

-- 
Josh

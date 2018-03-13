Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeCMWjB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:39:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752650AbeCMWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:38:59 -0400
Date: Tue, 13 Mar 2018 17:38:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/10] livepatch: Free only structures with
 initialized kobject
Message-ID: <20180313223858.p32bicvp4ohj5mk6@treble>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307082039.10196-3-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:20:31AM +0100, Petr Mladek wrote:
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> For this, we will need to dynamically create funcs and objects
> for functions that are no longer patched.
> 
> We will want to reuse the existing init() and free() functions. Up to now,
> the free() functions checked a limit and were called only for structures
> with initialized kobject. But we will want to call them also for structures
> that were allocated but where the kobject was not initialized yet.
> 
> This patch removes the limit. It calls klp_free*() functions for all
> structures. But only the ones with initialized kobject are freed.
> The handling of un-initialized structures will be added later with
> the support for dynamic structures.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  kernel/livepatch/core.c | 44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 1d525f4a270a..69bde95e76f8 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -653,17 +653,15 @@ static struct kobj_type klp_ktype_func = {
>  	.sysfs_ops = &kobj_sysfs_ops,
>  };
>  
> -/*
> - * Free all functions' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> - */
> -static void klp_free_funcs_limited(struct klp_object *obj,
> -				   struct klp_func *limit)
> +/* Free all funcs that have the kobject initialized. */
> +static void klp_free_funcs(struct klp_object *obj)
>  {
>  	struct klp_func *func;
>  
> -	for (func = obj->funcs; func->old_name && func != limit; func++)
> -		kobject_put(&func->kobj);
> +	klp_for_each_func(obj, func) {
> +		if (func->kobj.state_initialized)
> +			kobject_put(&func->kobj);
> +	}
>  }

Now that this function only has a single caller, personally I think it
would become more readable if klp_free_funcs() were inlined into its
caller (klp_free_objects()).  At the very least it should be moved to be
right above it.

>  
>  /* Clean up when a patched object is unloaded */
> @@ -677,24 +675,23 @@ static void klp_free_object_loaded(struct klp_object *obj)
>  		func->old_addr = 0;
>  }
>  
> -/*
> - * Free all objects' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> - */
> -static void klp_free_objects_limited(struct klp_patch *patch,
> -				     struct klp_object *limit)
> +/* Free all funcs and objects that have the kobject initialized. */
> +static void klp_free_objects(struct klp_patch *patch)
>  {
>  	struct klp_object *obj;
>  
> -	for (obj = patch->objs; obj->funcs && obj != limit; obj++) {
> -		klp_free_funcs_limited(obj, NULL);
> -		kobject_put(&obj->kobj);
> +	klp_for_each_object(patch, obj) {
> +		klp_free_funcs(obj);
> +
> +		if (obj->kobj.state_initialized)
> +			kobject_put(&obj->kobj);
>  	}
>  }
>  
>  static void klp_free_patch(struct klp_patch *patch)
>  {
> -	klp_free_objects_limited(patch, NULL);
> +	klp_free_objects(patch);
> +
>  	if (!list_empty(&patch->list))
>  		list_del(&patch->list);
>  }
> @@ -791,21 +788,16 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
>  	klp_for_each_func(obj, func) {
>  		ret = klp_init_func(obj, func);
>  		if (ret)
> -			goto free;
> +			return ret;
>  	}
>  
>  	if (klp_is_object_loaded(obj)) {
>  		ret = klp_init_object_loaded(patch, obj);
>  		if (ret)
> -			goto free;
> +			return ret;
>  	}
>  
>  	return 0;
> -
> -free:
> -	klp_free_funcs_limited(obj, func);
> -	kobject_put(&obj->kobj);
> -	return ret;
>  }
>  
>  static int klp_init_patch(struct klp_patch *patch)
> @@ -842,7 +834,7 @@ static int klp_init_patch(struct klp_patch *patch)
>  	return 0;
>  
>  free:
> -	klp_free_objects_limited(patch, obj);
> +	klp_free_objects(patch);
>  
>  	mutex_unlock(&klp_mutex);
>  
> -- 
> 2.13.6
> 

-- 
Josh

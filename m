Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeCMWoW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:44:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751300AbeCMWoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:44:20 -0400
Date: Tue, 13 Mar 2018 17:44:17 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/10] livepatch: Initial support for dynamic
 structures
Message-ID: <20180313224417.h7akqufvjxuwxp5e@treble>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307082039.10196-4-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:20:32AM +0100, Petr Mladek wrote:
> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> For this, we will need to dynamically create funcs and objects
> for functions that are no longer patched.
> 
> This patch adds basic framework to handle such dynamic structures.
> 
> It adds enum klp_func_type that allows to distinguish the dynamically
> allocated funcs' structures. Note that objects' structures do not have
> a clear type. Namely the static objects' structures might list both static
> and dynamic funcs' structures.
> 
> The function type is then used to limit klp_free() functions. We will
> want to free the dynamic structures separately when they are no longer
> needed. At the same time, we also want to make our life easier,
> and introduce _any_ type that will allow to process all existing
> structures in one go.
> 
> We need to be careful here. First, objects' structures must be freed
> only when all listed funcs' structures are freed. Also we must avoid
> double free. Both problems are solved by removing the freed structures
> from the list.
> 
> Also note that klp_free*() functions are called also in klp_init_patch()
> error path when only some kobjects have been initialized. The other
> dynamic structures must be freed immediately by calling the respective
> klp_free_*_dynamic() functions.
> 
> Finally, the dynamic objects' structures are generic. The respective
> klp_allocate_object_dynamic() and klp_free_object_dynamic() can
> be implemented here. On the other hand, klp_free_func_dynamic()
> is empty. It must be updated when a particular dynamic
> klp_func_type is introduced.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Converted into a generic API]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

I appreciate the split out patches, but I feel like they're split up
*too* much.  I found that it was hard to make sense of patches 3-5
without looking at patch 6.  So I'd suggest combining 3-6 into a single
patch.

Also, since patches 7-8 seem to be bug fixes for patch 6, they should be
squashed in, so we don't break bisectability unnecessarily.

> ---
>  include/linux/livepatch.h |  37 +++++++++++-
>  kernel/livepatch/core.c   | 141 +++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 163 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index e5db2ba7e2a5..7fb76e7d2693 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -35,12 +35,22 @@
>  #define KLP_UNPATCHED	 0
>  #define KLP_PATCHED	 1
>  
> +/*
> + * Function type is used to distinguish dynamically allocated structures
> + * and limit some operations.
> + */
> +enum klp_func_type {
> +	KLP_FUNC_ANY = -1,	/* Substitute any type */
> +	KLP_FUNC_STATIC = 0,    /* Original statically defined structure */
> +};
> +
>  /**
>   * struct klp_func - function structure for live patching
>   * @old_name:	name of the function to be patched
>   * @new_func:	pointer to the patched function code
>   * @old_sympos: a hint indicating which symbol position the old function
>   *		can be found (optional)
> + * @ftype:	distinguish static and dynamic structures

The "f" in ftype is redundant because it's already in a klp_func struct.

Also, I wonder if a 'dynamic' bool would be cleaner / more legible than
the enum.  Instead of e.g.

  klp_free_objects(patch, KLP_FUNC_ANY);
  klp_free_objects(patch, KLP_FUNC_NOP);

it could be

  klp_free_objects(patch)
  klp_free_objects_dynamic(patch);

with the klp_free_objects*() functions calling a __klp_free_objects()
helper which takes a bool as an argument.

There would need to be other changes, so I'm not sure it would be
better, but it could be worth trying out and seeing if it's cleaner.

>   * @old_addr:	the address of the function being patched
>   * @kobj:	kobject for sysfs resources
>   * @stack_node:	list node for klp_ops func_stack list
> @@ -79,6 +89,7 @@ struct klp_func {
>  	unsigned long old_sympos;
>  
>  	/* internal */
> +	enum klp_func_type ftype;
>  	unsigned long old_addr;
>  	struct kobject kobj;
>  	struct list_head stack_node;
> @@ -164,17 +175,41 @@ struct klp_patch {
>  #define klp_for_each_object_static(patch, obj) \
>  	for (obj = patch->objs; obj->funcs || obj->name; obj++)
>  
> +#define klp_for_each_object_safe(patch, obj, tmp_obj)		\
> +	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, obj_entry)
> +
>  #define klp_for_each_object(patch, obj)	\
>  	list_for_each_entry(obj, &patch->obj_list, obj_entry)
>  
> +/* Support also dynamically allocated struct klp_object */
>  #define klp_for_each_func_static(obj, func) \
>  	for (func = obj->funcs; \
> -	     func->old_name || func->new_func || func->old_sympos; \
> +	     func && (func->old_name || func->new_func || func->old_sympos); \
>  	     func++)
>  
> +#define klp_for_each_func_safe(obj, func, tmp_func)			\
> +	list_for_each_entry_safe(func, tmp_func, &obj->func_list, func_entry)
> +
>  #define klp_for_each_func(obj, func)	\
>  	list_for_each_entry(func, &obj->func_list, func_entry)
>  
> +static inline bool klp_is_object_dynamic(struct klp_object *obj)
> +{
> +	return !obj->funcs;
> +}
> +
> +static inline bool klp_is_func_dynamic(struct klp_func *func)
> +{
> +	WARN_ON_ONCE(func->ftype == KLP_FUNC_ANY);

This seems like a silly warning.  Surely such a condition wouldn't get
past code review :-)

> +	return func->ftype != KLP_FUNC_STATIC;
> +}

I think this would be clearer:

	return func->ftype == KLP_FUNC_NOP;

and perhaps KLP_FUNC_NOP should be renamed to KLP_FUNC_DYNAMIC?

	return func->ftype == KLP_FUNC_DYNAMIC;

(though I realize this patch doesn't have KLP_FUNC_NOP yet)

> +
> +static inline bool klp_is_func_type(struct klp_func *func,
> +				    enum klp_func_type ftype)
> +{
> +	return ftype == KLP_FUNC_ANY || ftype == func->ftype;
> +}
> +
>  int klp_register_patch(struct klp_patch *);
>  int klp_unregister_patch(struct klp_patch *);
>  int klp_enable_patch(struct klp_patch *);
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 69bde95e76f8..a47c26147c17 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -124,6 +124,26 @@ static bool klp_initialized(void)
>  	return !!klp_root_kobj;
>  }
>  
> +static struct klp_object *klp_find_object(struct klp_patch *patch,
> +					  struct klp_object *old_obj)
> +{
> +	struct klp_object *obj;
> +	bool mod = klp_is_module(old_obj);
> +
> +	klp_for_each_object(patch, obj) {
> +		if (mod) {

The 'mod' variable is a bit confusing here, as it's not clear that it
refers to the old object.  For clarity, maybe just do the
klp_is_module(old_obj) check here.

> +			if (klp_is_module(obj) &&
> +			    strcmp(old_obj->name, obj->name) == 0) {
> +				return obj;
> +			}
> +		} else if (!klp_is_module(obj)) {
> +			return obj;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  struct klp_find_arg {
>  	const char *objname;
>  	const char *name;
> @@ -621,6 +641,66 @@ static struct attribute *klp_patch_attrs[] = {
>  	NULL
>  };
>  
> +/*
> + * Dynamically allocated objects and functions.
> + */
> +static void klp_free_func_dynamic(struct klp_func *func)
> +{
> +}
> +
> +static void klp_free_object_dynamic(struct klp_object *obj)
> +{
> +	kfree(obj->name);
> +	kfree(obj);
> +}
> +
> +static struct klp_object *klp_alloc_object_dynamic(const char *name)
> +{
> +	struct klp_object *obj;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> +	if (!obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (name) {
> +		obj->name = kstrdup(name, GFP_KERNEL);
> +		if (!obj->name) {
> +			kfree(obj);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return obj;
> +}
> +
> +static struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
> +						struct klp_object *old_obj)
> +{
> +	struct klp_object *obj;
> +
> +	obj = klp_find_object(patch, old_obj);
> +	if (obj)
> +		return obj;
> +
> +	obj = klp_alloc_object_dynamic(old_obj->name);
> +	if (IS_ERR(obj))
> +		return obj;
> +
> +	klp_init_object_list(patch, obj);
> +	return obj;
> +}
> +
> +/*
> + * Patch release framework must support the following scenarios:
> + *
> + *   + Asynchonous release is used when kobjects are initialized.
> + *
> + *   + Direct release is used in error paths for structures that
> + *     have not had kobj initialized yet.
> + *
> + *   + Allow to release dynamic structures of the given type when
> + *     they are not longer needed.
> + */
>  static void klp_kobj_release_patch(struct kobject *kobj)
>  {
>  	struct klp_patch *patch;
> @@ -637,6 +717,12 @@ static struct kobj_type klp_ktype_patch = {
>  
>  static void klp_kobj_release_object(struct kobject *kobj)
>  {
> +	struct klp_object *obj;
> +
> +	obj = container_of(kobj, struct klp_object, kobj);
> +
> +	if (klp_is_object_dynamic(obj))
> +		klp_free_object_dynamic(obj);
>  }
>  
>  static struct kobj_type klp_ktype_object = {
> @@ -646,6 +732,12 @@ static struct kobj_type klp_ktype_object = {
>  
>  static void klp_kobj_release_func(struct kobject *kobj)
>  {
> +	struct klp_func *func;
> +
> +	func = container_of(kobj, struct klp_func, kobj);
> +
> +	if (klp_is_func_dynamic(func))
> +		klp_free_func_dynamic(func);

It's a bit difficult to review the code here in this patch, when dynamic
funcs don't exist yet.  Again it seems to me the patches are split up
too much.

>  }
>  
>  static struct kobj_type klp_ktype_func = {
> @@ -653,14 +745,26 @@ static struct kobj_type klp_ktype_func = {
>  	.sysfs_ops = &kobj_sysfs_ops,
>  };
>  
> -/* Free all funcs that have the kobject initialized. */
> -static void klp_free_funcs(struct klp_object *obj)
> +/*
> + * Free all funcs of the given ftype. Use the kobject when it has already
> + * been initialized. Otherwise, do it directly.
> + */
> +static void klp_free_funcs(struct klp_object *obj,
> +			   enum klp_func_type ftype)
>  {
> -	struct klp_func *func;
> +	struct klp_func *func, *tmp_func;
> +
> +	klp_for_each_func_safe(obj, func, tmp_func) {
> +		if (!klp_is_func_type(func, ftype))
> +			continue;
> +
> +		/* Avoid double free and allow to detect empty objects. */
> +		list_del(&func->func_entry);
>  
> -	klp_for_each_func(obj, func) {
>  		if (func->kobj.state_initialized)
>  			kobject_put(&func->kobj);
> +		else if (klp_is_func_dynamic(func))
> +			klp_free_func_dynamic(func);

Here it's not obvious why the else condition is needed, since dynamic
objects also have kobjects.  I *think* it's only needed for the case
where initialization fails before the kobject has been added.  A comment
would help.

>  	}
>  }
>  
> @@ -675,22 +779,34 @@ static void klp_free_object_loaded(struct klp_object *obj)
>  		func->old_addr = 0;
>  }
>  
> -/* Free all funcs and objects that have the kobject initialized. */
> -static void klp_free_objects(struct klp_patch *patch)
> +/*
> + * Free all linked funcs of the given ftype. Then free empty objects.
> + * Use the kobject when it has already been initialized. Otherwise,
> + * do it directly.
> + */
> +static void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype)
>  {
> -	struct klp_object *obj;
> +	struct klp_object *obj, *tmp_obj;
>  
> -	klp_for_each_object(patch, obj) {
> -		klp_free_funcs(obj);
> +	klp_for_each_object_safe(patch, obj, tmp_obj) {
> +		klp_free_funcs(obj, ftype);
> +
> +		if (!list_empty(&obj->func_list))
> +			continue;
> +
> +		/* Avoid freeing the object twice. */
> +		list_del(&obj->obj_entry);
>  
>  		if (obj->kobj.state_initialized)
>  			kobject_put(&obj->kobj);
> +		else if (klp_is_object_dynamic(obj))
> +			klp_free_object_dynamic(obj);

A comment is also needed for this else condition.

>  	}
>  }
>  
>  static void klp_free_patch(struct klp_patch *patch)
>  {
> -	klp_free_objects(patch);
> +	klp_free_objects(patch, KLP_FUNC_ANY);
>  
>  	if (!list_empty(&patch->list))
>  		list_del(&patch->list);
> @@ -771,9 +887,6 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
>  	int ret;
>  	const char *name;
>  
> -	if (!obj->funcs)
> -		return -EINVAL;
> -
>  	obj->patched = false;
>  	obj->mod = NULL;
>  
> @@ -834,7 +947,7 @@ static int klp_init_patch(struct klp_patch *patch)
>  	return 0;
>  
>  free:
> -	klp_free_objects(patch);
> +	klp_free_objects(patch, KLP_FUNC_ANY);
>  
>  	mutex_unlock(&klp_mutex);
>  
> -- 
> 2.13.6
> 

-- 
Josh

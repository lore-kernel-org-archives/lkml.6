Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeCMWic (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:38:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752729AbeCMWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:38:30 -0400
Date: Tue, 13 Mar 2018 17:38:29 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/10] livepatch: Use lists to manage patches,
 objects and functions
Message-ID: <20180313223829.fjpehbvzpmoehkby@treble>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307082039.10196-2-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:20:30AM +0100, Petr Mladek wrote:
> From: Jason Baron <jbaron@akamai.com>
> 
> Currently klp_patch contains a pointer to a statically allocated array of
> struct klp_object and struct klp_objects contains a pointer to a statically
> allocated array of klp_func. In order to allow for the dynamic allocation
> of objects and functions, link klp_patch, klp_object, and klp_func together
> via linked lists. This allows us to more easily allocate new objects and
> functions, while having the iterator be a simple linked list walk.
> 
> The static structures are added to the lists early. It allows to add
> the dynamically allocated objects before klp_init_object() and
> klp_init_func() calls. Therefore it reduces the further changes
> to the code.
> 
> Also klp_init_*_list() functions are split because they will
> be used when adding the dynamically allocated structures.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Initialize lists before init calls]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  include/linux/livepatch.h | 19 +++++++++++++++++--
>  kernel/livepatch/core.c   | 27 +++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 4754f01c1abb..e5db2ba7e2a5 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
>  #include <linux/completion.h>
> +#include <linux/list.h>
>  
>  #if IS_ENABLED(CONFIG_LIVEPATCH)
>  
> @@ -43,6 +44,7 @@
>   * @old_addr:	the address of the function being patched
>   * @kobj:	kobject for sysfs resources
>   * @stack_node:	list node for klp_ops func_stack list
> + * @func_entry:	links struct klp_func to struct klp_object

For consistency with 'stack_node', I think the field should have 'node'
in the name.  Also, putting 'func' in the name is redundant because the
struct already has 'func' in its name.  IMO, just 'node' would be good.

I also found the description to be confusing.  How about something
similar to the 'stack_node' description:

    * @node:		list node for klp_object func list

>   * @old_size:	size of the old function
>   * @new_size:	size of the new function
>   * @patched:	the func has been added to the klp_ops list
> @@ -80,6 +82,7 @@ struct klp_func {
>  	unsigned long old_addr;
>  	struct kobject kobj;
>  	struct list_head stack_node;
> +	struct list_head func_entry;
>  	unsigned long old_size, new_size;
>  	bool patched;
>  	bool transition;
> @@ -117,6 +120,8 @@ struct klp_callbacks {
>   * @kobj:	kobject for sysfs resources
>   * @mod:	kernel module associated with the patched object
>   *		(NULL for vmlinux)
> + * @func_list:	head of list for struct klp_func
> + * @obj_entry:	links struct klp_object to struct klp_patch

Similar comments here.

>   * @patched:	the object's funcs have been added to the klp_ops list
>   */
>  struct klp_object {
> @@ -127,6 +132,8 @@ struct klp_object {
>  
>  	/* internal */
>  	struct kobject kobj;
> +	struct list_head func_list;
> +	struct list_head obj_entry;
>  	struct module *mod;
>  	bool patched;
>  };
> @@ -137,6 +144,7 @@ struct klp_object {
>   * @objs:	object entries for kernel objects to be patched
>   * @list:	list node for global list of registered patches
>   * @kobj:	kobject for sysfs resources
> + * @obj_list:	head of list for struct klp_object
>   * @enabled:	the patch is enabled (but operation may be incomplete)
>   * @finish:	for waiting till it is safe to remove the patch module
>   */
> @@ -148,18 +156,25 @@ struct klp_patch {
>  	/* internal */
>  	struct list_head list;
>  	struct kobject kobj;
> +	struct list_head obj_list;
>  	bool enabled;
>  	struct completion finish;
>  };
>  
> -#define klp_for_each_object(patch, obj) \
> +#define klp_for_each_object_static(patch, obj) \
>  	for (obj = patch->objs; obj->funcs || obj->name; obj++)
>  
> -#define klp_for_each_func(obj, func) \
> +#define klp_for_each_object(patch, obj)	\
> +	list_for_each_entry(obj, &patch->obj_list, obj_entry)
> +
> +#define klp_for_each_func_static(obj, func) \
>  	for (func = obj->funcs; \
>  	     func->old_name || func->new_func || func->old_sympos; \
>  	     func++)
>  
> +#define klp_for_each_func(obj, func)	\
> +	list_for_each_entry(func, &obj->func_list, func_entry)
> +
>  int klp_register_patch(struct klp_patch *);
>  int klp_unregister_patch(struct klp_patch *);
>  int klp_enable_patch(struct klp_patch *);
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 3a4656fb7047..1d525f4a270a 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -49,6 +49,32 @@ static LIST_HEAD(klp_patches);
>  
>  static struct kobject *klp_root_kobj;
>  
> +static void klp_init_func_list(struct klp_object *obj, struct klp_func *func)
> +{
> +	list_add(&func->func_entry, &obj->func_list);
> +}

This function is confusingly named.  It *adds* to the func list instead
of initializing it.

Also, I think wrapping a single list_add() in a function makes the
calling code harder to read and understand.  I would suggest getting rid
of the function altogether and just inlining the list_add().

I also found the code harder to read in several other places, for
similar reasons (several small single-use functions).  I call it
functionitis :-)

> +
> +static void klp_init_object_list(struct klp_patch *patch,
> +				 struct klp_object *obj)
> +{
> +	struct klp_func *func;
> +
> +	list_add(&obj->obj_entry, &patch->obj_list);
> +
> +	INIT_LIST_HEAD(&obj->func_list);
> +	klp_for_each_func_static(obj, func)
> +		klp_init_func_list(obj, func);
> +}
> +
> +static void klp_init_patch_list(struct klp_patch *patch)
> +{
> +	struct klp_object *obj;
> +
> +	INIT_LIST_HEAD(&patch->obj_list);
> +	klp_for_each_object_static(patch, obj)
> +		klp_init_object_list(patch, obj);
> +}

klp_init_patch_list() can be a confusing name.  To me it sounds like a
list of patches.  But really it's a list of objects.

The same goes for klp_init_object_list().

What if we just call it klp_init_lists(), and move
klp_init_object_list() inline?

I know a later patch also adds a call to klp_init_object_list() from
klp_get_or_add_object(), but I think it should be inlined there as well,
because all that function needs to do is the list_add() and the
INIT_LIST_HEAD() -- the object is freshly allocated so it doesn't need
to copy any funcs to the list.  IMO it's more readable and more explicit
to repeat the few minor and obvious lines of code than to hide them in a
wrapper function which also does other things for other callers.

All this will help with some of the functionitis-related readability
issues, IMO.

> +
>  static bool klp_is_module(struct klp_object *obj)
>  {
>  	return obj->name;
> @@ -794,6 +820,7 @@ static int klp_init_patch(struct klp_patch *patch)
>  
>  	patch->enabled = false;
>  	init_completion(&patch->finish);
> +	klp_init_patch_list(patch);
>  
>  	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
>  				   klp_root_kobj, "%s", patch->mod->name);
> -- 
> 2.13.6
> 

-- 
Josh

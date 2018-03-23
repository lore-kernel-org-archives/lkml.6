Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCWOzB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:55:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeCWOzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:55:00 -0400
Date: Fri, 23 Mar 2018 15:54:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] livepatch: Atomic replace feature
Message-ID: <20180323145457.pup7fxle2pvhbjon@pathway.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323120028.31451-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-23 13:00:20, Petr Mladek wrote:
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.
> 
> This version is heavily refactored and cleaned based on feedback from Josh.
> There are actually only three functional changes.
> 
> It still passes the first draft of the selfttest from Joe that can
> be found at https://lkml.kernel.org/r/1520881024-29386-1-git-send-email-joe.lawrence@redhat.com
> 
> 
> Changes against v10:
> 
>   + Bug fixes and functional changes:
>     + Handle Nops in klp_ftrace_handled() to avoid infinite loop [Mirek]
>     + Really add dynamically allocated klp_object into the list [Petr]
>     + Clear patch->replace when transition finishes [Josh]
> 
>   + Refactoring and clean up [Josh]:
>     + Replace enum types with bools
>     + Avoid using ERR_PTR
>     + Remove too paranoid warnings
>     + Distinguish registered patches by a flag instead of a list
>     + Squash some functions
>     + Update comments, documentation, and commit messages
>     + Squashed and split patches to do more controversial changes later

Please, see below git diff against v10. Otherwise, the changes might
be hard to find because of the refactoring.

diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
index c041fc1bd259..206b7f98d270 100644
--- a/Documentation/livepatch/cumulative-patches.txt
+++ b/Documentation/livepatch/cumulative-patches.txt
@@ -31,15 +31,37 @@ be enabled even when some earlier patches have not been enabled yet.
 
 All processes are then migrated to use the code only from the new patch.
 Once the transition is finished, all older patches are removed from the stack
-of patches. Even the older not-enabled patches mentioned above.
+of patches. Even the older not-enabled patches mentioned above. They can
+even be unregistered and the related modules unloaded.
 
 Ftrace handlers are transparently removed from functions that are no
 longer modified by the new cumulative patch.
 
-As a result, the livepatch author might maintain sources only for one
+As a result, the livepatch authors might maintain sources only for one
 cumulative patch. It helps to keep the patch consistent while adding or
 removing various fixes or features.
 
+Users could keep only the last patch installed on the system after
+the transition to has finished. It helps to clearly see what code is
+actually in use. Also the livepatch might then be seen as a "normal"
+module that modifies the kernel behavior. The only difference is that
+it can be updated at runtime without breaking its functionality.
+
+
+Features
+--------
+
+The atomic replace allows:
+
+  + Atomically revert some functions in a previous patch while
+    upgrading other functions.
+
+  + Remove eventual performance impact caused by core redirection
+    for functions that are no longer patched.
+
+  + Decrease user confusion about stacking order and what patches are
+    currently in effect.
+
 
 Limitations:
 ------------
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 7222b801d63a..1635b30bb1ec 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -35,34 +35,19 @@
 #define KLP_UNPATCHED	 0
 #define KLP_PATCHED	 1
 
-/*
- * Function type is used to distinguish dynamically allocated structures
- * and limit some operations.
- */
-enum klp_func_type {
-	KLP_FUNC_ANY = -1,	/* Substitute any type */
-	KLP_FUNC_STATIC = 0,    /* Original statically defined structure */
-	KLP_FUNC_NOP,		/* Dynamically allocated NOP function patch */
-};
-
-enum klp_object_type {
-	KLP_OBJECT_STATIC = 0,  /* Original statically defined structure */
-	KLP_OBJECT_DYNAMIC,	/* Dynamically allocated structure. */
-};
-
 /**
  * struct klp_func - function structure for live patching
  * @old_name:	name of the function to be patched
  * @new_func:	pointer to the patched function code
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
- * @ftype:	distinguish static and dynamic structures
  * @old_addr:	the address of the function being patched
  * @kobj:	kobject for sysfs resources
+ * @node:	list node for klp_object func_list
  * @stack_node:	list node for klp_ops func_stack list
- * @func_entry:	links struct klp_func to struct klp_object
  * @old_size:	size of the old function
  * @new_size:	size of the new function
+ * @nop:        temporary patch to use the original code again; dyn. allocated
  * @patched:	the func has been added to the klp_ops list
  * @transition:	the func is currently being applied or reverted
  *
@@ -95,12 +80,12 @@ struct klp_func {
 	unsigned long old_sympos;
 
 	/* internal */
-	enum klp_func_type ftype;
 	unsigned long old_addr;
 	struct kobject kobj;
+	struct list_head node;
 	struct list_head stack_node;
-	struct list_head func_entry;
 	unsigned long old_size, new_size;
+	bool nop;
 	bool patched;
 	bool transition;
 };
@@ -137,8 +122,9 @@ struct klp_callbacks {
  * @kobj:	kobject for sysfs resources
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
- * @func_list:	head of list for struct klp_func
- * @obj_entry:	links struct klp_object to struct klp_patch
+ * @func_list:	dynamic list of the function entries
+ * @node:	list node for klp_patch obj_list
+ * @dynamic:    temporary object for nop functions; dynamically allocated
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
@@ -148,11 +134,11 @@ struct klp_object {
 	struct klp_callbacks callbacks;
 
 	/* internal */
-	enum klp_object_type otype;
 	struct kobject kobj;
 	struct list_head func_list;
-	struct list_head obj_entry;
+	struct list_head node;
 	struct module *mod;
+	bool dynamic;
 	bool patched;
 };
 
@@ -163,7 +149,8 @@ struct klp_object {
  * @replace:	replace all already registered patches
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
- * @obj_list:	head of list for struct klp_object
+ * @obj_list:	dynamic list of the object entries
+ * @registered: reliable way to check registration status
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @finish:	for waiting till it is safe to remove the patch module
  */
@@ -177,6 +164,7 @@ struct klp_patch {
 	struct list_head list;
 	struct kobject kobj;
 	struct list_head obj_list;
+	bool registered;
 	bool enabled;
 	struct completion finish;
 };
@@ -185,39 +173,21 @@ struct klp_patch {
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
 #define klp_for_each_object_safe(patch, obj, tmp_obj)		\
-	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, obj_entry)
+	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, node)
 
 #define klp_for_each_object(patch, obj)	\
-	list_for_each_entry(obj, &patch->obj_list, obj_entry)
+	list_for_each_entry(obj, &patch->obj_list, node)
 
-/* Support also dynamically allocated struct klp_object */
 #define klp_for_each_func_static(obj, func) \
 	for (func = obj->funcs; \
-	     func && (func->old_name || func->new_func || func->old_sympos); \
+	     func->old_name || func->new_func || func->old_sympos; \
 	     func++)
 
 #define klp_for_each_func_safe(obj, func, tmp_func)			\
-	list_for_each_entry_safe(func, tmp_func, &obj->func_list, func_entry)
+	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
 
 #define klp_for_each_func(obj, func)	\
-	list_for_each_entry(func, &obj->func_list, func_entry)
-
-static inline bool klp_is_object_dynamic(struct klp_object *obj)
-{
-	return obj->otype == KLP_OBJECT_DYNAMIC;
-}
-
-static inline bool klp_is_func_dynamic(struct klp_func *func)
-{
-	WARN_ON_ONCE(func->ftype == KLP_FUNC_ANY);
-	return func->ftype != KLP_FUNC_STATIC;
-}
-
-static inline bool klp_is_func_type(struct klp_func *func,
-				    enum klp_func_type ftype)
-{
-	return ftype == KLP_FUNC_ANY || ftype == func->ftype;
-}
+	list_for_each_entry(func, &obj->func_list, node)
 
 int klp_register_patch(struct klp_patch *);
 int klp_unregister_patch(struct klp_patch *);
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index b098dc10d4d5..c64371ffc063 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -45,41 +45,28 @@
  */
 DEFINE_MUTEX(klp_mutex);
 
-static LIST_HEAD(klp_patches);
-
 /*
- * List of 'replaced' patches that have been replaced by a patch that has the
- * 'replace' bit set. When they are added to this list, they are disabled and
- * can not be re-enabled, but they can be unregistered().
+ * Stack of patches. It defines the order in which the patches can be enabled.
+ * Only patches on this stack might be enabled. New patches are added when
+ * registered. They are removed when they are unregistered.
  */
-static LIST_HEAD(klp_replaced_patches);
+static LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
 
-static void klp_init_func_list(struct klp_object *obj, struct klp_func *func)
-{
-	list_add(&func->func_entry, &obj->func_list);
-}
-
-static void klp_init_object_list(struct klp_patch *patch,
-				 struct klp_object *obj)
-{
-	struct klp_func *func;
-
-	list_add(&obj->obj_entry, &patch->obj_list);
-
-	INIT_LIST_HEAD(&obj->func_list);
-	klp_for_each_func_static(obj, func)
-		klp_init_func_list(obj, func);
-}
-
-static void klp_init_patch_list(struct klp_patch *patch)
+static void klp_init_lists(struct klp_patch *patch)
 {
 	struct klp_object *obj;
+	struct klp_func *func;
 
 	INIT_LIST_HEAD(&patch->obj_list);
-	klp_for_each_object_static(patch, obj)
-		klp_init_object_list(patch, obj);
+	klp_for_each_object_static(patch, obj) {
+		list_add(&obj->node, &patch->obj_list);
+
+		INIT_LIST_HEAD(&obj->func_list);
+		klp_for_each_func_static(obj, func)
+			list_add(&func->node, &obj->func_list);
+	}
 }
 
 static bool klp_is_module(struct klp_object *obj)
@@ -115,28 +102,17 @@ static void klp_find_object_module(struct klp_object *obj)
 	mutex_unlock(&module_mutex);
 }
 
-static bool klp_is_patch_in_list(struct klp_patch *patch,
-				 struct list_head *head)
+static bool klp_is_patch_on_stack(struct klp_patch *patch)
 {
 	struct klp_patch *mypatch;
 
-	list_for_each_entry(mypatch, head, list)
+	list_for_each_entry(mypatch, &klp_patches, list)
 		if (mypatch == patch)
 			return true;
 
 	return false;
 }
 
-static bool klp_is_patch_usable(struct klp_patch *patch)
-{
-	return klp_is_patch_in_list(patch, &klp_patches);
-}
-
-static bool klp_is_patch_replaced(struct klp_patch *patch)
-{
-	return klp_is_patch_in_list(patch, &klp_replaced_patches);
-}
-
 static bool klp_initialized(void)
 {
 	return !!klp_root_kobj;
@@ -161,10 +137,9 @@ static struct klp_object *klp_find_object(struct klp_patch *patch,
 					  struct klp_object *old_obj)
 {
 	struct klp_object *obj;
-	bool mod = klp_is_module(old_obj);
 
 	klp_for_each_object(patch, obj) {
-		if (mod) {
+		if (klp_is_module(old_obj)) {
 			if (klp_is_module(obj) &&
 			    strcmp(old_obj->name, obj->name) == 0) {
 				return obj;
@@ -361,14 +336,18 @@ static int klp_write_object_relocations(struct module *pmod,
  * This function removes replaced patches from both func_stack
  * and klp_patches stack.
  *
- * We could be pretty aggressive here. It is called in situation
- * when these structures are no longer accessible. All functions
- * are redirected using the klp_transition_patch. They use either
- * a new code or they are in the original code because of the special
- * nop function patches.
+ * We could be pretty aggressive here. It is called in the situation where
+ * these structures are no longer accessible. All functions are redirected
+ * by the klp_transition_patch. They use either a new code or they are in
+ * the original code because of the special nop function patches.
+ *
+ * The only exception is when the transition was forced. In this case,
+ * klp_ftrace_handler() might still see the replaced patch on the stack.
+ * Fortunately, it is carefully designed to work with removed functions
+ * thanks to RCU. We only have to keep the patches on the system. This
+ * is handled by @keep_module parameter.
  */
-void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
-				     bool keep_module)
+void klp_discard_replaced_patches(struct klp_patch *new_patch, bool keep_module)
 {
 	struct klp_patch *old_patch, *tmp_patch;
 
@@ -377,7 +356,7 @@ void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
 			return;
 
 		if (old_patch->enabled) {
-			klp_unpatch_objects(old_patch, KLP_FUNC_ANY);
+			klp_unpatch_objects(old_patch);
 			old_patch->enabled = false;
 
 			if (!keep_module)
@@ -388,7 +367,7 @@ void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
 		 * Replaced patches could not get re-enabled to keep
 		 * the code sane.
 		 */
-		list_move(&old_patch->list, &klp_replaced_patches);
+		list_del_init(&old_patch->list);
 	}
 }
 
@@ -443,7 +422,7 @@ int klp_disable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_usable(patch)) {
+	if (!patch->registered) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -472,13 +451,14 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
-	if (!klp_is_patch_usable(patch))
+	/* Enforce stacking. */
+	if (!klp_is_patch_on_stack(patch))
 		return -EINVAL;
 
 	/*
-	 * Enforce stacking: only the first disabled patch can be enabled.
-	 * This is not required for patches with the replace flags. They
-	 * override even disabled patches that were registered earlier.
+	 * Only the first disabled patch can be enabled. This is not required
+	 * for patches with the replace flags. They override even disabled
+	 * patches that were registered earlier.
 	 */
 	if (!patch->replace &&
 	    patch->list.prev != &klp_patches &&
@@ -551,7 +531,7 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_usable(patch)) {
+	if (!patch->registered) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -592,15 +572,16 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_usable(patch)) {
+	if (!patch->registered) {
 		/*
 		 * Module with the patch could either disappear meanwhile or is
-		 * not properly initialized yet or the patch was just replaced.
+		 * not properly initialized yet.
 		 */
 		ret = -EINVAL;
 		goto err;
 	}
 
+
 	if (patch->enabled == enabled) {
 		/* already in requested state */
 		ret = -EINVAL;
@@ -720,18 +701,6 @@ static struct attribute *klp_patch_attrs[] = {
 /*
  * Dynamically allocated objects and functions.
  */
-static void klp_free_func_nop(struct klp_func *func)
-{
-	kfree(func->old_name);
-	kfree(func);
-}
-
-static void klp_free_func_dynamic(struct klp_func *func)
-{
-	if (func->ftype == KLP_FUNC_NOP)
-		klp_free_func_nop(func);
-}
-
 static void klp_free_object_dynamic(struct klp_object *obj)
 {
 	kfree(obj->name);
@@ -744,35 +713,26 @@ static struct klp_object *klp_alloc_object_dynamic(const char *name)
 
 	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
 	if (!obj)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	if (name) {
 		obj->name = kstrdup(name, GFP_KERNEL);
 		if (!obj->name) {
 			kfree(obj);
-			return ERR_PTR(-ENOMEM);
+			return NULL;
 		}
 	}
-	obj->otype = KLP_OBJECT_DYNAMIC;
+
+	INIT_LIST_HEAD(&obj->func_list);
+	obj->dynamic = true;
 
 	return obj;
 }
 
-static struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
-						struct klp_object *old_obj)
+static void klp_free_func_nop(struct klp_func *func)
 {
-	struct klp_object *obj;
-
-	obj = klp_find_object(patch, old_obj);
-	if (obj)
-		return obj;
-
-	obj = klp_alloc_object_dynamic(old_obj->name);
-	if (IS_ERR(obj))
-		return obj;
-
-	klp_init_object_list(patch, obj);
-	return obj;
+	kfree(func->old_name);
+	kfree(func);
 }
 
 static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
@@ -782,59 +742,52 @@ static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
 
 	func = kzalloc(sizeof(*func), GFP_KERNEL);
 	if (!func)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	if (old_func->old_name) {
 		func->old_name = kstrdup(old_func->old_name, GFP_KERNEL);
 		if (!func->old_name) {
 			kfree(func);
-			return ERR_PTR(-ENOMEM);
+			return NULL;
 		}
 	}
-	func->old_sympos = old_func->old_sympos;
+
 	/*
 	 * func->new_func is same as func->old_addr. These addresses are
 	 * set when the object is loaded, see klp_init_object_loaded().
 	 */
-	func->ftype = KLP_FUNC_NOP;
+	func->old_sympos = old_func->old_sympos;
+	func->nop = true;
 
 	return func;
 }
 
-static int klp_add_func_nop(struct klp_object *obj,
-			    struct klp_func *old_func)
-{
-	struct klp_func *func;
-
-	func = klp_find_func(obj, old_func);
-
-	if (func)
-		return 0;
-
-	func = klp_alloc_func_nop(old_func, obj);
-	if (IS_ERR(func))
-		return PTR_ERR(func);
-
-	klp_init_func_list(obj, func);
-
-	return 0;
-}
-
 static int klp_add_object_nops(struct klp_patch *patch,
 			       struct klp_object *old_obj)
 {
 	struct klp_object *obj;
-	struct klp_func *old_func;
-	int err = 0;
+	struct klp_func *func, *old_func;
+
+	obj = klp_find_object(patch, old_obj);
+
+	if (!obj) {
+		obj = klp_alloc_object_dynamic(old_obj->name);
+		if (!obj)
+			return -ENOMEM;
 
-	obj = klp_get_or_add_object(patch, old_obj);
-	if (IS_ERR(obj))
-		return PTR_ERR(obj);
+		list_add(&obj->node, &patch->obj_list);
+	}
 
 	klp_for_each_func(old_obj, old_func) {
-		err = klp_add_func_nop(obj, old_func);
-		if (err)
-			return err;
+		func = klp_find_func(obj, old_func);
+		if (func)
+			continue;
+
+		func = klp_alloc_func_nop(old_func, obj);
+		if (!func)
+			return -ENOMEM;
+
+		list_add(&func->node, &obj->func_list);
 	}
 
 	return 0;
@@ -843,15 +796,7 @@ static int klp_add_object_nops(struct klp_patch *patch,
 /*
  * Add 'nop' functions which simply return to the caller to run
  * the original function. The 'nop' functions are added to a
- * patch to facilitate a 'replace' mode
- *
- * The nops are generated for all patches on the stack when
- * the new patch is initialized. It is safe even though some
- * older patches might get disabled and removed before the
- * new one is enabled. In the worst case, there might be nops
- * which will not be really needed. But it does not harm and
- * simplifies the implementation a lot. Especially we could
- * use the init functions as is.
+ * patch to facilitate a 'replace' mode.
  */
 static int klp_add_nops(struct klp_patch *patch)
 {
@@ -859,9 +804,6 @@ static int klp_add_nops(struct klp_patch *patch)
 	struct klp_object *old_obj;
 	int err = 0;
 
-	if (WARN_ON(!patch->replace))
-		return -EINVAL;
-
 	list_for_each_entry(old_patch, &klp_patches, list) {
 		klp_for_each_object(old_patch, old_obj) {
 			err = klp_add_object_nops(patch, old_obj);
@@ -873,17 +815,6 @@ static int klp_add_nops(struct klp_patch *patch)
 	return 0;
 }
 
-/*
- * Patch release framework must support the following scenarios:
- *
- *   + Asynchonous release is used when kobjects are initialized.
- *
- *   + Direct release is used in error paths for structures that
- *     have not had kobj initialized yet.
- *
- *   + Allow to release dynamic structures of the given type when
- *     they are not longer needed.
- */
 static void klp_kobj_release_patch(struct kobject *kobj)
 {
 	struct klp_patch *patch;
@@ -904,7 +835,7 @@ static void klp_kobj_release_object(struct kobject *kobj)
 
 	obj = container_of(kobj, struct klp_object, kobj);
 
-	if (klp_is_object_dynamic(obj))
+	if (obj->dynamic)
 		klp_free_object_dynamic(obj);
 }
 
@@ -919,8 +850,8 @@ static void klp_kobj_release_func(struct kobject *kobj)
 
 	func = container_of(kobj, struct klp_func, kobj);
 
-	if (klp_is_func_dynamic(func))
-		klp_free_func_dynamic(func);
+	if (func->nop)
+		klp_free_func_nop(func);
 }
 
 static struct kobj_type klp_ktype_func = {
@@ -928,26 +859,25 @@ static struct kobj_type klp_ktype_func = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
-/*
- * Free all funcs of the given ftype. Use the kobject when it has already
- * been initialized. Otherwise, do it directly.
- */
-static void klp_free_funcs(struct klp_object *obj,
-			   enum klp_func_type ftype)
+static void __klp_free_funcs(struct klp_object *obj, bool free_all)
 {
 	struct klp_func *func, *tmp_func;
 
 	klp_for_each_func_safe(obj, func, tmp_func) {
-		if (!klp_is_func_type(func, ftype))
+		if (!free_all && !func->nop)
 			continue;
 
-		/* Avoid double free and allow to detect empty objects. */
-		list_del(&func->func_entry);
+		/*
+		 * Avoid double free. It would be tricky to wait for kobject
+		 * callbacks when only NOPs are handled.
+		 */
+		list_del(&func->node);
 
+		/* Might be called from klp_init_patch() error path. */
 		if (func->kobj.state_initialized)
 			kobject_put(&func->kobj);
-		else if (klp_is_func_dynamic(func))
-			klp_free_func_dynamic(func);
+		else if (func->nop)
+			klp_free_func_nop(func);
 	}
 }
 
@@ -961,48 +891,48 @@ static void klp_free_object_loaded(struct klp_object *obj)
 	klp_for_each_func(obj, func) {
 		func->old_addr = 0;
 
-		if (klp_is_func_type(func, KLP_FUNC_NOP))
+		if (func->nop)
 			func->new_func = NULL;
 	}
 }
 
-/*
- * Free all linked funcs of the given ftype. Then free empty objects.
- * Use the kobject when it has already been initialized. Otherwise,
- * do it directly.
- */
-void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype)
+static void __klp_free_objects(struct klp_patch *patch, bool free_all)
 {
 	struct klp_object *obj, *tmp_obj;
 
 	klp_for_each_object_safe(patch, obj, tmp_obj) {
-		klp_free_funcs(obj, ftype);
+		__klp_free_funcs(obj, free_all);
 
-		if (!list_empty(&obj->func_list))
+		if (!free_all && !obj->dynamic)
 			continue;
 
 		/*
-		 * Keep objects from the original patch initialized until
-		 * the entire patch is being freed.
+		 * Avoid double free. It would be tricky to wait for kobject
+		 * callbacks when only dynamic objects are handled.
 		 */
-		if (!klp_is_object_dynamic(obj) &&
-		    ftype != KLP_FUNC_STATIC &&
-		    ftype != KLP_FUNC_ANY)
-			continue;
-
-		/* Avoid freeing the object twice. */
-		list_del(&obj->obj_entry);
+		list_del(&obj->node);
 
+		/* Might be called from klp_init_patch() error path. */
 		if (obj->kobj.state_initialized)
 			kobject_put(&obj->kobj);
-		else if (klp_is_object_dynamic(obj))
+		else if (obj->dynamic)
 			klp_free_object_dynamic(obj);
 	}
 }
 
+static void klp_free_objects(struct klp_patch *patch)
+{
+	__klp_free_objects(patch, true);
+}
+
+void klp_free_objects_dynamic(struct klp_patch *patch)
+{
+	__klp_free_objects(patch, false);
+}
+
 static void klp_free_patch(struct klp_patch *patch)
 {
-	klp_free_objects(patch, KLP_FUNC_ANY);
+	klp_free_objects(patch);
 
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
@@ -1017,7 +947,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 	 * NOPs get the address later. The the patched module must be loaded,
 	 * see klp_init_object_loaded().
 	 */
-	if (!func->new_func && !klp_is_func_type(func, KLP_FUNC_NOP))
+	if (!func->new_func && !func->nop)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&func->stack_node);
@@ -1072,7 +1002,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			return -ENOENT;
 		}
 
-		if (klp_is_func_type(func, KLP_FUNC_NOP))
+		if (func->nop)
 			func->new_func = (void *)func->old_addr;
 
 		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
@@ -1093,6 +1023,9 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	int ret;
 	const char *name;
 
+	if (!obj->funcs && !obj->dynamic)
+		return -EINVAL;
+
 	obj->patched = false;
 	obj->mod = NULL;
 
@@ -1131,7 +1064,7 @@ static int klp_init_patch(struct klp_patch *patch)
 
 	patch->enabled = false;
 	init_completion(&patch->finish);
-	klp_init_patch_list(patch);
+	klp_init_lists(patch);
 
 	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
 				   klp_root_kobj, "%s", patch->mod->name);
@@ -1153,13 +1086,14 @@ static int klp_init_patch(struct klp_patch *patch)
 	}
 
 	list_add_tail(&patch->list, &klp_patches);
+	patch->registered = true;
 
 	mutex_unlock(&klp_mutex);
 
 	return 0;
 
 free:
-	klp_free_objects(patch, KLP_FUNC_ANY);
+	klp_free_objects(patch);
 
 	mutex_unlock(&klp_mutex);
 
@@ -1183,7 +1117,7 @@ int klp_unregister_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_usable(patch) && !klp_is_patch_replaced(patch)) {
+	if (!patch->registered) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1194,6 +1128,7 @@ int klp_unregister_patch(struct klp_patch *patch)
 	}
 
 	klp_free_patch(patch);
+	patch->registered = false;
 
 	mutex_unlock(&klp_mutex);
 
@@ -1272,7 +1207,7 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 
 				pr_notice("reverting patch '%s' on unloading module '%s'\n",
 					  patch->mod->name, obj->mod->name);
-				klp_unpatch_object(obj, KLP_FUNC_ANY);
+				klp_unpatch_object(obj);
 
 				klp_post_unpatch_callback(obj);
 			}
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 43184a5318d8..0837360a7170 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -6,9 +6,9 @@
 
 extern struct mutex klp_mutex;
 
-void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
-				     bool keep_module);
-void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype);
+void klp_discard_replaced_patches(struct klp_patch *new_patch,
+				  bool keep_module);
+void klp_free_objects_dynamic(struct klp_patch *patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 460a09aa7715..64b9ec3facf7 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,8 +118,11 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 		}
 	}
 
-	/* Survive ugly mistakes, for example, when handling NOPs. */
-	if (WARN_ON_ONCE(!func->new_func))
+	/*
+	 * NOPs are used to replace existing patches with original code.
+	 * Do nothing! Setting pc would cause an infinite loop.
+	 */
+	if (func->nop)
 		goto unlock;
 
 	klp_arch_set_pc(regs, (unsigned long)func->new_func);
@@ -241,27 +244,28 @@ static int klp_patch_func(struct klp_func *func)
 	return ret;
 }
 
-void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype)
+static void __klp_unpatch_object(struct klp_object *obj, bool unpatch_all)
 {
 	struct klp_func *func;
 
 	klp_for_each_func(obj, func) {
-		if (!func->patched)
+		if (!unpatch_all && !func->nop)
 			continue;
 
-		if (klp_is_func_type(func, ftype))
+		if (func->patched)
 			klp_unpatch_func(func);
 	}
 
-	/*
-	 * The state of the object is defined by the state of statically
-	 * defined func structures. Note that we will need to run callbacks
-	 * even when obj->funcs array is empty.
-	 */
-	if (ftype == KLP_FUNC_ANY || ftype == KLP_FUNC_STATIC)
+	if (unpatch_all || obj->dynamic)
 		obj->patched = false;
 }
 
+
+void klp_unpatch_object(struct klp_object *obj)
+{
+	__klp_unpatch_object(obj, true);
+}
+
 int klp_patch_object(struct klp_object *obj)
 {
 	struct klp_func *func;
@@ -273,7 +277,7 @@ int klp_patch_object(struct klp_object *obj)
 	klp_for_each_func(obj, func) {
 		ret = klp_patch_func(func);
 		if (ret) {
-			klp_unpatch_object(obj, KLP_FUNC_ANY);
+			klp_unpatch_object(obj);
 			return ret;
 		}
 	}
@@ -282,11 +286,21 @@ int klp_patch_object(struct klp_object *obj)
 	return 0;
 }
 
-void klp_unpatch_objects(struct klp_patch *patch, enum klp_func_type ftype)
+static void __klp_unpatch_objects(struct klp_patch *patch, bool unpatch_all)
 {
 	struct klp_object *obj;
 
 	klp_for_each_object(patch, obj)
 		if (obj->patched)
-			klp_unpatch_object(obj, ftype);
+			__klp_unpatch_object(obj, unpatch_all);
+}
+
+void klp_unpatch_objects(struct klp_patch *patch)
+{
+	__klp_unpatch_objects(patch, true);
+}
+
+void klp_unpatch_objects_dynamic(struct klp_patch *patch)
+{
+	__klp_unpatch_objects(patch, false);
 }
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index 885f644add4c..cd8e1f03b22b 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -28,7 +28,8 @@ struct klp_ops {
 struct klp_ops *klp_find_ops(unsigned long old_addr);
 
 int klp_patch_object(struct klp_object *obj);
-void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype);
-void klp_unpatch_objects(struct klp_patch *patch, enum klp_func_type ftype);
+void klp_unpatch_object(struct klp_object *obj);
+void klp_unpatch_objects(struct klp_patch *patch);
+void klp_unpatch_objects_dynamic(struct klp_patch *patch);
 
 #endif /* _LIVEPATCH_PATCH_H */
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index d6af190865d2..05ea2a8e03bd 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -87,34 +87,16 @@ static void klp_complete_transition(void)
 		 klp_transition_patch->mod->name,
 		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
-	/*
-	 * For replace patches, we disable all previous patches, and replace
-	 * the dynamic no-op functions by removing the ftrace hook.
-	 */
 	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
-		/*
-		 * Make sure that no ftrace handler accesses any older patch
-		 * on the stack.  This might happen when the user forced the
-		 * transaction while some running tasks were still falling
-		 * back to the old code.  There might even still be ftrace
-		 * handlers that have not seen the last patch on the stack yet.
-		 *
-		 * It probably is not necessary because of the rcu-safe access.
-		 * But better be safe than sorry.
-		 */
-		if (klp_forced)
-			klp_synchronize_transition();
-
-		klp_throw_away_replaced_patches(klp_transition_patch,
-						klp_forced);
+		klp_discard_replaced_patches(klp_transition_patch, klp_forced);
 
 		/*
 		 * There is no need to synchronize the transition after removing
 		 * nops. They must be the last on the func_stack. Ftrace
-		 * gurantees that nobody will stay in the trampoline after
+		 * guarantees that nobody will stay in the trampoline after
 		 * the ftrace handler is unregistered.
 		 */
-		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
+		klp_unpatch_objects_dynamic(klp_transition_patch);
 	}
 
 	if (klp_target_state == KLP_UNPATCHED) {
@@ -122,7 +104,7 @@ static void klp_complete_transition(void)
 		 * All tasks have transitioned to KLP_UNPATCHED so we can now
 		 * remove the new functions from the func_stack.
 		 */
-		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_ANY);
+		klp_unpatch_objects(klp_transition_patch);
 
 		/*
 		 * Make sure klp_ftrace_handler() can no longer see functions
@@ -173,14 +155,20 @@ static void klp_complete_transition(void)
 	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
 		module_put(klp_transition_patch->mod);
 
-	/*
-	 * We do not need to wait until the objects are really freed.
-	 * The patch must be on the bottom of the stack. Therefore it
-	 * will never replace anything else. The only important thing
-	 * is that we wait when the patch is being unregistered.
-	 */
-	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
-		klp_free_objects(klp_transition_patch, KLP_FUNC_NOP);
+	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
+		/*
+		 * We do not need to wait until the objects are really freed.
+		 * We will never need them again because the patch must be on
+		 * the bottom of the stack now.
+		 */
+		klp_free_objects_dynamic(klp_transition_patch);
+		/*
+		 * Replace behavior will not longer be needed. Avoid the related
+		 * code when disabling and enabling again.
+		 */
+		klp_transition_patch->replace = false;
+	}
+
 
 	klp_target_state = KLP_UNDEFINED;
 	klp_transition_patch = NULL;

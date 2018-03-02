Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946268AbeCBKd6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:33:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35643 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1945990AbeCBK3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:52 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v9 6/9] livepatch: Add atomic replace
Date: Fri,  2 Mar 2018 11:29:32 +0100
Message-Id: <20180302102935.14564-7-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180302102935.14564-1-pmladek@suse.com>
References: <20180302102935.14564-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

Sometimes we would like to revert a particular fix. Currently, this
is not easy because we want to keep all other fixes active and we
could revert only the last applied patch.

One solution would be to apply new patch that implemented all
the reverted functions like in the original code. It would work
as expected but there will be unnecessary redirections. In addition,
it would also require knowing which functions need to be reverted at
build time.

Another problem is when there are many patches that touch the same
functions. There might be dependencies between patches that are
not enforced on the kernel side. Also it might be pretty hard to
actually prepare the patch and ensure compatibility with
the other patches.

A better solution would be to create cumulative patch and say that
it replaces all older ones.

This patch adds a new "replace" flag to struct klp_patch. When it is
enabled, a set of 'nop' klp_func will be dynamically created for all
functions that are already being patched but that will no longer be
modified by the new patch. They are temporarily used as a new target
during the patch transition.

There are used several simplifications:

  + nops' structures are generated already when the patch is registered.
    All registered patches are taken into account, even the disabled ones.
    As a result, there might be more nops than are really needed when
    the patch is enabled and some disabled patches were removed before.
    But we are on the safe side and it simplifies the implementation.
    Especially we could reuse the existing init() functions. Also freeing
    is easier because the same nops are created and removed only once.

    Alternative solution would be to create nops when the patch is enabled.
    But then any reusing of the init() functions and error paths would be
    complicated. Also it would increase the risk of errors because of
    late kobject initialization. Finally, it would need tricky waiting
    for freed kobjects when finalizing a reverted enable transaction.

  + The replaced patches are removed from the stack and cannot longer
    be enabled directly. Otherwise, we would need to implement a more
    complex logic of handling the stack of patches. It might be hard
    to come with a reasonable semantic.

    A fallback is to remove (rmmod) the replaced patches and register
    (insmod) them again.

  + Nops are handled like normal function patches. It reduces changes
    in the existing code.

    It would be possible to copy internal values when they are allocated
    and make short cuts in init() functions. It would be possible to use
    the fact that old_func and new_func point to the same function and
    do not init new_func and new_size at all. It would be possible to
    detect nop func in ftrace handler and just leave. But all these would
    just complicate the code and maintenance.

  + The callbacks from the replaced patches are not called. It would be
    pretty hard to define a reasonable semantic and implement it.

    It might even be counter-productive. The new patch is cumulative.
    It is supposed to include most of the changes from older patches.
    In most cases, it will not want to call pre_unpatch() post_unpatch()
    callbacks from the replaced patches. It would disable/break things
    for no good reasons. Also it should be easier to handle various
    scenarios in a single script in the new patch than think about
    interactions caused by running many scripts from older patches.
    No to say that the old scripts even would not expect to be called
    in this situation.

Signed-off-by: Jason Baron <jbaron@akamai.com>
[pmladek@suse.com: Split, reuse existing code, simplified]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 include/linux/livepatch.h     |   3 +
 kernel/livepatch/core.c       | 162 +++++++++++++++++++++++++++++++++++++++++-
 kernel/livepatch/core.h       |   4 ++
 kernel/livepatch/transition.c |  39 ++++++++++
 4 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 7fb76e7d2693..ed598d849029 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -42,6 +42,7 @@
 enum klp_func_type {
 	KLP_FUNC_ANY = -1,	/* Substitute any type */
 	KLP_FUNC_STATIC = 0,    /* Original statically defined structure */
+	KLP_FUNC_NOP,		/* Dynamically allocated NOP function patch */
 };
 
 /**
@@ -153,6 +154,7 @@ struct klp_object {
  * struct klp_patch - patch structure for live patching
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
+ * @replace:	replace all already registered patches
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	head of list for struct klp_object
@@ -163,6 +165,7 @@ struct klp_patch {
 	/* external */
 	struct module *mod;
 	struct klp_object *objs;
+	bool replace;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index fd0296859ff4..ad508a86b2f9 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -142,6 +142,21 @@ static bool klp_initialized(void)
 	return !!klp_root_kobj;
 }
 
+static struct klp_func *klp_find_func(struct klp_object *obj,
+				      struct klp_func *old_func)
+{
+	struct klp_func *func;
+
+	klp_for_each_func(obj, func) {
+		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
+		    (old_func->old_sympos == func->old_sympos)) {
+			return func;
+		}
+	}
+
+	return NULL;
+}
+
 static struct klp_object *klp_find_object(struct klp_patch *patch,
 					  struct klp_object *old_obj)
 {
@@ -342,6 +357,39 @@ static int klp_write_object_relocations(struct module *pmod,
 	return ret;
 }
 
+/*
+ * This function removes replaced patches from both func_stack
+ * and klp_patches stack.
+ *
+ * We could be pretty aggressive here. It is called in situation
+ * when these structures are no longer accessible. All functions
+ * are redirected using the klp_transition_patch. They use either
+ * a new code or they are in the original code because of the special
+ * nop function patches.
+ */
+void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
+				     bool keep_module)
+{
+	struct klp_patch *old_patch, *tmp_patch;
+
+	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
+		if (old_patch == new_patch)
+			return;
+
+		klp_unpatch_objects(old_patch, KLP_FUNC_ANY);
+		old_patch->enabled = false;
+
+		/*
+		 * Replaced patches could not get re-enabled to keep
+		 * the code sane.
+		 */
+		list_move(&old_patch->list, &klp_replaced_patches);
+
+		if (!keep_module)
+			module_put(old_patch->mod);
+	}
+}
+
 static int __klp_disable_patch(struct klp_patch *patch)
 {
 	struct klp_object *obj;
@@ -537,7 +585,7 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!klp_is_patch_usable(patch)) {
 		/*
 		 * Module with the patch could either disappear meanwhile or is
-		 * not properly initialized yet.
+		 * not properly initialized yet or the patch was just replaced.
 		 */
 		ret = -EINVAL;
 		goto err;
@@ -662,8 +710,16 @@ static struct attribute *klp_patch_attrs[] = {
 /*
  * Dynamically allocated objects and functions.
  */
+static void klp_free_func_nop(struct klp_func *func)
+{
+	kfree(func->old_name);
+	kfree(func);
+}
+
 static void klp_free_func_dynamic(struct klp_func *func)
 {
+	if (func->ftype == KLP_FUNC_NOP)
+		klp_free_func_nop(func);
 }
 
 static void klp_free_object_dynamic(struct klp_object *obj)
@@ -708,6 +764,102 @@ static struct klp_object *klp_get_or_add_object(struct klp_patch *patch,
 	return obj;
 }
 
+static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
+					   struct klp_object *obj)
+{
+	struct klp_func *func;
+
+	func = kzalloc(sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return ERR_PTR(-ENOMEM);
+
+	if (old_func->old_name) {
+		func->old_name = kstrdup(old_func->old_name, GFP_KERNEL);
+		if (!func->old_name) {
+			kfree(func);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	func->old_sympos = old_func->old_sympos;
+	/* NOP func is the same as using the original implementation. */
+	func->new_func = (void *)old_func->old_addr;
+	func->ftype = KLP_FUNC_NOP;
+
+	return func;
+}
+
+static int klp_add_func_nop(struct klp_object *obj,
+			    struct klp_func *old_func)
+{
+	struct klp_func *func;
+
+	func = klp_find_func(obj, old_func);
+
+	if (func)
+		return 0;
+
+	func = klp_alloc_func_nop(old_func, obj);
+	if (IS_ERR(func))
+		return PTR_ERR(func);
+
+	klp_init_func_list(obj, func);
+
+	return 0;
+}
+
+static int klp_add_object_nops(struct klp_patch *patch,
+			       struct klp_object *old_obj)
+{
+	struct klp_object *obj;
+	struct klp_func *old_func;
+	int err = 0;
+
+	obj = klp_get_or_add_object(patch, old_obj);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+
+	klp_for_each_func(old_obj, old_func) {
+		err = klp_add_func_nop(obj, old_func);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * Add 'nop' functions which simply return to the caller to run
+ * the original function. The 'nop' functions are added to a
+ * patch to facilitate a 'replace' mode
+ *
+ * The nops are generated for all patches on the stack when
+ * the new patch is initialized. It is safe even though some
+ * older patches might get disabled and removed before the
+ * new one is enabled. In the worst case, there might be nops
+ * which will not be really needed. But it does not harm and
+ * simplifies the implementation a lot. Especially we could
+ * use the init functions as is.
+ */
+static int klp_add_nops(struct klp_patch *patch)
+{
+	struct klp_patch *old_patch;
+	struct klp_object *old_obj;
+	int err = 0;
+
+	if (WARN_ON(!patch->replace))
+		return -EINVAL;
+
+	list_for_each_entry(old_patch, &klp_patches, list) {
+		klp_for_each_object(old_patch, old_obj) {
+			err = klp_add_object_nops(patch, old_obj);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Patch release framework must support the following scenarios:
  *
@@ -802,7 +954,7 @@ static void klp_free_object_loaded(struct klp_object *obj)
  * Use the kobject when it has already been initialized. Otherwise,
  * do it directly.
  */
-static void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype)
+void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype)
 {
 	struct klp_object *obj, *tmp_obj;
 
@@ -952,6 +1104,12 @@ static int klp_init_patch(struct klp_patch *patch)
 		return ret;
 	}
 
+	if (patch->replace) {
+		ret = klp_add_nops(patch);
+		if (ret)
+			goto free;
+	}
+
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
 		if (ret)
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 48a83d4364cf..43184a5318d8 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -6,6 +6,10 @@
 
 extern struct mutex klp_mutex;
 
+void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
+				     bool keep_module);
+void klp_free_objects(struct klp_patch *patch, enum klp_func_type ftype);
+
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
 	return !obj->name || obj->mod;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 6917100fbe79..d6af190865d2 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -87,6 +87,36 @@ static void klp_complete_transition(void)
 		 klp_transition_patch->mod->name,
 		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
+	/*
+	 * For replace patches, we disable all previous patches, and replace
+	 * the dynamic no-op functions by removing the ftrace hook.
+	 */
+	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
+		/*
+		 * Make sure that no ftrace handler accesses any older patch
+		 * on the stack.  This might happen when the user forced the
+		 * transaction while some running tasks were still falling
+		 * back to the old code.  There might even still be ftrace
+		 * handlers that have not seen the last patch on the stack yet.
+		 *
+		 * It probably is not necessary because of the rcu-safe access.
+		 * But better be safe than sorry.
+		 */
+		if (klp_forced)
+			klp_synchronize_transition();
+
+		klp_throw_away_replaced_patches(klp_transition_patch,
+						klp_forced);
+
+		/*
+		 * There is no need to synchronize the transition after removing
+		 * nops. They must be the last on the func_stack. Ftrace
+		 * gurantees that nobody will stay in the trampoline after
+		 * the ftrace handler is unregistered.
+		 */
+		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_NOP);
+	}
+
 	if (klp_target_state == KLP_UNPATCHED) {
 		/*
 		 * All tasks have transitioned to KLP_UNPATCHED so we can now
@@ -143,6 +173,15 @@ static void klp_complete_transition(void)
 	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
 		module_put(klp_transition_patch->mod);
 
+	/*
+	 * We do not need to wait until the objects are really freed.
+	 * The patch must be on the bottom of the stack. Therefore it
+	 * will never replace anything else. The only important thing
+	 * is that we wait when the patch is being unregistered.
+	 */
+	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
+		klp_free_objects(klp_transition_patch, KLP_FUNC_NOP);
+
 	klp_target_state = KLP_UNDEFINED;
 	klp_transition_patch = NULL;
 }
-- 
2.13.6

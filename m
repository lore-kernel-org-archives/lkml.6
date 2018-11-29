Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6122081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6122081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK2Ut6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbeK2Ut5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:49:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5730DAD47;
        Thu, 29 Nov 2018 09:45:09 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v14 07/11] livepatch: Add atomic replace
Date:   Thu, 29 Nov 2018 10:44:27 +0100
Message-Id: <20181129094431.7801-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181129094431.7801-1-pmladek@suse.com>
References: <20181129094431.7801-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
actually prepare the patch and ensure compatibility with the other
patches.

Atomic replace && cumulative patches:

A better solution would be to create cumulative patch and say that
it replaces all older ones.

This patch adds a new "replace" flag to struct klp_patch. When it is
enabled, a set of 'nop' klp_func will be dynamically created for all
functions that are already being patched but that will no longer be
modified by the new patch. They are used as a new target during
the patch transition.

The idea is to handle Nops' structures like the static ones. When
the dynamic structures are allocated, we initialize all values that
are normally statically defined.

The only exception is "new_func" in struct klp_func. It has to point
to the original function and the address is known only when the object
(module) is loaded. Note that we really need to set it. The address is
used, for example, in klp_check_stack_func().

Nevertheless we still need to distinguish the dynamically allocated
structures in some operations. For this, we add "nop" flag into
struct klp_func and "dynamic" flag into struct klp_object. They
need special handling in the following situations:

  + The structures are added into the lists of objects and functions
    immediately. In fact, the lists were created for this purpose.

  + The address of the original function is known only when the patched
    object (module) is loaded. Therefore it is copied later in
    klp_init_object_loaded().

  + The ftrace handler must not set PC to func->new_func. It would cause
    infinite loop because the address points back to the beginning of
    the original function.

  + The various free() functions must free the structure itself.

Note that other ways to detect the dynamic structures are not considered
safe. For example, even the statically defined struct klp_object might
include empty funcs array. It might be there just to run some callbacks.

Special callbacks handling:

The callbacks from the replaced patches are _not_ called by intention.
It would be pretty hard to define a reasonable semantic and implement it.

It might even be counter-productive. The new patch is cumulative. It is
supposed to include most of the changes from older patches. In most cases,
it will not want to call pre_unpatch() post_unpatch() callbacks from
the replaced patches. It would disable/break things for no good reasons.
Also it should be easier to handle various scenarios in a single script
in the new patch than think about interactions caused by running many
scripts from older patches. Not to say that the old scripts even would
not expect to be called in this situation.

Removing replaced patches:

One nice effect of the cumulative patches is that the code from the
older patches is no longer used. Therefore the replaced patches can
be removed. It has several advantages:

  + Nops' structs will not longer be necessary and might be removed.
    This would save memory, restore performance (no ftrace handler),
    allow clear view on what is really patched.

  + Disabling the patch will cause using the original code everywhere.
    Therefore the livepatch callbacks could handle only one scenario.
    Note that the complication is already complex enough when the patch
    gets enabled. It is currently solved by calling callbacks only from
    the new cumulative patch.

  + The state is clean in both the sysfs interface and lsmod. The modules
    with the replaced livepatches might even get removed from the system.

Some people actually expected this behavior from the beginning. After all
a cumulative patch is supposed to "completely" replace an existing one.
It is like when a new version of an application replaces an older one.

This patch does the first step. It removes the replaced patches from
the list of patches. It is safe. The consistency model ensures that
they are not longer used. By other words, each process works only with
the structures from klp_transition_patch.

The removal is done by a special function. It combines actions done by
__disable_patch() and klp_complete_transition(). But it is a fast
track without all the transaction-related stuff.

Signed-off-by: Jason Baron <jbaron@akamai.com>
[pmladek@suse.com: Split, reuse existing code, simplified]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
---
 Documentation/livepatch/livepatch.txt |  33 ++++-
 include/linux/livepatch.h             |   6 +
 kernel/livepatch/core.c               | 221 +++++++++++++++++++++++++++++++++-
 kernel/livepatch/core.h               |   1 +
 kernel/livepatch/patch.c              |   8 ++
 kernel/livepatch/transition.c         |   3 +
 6 files changed, 264 insertions(+), 8 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index d849af312576..ba6e83a08209 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -15,8 +15,9 @@ Table of Contents:
 5. Livepatch life-cycle
    5.1. Loading
    5.2. Enabling
-   5.3. Disabling
-   5.4. Removing
+   5.3. Replacing
+   5.4. Disabling
+   5.5. Removing
 6. Sysfs
 7. Limitations
 
@@ -300,8 +301,12 @@ into three levels:
 5. Livepatch life-cycle
 =======================
 
-Livepatching can be described by four basic operations:
-loading, enabling, disabling, removing.
+Livepatching can be described by five basic operations:
+loading, enabling, replacing, disabling, removing.
+
+Where the replacing and the disabling operations are mutually
+exclusive. They have the same result for the given patch but
+not for the system.
 
 
 5.1. Loading
@@ -347,7 +352,23 @@ to '0'.
     the "Consistency model" section.
 
 
-5.3. Disabling
+5.3. Replacing
+--------------
+
+All enabled patches might get replaced by a cumulative patch that
+has the .replace flag set.
+
+Once the new patch is enabled and the 'transition" finishes then
+all the functions (struct klp_func) associated with the replaced
+patches are removed from the corresponding struct klp_ops. Also
+the ftrace handler is unregistered and the struct klp_ops is
+freed when the related function is not modified by the new patch
+and func_stack list becomes empty.
+
+See Documentation/livepatch/cumulative-patches.txt for more details.
+
+
+5.4. Disabling
 --------------
 
 Enabled patches might get disabled by writing '0' to
@@ -372,7 +393,7 @@ Note that patches must be disabled in exactly the reverse order in which
 they were enabled. It makes the problem and the implementation much easier.
 
 
-5.4. Removing
+5.5. Removing
 -------------
 
 Module removal is only safe when there are no users of the underlying
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 662e4cf664b8..a44bc730cc47 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -48,6 +48,7 @@
  * @old_size:	size of the old function
  * @new_size:	size of the new function
  * @kobj_alive: @kobj has been added and needs freeing
+ * @nop:        temporary patch to use the original code again; dyn. allocated
  * @patched:	the func has been added to the klp_ops list
  * @transition:	the func is currently being applied or reverted
  *
@@ -86,6 +87,7 @@ struct klp_func {
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
 	bool kobj_alive;
+	bool nop;
 	bool patched;
 	bool transition;
 };
@@ -125,6 +127,7 @@ struct klp_callbacks {
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
  * @kobj_alive: @kobj has been added and needs freeing
+ * @dynamic:    temporary object for nop functions; dynamically allocated
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
@@ -139,6 +142,7 @@ struct klp_object {
 	struct list_head node;
 	struct module *mod;
 	bool kobj_alive;
+	bool dynamic;
 	bool patched;
 };
 
@@ -146,6 +150,7 @@ struct klp_object {
  * struct klp_patch - patch structure for live patching
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
+ * @replace:	replace all already registered patches
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -159,6 +164,7 @@ struct klp_patch {
 	/* external */
 	struct module *mod;
 	struct klp_object *objs;
+	bool replace;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index c48f34272473..7092d288cfa6 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -88,6 +88,40 @@ static bool klp_initialized(void)
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
+static struct klp_object *klp_find_object(struct klp_patch *patch,
+					  struct klp_object *old_obj)
+{
+	struct klp_object *obj;
+
+	klp_for_each_object(patch, obj) {
+		if (klp_is_module(old_obj)) {
+			if (klp_is_module(obj) &&
+			    strcmp(old_obj->name, obj->name) == 0) {
+				return obj;
+			}
+		} else if (!klp_is_module(obj)) {
+			return obj;
+		}
+	}
+
+	return NULL;
+}
+
 struct klp_find_arg {
 	const char *objname;
 	const char *name;
@@ -415,6 +449,124 @@ static struct attribute *klp_patch_attrs[] = {
 	NULL
 };
 
+/*
+ * Dynamically allocated objects and functions.
+ */
+static void klp_free_object_dynamic(struct klp_object *obj)
+{
+	kfree(obj->name);
+	kfree(obj);
+}
+
+static struct klp_object *klp_alloc_object_dynamic(const char *name)
+{
+	struct klp_object *obj;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return NULL;
+
+	if (name) {
+		obj->name = kstrdup(name, GFP_KERNEL);
+		if (!obj->name) {
+			kfree(obj);
+			return NULL;
+		}
+	}
+
+	INIT_LIST_HEAD(&obj->func_list);
+	obj->dynamic = true;
+
+	return obj;
+}
+
+static void klp_free_func_nop(struct klp_func *func)
+{
+	kfree(func->old_name);
+	kfree(func);
+}
+
+static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
+					   struct klp_object *obj)
+{
+	struct klp_func *func;
+
+	func = kzalloc(sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return NULL;
+
+	if (old_func->old_name) {
+		func->old_name = kstrdup(old_func->old_name, GFP_KERNEL);
+		if (!func->old_name) {
+			kfree(func);
+			return NULL;
+		}
+	}
+
+	/*
+	 * func->new_func is same as func->old_func. These addresses are
+	 * set when the object is loaded, see klp_init_object_loaded().
+	 */
+	func->old_sympos = old_func->old_sympos;
+	func->nop = true;
+
+	return func;
+}
+
+static int klp_add_object_nops(struct klp_patch *patch,
+			       struct klp_object *old_obj)
+{
+	struct klp_object *obj;
+	struct klp_func *func, *old_func;
+
+	obj = klp_find_object(patch, old_obj);
+
+	if (!obj) {
+		obj = klp_alloc_object_dynamic(old_obj->name);
+		if (!obj)
+			return -ENOMEM;
+
+		list_add_tail(&obj->node, &patch->obj_list);
+	}
+
+	klp_for_each_func(old_obj, old_func) {
+		func = klp_find_func(obj, old_func);
+		if (func)
+			continue;
+
+		func = klp_alloc_func_nop(old_func, obj);
+		if (!func)
+			return -ENOMEM;
+
+		list_add_tail(&func->node, &obj->func_list);
+	}
+
+	return 0;
+}
+
+/*
+ * Add 'nop' functions which simply return to the caller to run
+ * the original function. The 'nop' functions are added to a
+ * patch to facilitate a 'replace' mode.
+ */
+static int klp_add_nops(struct klp_patch *patch)
+{
+	struct klp_patch *old_patch;
+	struct klp_object *old_obj;
+
+	list_for_each_entry(old_patch, &klp_patches, list) {
+		klp_for_each_object(old_patch, old_obj) {
+			int err;
+
+			err = klp_add_object_nops(patch, old_obj);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void klp_kobj_release_patch(struct kobject *kobj)
 {
 	struct klp_patch *patch;
@@ -431,6 +583,12 @@ static struct kobj_type klp_ktype_patch = {
 
 static void klp_kobj_release_object(struct kobject *kobj)
 {
+	struct klp_object *obj;
+
+	obj = container_of(kobj, struct klp_object, kobj);
+
+	if (obj->dynamic)
+		klp_free_object_dynamic(obj);
 }
 
 static struct kobj_type klp_ktype_object = {
@@ -440,6 +598,12 @@ static struct kobj_type klp_ktype_object = {
 
 static void klp_kobj_release_func(struct kobject *kobj)
 {
+	struct klp_func *func;
+
+	func = container_of(kobj, struct klp_func, kobj);
+
+	if (func->nop)
+		klp_free_func_nop(func);
 }
 
 static struct kobj_type klp_ktype_func = {
@@ -456,6 +620,8 @@ static void klp_free_funcs(struct klp_object *obj)
 		if (func->kobj_alive) {
 			func->kobj_alive = false;
 			kobject_put(&func->kobj);
+		} else if (func->nop) {
+			klp_free_func_nop(func);
 		}
 	}
 }
@@ -467,8 +633,12 @@ static void klp_free_object_loaded(struct klp_object *obj)
 
 	obj->mod = NULL;
 
-	klp_for_each_func(obj, func)
+	klp_for_each_func(obj, func) {
 		func->old_func = NULL;
+
+		if (func->nop)
+			func->new_func = NULL;
+	}
 }
 
 static void klp_free_objects(struct klp_patch *patch)
@@ -482,6 +652,8 @@ static void klp_free_objects(struct klp_patch *patch)
 		if (obj->kobj_alive) {
 			obj->kobj_alive = false;
 			kobject_put(&obj->kobj);
+		} else if (obj->dynamic) {
+			klp_free_object_dynamic(obj);
 		}
 	}
 }
@@ -545,7 +717,14 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
 	int ret;
 
-	if (!func->old_name || !func->new_func)
+	if (!func->old_name)
+		return -EINVAL;
+
+	/*
+	 * NOPs get the address later. The patched module must be loaded,
+	 * see klp_init_object_loaded().
+	 */
+	if (!func->new_func && !func->nop)
 		return -EINVAL;
 
 	if (strlen(func->old_name) >= KSYM_NAME_LEN)
@@ -607,6 +786,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			return -ENOENT;
 		}
 
+		if (func->nop)
+			func->new_func = func->old_func;
+
 		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
 						  &func->new_size, NULL);
 		if (!ret) {
@@ -700,6 +882,12 @@ static int klp_init_patch(struct klp_patch *patch)
 		return ret;
 	patch->kobj_alive = true;
 
+	if (patch->replace) {
+		ret = klp_add_nops(patch);
+		if (ret)
+			return ret;
+	}
+
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
 		if (ret)
@@ -872,6 +1060,35 @@ int klp_enable_patch(struct klp_patch *patch)
 EXPORT_SYMBOL_GPL(klp_enable_patch);
 
 /*
+ * This function removes replaced patches.
+ *
+ * We could be pretty aggressive here. It is called in the situation where
+ * these structures are no longer accessible. All functions are redirected
+ * by the klp_transition_patch. They use either a new code or they are in
+ * the original code because of the special nop function patches.
+ *
+ * The only exception is when the transition was forced. In this case,
+ * klp_ftrace_handler() might still see the replaced patch on the stack.
+ * Fortunately, it is carefully designed to work with removed functions
+ * thanks to RCU. We only have to keep the patches on the system. Also
+ * this is handled transparently by patch->module_put.
+ */
+void klp_discard_replaced_patches(struct klp_patch *new_patch)
+{
+	struct klp_patch *old_patch, *tmp_patch;
+
+	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
+		if (old_patch == new_patch)
+			return;
+
+		old_patch->enabled = false;
+		klp_unpatch_objects(old_patch);
+		klp_free_patch_start(old_patch);
+		schedule_work(&old_patch->free_work);
+	}
+}
+
+/*
  * Remove parts of patches that touch a given kernel module. The list of
  * patches processed might be limited. When limit is NULL, all patches
  * will be handled.
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index d4eefc520c08..f6a853adcc00 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -8,6 +8,7 @@ extern struct mutex klp_mutex;
 extern struct list_head klp_patches;
 
 void klp_free_patch_start(struct klp_patch *patch);
+void klp_discard_replaced_patches(struct klp_patch *new_patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 130002eaadb8..fe27709d13ea 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,7 +118,15 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 		}
 	}
 
+	/*
+	 * NOPs are used to replace existing patches with original code.
+	 * Do nothing! Setting pc would cause an infinite loop.
+	 */
+	if (func->nop)
+		goto unlock;
+
 	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+
 unlock:
 	preempt_enable_notrace();
 }
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 34d7a3308fde..aee073c8293b 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -85,6 +85,9 @@ static void klp_complete_transition(void)
 		 klp_transition_patch->mod->name,
 		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
+	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
+		klp_discard_replaced_patches(klp_transition_patch);
+
 	if (klp_target_state == KLP_UNPATCHED) {
 		/*
 		 * All tasks have transitioned to KLP_UNPATCHED so we can now
-- 
2.13.7


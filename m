Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F133C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345152064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345152064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJOUXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:23:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726870AbeJOUWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D08DEAF13;
        Mon, 15 Oct 2018 12:37:37 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 09/12] livepatch: Remove Nop structures when unused
Date:   Mon, 15 Oct 2018 14:37:10 +0200
Message-Id: <20181015123713.25868-10-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced patches are removed from the stack when the transition is
finished. It means that Nop structures will never be needed again
and can be removed. Why should we care?

  + Nop structures make false feeling that the function is patched
    even though the ftrace handler has no effect.

  + Ftrace handlers are not completely for free. They cause slowdown that
    might be visible in some workloads. The ftrace-related slowdown might
    actually be the reason why the function is not longer patched in
    the new cumulative patch. One would expect that cumulative patch
    would allow to solve these problems as well.

  + Cumulative patches are supposed to replace any earlier version of
    the patch. The amount of NOPs depends on which version was replaced.
    This multiplies the amount of scenarios that might happen.

    One might say that NOPs are innocent. But there are even optimized
    NOP instructions for different processor, for example, see
    arch/x86/kernel/alternative.c. And klp_ftrace_handler() is much
    more complicated.

  + It sounds natural to clean up a mess that is not longer needed.
    It could only be worse if we do not do it.

This patch allows to unpatch and free the dynamic structures independently
when the transition finishes.

The free part is a bit tricky because kobject free callbacks are called
asynchronously. We could not wait for them easily. Fortunately, we do
not have to. Any further access can be avoided by removing them from
the dynamic lists.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h     |  6 ++++
 kernel/livepatch/core.c       | 72 ++++++++++++++++++++++++++++++++++++++-----
 kernel/livepatch/core.h       |  2 +-
 kernel/livepatch/patch.c      | 31 ++++++++++++++++---
 kernel/livepatch/patch.h      |  1 +
 kernel/livepatch/transition.c |  2 +-
 6 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 352e9bcaddf9..63d3f88309d1 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -214,6 +214,9 @@ struct klp_patch {
 #define klp_for_each_object_static(patch, obj) \
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
+#define klp_for_each_object_safe(patch, obj, tmp_obj)		\
+	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, node)
+
 #define klp_for_each_object(patch, obj)	\
 	list_for_each_entry(obj, &patch->obj_list, node)
 
@@ -222,6 +225,9 @@ struct klp_patch {
 	     func->old_name || func->new_addr || func->old_sympos; \
 	     func++)
 
+#define klp_for_each_func_safe(obj, func, tmp_func)			\
+	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
+
 #define klp_for_each_func(obj, func)	\
 	list_for_each_entry(func, &obj->func_list, node)
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 70a09c8bf3e1..f260568714db 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -633,11 +633,20 @@ static struct kobj_type klp_ktype_func = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
-static void klp_free_funcs(struct klp_object *obj)
+static void __klp_free_funcs(struct klp_object *obj, bool free_all)
 {
-	struct klp_func *func;
+	struct klp_func *func, *tmp_func;
+
+	klp_for_each_func_safe(obj, func, tmp_func) {
+		if (!free_all && !func->nop)
+			continue;
+
+		/*
+		 * Avoid double free. It would be tricky to wait for kobject
+		 * callbacks when only NOPs are handled.
+		 */
+		list_del(&func->node);
 
-	klp_for_each_func(obj, func) {
 		/* Might be called from klp_init_patch() error path. */
 		if (func->kobj.state_initialized)
 			kobject_put(&func->kobj);
@@ -661,12 +670,21 @@ static void klp_free_object_loaded(struct klp_object *obj)
 	}
 }
 
-static void klp_free_objects(struct klp_patch *patch)
+static void __klp_free_objects(struct klp_patch *patch, bool free_all)
 {
-	struct klp_object *obj;
+	struct klp_object *obj, *tmp_obj;
 
-	klp_for_each_object(patch, obj) {
-		klp_free_funcs(obj);
+	klp_for_each_object_safe(patch, obj, tmp_obj) {
+		__klp_free_funcs(obj, free_all);
+
+		if (!free_all && !obj->dynamic)
+			continue;
+
+		/*
+		 * Avoid double free. It would be tricky to wait for kobject
+		 * callbacks when only dynamic objects are handled.
+		 */
+		list_del(&obj->node);
 
 		/* Might be called from klp_init_patch() error path. */
 		if (obj->kobj.state_initialized)
@@ -676,6 +694,16 @@ static void klp_free_objects(struct klp_patch *patch)
 	}
 }
 
+static void klp_free_objects(struct klp_patch *patch)
+{
+	__klp_free_objects(patch, true);
+}
+
+static void klp_free_objects_dynamic(struct klp_patch *patch)
+{
+	__klp_free_objects(patch, false);
+}
+
 /*
  * The synchronous variant is needed when the patch is freed in
  * the klp_enable_patch() error paths.
@@ -1051,7 +1079,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * thanks to RCU. We only have to keep the patches on the system. Also
  * this is handled transparently by patch->module_put.
  */
-void klp_discard_replaced_patches(struct klp_patch *new_patch)
+static void klp_discard_replaced_patches(struct klp_patch *new_patch)
 {
 	struct klp_patch *old_patch, *tmp_patch;
 
@@ -1067,6 +1095,34 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch)
 }
 
 /*
+ * This function removes the dynamically allocated 'nop' functions.
+ *
+ * We could be pretty aggressive. NOPs do not change the existing
+ * behavior except for adding unnecessary delay by the ftrace handler.
+ *
+ * It is safe even when the transition was forced. The ftrace handler
+ * will see a valid ops->func_stack entry thanks to RCU.
+ *
+ * We could even free the NOPs structures. They must be the last entry
+ * in ops->func_stack. Therefore unregister_ftrace_function() is called.
+ * It does the same as klp_synchronize_transition() to make sure that
+ * nobody is inside the ftrace handler once the operation finishes.
+ *
+ * IMPORTANT: It must be called right after removing the replaced patches!
+ */
+static void klp_discard_nops(struct klp_patch *new_patch)
+{
+	klp_unpatch_objects_dynamic(klp_transition_patch);
+	klp_free_objects_dynamic(klp_transition_patch);
+}
+
+void klp_discard_replaced_stuff(struct klp_patch *new_patch)
+{
+	klp_discard_replaced_patches(new_patch);
+	klp_discard_nops(new_patch);
+}
+
+/*
  * Remove parts of patches that touch a given kernel module. The list of
  * patches processed might be limited. When limit is NULL, all patches
  * will be handled.
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index f6a853adcc00..4d5d0658f3db 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -8,7 +8,7 @@ extern struct mutex klp_mutex;
 extern struct list_head klp_patches;
 
 void klp_free_patch_start(struct klp_patch *patch);
-void klp_discard_replaced_patches(struct klp_patch *new_patch);
+void klp_discard_replaced_stuff(struct klp_patch *new_patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 7754510116d7..47f8ad59293a 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -244,15 +244,26 @@ static int klp_patch_func(struct klp_func *func)
 	return ret;
 }
 
-void klp_unpatch_object(struct klp_object *obj)
+static void __klp_unpatch_object(struct klp_object *obj, bool unpatch_all)
 {
 	struct klp_func *func;
 
-	klp_for_each_func(obj, func)
+	klp_for_each_func(obj, func) {
+		if (!unpatch_all && !func->nop)
+			continue;
+
 		if (func->patched)
 			klp_unpatch_func(func);
+	}
 
-	obj->patched = false;
+	if (unpatch_all || obj->dynamic)
+		obj->patched = false;
+}
+
+
+void klp_unpatch_object(struct klp_object *obj)
+{
+	__klp_unpatch_object(obj, true);
 }
 
 int klp_patch_object(struct klp_object *obj)
@@ -275,11 +286,21 @@ int klp_patch_object(struct klp_object *obj)
 	return 0;
 }
 
-void klp_unpatch_objects(struct klp_patch *patch)
+static void __klp_unpatch_objects(struct klp_patch *patch, bool unpatch_all)
 {
 	struct klp_object *obj;
 
 	klp_for_each_object(patch, obj)
 		if (obj->patched)
-			klp_unpatch_object(obj);
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
index e72d8250d04b..cd8e1f03b22b 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -30,5 +30,6 @@ struct klp_ops *klp_find_ops(unsigned long old_addr);
 int klp_patch_object(struct klp_object *obj);
 void klp_unpatch_object(struct klp_object *obj);
 void klp_unpatch_objects(struct klp_patch *patch);
+void klp_unpatch_objects_dynamic(struct klp_patch *patch);
 
 #endif /* _LIVEPATCH_PATCH_H */
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index fbc1f7c1ab10..69c25c0d7085 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -86,7 +86,7 @@ static void klp_complete_transition(void)
 		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
 	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
-		klp_discard_replaced_patches(klp_transition_patch);
+		klp_discard_replaced_stuff(klp_transition_patch);
 
 	if (klp_target_state == KLP_UNPATCHED) {
 		/*
-- 
2.13.7


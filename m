Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D0C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194DF20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194DF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeK2Ut6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728063AbeK2Ut5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:49:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0372AE8A;
        Thu, 29 Nov 2018 09:45:10 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
Date:   Thu, 29 Nov 2018 10:44:28 +0100
Message-Id: <20181129094431.7801-9-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181129094431.7801-1-pmladek@suse.com>
References: <20181129094431.7801-1-pmladek@suse.com>
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
 kernel/livepatch/core.c       | 64 ++++++++++++++++++++++++++++++++++++++-----
 kernel/livepatch/core.h       |  1 +
 kernel/livepatch/patch.c      | 31 +++++++++++++++++----
 kernel/livepatch/patch.h      |  1 +
 kernel/livepatch/transition.c |  4 ++-
 6 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index a44bc730cc47..ad29f17e1f55 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -180,6 +180,9 @@ struct klp_patch {
 #define klp_for_each_object_static(patch, obj) \
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
+#define klp_for_each_object_safe(patch, obj, tmp_obj)		\
+	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, node)
+
 #define klp_for_each_object(patch, obj)	\
 	list_for_each_entry(obj, &patch->obj_list, node)
 
@@ -188,6 +191,9 @@ struct klp_patch {
 	     func->old_name || func->new_func || func->old_sympos; \
 	     func++)
 
+#define klp_for_each_func_safe(obj, func, tmp_func)			\
+	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
+
 #define klp_for_each_func(obj, func)	\
 	list_for_each_entry(func, &obj->func_list, node)
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 7092d288cfa6..0ce752e9e8bb 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -611,11 +611,20 @@ static struct kobj_type klp_ktype_func = {
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
 		if (func->kobj_alive) {
 			func->kobj_alive = false;
@@ -641,12 +650,21 @@ static void klp_free_object_loaded(struct klp_object *obj)
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
 		if (obj->kobj_alive) {
@@ -658,6 +676,16 @@ static void klp_free_objects(struct klp_patch *patch)
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
  * This function implements the free operations that can be called safely
  * under klp_mutex.
@@ -1089,6 +1117,28 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch)
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
+void klp_discard_nops(struct klp_patch *new_patch)
+{
+	klp_unpatch_objects_dynamic(klp_transition_patch);
+	klp_free_objects_dynamic(klp_transition_patch);
+}
+
+/*
  * Remove parts of patches that touch a given kernel module. The list of
  * patches processed might be limited. When limit is NULL, all patches
  * will be handled.
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index f6a853adcc00..e6200f38701f 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -9,6 +9,7 @@ extern struct list_head klp_patches;
 
 void klp_free_patch_start(struct klp_patch *patch);
 void klp_discard_replaced_patches(struct klp_patch *new_patch);
+void klp_discard_nops(struct klp_patch *new_patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index fe27709d13ea..37da868859a5 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -246,15 +246,26 @@ static int klp_patch_func(struct klp_func *func)
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
@@ -277,11 +288,21 @@ int klp_patch_object(struct klp_object *obj)
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
index 2bc8db4e9973..ce761c5d08a6 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -30,5 +30,6 @@ struct klp_ops *klp_find_ops(void *old_func);
 int klp_patch_object(struct klp_object *obj);
 void klp_unpatch_object(struct klp_object *obj);
 void klp_unpatch_objects(struct klp_patch *patch);
+void klp_unpatch_objects_dynamic(struct klp_patch *patch);
 
 #endif /* _LIVEPATCH_PATCH_H */
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index aee073c8293b..aed32e09f041 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -85,8 +85,10 @@ static void klp_complete_transition(void)
 		 klp_transition_patch->mod->name,
 		 klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
-	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED)
+	if (klp_transition_patch->replace && klp_target_state == KLP_PATCHED) {
 		klp_discard_replaced_patches(klp_transition_patch);
+		klp_discard_nops(klp_transition_patch);
+	}
 
 	if (klp_target_state == KLP_UNPATCHED) {
 		/*
-- 
2.13.7


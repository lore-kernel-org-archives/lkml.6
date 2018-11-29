Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927742081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927742081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeK2Utw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:48024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbeK2Utw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9E5CAE8A;
        Thu, 29 Nov 2018 09:45:02 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Date:   Thu, 29 Nov 2018 10:44:23 +0100
Message-Id: <20181129094431.7801-4-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181129094431.7801-1-pmladek@suse.com>
References: <20181129094431.7801-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for freeing livepatch structures is a bit scattered and tricky:

  + direct calls to klp_free_*_limited() and kobject_put() are
    used to release partially initialized objects

  + klp_free_patch() removes the patch from the public list
    and releases all objects except for patch->kobj

  + object_put(&patch->kobj) and the related wait_for_completion()
    are called directly outside klp_mutex; this code is duplicated;

Now, we are going to remove the registration stage to simplify the API
and the code. This would require handling more situations in
klp_enable_patch() error paths.

More importantly, we are going to add a feature called atomic replace.
It will need to dynamically create func and object structures. We will
want to reuse the existing init() and free() functions. This would
create even more error path scenarios.

This patch implements a more clever free functions:

  + checks kobj_alive flag instead of @limit[*]

  + initializes patch->list early so that the check for empty list
    always works

  + The action(s) that has to be done outside klp_mutex are done
    in separate klp_free_patch_finish() function. It waits only
    when patch->kobj was really released via the _start() part.

The patch does not change the existing behavior.

[*] We need our own flag. Note that kobject_put() cannot be called safely
    when kobj.state_initialized is set. This flag is true when kobject_add()
    part failed. And it is never cleared.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
---
 include/linux/livepatch.h |   6 ++
 kernel/livepatch/core.c   | 145 +++++++++++++++++++++++++++++++---------------
 2 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 634e13876380..6646bc4730bc 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -45,6 +45,7 @@
  * @stack_node:	list node for klp_ops func_stack list
  * @old_size:	size of the old function
  * @new_size:	size of the new function
+ * @kobj_alive: @kobj has been added and needs freeing
  * @patched:	the func has been added to the klp_ops list
  * @transition:	the func is currently being applied or reverted
  *
@@ -81,6 +82,7 @@ struct klp_func {
 	struct kobject kobj;
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
+	bool kobj_alive;
 	bool patched;
 	bool transition;
 };
@@ -117,6 +119,7 @@ struct klp_callbacks {
  * @kobj:	kobject for sysfs resources
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
+ * @kobj_alive: @kobj has been added and needs freeing
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
@@ -128,6 +131,7 @@ struct klp_object {
 	/* internal */
 	struct kobject kobj;
 	struct module *mod;
+	bool kobj_alive;
 	bool patched;
 };
 
@@ -137,6 +141,7 @@ struct klp_object {
  * @objs:	object entries for kernel objects to be patched
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
+ * @kobj_alive: @kobj has been added and needs freeing
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @finish:	for waiting till it is safe to remove the patch module
  */
@@ -148,6 +153,7 @@ struct klp_patch {
 	/* internal */
 	struct list_head list;
 	struct kobject kobj;
+	bool kobj_alive;
 	bool enabled;
 	struct completion finish;
 };
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 20589da35194..6c255dbcc517 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -465,17 +465,17 @@ static struct kobj_type klp_ktype_func = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
-/*
- * Free all functions' kobjects in the array up to some limit. When limit is
- * NULL, all kobjects are freed.
- */
-static void klp_free_funcs_limited(struct klp_object *obj,
-				   struct klp_func *limit)
+static void klp_free_funcs(struct klp_object *obj)
 {
 	struct klp_func *func;
 
-	for (func = obj->funcs; func->old_name && func != limit; func++)
-		kobject_put(&func->kobj);
+	klp_for_each_func(obj, func) {
+		/* Might be called from klp_init_patch() error path. */
+		if (func->kobj_alive) {
+			func->kobj_alive = false;
+			kobject_put(&func->kobj);
+		}
+	}
 }
 
 /* Clean up when a patched object is unloaded */
@@ -489,30 +489,63 @@ static void klp_free_object_loaded(struct klp_object *obj)
 		func->old_func = NULL;
 }
 
-/*
- * Free all objects' kobjects in the array up to some limit. When limit is
- * NULL, all kobjects are freed.
- */
-static void klp_free_objects_limited(struct klp_patch *patch,
-				     struct klp_object *limit)
+static void klp_free_objects(struct klp_patch *patch)
 {
 	struct klp_object *obj;
 
-	for (obj = patch->objs; obj->funcs && obj != limit; obj++) {
-		klp_free_funcs_limited(obj, NULL);
-		kobject_put(&obj->kobj);
+	klp_for_each_object(patch, obj) {
+		klp_free_funcs(obj);
+
+		/* Might be called from klp_init_patch() error path. */
+		if (obj->kobj_alive) {
+			obj->kobj_alive = false;
+			kobject_put(&obj->kobj);
+		}
 	}
 }
 
-static void klp_free_patch(struct klp_patch *patch)
+/*
+ * This function implements the free operations that can be called safely
+ * under klp_mutex.
+ *
+ * The operation must be completed by calling klp_free_patch_finish()
+ * outside klp_mutex.
+ */
+static void klp_free_patch_start(struct klp_patch *patch)
 {
-	klp_free_objects_limited(patch, NULL);
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
+
+	klp_free_objects(patch);
+}
+
+/*
+ * This function implements the free part that must be called outside
+ * klp_mutex.
+ *
+ * It must be called after klp_free_patch_start(). And it has to be
+ * the last function accessing the livepatch structures when the patch
+ * gets disabled.
+ */
+static void klp_free_patch_finish(struct klp_patch *patch)
+{
+	/*
+	 * Avoid deadlock with enabled_store() sysfs callback by
+	 * calling this outside klp_mutex. It is safe because
+	 * this is called when the patch gets disabled and it
+	 * cannot get enabled again.
+	 */
+	if (patch->kobj_alive) {
+		patch->kobj_alive = false;
+		kobject_put(&patch->kobj);
+		wait_for_completion(&patch->finish);
+	}
 }
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
+	int ret;
+
 	if (!func->old_name || !func->new_func)
 		return -EINVAL;
 
@@ -528,9 +561,13 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 	 * object. If the user selects 0 for old_sympos, then 1 will be used
 	 * since a unique symbol will be the first occurrence.
 	 */
-	return kobject_init_and_add(&func->kobj, &klp_ktype_func,
-				    &obj->kobj, "%s,%lu", func->old_name,
-				    func->old_sympos ? func->old_sympos : 1);
+	ret = kobject_init_and_add(&func->kobj, &klp_ktype_func,
+				   &obj->kobj, "%s,%lu", func->old_name,
+				   func->old_sympos ? func->old_sympos : 1);
+	if (!ret)
+		func->kobj_alive = true;
+
+	return ret;
 }
 
 /* Arches may override this to finish any remaining arch-specific tasks */
@@ -589,9 +626,6 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	int ret;
 	const char *name;
 
-	if (!obj->funcs)
-		return -EINVAL;
-
 	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
 		return -EINVAL;
 
@@ -605,47 +639,66 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 				   &patch->kobj, "%s", name);
 	if (ret)
 		return ret;
+	obj->kobj_alive = true;
 
 	klp_for_each_func(obj, func) {
 		ret = klp_init_func(obj, func);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
-	if (klp_is_object_loaded(obj)) {
+	if (klp_is_object_loaded(obj))
 		ret = klp_init_object_loaded(patch, obj);
-		if (ret)
-			goto free;
-	}
-
-	return 0;
 
-free:
-	klp_free_funcs_limited(obj, func);
-	kobject_put(&obj->kobj);
 	return ret;
 }
 
-static int klp_init_patch(struct klp_patch *patch)
+/* Init operations that must succeed before klp_free_patch() can be called. */
+static int klp_init_patch_before_free(struct klp_patch *patch)
 {
 	struct klp_object *obj;
-	int ret;
+	struct klp_func *func;
 
 	if (!patch->objs)
 		return -EINVAL;
 
-	mutex_lock(&klp_mutex);
-
+	INIT_LIST_HEAD(&patch->list);
+	patch->kobj_alive = false;
 	patch->enabled = false;
 	init_completion(&patch->finish);
 
-	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
-				   klp_root_kobj, "%s", patch->mod->name);
+	klp_for_each_object(patch, obj) {
+		if (!obj->funcs)
+			return -EINVAL;
+
+		obj->kobj_alive = false;
+
+		klp_for_each_func(obj, func)
+			func->kobj_alive = false;
+	}
+
+	return 0;
+}
+
+static int klp_init_patch(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+	int ret;
+
+	mutex_lock(&klp_mutex);
+
+	ret = klp_init_patch_before_free(patch);
 	if (ret) {
 		mutex_unlock(&klp_mutex);
 		return ret;
 	}
 
+	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
+				   klp_root_kobj, "%s", patch->mod->name);
+	if (ret)
+		goto free;
+	patch->kobj_alive = true;
+
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
 		if (ret)
@@ -659,12 +712,11 @@ static int klp_init_patch(struct klp_patch *patch)
 	return 0;
 
 free:
-	klp_free_objects_limited(patch, obj);
+	klp_free_patch_start(patch);
 
 	mutex_unlock(&klp_mutex);
 
-	kobject_put(&patch->kobj);
-	wait_for_completion(&patch->finish);
+	klp_free_patch_finish(patch);
 
 	return ret;
 }
@@ -693,12 +745,11 @@ int klp_unregister_patch(struct klp_patch *patch)
 		goto err;
 	}
 
-	klp_free_patch(patch);
+	klp_free_patch_start(patch);
 
 	mutex_unlock(&klp_mutex);
 
-	kobject_put(&patch->kobj);
-	wait_for_completion(&patch->finish);
+	klp_free_patch_finish(patch);
 
 	return 0;
 err:
-- 
2.13.7


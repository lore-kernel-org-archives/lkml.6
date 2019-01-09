Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9671C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F711206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfAIMo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:44:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:42708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731173AbfAIMnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:43:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B97CAD8C;
        Wed,  9 Jan 2019 12:43:41 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v15 02/11] livepatch: Shuffle klp_enable_patch()/klp_disable_patch() code
Date:   Wed,  9 Jan 2019 13:43:20 +0100
Message-Id: <20190109124329.21991-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190109124329.21991-1-pmladek@suse.com>
References: <20190109124329.21991-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to simplify the API and code by removing the registration
step. This would require calling init/free functions from enable/disable
ones.

This patch just moves the code to prevent more forward declarations.

This patch does not change the code except for two forward declarations.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 kernel/livepatch/core.c | 330 ++++++++++++++++++++++++------------------------
 1 file changed, 166 insertions(+), 164 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index cb59c7fb94cb..20589da35194 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -278,170 +278,6 @@ static int klp_write_object_relocations(struct module *pmod,
 	return ret;
 }
 
-static int __klp_disable_patch(struct klp_patch *patch)
-{
-	struct klp_object *obj;
-
-	if (WARN_ON(!patch->enabled))
-		return -EINVAL;
-
-	if (klp_transition_patch)
-		return -EBUSY;
-
-	/* enforce stacking: only the last enabled patch can be disabled */
-	if (!list_is_last(&patch->list, &klp_patches) &&
-	    list_next_entry(patch, list)->enabled)
-		return -EBUSY;
-
-	klp_init_transition(patch, KLP_UNPATCHED);
-
-	klp_for_each_object(patch, obj)
-		if (obj->patched)
-			klp_pre_unpatch_callback(obj);
-
-	/*
-	 * Enforce the order of the func->transition writes in
-	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
-	 * klp_start_transition().  In the rare case where klp_ftrace_handler()
-	 * is called shortly after klp_update_patch_state() switches the task,
-	 * this ensures the handler sees that func->transition is set.
-	 */
-	smp_wmb();
-
-	klp_start_transition();
-	klp_try_complete_transition();
-	patch->enabled = false;
-
-	return 0;
-}
-
-/**
- * klp_disable_patch() - disables a registered patch
- * @patch:	The registered, enabled patch to be disabled
- *
- * Unregisters the patched functions from ftrace.
- *
- * Return: 0 on success, otherwise error
- */
-int klp_disable_patch(struct klp_patch *patch)
-{
-	int ret;
-
-	mutex_lock(&klp_mutex);
-
-	if (!klp_is_patch_registered(patch)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	if (!patch->enabled) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	ret = __klp_disable_patch(patch);
-
-err:
-	mutex_unlock(&klp_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(klp_disable_patch);
-
-static int __klp_enable_patch(struct klp_patch *patch)
-{
-	struct klp_object *obj;
-	int ret;
-
-	if (klp_transition_patch)
-		return -EBUSY;
-
-	if (WARN_ON(patch->enabled))
-		return -EINVAL;
-
-	/* enforce stacking: only the first disabled patch can be enabled */
-	if (patch->list.prev != &klp_patches &&
-	    !list_prev_entry(patch, list)->enabled)
-		return -EBUSY;
-
-	/*
-	 * A reference is taken on the patch module to prevent it from being
-	 * unloaded.
-	 */
-	if (!try_module_get(patch->mod))
-		return -ENODEV;
-
-	pr_notice("enabling patch '%s'\n", patch->mod->name);
-
-	klp_init_transition(patch, KLP_PATCHED);
-
-	/*
-	 * Enforce the order of the func->transition writes in
-	 * klp_init_transition() and the ops->func_stack writes in
-	 * klp_patch_object(), so that klp_ftrace_handler() will see the
-	 * func->transition updates before the handler is registered and the
-	 * new funcs become visible to the handler.
-	 */
-	smp_wmb();
-
-	klp_for_each_object(patch, obj) {
-		if (!klp_is_object_loaded(obj))
-			continue;
-
-		ret = klp_pre_patch_callback(obj);
-		if (ret) {
-			pr_warn("pre-patch callback failed for object '%s'\n",
-				klp_is_module(obj) ? obj->name : "vmlinux");
-			goto err;
-		}
-
-		ret = klp_patch_object(obj);
-		if (ret) {
-			pr_warn("failed to patch object '%s'\n",
-				klp_is_module(obj) ? obj->name : "vmlinux");
-			goto err;
-		}
-	}
-
-	klp_start_transition();
-	klp_try_complete_transition();
-	patch->enabled = true;
-
-	return 0;
-err:
-	pr_warn("failed to enable patch '%s'\n", patch->mod->name);
-
-	klp_cancel_transition();
-	return ret;
-}
-
-/**
- * klp_enable_patch() - enables a registered patch
- * @patch:	The registered, disabled patch to be enabled
- *
- * Performs the needed symbol lookups and code relocations,
- * then registers the patched functions with ftrace.
- *
- * Return: 0 on success, otherwise error
- */
-int klp_enable_patch(struct klp_patch *patch)
-{
-	int ret;
-
-	mutex_lock(&klp_mutex);
-
-	if (!klp_is_patch_registered(patch)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	ret = __klp_enable_patch(patch);
-
-err:
-	mutex_unlock(&klp_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(klp_enable_patch);
-
 /*
  * Sysfs Interface
  *
@@ -454,6 +290,8 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
+static int __klp_disable_patch(struct klp_patch *patch);
+static int __klp_enable_patch(struct klp_patch *patch);
 
 static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 			     const char *buf, size_t count)
@@ -904,6 +742,170 @@ int klp_register_patch(struct klp_patch *patch)
 }
 EXPORT_SYMBOL_GPL(klp_register_patch);
 
+static int __klp_disable_patch(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+
+	if (WARN_ON(!patch->enabled))
+		return -EINVAL;
+
+	if (klp_transition_patch)
+		return -EBUSY;
+
+	/* enforce stacking: only the last enabled patch can be disabled */
+	if (!list_is_last(&patch->list, &klp_patches) &&
+	    list_next_entry(patch, list)->enabled)
+		return -EBUSY;
+
+	klp_init_transition(patch, KLP_UNPATCHED);
+
+	klp_for_each_object(patch, obj)
+		if (obj->patched)
+			klp_pre_unpatch_callback(obj);
+
+	/*
+	 * Enforce the order of the func->transition writes in
+	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
+	 * klp_start_transition().  In the rare case where klp_ftrace_handler()
+	 * is called shortly after klp_update_patch_state() switches the task,
+	 * this ensures the handler sees that func->transition is set.
+	 */
+	smp_wmb();
+
+	klp_start_transition();
+	klp_try_complete_transition();
+	patch->enabled = false;
+
+	return 0;
+}
+
+/**
+ * klp_disable_patch() - disables a registered patch
+ * @patch:	The registered, enabled patch to be disabled
+ *
+ * Unregisters the patched functions from ftrace.
+ *
+ * Return: 0 on success, otherwise error
+ */
+int klp_disable_patch(struct klp_patch *patch)
+{
+	int ret;
+
+	mutex_lock(&klp_mutex);
+
+	if (!klp_is_patch_registered(patch)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (!patch->enabled) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = __klp_disable_patch(patch);
+
+err:
+	mutex_unlock(&klp_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(klp_disable_patch);
+
+static int __klp_enable_patch(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+	int ret;
+
+	if (klp_transition_patch)
+		return -EBUSY;
+
+	if (WARN_ON(patch->enabled))
+		return -EINVAL;
+
+	/* enforce stacking: only the first disabled patch can be enabled */
+	if (patch->list.prev != &klp_patches &&
+	    !list_prev_entry(patch, list)->enabled)
+		return -EBUSY;
+
+	/*
+	 * A reference is taken on the patch module to prevent it from being
+	 * unloaded.
+	 */
+	if (!try_module_get(patch->mod))
+		return -ENODEV;
+
+	pr_notice("enabling patch '%s'\n", patch->mod->name);
+
+	klp_init_transition(patch, KLP_PATCHED);
+
+	/*
+	 * Enforce the order of the func->transition writes in
+	 * klp_init_transition() and the ops->func_stack writes in
+	 * klp_patch_object(), so that klp_ftrace_handler() will see the
+	 * func->transition updates before the handler is registered and the
+	 * new funcs become visible to the handler.
+	 */
+	smp_wmb();
+
+	klp_for_each_object(patch, obj) {
+		if (!klp_is_object_loaded(obj))
+			continue;
+
+		ret = klp_pre_patch_callback(obj);
+		if (ret) {
+			pr_warn("pre-patch callback failed for object '%s'\n",
+				klp_is_module(obj) ? obj->name : "vmlinux");
+			goto err;
+		}
+
+		ret = klp_patch_object(obj);
+		if (ret) {
+			pr_warn("failed to patch object '%s'\n",
+				klp_is_module(obj) ? obj->name : "vmlinux");
+			goto err;
+		}
+	}
+
+	klp_start_transition();
+	klp_try_complete_transition();
+	patch->enabled = true;
+
+	return 0;
+err:
+	pr_warn("failed to enable patch '%s'\n", patch->mod->name);
+
+	klp_cancel_transition();
+	return ret;
+}
+
+/**
+ * klp_enable_patch() - enables a registered patch
+ * @patch:	The registered, disabled patch to be enabled
+ *
+ * Performs the needed symbol lookups and code relocations,
+ * then registers the patched functions with ftrace.
+ *
+ * Return: 0 on success, otherwise error
+ */
+int klp_enable_patch(struct klp_patch *patch)
+{
+	int ret;
+
+	mutex_lock(&klp_mutex);
+
+	if (!klp_is_patch_registered(patch)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = __klp_enable_patch(patch);
+
+err:
+	mutex_unlock(&klp_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(klp_enable_patch);
+
 /*
  * Remove parts of patches that touch a given kernel module. The list of
  * patches processed might be limited. When limit is NULL, all patches
-- 
2.13.7


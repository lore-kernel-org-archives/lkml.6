Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8242064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8242064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeJOUWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbeJOUWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AF39AE65;
        Mon, 15 Oct 2018 12:37:31 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v13 04/12] livepatch: Consolidate klp_free functions
Date:   Mon, 15 Oct 2018 14:37:05 +0200
Message-Id: <20181015123713.25868-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
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

  + checks kobj.state_initialized instead of @limit

  + initializes patch->list early so that the check for empty list
    always works

  + The action(s) that has to be done outside klp_mutex are done
    in separate klp_free_patch_finish() function. It waits only
    when patch->kobj was really released via the _start() part.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
---
 kernel/livepatch/core.c | 79 +++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index b3956cce239e..17cb974522d0 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -465,17 +465,15 @@ static struct kobj_type klp_ktype_func = {
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
+		if (func->kobj.state_initialized)
+			kobject_put(&func->kobj);
+	}
 }
 
 /* Clean up when a patched object is unloaded */
@@ -489,26 +487,46 @@ static void klp_free_object_loaded(struct klp_object *obj)
 		func->old_addr = 0;
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
+		if (obj->kobj.state_initialized)
+			kobject_put(&obj->kobj);
 	}
 }
 
-static void klp_free_patch(struct klp_patch *patch)
+/*
+ * Some operations are synchronized by klp_mutex, e.g. the access to
+ * klp_patches list. But the caller has to put patch->kobj outside
+ * the lock. Otherwise, there might be a deadlock with sysfs operations
+ * waiting on klp_mutex.
+ *
+ * This function implements the free part that has to be called under
+ * klp_mutex.
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
+ */
+static void klp_free_patch_finish(struct klp_patch *patch)
+{
+	if (patch->kobj.state_initialized) {
+		kobject_put(&patch->kobj);
+		wait_for_completion(&patch->finish);
+	}
 }
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
@@ -609,20 +627,12 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
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
 
-	return 0;
-
-free:
-	klp_free_funcs_limited(obj, func);
-	kobject_put(&obj->kobj);
 	return ret;
 }
 
@@ -637,6 +647,7 @@ static int klp_init_patch(struct klp_patch *patch)
 	mutex_lock(&klp_mutex);
 
 	patch->enabled = false;
+	INIT_LIST_HEAD(&patch->list);
 	init_completion(&patch->finish);
 
 	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
@@ -659,12 +670,11 @@ static int klp_init_patch(struct klp_patch *patch)
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
@@ -693,12 +703,11 @@ int klp_unregister_patch(struct klp_patch *patch)
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


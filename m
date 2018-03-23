Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeCWMC2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39567 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbeCWMAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:00:51 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/8] livepatch: Free only structures with initialized kobject
Date: Fri, 23 Mar 2018 13:00:22 +0100
Message-Id: <20180323120028.31451-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180323120028.31451-1-pmladek@suse.com>
References: <20180323120028.31451-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to add a feature called atomic replace. It will allow to
create a patch that would replace all already registered patches.
For this, we will need to dynamically create funcs and objects
for functions that are no longer patched.

We will want to reuse the existing init() and free() functions. Up to now,
the free() functions checked a limit and were called only for structures
with initialized kobject. But we will want to call them also for structures
that were allocated but where the kobject was not initialized yet.

This patch removes the limit. It calls klp_free*() functions for all
structures. But only the ones with initialized kobject are freed.
The handling of un-initialized structures will be added later with
the support for dynamic structures.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 56cb0574c59c..dcce028ecde8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -642,17 +642,15 @@ static struct kobj_type klp_ktype_func = {
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
@@ -666,24 +664,23 @@ static void klp_free_object_loaded(struct klp_object *obj)
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
 
 static void klp_free_patch(struct klp_patch *patch)
 {
-	klp_free_objects_limited(patch, NULL);
+	klp_free_objects(patch);
+
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
 }
@@ -780,21 +777,16 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	klp_for_each_func(obj, func) {
 		ret = klp_init_func(obj, func);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
 	if (klp_is_object_loaded(obj)) {
 		ret = klp_init_object_loaded(patch, obj);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
 	return 0;
-
-free:
-	klp_free_funcs_limited(obj, func);
-	kobject_put(&obj->kobj);
-	return ret;
 }
 
 static int klp_init_patch(struct klp_patch *patch)
@@ -831,7 +823,7 @@ static int klp_init_patch(struct klp_patch *patch)
 	return 0;
 
 free:
-	klp_free_objects_limited(patch, obj);
+	klp_free_objects(patch);
 
 	mutex_unlock(&klp_mutex);
 
-- 
2.13.6

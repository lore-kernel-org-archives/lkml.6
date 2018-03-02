Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946291AbeCBKes (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:34:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:35617 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946100AbeCBK3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:49 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v9 4/9] livepatch: Allow to unpatch only functions of the given type
Date: Fri,  2 Mar 2018 11:29:30 +0100
Message-Id: <20180302102935.14564-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180302102935.14564-1-pmladek@suse.com>
References: <20180302102935.14564-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

We are going to add a feature called atomic replace. It will allow to
create a patch that would replace all already registered patches.
For this, we will need to dynamically create funcs and objects
for functions that are no longer patched.

The dynamically allocated objects will not longer be needed once
the patch is applied.

This patch allows to unpatch functions of the given type. It might
cause that the obj->patched flag is true even when some listed
functions are not longer patched. This is fine as long as the
unpatched funcs' structures are removed right after. It will
be the case. Anyway, it is safe. In the worst case, it will
not be possible to enable the disabled functions.

Signed-off-by: Jason Baron <jbaron@akamai.com>
[pmladek@suse.com: Split and modified to use the generic ftype]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c       |  2 +-
 kernel/livepatch/patch.c      | 26 +++++++++++++++++++-------
 kernel/livepatch/patch.h      |  4 ++--
 kernel/livepatch/transition.c |  2 +-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a47c26147c17..ab1f6a371fc8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1060,7 +1060,7 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 
 				pr_notice("reverting patch '%s' on unloading module '%s'\n",
 					  patch->mod->name, obj->mod->name);
-				klp_unpatch_object(obj);
+				klp_unpatch_object(obj, KLP_FUNC_ANY);
 
 				klp_post_unpatch_callback(obj);
 			}
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 82d584225dc6..54b3c379bb0f 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -236,15 +236,27 @@ static int klp_patch_func(struct klp_func *func)
 	return ret;
 }
 
-void klp_unpatch_object(struct klp_object *obj)
+/*
+ * It keeps obj->patched flag true when any listed function is still patched.
+ * The caller is responsible for removing the unpatched functions to
+ * make the flag clean again.
+ */
+void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype)
 {
 	struct klp_func *func;
+	bool patched = false;
 
-	klp_for_each_func(obj, func)
-		if (func->patched)
+	klp_for_each_func(obj, func) {
+		if (!func->patched)
+			continue;
+
+		if (klp_is_func_type(func, ftype))
 			klp_unpatch_func(func);
+		else
+			patched = true;
+	}
 
-	obj->patched = false;
+	obj->patched = patched;
 }
 
 int klp_patch_object(struct klp_object *obj)
@@ -258,7 +270,7 @@ int klp_patch_object(struct klp_object *obj)
 	klp_for_each_func(obj, func) {
 		ret = klp_patch_func(func);
 		if (ret) {
-			klp_unpatch_object(obj);
+			klp_unpatch_object(obj, KLP_FUNC_ANY);
 			return ret;
 		}
 	}
@@ -267,11 +279,11 @@ int klp_patch_object(struct klp_object *obj)
 	return 0;
 }
 
-void klp_unpatch_objects(struct klp_patch *patch)
+void klp_unpatch_objects(struct klp_patch *patch, enum klp_func_type ftype)
 {
 	struct klp_object *obj;
 
 	klp_for_each_object(patch, obj)
 		if (obj->patched)
-			klp_unpatch_object(obj);
+			klp_unpatch_object(obj, ftype);
 }
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index e72d8250d04b..885f644add4c 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -28,7 +28,7 @@ struct klp_ops {
 struct klp_ops *klp_find_ops(unsigned long old_addr);
 
 int klp_patch_object(struct klp_object *obj);
-void klp_unpatch_object(struct klp_object *obj);
-void klp_unpatch_objects(struct klp_patch *patch);
+void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype);
+void klp_unpatch_objects(struct klp_patch *patch, enum klp_func_type ftype);
 
 #endif /* _LIVEPATCH_PATCH_H */
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 7c6631e693bc..6917100fbe79 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -92,7 +92,7 @@ static void klp_complete_transition(void)
 		 * All tasks have transitioned to KLP_UNPATCHED so we can now
 		 * remove the new functions from the func_stack.
 		 */
-		klp_unpatch_objects(klp_transition_patch);
+		klp_unpatch_objects(klp_transition_patch, KLP_FUNC_ANY);
 
 		/*
 		 * Make sure klp_ftrace_handler() can no longer see functions
-- 
2.13.6

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946130AbeCBK36 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:29:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946112AbeCBK3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:51 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v9 5/9] livepatch: Support separate list for replaced patches.
Date: Fri,  2 Mar 2018 11:29:31 +0100
Message-Id: <20180302102935.14564-6-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180302102935.14564-1-pmladek@suse.com>
References: <20180302102935.14564-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

We are going to add a feature called atomic replace. It will allow to
create a patch that would replace all already registered patches.

The replaced patches will stay registered because they are typically
unregistered by some package uninstall scripts. But we will remove
these patches from @klp_patches list to keep the enabled patch
on the bottom of the stack. Otherwise, we would need to implement
rather complex logic for moving the patches on the stack. Also
it would complicate implementation of the atomic replace feature.
It is not worth it.

As a result, we will have patches that are registered but that
are no longer usable. Let's get prepared for this and use
a better descriptive name for klp_is_patch_registered() function.

Also create separate list for the replaced patches and allow to
unregister them. Alternative solution would be to add a flag
into struct klp_patch. Note that patch->kobj.state_initialized
is not safe because it can be cleared outside klp_mutex.

This patch does not change the existing behavior.

Signed-off-by: Jason Baron <jbaron@akamai.com>
[pmladek@suse.com: Split and renamed klp_is_patch_usable()]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ab1f6a371fc8..fd0296859ff4 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -47,6 +47,13 @@ DEFINE_MUTEX(klp_mutex);
 
 static LIST_HEAD(klp_patches);
 
+/*
+ * List of 'replaced' patches that have been replaced by a patch that has the
+ * 'replace' bit set. When they are added to this list, they are disabled and
+ * can not be re-enabled, but they can be unregistered().
+ */
+static LIST_HEAD(klp_replaced_patches);
+
 static struct kobject *klp_root_kobj;
 
 static void klp_init_func_list(struct klp_object *obj, struct klp_func *func)
@@ -108,17 +115,28 @@ static void klp_find_object_module(struct klp_object *obj)
 	mutex_unlock(&module_mutex);
 }
 
-static bool klp_is_patch_registered(struct klp_patch *patch)
+static bool klp_is_patch_in_list(struct klp_patch *patch,
+				 struct list_head *head)
 {
 	struct klp_patch *mypatch;
 
-	list_for_each_entry(mypatch, &klp_patches, list)
+	list_for_each_entry(mypatch, head, list)
 		if (mypatch == patch)
 			return true;
 
 	return false;
 }
 
+static bool klp_is_patch_usable(struct klp_patch *patch)
+{
+	return klp_is_patch_in_list(patch, &klp_patches);
+}
+
+static bool klp_is_patch_replaced(struct klp_patch *patch)
+{
+	return klp_is_patch_in_list(patch, &klp_replaced_patches);
+}
+
 static bool klp_initialized(void)
 {
 	return !!klp_root_kobj;
@@ -375,7 +393,7 @@ int klp_disable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
+	if (!klp_is_patch_usable(patch)) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -475,7 +493,7 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
+	if (!klp_is_patch_usable(patch)) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -516,7 +534,7 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
+	if (!klp_is_patch_usable(patch)) {
 		/*
 		 * Module with the patch could either disappear meanwhile or is
 		 * not properly initialized yet.
@@ -971,7 +989,7 @@ int klp_unregister_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
+	if (!klp_is_patch_usable(patch) && !klp_is_patch_replaced(patch)) {
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.13.6

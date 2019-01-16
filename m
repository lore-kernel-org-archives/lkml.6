Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91FAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73A820651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405360AbfAPQR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:17:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:38728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405356AbfAPQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:17:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B98A6AEB1;
        Wed, 16 Jan 2019 16:17:51 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4/4] livepatch: Remove the redundant enabled flag in struct klp_patch
Date:   Wed, 16 Jan 2019 17:17:20 +0100
Message-Id: <20190116161720.796-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190116161720.796-1-pmladek@suse.com>
References: <20190116161720.796-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Livepatches can not longer get enabled and disabled repeatedly.
The list klp_patches contains only enabled patches and eventually
the patch in transition. As a result, the enabled flag in
struct klp_patch provides redundant information and can get
removed.

The flag is replaced by helper function klp_patch_enabled().
It simplifies the code. Also it helps to understand the semantic,
especially for the patch in transition.

Alternative solution was to remove klp_target_state. But this
would be unfortunate. The three state variable helps to
catch bugs and regressions. Also it makes it easier to get
the state a lockless way in klp_update_patch_state().

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h     |  2 --
 kernel/livepatch/core.c       | 23 +++++++++++++++--------
 kernel/livepatch/transition.c |  7 +++----
 kernel/livepatch/transition.h |  1 +
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 53551f470722..fa68192e6bb2 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -155,7 +155,6 @@ struct klp_object {
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
  * @kobj_added: @kobj has been added and needs freeing
- * @enabled:	the patch is enabled (but operation may be incomplete)
  * @forced:	was involved in a forced transition
  * @free_work:	patch cleanup from workqueue-context
  * @finish:	for waiting till it is safe to remove the patch module
@@ -171,7 +170,6 @@ struct klp_patch {
 	struct kobject kobj;
 	struct list_head obj_list;
 	bool kobj_added;
-	bool enabled;
 	bool forced;
 	struct work_struct free_work;
 	struct completion finish;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 684766d306ad..8e644837e668 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -59,6 +59,17 @@ static bool klp_is_module(struct klp_object *obj)
 	return obj->name;
 }
 
+static bool klp_patch_enabled(struct klp_patch *patch)
+{
+	if (patch == klp_transition_patch) {
+		WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
+
+		return klp_target_state == KLP_PATCHED;
+	}
+
+	return !list_empty(&patch->list);
+}
+
 /* sets obj->mod if object is not vmlinux and module is found */
 static void klp_find_object_module(struct klp_object *obj)
 {
@@ -335,7 +346,7 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_lock(&klp_mutex);
 
-	if (patch->enabled == enabled) {
+	if (klp_patch_enabled(patch) == enabled) {
 		/* already in requested state */
 		ret = -EINVAL;
 		goto out;
@@ -369,7 +380,7 @@ static ssize_t enabled_show(struct kobject *kobj,
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->enabled);
+	return snprintf(buf, PAGE_SIZE-1, "%d\n", klp_patch_enabled(patch));
 }
 
 static ssize_t transition_show(struct kobject *kobj,
@@ -862,7 +873,6 @@ static int klp_init_patch_early(struct klp_patch *patch)
 	INIT_LIST_HEAD(&patch->list);
 	INIT_LIST_HEAD(&patch->obj_list);
 	patch->kobj_added = false;
-	patch->enabled = false;
 	patch->forced = false;
 	INIT_WORK(&patch->free_work, klp_free_patch_work_fn);
 	init_completion(&patch->finish);
@@ -919,7 +929,7 @@ static int __klp_disable_patch(struct klp_patch *patch)
 {
 	struct klp_object *obj;
 
-	if (WARN_ON(!patch->enabled))
+	if (WARN_ON(!klp_patch_enabled(patch)))
 		return -EINVAL;
 
 	if (klp_transition_patch)
@@ -941,7 +951,6 @@ static int __klp_disable_patch(struct klp_patch *patch)
 	smp_wmb();
 
 	klp_start_transition();
-	patch->enabled = false;
 	klp_try_complete_transition();
 
 	return 0;
@@ -955,7 +964,7 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	if (klp_transition_patch)
 		return -EBUSY;
 
-	if (WARN_ON(patch->enabled))
+	if (list_empty(&patch->list))
 		return -EINVAL;
 
 	if (!patch->kobj_added)
@@ -994,7 +1003,6 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	}
 
 	klp_start_transition();
-	patch->enabled = true;
 	klp_try_complete_transition();
 
 	return 0;
@@ -1093,7 +1101,6 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch)
 		if (old_patch == new_patch)
 			return;
 
-		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
 		klp_free_patch_start(old_patch);
 		schedule_work(&old_patch->free_work);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index a3a6f32c6fd0..a40b58660640 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -31,7 +31,7 @@
 
 struct klp_patch *klp_transition_patch;
 
-static int klp_target_state = KLP_UNDEFINED;
+int klp_target_state = KLP_UNDEFINED;
 
 /*
  * This work can be performed periodically to finish patching or unpatching any
@@ -354,6 +354,7 @@ static bool klp_try_switch_task(struct task_struct *task)
 void klp_try_complete_transition(void)
 {
 	unsigned int cpu;
+	int target_state = klp_target_state;
 	struct task_struct *g, *task;
 	struct klp_patch *patch;
 	bool complete = true;
@@ -412,7 +413,7 @@ void klp_try_complete_transition(void)
 	 * klp_complete_transition() but it is called also
 	 * from klp_cancel_transition().
 	 */
-	if (!patch->enabled) {
+	if (target_state == KLP_UNPATCHED) {
 		klp_free_patch_start(patch);
 		schedule_work(&patch->free_work);
 	}
@@ -545,8 +546,6 @@ void klp_reverse_transition(void)
 		 klp_target_state == KLP_PATCHED ? "patching to unpatching" :
 						   "unpatching to patching");
 
-	klp_transition_patch->enabled = !klp_transition_patch->enabled;
-
 	klp_target_state = !klp_target_state;
 
 	/*
diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
index f9d0bc016067..b9f3e96d8c13 100644
--- a/kernel/livepatch/transition.h
+++ b/kernel/livepatch/transition.h
@@ -5,6 +5,7 @@
 #include <linux/livepatch.h>
 
 extern struct klp_patch *klp_transition_patch;
+extern int klp_target_state;
 
 void klp_init_transition(struct klp_patch *patch, int state);
 void klp_cancel_transition(void);
-- 
2.13.7


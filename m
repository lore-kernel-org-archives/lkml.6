Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C9C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03922064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03922064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJOUWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbeJOUWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0EB7AE15;
        Mon, 15 Oct 2018 12:37:32 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 05/12] livepatch: Refuse to unload only livepatches available during a forced transition
Date:   Mon, 15 Oct 2018 14:37:06 +0200
Message-Id: <20181015123713.25868-6-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_put() is currently never called in klp_complete_transition() when
klp_force is set. As a result, we might keep the reference count even when
klp_enable_patch() fails and klp_cancel_transition() is called.

This might make an assumption that a module might get blocked in some
strange init state. Fortunately, it is not the case. The reference count
is ignored when mod->init fails and erroneous modules are always removed.

Anyway, this might make some confusion. Instead, this patch moves
the global klp_forced flag into struct klp_patch. As a result,
we block only modules that might still be in use after a forced
transition. Newly loaded livepatches might be eventually completely
removed later.

It is not a big deal. But the code is at least consistent with
the reality.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h     |  2 ++
 kernel/livepatch/core.c       |  4 +++-
 kernel/livepatch/core.h       |  1 +
 kernel/livepatch/transition.c | 10 +++++-----
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 1163742b27c0..77fce7d385df 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -138,6 +138,7 @@ struct klp_object {
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @enabled:	the patch is enabled (but operation may be incomplete)
+ * @forced:	was involved in a forced transition
  * @finish:	for waiting till it is safe to remove the patch module
  */
 struct klp_patch {
@@ -149,6 +150,7 @@ struct klp_patch {
 	struct list_head list;
 	struct kobject kobj;
 	bool enabled;
+	bool forced;
 	struct completion finish;
 };
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 17cb974522d0..f38637326ac2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -45,7 +45,8 @@
  */
 DEFINE_MUTEX(klp_mutex);
 
-static LIST_HEAD(klp_patches);
+/* Registered patches */
+LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
 
@@ -647,6 +648,7 @@ static int klp_init_patch(struct klp_patch *patch)
 	mutex_lock(&klp_mutex);
 
 	patch->enabled = false;
+	patch->forced = false;
 	INIT_LIST_HEAD(&patch->list);
 	init_completion(&patch->finish);
 
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 48a83d4364cf..d0cb5390e247 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -5,6 +5,7 @@
 #include <linux/livepatch.h>
 
 extern struct mutex klp_mutex;
+extern struct list_head klp_patches;
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 982a2e4c6120..30a28634c88c 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -33,8 +33,6 @@ struct klp_patch *klp_transition_patch;
 
 static int klp_target_state = KLP_UNDEFINED;
 
-static bool klp_forced = false;
-
 /*
  * This work can be performed periodically to finish patching or unpatching any
  * "straggler" tasks which failed to transition in the first attempt.
@@ -137,10 +135,10 @@ static void klp_complete_transition(void)
 		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
 	/*
-	 * klp_forced set implies unbounded increase of module's ref count if
+	 * patch->forced set implies unbounded increase of module's ref count if
 	 * the module is disabled/enabled in a loop.
 	 */
-	if (!klp_forced && klp_target_state == KLP_UNPATCHED)
+	if (!klp_transition_patch->forced && klp_target_state == KLP_UNPATCHED)
 		module_put(klp_transition_patch->mod);
 
 	klp_target_state = KLP_UNDEFINED;
@@ -620,6 +618,7 @@ void klp_send_signals(void)
  */
 void klp_force_transition(void)
 {
+	struct klp_patch *patch;
 	struct task_struct *g, *task;
 	unsigned int cpu;
 
@@ -633,5 +632,6 @@ void klp_force_transition(void)
 	for_each_possible_cpu(cpu)
 		klp_update_patch_state(idle_task(cpu));
 
-	klp_forced = true;
+	list_for_each_entry(patch, &klp_patches, list)
+		patch->forced = true;
 }
-- 
2.13.7


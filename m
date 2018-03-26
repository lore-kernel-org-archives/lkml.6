Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeCZVWJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:22:09 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:43900 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeCZVWH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:07 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/6] sched/core: Update preempt_notifier_key to modern api
Date: Mon, 26 Mar 2018 14:09:26 -0700
Message-Id: <20180326210929.5244-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sched/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 757d5a251ca4..bf9e773007e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2462,17 +2462,17 @@ void wake_up_new_task(struct task_struct *p)
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
-static struct static_key preempt_notifier_key = STATIC_KEY_INIT_FALSE;
+static DEFINE_STATIC_KEY_FALSE(preempt_notifier_key);
 
 void preempt_notifier_inc(void)
 {
-	static_key_slow_inc(&preempt_notifier_key);
+	static_branch_inc(&preempt_notifier_key);
 }
 EXPORT_SYMBOL_GPL(preempt_notifier_inc);
 
 void preempt_notifier_dec(void)
 {
-	static_key_slow_dec(&preempt_notifier_key);
+	static_branch_dec(&preempt_notifier_key);
 }
 EXPORT_SYMBOL_GPL(preempt_notifier_dec);
 
@@ -2482,7 +2482,7 @@ EXPORT_SYMBOL_GPL(preempt_notifier_dec);
  */
 void preempt_notifier_register(struct preempt_notifier *notifier)
 {
-	if (!static_key_false(&preempt_notifier_key))
+	if (!static_branch_unlikely(&preempt_notifier_key))
 		WARN(1, "registering preempt_notifier while notifiers disabled\n");
 
 	hlist_add_head(&notifier->link, &current->preempt_notifiers);
@@ -2511,7 +2511,7 @@ static void __fire_sched_in_preempt_notifiers(struct task_struct *curr)
 
 static __always_inline void fire_sched_in_preempt_notifiers(struct task_struct *curr)
 {
-	if (static_key_false(&preempt_notifier_key))
+	if (static_branch_unlikely(&preempt_notifier_key))
 		__fire_sched_in_preempt_notifiers(curr);
 }
 
@@ -2529,7 +2529,7 @@ static __always_inline void
 fire_sched_out_preempt_notifiers(struct task_struct *curr,
 				 struct task_struct *next)
 {
-	if (static_key_false(&preempt_notifier_key))
+	if (static_branch_unlikely(&preempt_notifier_key))
 		__fire_sched_out_preempt_notifiers(curr, next);
 }
 
-- 
2.13.6

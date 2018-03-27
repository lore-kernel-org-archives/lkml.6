Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeC0HrO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:47:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeC0HrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:47:13 -0400
Date: Tue, 27 Mar 2018 00:46:29 -0700
From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-b720342849fe685310fca01748a32730a6eca5aa@git.kernel.org>
Cc: mingo@kernel.org, dave@stgolabs.net, peterz@infradead.org,
        dbueso@suse.de, torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: dbueso@suse.de, tglx@linutronix.de, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave@stgolabs.net, peterz@infradead.org
In-Reply-To: <20180326210929.5244-4-dave@stgolabs.net>
References: <20180326210929.5244-4-dave@stgolabs.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Update preempt_notifier_key to modern
 API
Git-Commit-ID: b720342849fe685310fca01748a32730a6eca5aa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b720342849fe685310fca01748a32730a6eca5aa
Gitweb:     https://git.kernel.org/tip/b720342849fe685310fca01748a32730a6eca5aa
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Mon, 26 Mar 2018 14:09:26 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Mar 2018 07:51:45 +0200

sched/core: Update preempt_notifier_key to modern API

No changes in refcount semantics, use DEFINE_STATIC_KEY_FALSE()
for initialization and replace:

  static_key_slow_inc|dec()   =>   static_branch_inc|dec()
  static_key_false()          =>   static_branch_unlikely()

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Link: http://lkml.kernel.org/r/20180326210929.5244-4-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b249adbf2a48..de440456f15c 100644
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
 

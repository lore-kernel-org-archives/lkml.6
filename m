Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDFKlu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:41:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:25697 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeDFKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:41:49 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] lockdep: Use for_each_process_thread() for debug_show_all_locks()
Date: Fri,  6 Apr 2018 19:41:18 +0900
Message-Id: <1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_show_all_locks() tries to grab tasklist_lock for two seconds, but
calling while_each_thread() without tasklist_lock held is not safe.
See commit 4449a51a7c281602 ("vm_is_stack: use for_each_thread() rather
then buggy while_each_thread()") for more information.

Change debug_show_all_locks() from "do_each_thread()/while_each_thread()
with possibility of missing tasklist_lock" to "for_each_process_thread()
with RCU", and add a call to touch_all_softlockup_watchdogs() like
show_state_filter() does.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/locking/lockdep.c | 43 ++++++++-----------------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0233863..94f4d21 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4451,8 +4451,6 @@ void debug_check_no_locks_held(void)
 void debug_show_all_locks(void)
 {
 	struct task_struct *g, *p;
-	int count = 10;
-	int unlock = 1;
 
 	if (unlikely(!debug_locks)) {
 		pr_warn("INFO: lockdep is turned off.\n");
@@ -4460,30 +4458,8 @@ void debug_show_all_locks(void)
 	}
 	pr_warn("\nShowing all locks held in the system:\n");
 
-	/*
-	 * Here we try to get the tasklist_lock as hard as possible,
-	 * if not successful after 2 seconds we ignore it (but keep
-	 * trying). This is to enable a debug printout even if a
-	 * tasklist_lock-holding task deadlocks or crashes.
-	 */
-retry:
-	if (!read_trylock(&tasklist_lock)) {
-		if (count == 10)
-			pr_warn("hm, tasklist_lock locked, retrying... ");
-		if (count) {
-			count--;
-			pr_cont(" #%d", 10-count);
-			mdelay(200);
-			goto retry;
-		}
-		pr_cont(" ignoring it.\n");
-		unlock = 0;
-	} else {
-		if (count != 10)
-			pr_cont(" locked it.\n");
-	}
-
-	do_each_thread(g, p) {
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
 		/*
 		 * It's not reliable to print a task's held locks
 		 * if it's not sleeping (or if it's not the current
@@ -4491,19 +4467,16 @@ void debug_show_all_locks(void)
 		 */
 		if (p->state == TASK_RUNNING && p != current)
 			continue;
-		if (p->lockdep_depth)
-			lockdep_print_held_locks(p);
-		if (!unlock)
-			if (read_trylock(&tasklist_lock))
-				unlock = 1;
+		if (!p->lockdep_depth)
+			continue;
+		lockdep_print_held_locks(p);
 		touch_nmi_watchdog();
-	} while_each_thread(g, p);
+		touch_all_softlockup_watchdogs();
+	}
+	rcu_read_unlock();
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
-
-	if (unlock)
-		read_unlock(&tasklist_lock);
 }
 EXPORT_SYMBOL_GPL(debug_show_all_locks);
 #endif
-- 
1.8.3.1

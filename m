Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeENHyE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:54:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeENHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:54:00 -0400
Date: Mon, 14 May 2018 00:53:38 -0700
From: tip-bot for Tetsuo Handa <tipbot@zytor.com>
Message-ID: <tip-0f736a52e4be86476eec1d5adbcbd9c2809ac4b4@git.kernel.org>
Cc: penguin-kernel@I-love.SAKURA.ne.jp, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        penguin-kernel@I-love.SAKURA.ne.jp, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Use for_each_process_thread()
 for debug_show_all_locks()
Git-Commit-ID: 0f736a52e4be86476eec1d5adbcbd9c2809ac4b4
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

Commit-ID:  0f736a52e4be86476eec1d5adbcbd9c2809ac4b4
Gitweb:     https://git.kernel.org/tip/0f736a52e4be86476eec1d5adbcbd9c2809ac4b4
Author:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate: Fri, 6 Apr 2018 19:41:18 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 09:15:02 +0200

locking/lockdep: Use for_each_process_thread() for debug_show_all_locks()

debug_show_all_locks() tries to grab the tasklist_lock for two seconds, but
calling while_each_thread() without tasklist_lock held is not safe.

See the following commit for more information:

  4449a51a7c281602 ("vm_is_stack: use for_each_thread() rather then buggy while_each_thread()")

Change debug_show_all_locks() from "do_each_thread()/while_each_thread()
with possibility of missing tasklist_lock" to "for_each_process_thread()
with RCU", and add a call to touch_all_softlockup_watchdogs() like
show_state_filter() does.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 43 ++++++++-----------------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 023386338269..94f4d21ff66d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4451,8 +4451,6 @@ EXPORT_SYMBOL_GPL(debug_check_no_locks_held);
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
@@ -4491,19 +4467,16 @@ retry:
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

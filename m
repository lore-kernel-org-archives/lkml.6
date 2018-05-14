Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeENHyg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:54:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbeENHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:54:34 -0400
Date: Mon, 14 May 2018 00:54:10 -0700
From: tip-bot for Tetsuo Handa <tipbot@zytor.com>
Message-ID: <tip-8cc05c71ba5f793690bb72aeb404dce65b5d4b52@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        penguin-kernel@I-love.SAKURA.ne.jp, mingo@kernel.org,
        tglx@linutronix.de, willy@infradead.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, hpa@zytor.com
Reply-To: willy@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dvyukov@google.com, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp
In-Reply-To: <1523011279-8206-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1523011279-8206-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Move sanity check to inside
 lockdep_print_held_locks()
Git-Commit-ID: 8cc05c71ba5f793690bb72aeb404dce65b5d4b52
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

Commit-ID:  8cc05c71ba5f793690bb72aeb404dce65b5d4b52
Gitweb:     https://git.kernel.org/tip/8cc05c71ba5f793690bb72aeb404dce65b5d4b52
Author:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate: Fri, 6 Apr 2018 19:41:19 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 09:15:02 +0200

locking/lockdep: Move sanity check to inside lockdep_print_held_locks()

Calling lockdep_print_held_locks() on a running thread is considered unsafe.

Since all callers should follow that rule and the sanity check is not heavy,
this patch moves the sanity check to inside lockdep_print_held_locks().

As a side effect of this patch, the number of locks held by running threads
will be printed as well. This change will be preferable when we want to
know which threads might be relevant to a problem but are unable to print
any clues because that thread is running.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1523011279-8206-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 94f4d21ff66d..edcac5de7ebc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -561,20 +561,24 @@ static void print_lock(struct held_lock *hlock)
 	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
-static void lockdep_print_held_locks(struct task_struct *curr)
+static void lockdep_print_held_locks(struct task_struct *p)
 {
-	int i, depth = curr->lockdep_depth;
+	int i, depth = READ_ONCE(p->lockdep_depth);
 
-	if (!depth) {
-		printk("no locks held by %s/%d.\n", curr->comm, task_pid_nr(curr));
+	if (!depth)
+		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
+	else
+		printk("%d lock%s held by %s/%d:\n", depth,
+		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+	/*
+	 * It's not reliable to print a task's held locks if it's not sleeping
+	 * and it's not the current task.
+	 */
+	if (p->state == TASK_RUNNING && p != current)
 		return;
-	}
-	printk("%d lock%s held by %s/%d:\n",
-		depth, depth > 1 ? "s" : "", curr->comm, task_pid_nr(curr));
-
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
-		print_lock(curr->held_locks + i);
+		print_lock(p->held_locks + i);
 	}
 }
 
@@ -4460,13 +4464,6 @@ void debug_show_all_locks(void)
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-		/*
-		 * It's not reliable to print a task's held locks
-		 * if it's not sleeping (or if it's not the current
-		 * task):
-		 */
-		if (p->state == TASK_RUNNING && p != current)
-			continue;
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);

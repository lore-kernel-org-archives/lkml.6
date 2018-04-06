Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDFKly (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:41:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:25713 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeDFKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:41:52 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] lockdep: Move sanity check to inside lockdep_print_held_locks().
Date: Fri,  6 Apr 2018 19:41:19 +0900
Message-Id: <1523011279-8206-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1523011279-8206-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is considered that calling lockdep_print_held_locks() on a running
thread is not safe. Since all callers should follow that rule and the
sanity check is not heavy, this patch moves the sanity check to inside
lockdep_print_held_locks().

As a side effect of this patch, number of locks held by running threads
will be printed as well. This change will be preferable when we want to
know which threads might be relevant to a problem but unable to print
any clue because that thread is running.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/locking/lockdep.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 94f4d21..edcac5d 100644
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
-- 
1.8.3.1

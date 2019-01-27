Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA4EC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC321917
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfA0LFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:05:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfA0LFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:05:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gniFO-0001s2-Df; Sun, 27 Jan 2019 12:05:06 +0100
Subject: [GIT pull] locking updates for 5.0
From:   Thomas Gleixner <tglx@linutronix.de>
Message-ID: <154858670614.17124.13586792661477887597.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
Date:   Sun, 27 Jan 2019 12:05:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

A small series of fixes which all address possible missed wakeups:

 - Document and fix the wakeup ordering of wake_q

 - Add the missing barrier in rcuwait_wake_up(), which was documented in
   the comment but missing in the code

 - Fix the possible missed wakeups in the rwsem and futex code

Thanks,

	tglx

------------------>
Peter Zijlstra (3):
      sched/wake_q: Document wake_q_add()
      sched/wake_q: Fix wakeup ordering for wake_q
      futex: Fix (possible) missed wakeup

Prateek Sood (1):
      sched/wait: Fix rcuwait_wake_up() ordering

Xie Yongji (1):
      locking/rwsem: Fix (possible) missed wakeup


 include/linux/sched/wake_q.h |  6 +++++-
 kernel/exit.c                |  2 +-
 kernel/futex.c               | 13 ++++++++-----
 kernel/locking/rwsem-xadd.c  | 11 +++++++++--
 kernel/sched/core.c          | 19 ++++++++++++++++---
 5 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 10b19a192b2d..545f37138057 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -24,9 +24,13 @@
  * called near the end of a function. Otherwise, the list can be
  * re-initialized for later re-use by wake_q_init().
  *
- * Note that this can cause spurious wakeups. schedule() callers
+ * NOTE that this can cause spurious wakeups. schedule() callers
  * must ensure the call is done inside a loop, confirming that the
  * wakeup condition has in fact occurred.
+ *
+ * NOTE that there is no guarantee the wakeup will happen any later than the
+ * wake_q_add() location. Therefore task must be ready to be woken at the
+ * location of the wake_q_add().
  */
 
 #include <linux/sched.h>
diff --git a/kernel/exit.c b/kernel/exit.c
index 284f2fe9a293..3fb7be001964 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -307,7 +307,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 *        MB (A)	      MB (B)
 	 *    [L] cond		  [L] tsk
 	 */
-	smp_rmb(); /* (B) */
+	smp_mb(); /* (B) */
 
 	/*
 	 * Avoid using task_rcu_dereference() magic as long as we are careful,
diff --git a/kernel/futex.c b/kernel/futex.c
index be3bff2315ff..fdd312da0992 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1452,11 +1452,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
 		return;
 
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock. wake_q_add() grabs reference to p.
-	 */
-	wake_q_add(wake_q, p);
+	get_task_struct(p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
@@ -1466,6 +1462,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * plist_del in __unqueue_futex().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
+	 */
+	wake_q_add(wake_q, p);
+	put_task_struct(p);
 }
 
 /*
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 09b180063ee1..50d9af615dc4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -198,15 +198,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		woken++;
 		tsk = waiter->task;
 
-		wake_q_add(wake_q, tsk);
+		get_task_struct(tsk);
 		list_del(&waiter->list);
 		/*
-		 * Ensure that the last operation is setting the reader
+		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
 		smp_store_release(&waiter->task, NULL);
+		/*
+		 * Ensure issuing the wakeup (either by us or someone else)
+		 * after setting the reader waiter to nil.
+		 */
+		wake_q_add(wake_q, tsk);
+		/* wake_q_add() already take the task ref */
+		put_task_struct(tsk);
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a674c7db2f29..d8d76a65cfdd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -396,6 +396,18 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
+/**
+ * wake_q_add() - queue a wakeup for 'later' waking.
+ * @head: the wake_q_head to add @task to
+ * @task: the task to queue for 'later' wakeup
+ *
+ * Queue a task for later wakeup, most likely by the wake_up_q() call in the
+ * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
+ * instantly.
+ *
+ * This function must be used as-if it were wake_up_process(); IOW the task
+ * must be ready to be woken at this location.
+ */
 void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 {
 	struct wake_q_node *node = &task->wake_q;
@@ -405,10 +417,11 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * its already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
-	 * This cmpxchg() executes a full barrier, which pairs with the full
-	 * barrier executed by the wakeup in wake_up_q().
+	 * In order to ensure that a pending wakeup will observe our pending
+	 * state, even in the failed case, an explicit smp_mb() must be used.
 	 */
-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
 		return;
 
 	get_task_struct(task);


Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2D217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfBDI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:58:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:58:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148vagd358373
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:57:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148va26358370;
        Mon, 4 Feb 2019 00:57:36 -0800
Date:   Mon, 4 Feb 2019 00:57:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-07879c6a3740fbbf3c8891a0ab484c20a12794d8@git.kernel.org>
Cc:     akpm@linux-foundation.org, will.deacon@arm.com, longman@redhat.com,
        xieyongji@baidu.com, dbueso@suse.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, elohimes@gmail.com,
        peterz@infradead.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, dbueso@suse.de,
          longman@redhat.com, will.deacon@arm.com,
          akpm@linux-foundation.org, xieyongji@baidu.com, mingo@kernel.org,
          paulmck@linux.vnet.ibm.com, hpa@zytor.com, tglx@linutronix.de,
          dave@stgolabs.net, linux-kernel@vger.kernel.org,
          peterz@infradead.org, elohimes@gmail.com
In-Reply-To: <20181218195352.7orq3upiwfdbrdne@linux-r8p5>
References: <20181218195352.7orq3upiwfdbrdne@linux-r8p5>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/wake_q: Reduce reference counting for
 special users
Git-Commit-ID: 07879c6a3740fbbf3c8891a0ab484c20a12794d8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  07879c6a3740fbbf3c8891a0ab484c20a12794d8
Gitweb:     https://git.kernel.org/tip/07879c6a3740fbbf3c8891a0ab484c20a12794d8
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Tue, 18 Dec 2018 11:53:52 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:03:28 +0100

sched/wake_q: Reduce reference counting for special users

Some users, specifically futexes and rwsems, required fixes
that allowed the callers to be safe when wakeups occur before
they are expected by wake_up_q(). Such scenarios also play
games and rely on reference counting, and until now were
pivoting on wake_q doing it. With the wake_q_add() call being
moved down, this can no longer be the case. As such we end up
with a a double task refcounting overhead; and these callers
care enough about this (being rather core-ish).

This patch introduces a wake_q_add_safe() call that serves
for callers that have already done refcounting and therefore the
task is 'safe' from wake_q point of view (int that it requires
reference throughout the entire queue/>wakeup cycle). In the one
case it has internal reference counting, in the other case it
consumes the reference counting.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Xie Yongji <xieyongji@baidu.com>
Cc: Yongji Xie <elohimes@gmail.com>
Cc: andrea.parri@amarulasolutions.com
Cc: lilin24@baidu.com
Cc: liuqi16@baidu.com
Cc: nixun@baidu.com
Cc: yuanlinsi01@baidu.com
Cc: zhangyu31@baidu.com
Link: https://lkml.kernel.org/r/20181218195352.7orq3upiwfdbrdne@linux-r8p5
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/wake_q.h |  4 +--
 kernel/futex.c               |  3 +--
 kernel/locking/rwsem-xadd.c  |  4 +--
 kernel/sched/core.c          | 60 ++++++++++++++++++++++++++++++++------------
 4 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 545f37138057..ad826d2a4557 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,8 +51,8 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
-extern void wake_q_add(struct wake_q_head *head,
-		       struct task_struct *task);
+extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
+extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
 
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index 69e619baf709..2abe1a0b3062 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1463,8 +1463,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * Queue the task for later wakeup for after we've released
 	 * the hb->lock. wake_q_add() grabs reference to p.
 	 */
-	wake_q_add(wake_q, p);
-	put_task_struct(p);
+	wake_q_add_safe(wake_q, p);
 }
 
 /*
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 50d9af615dc4..fbe96341beee 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -211,9 +211,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 * Ensure issuing the wakeup (either by us or someone else)
 		 * after setting the reader waiter to nil.
 		 */
-		wake_q_add(wake_q, tsk);
-		/* wake_q_add() already take the task ref */
-		put_task_struct(tsk);
+		wake_q_add_safe(wake_q, tsk);
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c8b4dba3d2d..64ceaa5158c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -396,19 +396,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 #endif
 #endif
 
-/**
- * wake_q_add() - queue a wakeup for 'later' waking.
- * @head: the wake_q_head to add @task to
- * @task: the task to queue for 'later' wakeup
- *
- * Queue a task for later wakeup, most likely by the wake_up_q() call in the
- * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
- * instantly.
- *
- * This function must be used as-if it were wake_up_process(); IOW the task
- * must be ready to be woken at this location.
- */
-void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 {
 	struct wake_q_node *node = &task->wake_q;
 
@@ -422,15 +410,55 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 */
 	smp_mb__before_atomic();
 	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
-		return;
-
-	get_task_struct(task);
+		return false;
 
 	/*
 	 * The head is context local, there can be no concurrency.
 	 */
 	*head->lastp = node;
 	head->lastp = &node->next;
+	return true;
+}
+
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
+void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	if (__wake_q_add(head, task))
+		get_task_struct(task);
+}
+
+/**
+ * wake_q_add_safe() - safely queue a wakeup for 'later' waking.
+ * @head: the wake_q_head to add @task to
+ * @task: the task to queue for 'later' wakeup
+ *
+ * Queue a task for later wakeup, most likely by the wake_up_q() call in the
+ * same context, _HOWEVER_ this is not guaranteed, the wakeup can come
+ * instantly.
+ *
+ * This function must be used as-if it were wake_up_process(); IOW the task
+ * must be ready to be woken at this location.
+ *
+ * This function is essentially a task-safe equivalent to wake_q_add(). Callers
+ * that already hold reference to @task can call the 'safe' version and trust
+ * wake_q to do the right thing depending whether or not the @task is already
+ * queued for wakeup.
+ */
+void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
+{
+	if (!__wake_q_add(head, task))
+		put_task_struct(task);
 }
 
 void wake_up_q(struct wake_q_head *head)

Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E824C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C38220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbeLQUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:53:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:48560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbeLQUxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:53:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C5C0ACE7;
        Mon, 17 Dec 2018 20:53:21 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:53:10 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
References: <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181217113718.GB4900@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Peter Zijlstra wrote:
>
>I've put some patches here:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
>
>Could you have a look?

So how about the following to reduce some of the performance penalty (at
the cost of more complexity)?

Thanks,
Davidlohr

----------8<-----------------------------------------------------------
[PATCH] sched/wake_q: Reduce reference counting for special users

Some users, specifically futexes and rwsems, required fixes
that allowed the callers to be safe when wakeups occur before
they are expected by wake_up_q(). Such scenarios also play
games and rely on reference counting, and until now were
pivoting on wake_q doing it. With the wake_q_add() call being
moved down, this can no longer be the case. As such we end up
with a double task refcounting overhead; and these callers
care enough about this (being rather core-ish).

This patch introduces a wake_q_add_tasksafe() call that serves
for callers that have already done refcounting and therefore the
task is 'safe' from wake_q point of view (int that it requires
reference throughout the entire queue/wakeup cycle). These
users also need to check the return value of the operation and
do the put() if necessary when the cmpxchg() fails. Regular users
of wake_q_add() that don't care about when the wakeup actually
happens can just ignore the return value.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/sched/wake_q.h |  7 ++++--
 kernel/futex.c               |  4 ++--
 kernel/locking/rwsem-xadd.c  |  7 +++---
 kernel/sched/core.c          | 53 +++++++++++++++++++++++++++++++-------------
 4 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 545f37138057..8c1fc6434c6c 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,8 +51,11 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
-extern void wake_q_add(struct wake_q_head *head,
-		       struct task_struct *task);
+extern bool wake_q_add(struct wake_q_head *head,
+		      struct task_struct *task);
+extern bool wake_q_add_tasksafe(struct wake_q_head *head,
+				struct task_struct *task);
+
 extern void wake_up_q(struct wake_q_head *head);
 
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index d14971f6ed3d..2ff7e811f13b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1402,8 +1402,8 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * Queue the task for later wakeup for after we've released
 	 * the hb->lock. wake_q_add() grabs reference to p.
 	 */
-	wake_q_add(wake_q, p);
-	put_task_struct(p);
+	if (!wake_q_add_tasksafe(wake_q, p))
+		put_task_struct(p);
 }
 
 /*
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 50d9af615dc4..dea4dcf9d8f5 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -211,9 +211,10 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 * Ensure issuing the wakeup (either by us or someone else)
 		 * after setting the reader waiter to nil.
 		 */
-		wake_q_add(wake_q, tsk);
-		/* wake_q_add() already take the task ref */
-		put_task_struct(tsk);
+		if (!wake_q_add_tasksafe(wake_q, tsk)) {
+			/* wake_q_add() already take the task ref */
+			put_task_struct(tsk);
+		}
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d740d7a3608d..2c1825fe46e6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -396,19 +396,8 @@ static bool set_nr_if_polling(struct task_struct *p)
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
+bool __wake_q_add(struct wake_q_head *head,
+		  struct task_struct *task, bool tasksafe)
 {
 	struct wake_q_node *node = &task->wake_q;
 
@@ -422,15 +411,49 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 */
 	smp_mb__before_atomic();
 	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
-		return;
+		return false;
 
-	get_task_struct(task);
+	if (!tasksafe)
+		get_task_struct(task);
 
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
+ *
+ * Returns whether or not the task was successfully queued for wakeup.
+ * If false, the task is already queued and can happen at any time after
+ * this call.
+ */
+bool wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	return __wake_q_add(head, task, false);
+}
+
+/*
+ * wake_q_add_tasksafe() is the same as the above wake_q_add(), except that
+ * the caller has already done the task reference counting for us. Normally
+ * the 'tasksafe' caller will check the return value and cleanup refcounting
+ * accordingly.
+ */
+bool wake_q_add_tasksafe(struct wake_q_head *head, struct task_struct *task)
+{
+	return __wake_q_add(head, task, true);
 }
 
 void wake_up_q(struct wake_q_head *head)
-- 
2.16.4


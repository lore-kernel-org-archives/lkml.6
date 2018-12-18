Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A3FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F921841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeLRTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:30:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:58686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbeLRTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:30:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAC59AF3C;
        Tue, 18 Dec 2018 19:30:17 +0000 (UTC)
Date:   Tue, 18 Dec 2018 11:30:09 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, andrea.parri@amarulasolutions.com
Subject: Re: [PATCH v2] sched/wake_q: Reduce reference counting for special
 users
Message-ID: <20181218193009.ytzz5rlrsh27rjre@linux-r8p5>
References: <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
 <20181218131419.GD16284@hirez.programming.kicks-ass.net>
 <20181218185443.g5jzinm3vnrkznmm@linux-r8p5>
 <a8767197-21b9-f470-b864-be88e020c647@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8767197-21b9-f470-b864-be88e020c647@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Are you missing some text here?

Nah this was a leftover, I was just removing it in v3.

Thanks.

----8<---------------------------------------------------------------

[PATCH v3] sched/wake_q: Reduce reference counting for special users

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
---
Changes from v2: got rid of some bogus/incomplete leftover comments
in wake_q_add().

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
index d14971f6ed3d..6218d98f649b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1402,8 +1402,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
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
index d740d7a3608d..8611c9a3ddd8 100644
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
+ * wake_q_add_safe() - queue a wakeup for 'later' waking.
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
+		get_task_struct(task);
 }
 
 void wake_up_q(struct wake_q_head *head)
-- 
2.16.4


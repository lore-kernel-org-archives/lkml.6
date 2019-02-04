Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14061214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfBDJC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:02:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:02:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1492dlc358960
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 01:02:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1492c22358957;
        Mon, 4 Feb 2019 01:02:38 -0800
Date:   Mon, 4 Feb 2019 01:02:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-c546951d9c9300065bad253ecdf1ac59ce9d06c8@git.kernel.org>
Cc:     paulmck@linux.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, efault@gmx.de,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        andrea.parri@amarulasolutions.com, hpa@zytor.com,
        will.deacon@arm.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, efault@gmx.de, paulmck@linux.ibm.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          will.deacon@arm.com, peterz@infradead.org,
          andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org,
          stern@rowland.harvard.edu, hpa@zytor.com
In-Reply-To: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
References: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Use READ_ONCE()/WRITE_ONCE() in
 move_queued_task()/task_rq_lock()
Git-Commit-ID: c546951d9c9300065bad253ecdf1ac59ce9d06c8
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

Commit-ID:  c546951d9c9300065bad253ecdf1ac59ce9d06c8
Gitweb:     https://git.kernel.org/tip/c546951d9c9300065bad253ecdf1ac59ce9d06c8
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 21 Jan 2019 16:52:40 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:13:21 +0100

sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()

move_queued_task() synchronizes with task_rq_lock() as follows:

	move_queued_task()		task_rq_lock()

	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
	[S] ->cpu = new_cpu		[L] ->on_rq

where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
"[L] ->on_rq" by the ACQUIRE itself.

Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honor
this address dependency.  Also, mark the accesses to ->cpu and ->on_rq
with READ_ONCE()/WRITE_ONCE() to comply with the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190121155240.27173-1-andrea.parri@amarulasolutions.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 4 ++--
 kernel/sched/core.c   | 9 +++++----
 kernel/sched/sched.h  | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 351c0fe64c85..4112639c2a85 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1745,9 +1745,9 @@ static __always_inline bool need_resched(void)
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	return p->cpu;
+	return READ_ONCE(p->cpu);
 #else
-	return task_thread_info(p)->cpu;
+	return READ_ONCE(task_thread_info(p)->cpu);
 #endif
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 32e06704565e..ec1b67a195cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -107,11 +107,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 		 *					[L] ->on_rq
 		 *	RELEASE (rq->lock)
 		 *
-		 * If we observe the old CPU in task_rq_lock, the acquire of
+		 * If we observe the old CPU in task_rq_lock(), the acquire of
 		 * the old rq->lock will fully serialize against the stores.
 		 *
-		 * If we observe the new CPU in task_rq_lock, the acquire will
-		 * pair with the WMB to ensure we must then also see migrating.
+		 * If we observe the new CPU in task_rq_lock(), the address
+		 * dependency headed by '[L] rq = task_rq()' and the acquire
+		 * will pair with the WMB to ensure we then also see migrating.
 		 */
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
@@ -916,7 +917,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 {
 	lockdep_assert_held(&rq->lock);
 
-	p->on_rq = TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 99e2a7772d16..c688ef5012e5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1479,9 +1479,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 */
 	smp_wmb();
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	p->cpu = cpu;
+	WRITE_ONCE(p->cpu, cpu);
 #else
-	task_thread_info(p)->cpu = cpu;
+	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 #endif
 	p->wake_cpu = cpu;
 #endif
@@ -1582,7 +1582,7 @@ static inline int task_on_rq_queued(struct task_struct *p)
 
 static inline int task_on_rq_migrating(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_MIGRATING;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
 /*

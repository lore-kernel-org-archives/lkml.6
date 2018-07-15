Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E85ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D614208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D614208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeGOXyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:54:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:54:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNT7pl921432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:29:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNT77I921429;
        Sun, 15 Jul 2018 16:29:07 -0700
Date:   Sun, 15 Jul 2018 16:29:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-91c27493e78df6849baaa21a9d66e26de8b875c0@git.kernel.org>
Cc:     vincent.guittot@linaro.org, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, vincent.guittot@linaro.org
In-Reply-To: <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/irq: Add IRQ utilization tracking
Git-Commit-ID: 91c27493e78df6849baaa21a9d66e26de8b875c0
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

Commit-ID:  91c27493e78df6849baaa21a9d66e26de8b875c0
Gitweb:     https://git.kernel.org/tip/91c27493e78df6849baaa21a9d66e26de8b875c0
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:09 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:21 +0200

sched/irq: Add IRQ utilization tracking

interrupt and steal time are the only remaining activities tracked by
rt_avg. Like for sched classes, we can use PELT to track their average
utilization of the CPU. But unlike sched class, we don't track when
entering/leaving interrupt; Instead, we take into account the time spent
under interrupt context when we update rqs' clock (rq_clock_task).
This also means that we have to decay the normal context time and account
for interrupt time during the update.

That's also important to note that because:

  rq_clock == rq_clock_task + interrupt time

and rq_clock_task is used by a sched class to compute its utilization, the
util_avg of a sched class only reflects the utilization of the time spent
in normal context and not of the whole time of the CPU. The utilization of
interrupt gives an more accurate level of utilization of CPU.

The CPU utilization is:

  avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq

Most of the time, avg_irq is small and neglictible so the use of the
approximation CPU utilization = /Sum avg_rq was enough.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Cc: viresh.kumar@linaro.org
Link: http://lkml.kernel.org/r/1530200714-4504-7-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/fair.c  | 13 ++++++++++---
 kernel/sched/pelt.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  | 16 ++++++++++++++++
 kernel/sched/sched.h |  3 +++
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9a08e9..38107a95baca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -17,6 +17,8 @@
 #include "../workqueue_internal.h"
 #include "../smpboot.h"
 
+#include "pelt.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
@@ -185,7 +187,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
-		sched_rt_avg_update(rq, irq_delta + steal);
+		update_irq_load_avg(rq, irq_delta + steal);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f096275c7df2..c2782b29c79f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,7 +7290,7 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool others_rqs_have_blocked(struct rq *rq)
+static inline bool others_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
@@ -7298,6 +7298,11 @@ static inline bool others_rqs_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	if (READ_ONCE(rq->avg_irq.util_avg))
+		return true;
+#endif
+
 	return false;
 }
 
@@ -7362,8 +7367,9 @@ static void update_blocked_averages(int cpu)
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (others_rqs_have_blocked(rq))
+	if (others_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7432,9 +7438,10 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 8b78b6320cda..ead6d8b4a8b8 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -357,3 +357,43 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+/*
+ * irq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_irq_load_avg(struct rq *rq, u64 running)
+{
+	int ret = 0;
+	/*
+	 * We know the time that has been used by interrupt since last update
+	 * but we don't when. Let be pessimistic and assume that interrupt has
+	 * happened just before the update. This is not so far from reality
+	 * because interrupt will most probably wake up task and trig an update
+	 * of rq clock during which the metric si updated.
+	 * We start to decay with normal context time and then we add the
+	 * interrupt context time.
+	 * We can safely remove running from rq->clock because
+	 * rq->clock += delta with delta >= running
+	 */
+	ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
+				0,
+				0,
+				0);
+	ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
+				1,
+				1,
+				1);
+
+	if (ret)
+		___update_load_avg(&rq->avg_irq, 1, 1);
+
+	return ret;
+}
+#endif
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 0e4f912461ad..d2894db28955 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,16 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+int update_irq_load_avg(struct rq *rq, u64 running);
+#else
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
+#endif
+
 /*
  * When a task is dequeued, its estimated utilization should not be update if
  * its util_avg has not been updated at least once.
@@ -51,6 +61,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	return 0;
 }
+
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9028f268f867..b26d0c9948dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -857,6 +857,9 @@ struct rq {
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	struct sched_avg	avg_irq;
+#endif
 	u64			idle_stamp;
 	u64			avg_idle;
 

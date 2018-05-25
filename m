Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936145AbeEYNN7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:13:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935442AbeEYNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:48 -0400
X-Google-Smtp-Source: ADUXVKLhY8CcDruEXe891TqNyXH1dZVVfaWP2WYZxWVC0FsU49M3AeejceQQw4pJ9Adz72GynBmfJA==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 07/10] sched/irq: add irq utilization tracking
Date: Fri, 25 May 2018 15:12:28 +0200
Message-Id: <1527253951-22709-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt and steal time are the only remaining activities tracked by
rt_avg. Like for sched classes, we can use PELT to track their average
utilization of the CPU. But unlike sched class, we don't track when
entering/leaving interrupt; Instead, we take into account the time spent
under interrupt context when we update rqs' clock (rq_clock_task).
This also means that we have to decay the normal context time and account
for interrupt time during the update.

That's also important to note that because
  rq_clock == rq_clock_task + interrupt time
and rq_clock_task is used by a sched class to compute its utilization, the
util_avg of a sched class only reflects the utilization of the time spent
in normal context and not of the whole time of the CPU. The utilization of
interrupt gives an more accurate level of utilization of CPU.
The CPU utilization is :
  avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq

Most of the time, avg_irq is small and neglictible so the use of the
approximation CPU utilization = /Sum avg_rq was enough

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/fair.c  | 26 +++++++-------------------
 kernel/sched/pelt.c  | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 5 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d155518..ab58288 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -16,6 +16,8 @@
 #include "../workqueue_internal.h"
 #include "../smpboot.h"
 
+#include "pelt.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
@@ -184,7 +186,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
-		sched_rt_avg_update(rq, irq_delta + steal);
+		update_irq_load_avg(rq, irq_delta + steal);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da75eda..1bb3379 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5323,8 +5323,6 @@ static void cpu_load_update(struct rq *this_rq, unsigned long this_load,
 
 		this_rq->cpu_load[i] = (old_load * (scale - 1) + new_load) >> i;
 	}
-
-	sched_avg_update(this_rq);
 }
 
 /* Used instead of source_load when we know the type == 0 */
@@ -7298,6 +7296,9 @@ static inline bool others_rqs_have_blocked(struct rq *rq)
 	if (rq->avg_dl.util_avg)
 		return true;
 
+	if (rq->avg_irq.util_avg)
+		return true;
+
 	return false;
 }
 
@@ -7362,6 +7363,7 @@ static void update_blocked_averages(int cpu)
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_rqs_have_blocked(rq))
 		done = false;
@@ -7432,6 +7434,7 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
 	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
@@ -7544,24 +7547,9 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	u64 total, used, age_stamp, avg;
-	s64 delta;
-
-	/*
-	 * Since we're reading these variables without serialization make sure
-	 * we read them once before doing sanity checks on them.
-	 */
-	age_stamp = READ_ONCE(rq->age_stamp);
-	avg = READ_ONCE(rq->rt_avg);
-	delta = __rq_clock_broken(rq) - age_stamp;
-
-	if (unlikely(delta < 0))
-		delta = 0;
-
-	total = sched_avg_period() + delta;
-
-	used = div_u64(avg, total);
+	unsigned long used;
 
+	used = READ_ONCE(rq->avg_irq.util_avg);
 	used += READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
 	if (likely(used < SCHED_CAPACITY_SCALE))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 3d5bd3a..d2e4f21 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -355,3 +355,41 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
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
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 0e4f912..0ce9a5a 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -5,6 +5,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_irq_load_avg(struct rq *rq, u64 running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -51,6 +52,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
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
index 0eb07a8..f7e8d5b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -850,6 +850,7 @@ struct rq {
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
+	struct sched_avg	avg_irq;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4

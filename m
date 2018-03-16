Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeCPL0A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:26:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35905 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753678AbeCPLZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:54 -0400
X-Google-Smtp-Source: AG47ELuyMbjDtg+jOElGFwUIkFmQyD3Gxq0gUsLbpWOaBxmCUuBC4VLF3gBTJBfoBiBOgExPpsaJ/A==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4 v4] sched/pelt: Move pelt related code in a dedicated file
Date: Fri, 16 Mar 2018 12:25:38 +0100
Message-Id: <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to track rt_rq's utilization as a part of the estimation of the
whole rq's utilization. This is necessary because rt tasks can steal
utilization to cfs tasks and make them lighter than they are.
As we want to use the same load tracking mecanism for both and prevent
useless dependency between cfs and rt code, pelt code is moved in a
dedicated file.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/Makefile |   2 +-
 kernel/sched/fair.c   | 306 +------------------------------------------------
 kernel/sched/pelt.c   | 308 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h   |  17 +++
 kernel/sched/sched.h  |  19 ++++
 5 files changed, 346 insertions(+), 306 deletions(-)
 create mode 100644 kernel/sched/pelt.c
 create mode 100644 kernel/sched/pelt.h

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index d9a02b3..7fe1834 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117..bfd56bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -255,9 +255,6 @@ static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 	return cfs_rq->rq;
 }
 
-/* An entity is a task if it doesn't "own" a runqueue */
-#define entity_is_task(se)	(!se->my_q)
-
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
 	SCHED_WARN_ON(!entity_is_task(se));
@@ -419,7 +416,6 @@ static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 	return container_of(cfs_rq, struct rq, cfs);
 }
 
-#define entity_is_task(se)	1
 
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
@@ -692,7 +688,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 
 #ifdef CONFIG_SMP
-
+#include "pelt.h"
 #include "sched-pelt.h"
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
@@ -2720,19 +2716,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 } while (0)
 
 #ifdef CONFIG_SMP
-/*
- * XXX we want to get rid of these helpers and use the full load resolution.
- */
-static inline long se_weight(struct sched_entity *se)
-{
-	return scale_load_down(se->load.weight);
-}
-
-static inline long se_runnable(struct sched_entity *se)
-{
-	return scale_load_down(se->runnable_weight);
-}
-
 static inline void
 enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -3033,287 +3016,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
-/*
- * Approximate:
- *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
- */
-static u64 decay_load(u64 val, u64 n)
-{
-	unsigned int local_n;
-
-	if (unlikely(n > LOAD_AVG_PERIOD * 63))
-		return 0;
-
-	/* after bounds checking we can collapse to 32-bit */
-	local_n = n;
-
-	/*
-	 * As y^PERIOD = 1/2, we can combine
-	 *    y^n = 1/2^(n/PERIOD) * y^(n%PERIOD)
-	 * With a look-up table which covers y^n (n<PERIOD)
-	 *
-	 * To achieve constant time decay_load.
-	 */
-	if (unlikely(local_n >= LOAD_AVG_PERIOD)) {
-		val >>= local_n / LOAD_AVG_PERIOD;
-		local_n %= LOAD_AVG_PERIOD;
-	}
-
-	val = mul_u64_u32_shr(val, runnable_avg_yN_inv[local_n], 32);
-	return val;
-}
-
-static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
-{
-	u32 c1, c2, c3 = d3; /* y^0 == 1 */
-
-	/*
-	 * c1 = d1 y^p
-	 */
-	c1 = decay_load((u64)d1, periods);
-
-	/*
-	 *            p-1
-	 * c2 = 1024 \Sum y^n
-	 *            n=1
-	 *
-	 *              inf        inf
-	 *    = 1024 ( \Sum y^n - \Sum y^n - y^0 )
-	 *              n=0        n=p
-	 */
-	c2 = LOAD_AVG_MAX - decay_load(LOAD_AVG_MAX, periods) - 1024;
-
-	return c1 + c2 + c3;
-}
-
-/*
- * Accumulate the three separate parts of the sum; d1 the remainder
- * of the last (incomplete) period, d2 the span of full periods and d3
- * the remainder of the (incomplete) current period.
- *
- *           d1          d2           d3
- *           ^           ^            ^
- *           |           |            |
- *         |<->|<----------------->|<--->|
- * ... |---x---|------| ... |------|-----x (now)
- *
- *                           p-1
- * u' = (u + d1) y^p + 1024 \Sum y^n + d3 y^0
- *                           n=1
- *
- *    = u y^p +					(Step 1)
- *
- *                     p-1
- *      d1 y^p + 1024 \Sum y^n + d3 y^0		(Step 2)
- *                     n=1
- */
-static __always_inline u32
-accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
-{
-	unsigned long scale_freq, scale_cpu;
-	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
-	u64 periods;
-
-	scale_freq = arch_scale_freq_capacity(cpu);
-	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
-
-	delta += sa->period_contrib;
-	periods = delta / 1024; /* A period is 1024us (~1ms) */
-
-	/*
-	 * Step 1: decay old *_sum if we crossed period boundaries.
-	 */
-	if (periods) {
-		sa->load_sum = decay_load(sa->load_sum, periods);
-		sa->runnable_load_sum =
-			decay_load(sa->runnable_load_sum, periods);
-		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
-
-		/*
-		 * Step 2
-		 */
-		delta %= 1024;
-		contrib = __accumulate_pelt_segments(periods,
-				1024 - sa->period_contrib, delta);
-	}
-	sa->period_contrib = delta;
-
-	contrib = cap_scale(contrib, scale_freq);
-	if (load)
-		sa->load_sum += load * contrib;
-	if (runnable)
-		sa->runnable_load_sum += runnable * contrib;
-	if (running)
-		sa->util_sum += contrib * scale_cpu;
-
-	return periods;
-}
-
-/*
- * We can represent the historical contribution to runnable average as the
- * coefficients of a geometric series.  To do this we sub-divide our runnable
- * history into segments of approximately 1ms (1024us); label the segment that
- * occurred N-ms ago p_N, with p_0 corresponding to the current period, e.g.
- *
- * [<- 1024us ->|<- 1024us ->|<- 1024us ->| ...
- *      p0            p1           p2
- *     (now)       (~1ms ago)  (~2ms ago)
- *
- * Let u_i denote the fraction of p_i that the entity was runnable.
- *
- * We then designate the fractions u_i as our co-efficients, yielding the
- * following representation of historical load:
- *   u_0 + u_1*y + u_2*y^2 + u_3*y^3 + ...
- *
- * We choose y based on the with of a reasonably scheduling period, fixing:
- *   y^32 = 0.5
- *
- * This means that the contribution to load ~32ms ago (u_32) will be weighted
- * approximately half as much as the contribution to load within the last ms
- * (u_0).
- *
- * When a period "rolls over" and we have new u_0`, multiplying the previous
- * sum again by y is sufficient to update:
- *   load_avg = u_0` + y*(u_0 + u_1*y + u_2*y^2 + ... )
- *            = u_0 + u_1*y + u_2*y^2 + ... [re-labeling u_i --> u_{i+1}]
- */
-static __always_inline int
-___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
-{
-	u64 delta;
-
-	delta = now - sa->last_update_time;
-	/*
-	 * This should only happen when time goes backwards, which it
-	 * unfortunately does during sched clock init when we swap over to TSC.
-	 */
-	if ((s64)delta < 0) {
-		sa->last_update_time = now;
-		return 0;
-	}
-
-	/*
-	 * Use 1024ns as the unit of measurement since it's a reasonable
-	 * approximation of 1us and fast to compute.
-	 */
-	delta >>= 10;
-	if (!delta)
-		return 0;
-
-	sa->last_update_time += delta << 10;
-
-	/*
-	 * running is a subset of runnable (weight) so running can't be set if
-	 * runnable is clear. But there are some corner cases where the current
-	 * se has been already dequeued but cfs_rq->curr still points to it.
-	 * This means that weight will be 0 but not running for a sched_entity
-	 * but also for a cfs_rq if the latter becomes idle. As an example,
-	 * this happens during idle_balance() which calls
-	 * update_blocked_averages()
-	 */
-	if (!load)
-		runnable = running = 0;
-
-	/*
-	 * Now we know we crossed measurement unit boundaries. The *_avg
-	 * accrues by two steps:
-	 *
-	 * Step 1: accumulate *_sum since last_update_time. If we haven't
-	 * crossed period boundaries, finish.
-	 */
-	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
-		return 0;
-
-	return 1;
-}
-
-static __always_inline void
-___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
-{
-	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
-
-	/*
-	 * Step 2: update *_avg.
-	 */
-	sa->load_avg = div_u64(load * sa->load_sum, divider);
-	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
-	sa->util_avg = sa->util_sum / divider;
-}
-
-/*
- * sched_entity:
- *
- *   task:
- *     se_runnable() == se_weight()
- *
- *   group: [ see update_cfs_group() ]
- *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
- *
- *   load_sum := runnable_sum
- *   load_avg = se_weight(se) * runnable_avg
- *
- *   runnable_load_sum := runnable_sum
- *   runnable_load_avg = se_runnable(se) * runnable_avg
- *
- * XXX collapse load_sum and runnable_load_sum
- *
- * cfq_rs:
- *
- *   load_sum = \Sum se_weight(se) * se->avg.load_sum
- *   load_avg = \Sum se->avg.load_avg
- *
- *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
- *   runnable_load_avg = \Sum se->avg.runable_load_avg
- */
-
-static int
-__update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
-{
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
-	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
-		return 1;
-	}
-
-	return 0;
-}
-
-static int
-__update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
-	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
-				cfs_rq->curr == se)) {
-
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
-		return 1;
-	}
-
-	return 0;
-}
-
-static int
-__update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
-{
-	if (___update_load_sum(now, cpu, &cfs_rq->avg,
-				scale_load_down(cfs_rq->load.weight),
-				scale_load_down(cfs_rq->runnable_weight),
-				cfs_rq->curr != NULL)) {
-
-		___update_load_avg(&cfs_rq->avg, 1, 1);
-		return 1;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /**
  * update_tg_load_avg - update the tg's load avg
@@ -3875,12 +3577,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
 
 #else /* CONFIG_SMP */
 
-static inline int
-update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
-{
-	return 0;
-}
-
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
new file mode 100644
index 0000000..d693e5e
--- /dev/null
+++ b/kernel/sched/pelt.c
@@ -0,0 +1,308 @@
+/*
+ * Per Entity Load Tracking
+ *
+ *  Copyright (C) 2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ *  Interactivity improvements by Mike Galbraith
+ *  (C) 2007 Mike Galbraith <efault@gmx.de>
+ *
+ *  Various enhancements by Dmitry Adamushko.
+ *  (C) 2007 Dmitry Adamushko <dmitry.adamushko@gmail.com>
+ *
+ *  Group scheduling enhancements by Srivatsa Vaddagiri
+ *  Copyright IBM Corporation, 2007
+ *  Author: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
+ *
+ *  Scaled math optimizations by Thomas Gleixner
+ *  Copyright (C) 2007, Thomas Gleixner <tglx@linutronix.de>
+ *
+ *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
+ *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
+ *
+ *  Move PELT related code from fair.c into this pelt.c file
+ *  Author: Vincent Guittot <vincent.guittot@linaro.org>
+ */
+
+#include <linux/sched.h>
+#include "sched.h"
+#include "sched-pelt.h"
+
+/*
+ * Approximate:
+ *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
+ */
+static u64 decay_load(u64 val, u64 n)
+{
+	unsigned int local_n;
+
+	if (unlikely(n > LOAD_AVG_PERIOD * 63))
+		return 0;
+
+	/* after bounds checking we can collapse to 32-bit */
+	local_n = n;
+
+	/*
+	 * As y^PERIOD = 1/2, we can combine
+	 *    y^n = 1/2^(n/PERIOD) * y^(n%PERIOD)
+	 * With a look-up table which covers y^n (n<PERIOD)
+	 *
+	 * To achieve constant time decay_load.
+	 */
+	if (unlikely(local_n >= LOAD_AVG_PERIOD)) {
+		val >>= local_n / LOAD_AVG_PERIOD;
+		local_n %= LOAD_AVG_PERIOD;
+	}
+
+	val = mul_u64_u32_shr(val, runnable_avg_yN_inv[local_n], 32);
+	return val;
+}
+
+static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
+{
+	u32 c1, c2, c3 = d3; /* y^0 == 1 */
+
+	/*
+	 * c1 = d1 y^p
+	 */
+	c1 = decay_load((u64)d1, periods);
+
+	/*
+	 *            p-1
+	 * c2 = 1024 \Sum y^n
+	 *            n=1
+	 *
+	 *              inf        inf
+	 *    = 1024 ( \Sum y^n - \Sum y^n - y^0 )
+	 *              n=0        n=p
+	 */
+	c2 = LOAD_AVG_MAX - decay_load(LOAD_AVG_MAX, periods) - 1024;
+
+	return c1 + c2 + c3;
+}
+
+#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
+
+/*
+ * Accumulate the three separate parts of the sum; d1 the remainder
+ * of the last (incomplete) period, d2 the span of full periods and d3
+ * the remainder of the (incomplete) current period.
+ *
+ *           d1          d2           d3
+ *           ^           ^            ^
+ *           |           |            |
+ *         |<->|<----------------->|<--->|
+ * ... |---x---|------| ... |------|-----x (now)
+ *
+ *                           p-1
+ * u' = (u + d1) y^p + 1024 \Sum y^n + d3 y^0
+ *                           n=1
+ *
+ *    = u y^p +					(Step 1)
+ *
+ *                     p-1
+ *      d1 y^p + 1024 \Sum y^n + d3 y^0		(Step 2)
+ *                     n=1
+ */
+static __always_inline u32
+accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
+	       unsigned long load, unsigned long runnable, int running)
+{
+	unsigned long scale_freq, scale_cpu;
+	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
+	u64 periods;
+
+	scale_freq = arch_scale_freq_capacity(cpu);
+	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+
+	delta += sa->period_contrib;
+	periods = delta / 1024; /* A period is 1024us (~1ms) */
+
+	/*
+	 * Step 1: decay old *_sum if we crossed period boundaries.
+	 */
+	if (periods) {
+		sa->load_sum = decay_load(sa->load_sum, periods);
+		sa->runnable_load_sum =
+			decay_load(sa->runnable_load_sum, periods);
+		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
+
+		/*
+		 * Step 2
+		 */
+		delta %= 1024;
+		contrib = __accumulate_pelt_segments(periods,
+				1024 - sa->period_contrib, delta);
+	}
+	sa->period_contrib = delta;
+
+	contrib = cap_scale(contrib, scale_freq);
+	if (load)
+		sa->load_sum += load * contrib;
+	if (runnable)
+		sa->runnable_load_sum += runnable * contrib;
+	if (running)
+		sa->util_sum += contrib * scale_cpu;
+
+	return periods;
+}
+
+/*
+ * We can represent the historical contribution to runnable average as the
+ * coefficients of a geometric series.  To do this we sub-divide our runnable
+ * history into segments of approximately 1ms (1024us); label the segment that
+ * occurred N-ms ago p_N, with p_0 corresponding to the current period, e.g.
+ *
+ * [<- 1024us ->|<- 1024us ->|<- 1024us ->| ...
+ *      p0            p1           p2
+ *     (now)       (~1ms ago)  (~2ms ago)
+ *
+ * Let u_i denote the fraction of p_i that the entity was runnable.
+ *
+ * We then designate the fractions u_i as our co-efficients, yielding the
+ * following representation of historical load:
+ *   u_0 + u_1*y + u_2*y^2 + u_3*y^3 + ...
+ *
+ * We choose y based on the with of a reasonably scheduling period, fixing:
+ *   y^32 = 0.5
+ *
+ * This means that the contribution to load ~32ms ago (u_32) will be weighted
+ * approximately half as much as the contribution to load within the last ms
+ * (u_0).
+ *
+ * When a period "rolls over" and we have new u_0`, multiplying the previous
+ * sum again by y is sufficient to update:
+ *   load_avg = u_0` + y*(u_0 + u_1*y + u_2*y^2 + ... )
+ *            = u_0 + u_1*y + u_2*y^2 + ... [re-labeling u_i --> u_{i+1}]
+ */
+static __always_inline int
+___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
+		  unsigned long load, unsigned long runnable, int running)
+{
+	u64 delta;
+
+	delta = now - sa->last_update_time;
+	/*
+	 * This should only happen when time goes backwards, which it
+	 * unfortunately does during sched clock init when we swap over to TSC.
+	 */
+	if ((s64)delta < 0) {
+		sa->last_update_time = now;
+		return 0;
+	}
+
+	/*
+	 * Use 1024ns as the unit of measurement since it's a reasonable
+	 * approximation of 1us and fast to compute.
+	 */
+	delta >>= 10;
+	if (!delta)
+		return 0;
+
+	sa->last_update_time += delta << 10;
+
+	/*
+	 * running is a subset of runnable (weight) so running can't be set if
+	 * runnable is clear. But there are some corner cases where the current
+	 * se has been already dequeued but cfs_rq->curr still points to it.
+	 * This means that weight will be 0 but not running for a sched_entity
+	 * but also for a cfs_rq if the latter becomes idle. As an example,
+	 * this happens during idle_balance() which calls
+	 * update_blocked_averages()
+	 */
+	if (!load)
+		runnable = running = 0;
+
+	/*
+	 * Now we know we crossed measurement unit boundaries. The *_avg
+	 * accrues by two steps:
+	 *
+	 * Step 1: accumulate *_sum since last_update_time. If we haven't
+	 * crossed period boundaries, finish.
+	 */
+	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
+		return 0;
+
+	return 1;
+}
+
+static __always_inline void
+___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
+{
+	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
+
+	/*
+	 * Step 2: update *_avg.
+	 */
+	sa->load_avg = div_u64(load * sa->load_sum, divider);
+	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
+	sa->util_avg = sa->util_sum / divider;
+}
+
+/*
+ * sched_entity:
+ *
+ *   task:
+ *     se_runnable() == se_weight()
+ *
+ *   group: [ see update_cfs_group() ]
+ *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
+ *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
+ *
+ *   load_sum := runnable_sum
+ *   load_avg = se_weight(se) * runnable_avg
+ *
+ *   runnable_load_sum := runnable_sum
+ *   runnable_load_avg = se_runnable(se) * runnable_avg
+ *
+ * XXX collapse load_sum and runnable_load_sum
+ *
+ * cfq_rs:
+ *
+ *   load_sum = \Sum se_weight(se) * se->avg.load_sum
+ *   load_avg = \Sum se->avg.load_avg
+ *
+ *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
+ *   runnable_load_avg = \Sum se->avg.runable_load_avg
+ */
+
+int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		se->runnable_weight = se->load.weight;
+
+	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
+		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		return 1;
+	}
+
+	return 0;
+}
+
+int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		se->runnable_weight = se->load.weight;
+
+	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
+				cfs_rq->curr == se)) {
+
+		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		return 1;
+	}
+
+	return 0;
+}
+
+int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
+{
+	if (___update_load_sum(now, cpu, &cfs_rq->avg,
+				scale_load_down(cfs_rq->load.weight),
+				scale_load_down(cfs_rq->runnable_weight),
+				cfs_rq->curr != NULL)) {
+
+		___update_load_avg(&cfs_rq->avg, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
new file mode 100644
index 0000000..c312d8c
--- /dev/null
+++ b/kernel/sched/pelt.h
@@ -0,0 +1,17 @@
+#ifdef CONFIG_SMP
+
+int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
+int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
+int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
+
+#else
+
+static inline int
+update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
+#endif
+
+
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22909ff..783eacf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -666,7 +666,26 @@ struct dl_rq {
 	u64			bw_ratio;
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+/* An entity is a task if it doesn't "own" a runqueue */
+#define entity_is_task(se)	(!se->my_q)
+#else
+#define entity_is_task(se)	1
+#endif
+
 #ifdef CONFIG_SMP
+/*
+ * XXX we want to get rid of these helpers and use the full load resolution.
+ */
+static inline long se_weight(struct sched_entity *se)
+{
+	return scale_load_down(se->load.weight);
+}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	return scale_load_down(se->runnable_weight);
+}
 
 static inline bool sched_asym_prefer(int a, int b)
 {
-- 
2.7.4

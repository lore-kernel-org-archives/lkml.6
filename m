Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075BC2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="duV9aU2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075BC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJ0Atb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:49:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38135 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJ0Ata (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:49:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id b14-v6so1968027wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W4kB8aCY9BT0CJkRshZsxXndz53iEB5a54+32/Uhb/A=;
        b=duV9aU2yD6T70wE2buMxe50fZl4U6XSeucOncyvSPOhebs7cXO+5nqKWy1fLkY++80
         Ku6HGdCJuJctqCGtmH5Th2Cgjd3tvJfRjjPmmOmJHH+Ioj/m7KFajgQKHZ3iaIB5A2Z5
         mFqSpP0NNWBtJ6TG1/tV9Dq173sP5+agXl2AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W4kB8aCY9BT0CJkRshZsxXndz53iEB5a54+32/Uhb/A=;
        b=nxhwgzrAuYkcw5nEvDmirFW4W+P6XyOP37kthP5sAj+6IzT54fCteMjsFcVErj9L02
         jRvfR+uT4dD0xm18uOS3vx2gwzWNaynFTOuaxngHKQekhftRWlIZvST6EnPV7e/r+HSS
         iEHJ7PWMZ7NkxJqcAm/I/7COFF16odb/QGNaYOmNDlooqyotBQTCC8lbouiC7qeelruU
         t+cn6QB19RLxzjJB/zYqDZxIz9le0unxWCyE9r5IylTqWoBJGFNqIgCitk64wpIOE1zk
         Q114tEk2ul6X8+Yi/NgREGsDVY5TewkJNo8TPg6BCSZg5FyeiEZDRMqudd1sfe3uNULu
         mEcA==
X-Gm-Message-State: AGRZ1gIO6Z6m9vlQCP7Vg92W2ngl0hnPAa4SRzCPLts4KoeTowm3hzxB
        A/PGQPokVmHq9TMo7rFOL+Iuug==
X-Google-Smtp-Source: AJdET5cOLNIo9S32w54zagWxzzjPBoTntVgloQsle8fmD8ddfpneZ3ouGSPBK/Y5XpE8OA8dLdXRpA==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr5747900wml.15.1540570310118;
        Fri, 26 Oct 2018 09:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d30:71a0:24b4:1c25])
        by smtp.gmail.com with ESMTPSA id y16-v6sm11807209wru.18.2018.10.26.09.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 09:11:49 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
Date:   Fri, 26 Oct 2018 18:11:43 +0200
Message-Id: <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of load tracking invariance scales the
contribution with current frequency and uarch performance (only for
utilization) of the CPU. One main result of this formula is that the
figures are capped by current capacity of CPU. Another one is that the
load_avg is not invariant because not scaled with uarch.

The util_avg of a periodic task that runs r time slots every p time slots
varies in the range :

    U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)

with U is the max util_avg value = SCHED_CAPACITY_SCALE

At a lower capacity, the range becomes:

    U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)

with C reflecting the compute capacity ratio between current capacity and
max capacity.

so C tries to compensate changes in (1-y^r') but it can't be accurate.

Instead of scaling the contribution value of PELT algo, we should scale the
running time. The PELT signal aims to track the amount of computation of
tasks and/or rq so it seems more correct to scale the running time to
reflect the effective amount of computation done since the last update.

In order to be fully invariant, we need to apply the same amount of
running time and idle time whatever the current capacity. Because running
at lower capacity implies that the task will run longer, we have to ensure
that the same amount of idle time will be apply when system becomes idle
and no idle time has been "stolen". But reaching the maximum utilization
value (SCHED_CAPACITY_SCALE) means that the task is seen as an
always-running task whatever the capacity of the CPU (even at max compute
capacity). In this case, we can discard this "stolen" idle times which
becomes meaningless.

In order to achieve this time scaling, a new clock_pelt is created per rq.
The increase of this clock scales with current capacity when something
is running on rq and synchronizes with clock_task when rq is idle. With
this mecanism, we ensure the same running and idle time whatever the
current capacity. This also enables to simplify the pelt algorithm by
removing all references of uarch and frequency and applying the same
contribution to utilization and loads. Furthermore, the scaling is done
only once per update of clock (update_rq_clock_task()) instead of during
each update of sched_entities and cfs/rt/dl_rq of the rq like the current
implementation. This is interesting when cgroup are involved as shown in
the results below:

On a hikey (octo ARM platform).
Performance cpufreq governor and only shallowest c-state to remove variance
generated by those power features so we only track the impact of pelt algo.

each test runs 16 times

./perf bench sched pipe
(higher is better)
kernel	tip/sched/core     + patch
        ops/seconds        ops/seconds         diff
cgroup
root    59652(+/- 0.18%)   59876(+/- 0.24%)    +0.38%
level1  55608(+/- 0.27%)   55923(+/- 0.24%)    +0.57%
level2  52115(+/- 0.29%)   52564(+/- 0.22%)    +0.86%

hackbench -l 1000
(lower is better)
kernel	tip/sched/core     + patch
        duration(sec)      duration(sec)        diff
cgroup
root    4.453(+/- 2.37%)   4.383(+/- 2.88%)     -1.57%
level1  4.859(+/- 8.50%)   4.830(+/- 7.07%)     -0.60%
level2  5.063(+/- 9.83%)   4.928(+/- 9.66%)     -2.66%

The responsivness of PELT is improved when CPU is not running at max
capacity with this new algorithm. I have put below some examples of
duration to reach some typical load values according to the capacity of the
CPU with current implementation and with this patch. These values has been
computed based on the geometric serie and the half period value:

Util (%)     max capacity  half capacity(mainline)  half capacity(w/ patch)
972 (95%)    138ms         not reachable            276ms
486 (47.5%)  30ms          138ms                     60ms
256 (25%)    13ms           32ms                     26ms

On my hikey (octo ARM platform) with schedutil governor, the time to reach
max OPP when starting from a null utilization, decreases from 223ms with
current scale invariance down to 121ms with the new algorithm.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  25 ++++++-----
 kernel/sched/pelt.c     |  23 +++++-----
 kernel/sched/pelt.h     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |   5 ++-
 7 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe02231..2c87aaf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -180,6 +180,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
+	update_rq_clock_pelt(rq, delta);
 }
 
 void update_rq_clock(struct rq *rq)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202..f07bffe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1761,7 +1761,7 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	deadline_queue_push_tasks(rq);
 
 	if (rq->curr->sched_class != &dl_sched_class)
-		update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	return p;
 }
@@ -1770,7 +1770,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -1787,7 +1787,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
 
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6806c27..7a69673 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -674,9 +674,8 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return calc_delta_fair(sched_slice(cfs_rq, se), se);
 }
 
-#ifdef CONFIG_SMP
 #include "pelt.h"
-#include "sched-pelt.h"
+#ifdef CONFIG_SMP
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
@@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 			 * such that the next switched_to_fair() has the
 			 * expected state.
 			 */
-			se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
+			se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 			return;
 		}
 	}
@@ -3466,7 +3465,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	u64 now = cfs_rq_clock_task(cfs_rq);
+	u64 now = cfs_rq_clock_pelt(cfs_rq);
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 	int decayed;
@@ -6694,6 +6693,12 @@ done: __maybe_unused;
 	if (new_tasks > 0)
 		goto again;
 
+	/*
+	 * rq is about to be idle, check if we need to update the
+	 * lost_idle_time of clock_pelt
+	 */
+	update_idle_rq_clock_pelt(rq);
+
 	return NULL;
 }
 
@@ -7353,7 +7358,7 @@ static void update_blocked_averages(int cpu)
 		if (throttled_hierarchy(cfs_rq))
 			continue;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
 			update_tg_load_avg(cfs_rq, 0);
 
 		/* Propagate pending load changes to the parent, if any: */
@@ -7374,8 +7379,8 @@ static void update_blocked_averages(int cpu)
 	}
 
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7445,11 +7450,11 @@ static inline void update_blocked_averages(int cpu)
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
-	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 90fb5bc..f5f78bf 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -26,7 +26,6 @@
 
 #include <linux/sched.h>
 #include "sched.h"
-#include "sched-pelt.h"
 #include "pelt.h"
 
 /*
@@ -106,16 +105,12 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  *                     n=1
  */
 static __always_inline u32
-accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
+accumulate_sum(u64 delta, struct sched_avg *sa,
 	       unsigned long load, unsigned long runnable, int running)
 {
-	unsigned long scale_freq, scale_cpu;
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
 
-	scale_freq = arch_scale_freq_capacity(cpu);
-	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
-
 	delta += sa->period_contrib;
 	periods = delta / 1024; /* A period is 1024us (~1ms) */
 
@@ -137,13 +132,12 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	}
 	sa->period_contrib = delta;
 
-	contrib = cap_scale(contrib, scale_freq);
 	if (load)
 		sa->load_sum += load * contrib;
 	if (runnable)
 		sa->runnable_load_sum += runnable * contrib;
 	if (running)
-		sa->util_sum += contrib * scale_cpu;
+		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
 	return periods;
 }
@@ -221,7 +215,7 @@ ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
+	if (!accumulate_sum(delta, sa, load, runnable, running))
 		return 0;
 
 	return 1;
@@ -365,12 +359,21 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 int update_irq_load_avg(struct rq *rq, u64 running)
 {
 	int ret = 0;
+
+	/*
+	 * We can't use clock_pelt because irq time is not accounted in
+	 * clock_task. Instead we directly scale the running time to
+	 * reflect the real amount of computation
+	 */
+	running = cap_scale(running, arch_scale_freq_capacity(cpu_of(rq)));
+	running = cap_scale(running, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+
 	/*
 	 * We know the time that has been used by interrupt since last update
 	 * but we don't when. Let be pessimistic and assume that interrupt has
 	 * happened just before the update. This is not so far from reality
 	 * because interrupt will most probably wake up task and trig an update
-	 * of rq clock during which the metric si updated.
+	 * of rq clock during which the metric is updated.
 	 * We start to decay with normal context time and then we add the
 	 * interrupt context time.
 	 * We can safely remove running from rq->clock because
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 7e56b48..fb39446 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -1,4 +1,5 @@
 #ifdef CONFIG_SMP
+#include "sched-pelt.h"
 
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
@@ -42,6 +43,102 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+/*
+ * The clock_pelt scales the time to reflect the effective amount of
+ * computation done during the running delta time but then sync back to
+ * clock_task when rq is idle.
+ *
+ *
+ * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
+ * @ max capacity  ------******---------------******---------------
+ * @ half capacity ------************---------************---------
+ * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
+ *
+ */
+static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
+{
+	if (unlikely(is_idle_task(rq->curr))) {
+		/* The rq is idle, we can sync to clock_task */
+		rq->clock_pelt  = rq_clock_task(rq);
+		return;
+	}
+
+	/*
+	 * When a rq runs at a lower compute capacity, it will need
+	 * more time to do the same amount of work than at max
+	 * capacity: either because it takes more time to compute the
+	 * same amount of work or because taking more time means
+	 * sharing more often the CPU between entities.
+	 * In order to be invariant, we scale the delta to reflect how
+	 * much work has been really done.
+	 * Running at lower capacity also means running longer to do
+	 * the same amount of work and this results in stealing some
+	 * idle time that will disturb the load signal compared to
+	 * max capacity; This stolen idle time will be automaticcally
+	 * reflected when the rq will be idle and the clock will be
+	 * synced with rq_clock_task.
+	 */
+
+	/*
+	 * scale the elapsed time to reflect the real amount of
+	 * computation
+	 */
+	delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+	delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
+
+	rq->clock_pelt += delta;
+}
+
+/*
+ * When rq becomes idle, we have to check if it has lost some idle time
+ * because it was fully busy. A rq is fully used when the /Sum util_sum
+ * is greater or equal to:
+ * (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
+ * For optimization and computing rounding purpose, we don't take into account
+ * the position in the current window (period_contrib) and we use the maximum
+ * util_avg value minus 1
+ */
+static inline void update_idle_rq_clock_pelt(struct rq *rq)
+{
+	u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
+	u32 overload = rq->cfs.avg.util_sum;
+	overload += rq->avg_rt.util_sum;
+	overload += rq->avg_dl.util_sum;
+
+	/*
+	 * Reflecting some stolen time makes sense only if the idle
+	 * phase would be present at max capacity. As soon as the
+	 * utilization of a rq has reached the maximum value, it is
+	 * considered as an always runnnig rq without idle time to
+	 * steal. This potential idle time is considered as lost in
+	 * this case. We keep track of this lost idle time compare to
+	 * rq's clock_task.
+	 */
+	if ((overload >= divider))
+		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+}
+
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	return rq->clock_pelt - rq->lost_idle_time;
+}
+
+#ifdef CONFIG_CFS_BANDWIDTH
+/* rq->task_clock normalized against any time this cfs_rq has spent throttled */
+static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
+{
+	if (unlikely(cfs_rq->throttle_count))
+		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
+
+	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
+}
+#else
+static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
+{
+	return rq_clock_pelt(rq_of(cfs_rq));
+}
+#endif
+
 #else
 
 static inline int
@@ -67,6 +164,18 @@ update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
 }
+
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	return rq_clock_task(rq);
+}
+
+static inline void
+update_rq_clock_pelt(struct rq *rq, s64 delta) { }
+
+static inline void
+update_idle_rq_clock_pelt(struct rq *rq) { }
+
 #endif
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a..f62f2d5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1584,7 +1584,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * rt task
 	 */
 	if (rq->curr->sched_class != &rt_sched_class)
-		update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	return p;
 }
@@ -1593,7 +1593,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
 	/*
 	 * The previous task needs to be made eligible for pushing
@@ -2324,7 +2324,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
 	watchdog(rq, p);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618b578..1e162b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -832,7 +832,10 @@ struct rq {
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-	u64			clock_task;
+	/* Ensure that all clocks are in the same cache line */
+	u64			clock_task ____cacheline_aligned;
+	u64			clock_pelt;
+	unsigned long		lost_idle_time;
 
 	atomic_t		nr_iowait;
 
-- 
2.7.4


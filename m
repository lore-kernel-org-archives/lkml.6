Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA085ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDFB20838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuYg7Kcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDFB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeJTAYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:24:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJTAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:24:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so6270577wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IvKJhK6xqvP8AgN5D//bnAFpGTeXhswS3ahpoKh9qh8=;
        b=MuYg7KcfdKvUCtqSrH117kNvIw17GQVklbSKPDWQDDgl8E76JHBiywQOTjwfNWoWFa
         gbbOeRFT4tnJLYIoogE5x02Hm79ziJjR3weHTK6+x2L0n936QB4AdGHK0SaS04k+1Hnc
         cS4hll49DQ8yisgFBFLy+pGuiQZx0APim2t1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IvKJhK6xqvP8AgN5D//bnAFpGTeXhswS3ahpoKh9qh8=;
        b=Jj6Gq9KYBy8vXCDHuSskDmc3CFRrkHnKcoS80jZ8Qyj7+WFbg6kCjEAxDBapILOP04
         5KTOMn/XYtGQ0CYCvR2KorlNNpr0FcfCpJsFJlIoLKb6xJ5U0Jmndg5wBCfqz5DmZjb1
         gpRu5tpQXS7CbErrLy2mcTxUMb8pa6kf6F4Aomm4VPgDfFIz5HDd8LAbc2dByq1hvFVU
         useCLptx0LtPZEFqD4MKEi43zdXifhcbhE/yEaD7ITyFi8cvPjBJioajT/6wpSzInvMF
         P8RLRzon/6ItM7chNqtSwm4lB4ennHRjQxs21S3ZIedPiv4PxyMFgLKdE0JL1554rq5B
         xhaQ==
X-Gm-Message-State: ABuFfoicnPhNqxhspawaskWAHCATIyiXIUYGre5UA9lsAQ/AADfCtYd5
        EYHh03Mh2tGtMptfgjUt/61PBA==
X-Google-Smtp-Source: ACcGV62ckIkdTOgomVhxXAcDmVNRmjOWYzRykRdgVN880KeFqR0yrtAc6eHsBRZx9dX1dsQpIgm0zA==
X-Received: by 2002:adf:9503:: with SMTP id 3-v6mr36996389wrs.91.1539965879981;
        Fri, 19 Oct 2018 09:17:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9024:3180:921a:1e27])
        by smtp.gmail.com with ESMTPSA id n11-v6sm17009460wrx.17.2018.10.19.09.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 09:17:58 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
Date:   Fri, 19 Oct 2018 18:17:51 +0200
Message-Id: <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
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
root    59648(+/- 0.13%)   59785(+/- 0.24%)    +0.23%
level1  55570(+/- 0.21%)   56003(+/- 0.24%)    +0.78%
level2  52100(+/- 0.20%)   52788(+/- 0.22%)    +1.32%

hackbench -l 1000
(lower is better)
kernel	tip/sched/core     + patch
        duration(sec)      duration(sec)        diff
cgroup
root    4.472(+/- 1.86%)   4.346(+/- 2.74%)     -2.80%
level1  5.039(+/- 11.05%)  4.662(+/- 7.57%)     -7.47%
level2  5.195(+/- 10.66%)  4.877(+/- 8.90%)     -6.12%

The responsivness of PELT is improved when CPU is not running at max
capacity with this new algorithm. I have put below some examples of
duration to reach some typical load values according to the capacity of the
CPU with current implementation and with this patch.

Util (%)     max capacity  half capacity(mainline)  half capacity(w/ patch)
972 (95%)    138ms         not reachable            276ms
486 (47.5%)  30ms          138ms                     60ms
256 (25%)    13ms           32ms                     26ms

On my hikey (octo ARM platform) with schedutil governor, the time to reach
max OPP when starting from a null utilization, decreases from 223ms with
current scale invariance down to 121ms with the new algorithm. For this
test, I have enable arch_scale_freq for arm64.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  6 ++--
 kernel/sched/fair.c     | 16 ++++-----
 kernel/sched/pelt.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/pelt.h     | 27 +++++++++++++++
 kernel/sched/rt.c       |  6 ++--
 kernel/sched/sched.h    |  2 ++
 7 files changed, 123 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..84e5c48 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -181,6 +181,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
+	update_rq_clock_pelt(rq, delta);
 }
 
 void update_rq_clock(struct rq *rq)
@@ -205,7 +206,6 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
-
 #ifdef CONFIG_SCHED_HRTICK
 /*
  * Use HR-timers to deliver accurate preemption points.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b..68cb4dc 100644
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
index 0969ce3..5677254 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -764,7 +764,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 			 * such that the next switched_to_fair() has the
 			 * expected state.
 			 */
-			se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
+			se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 			return;
 		}
 	}
@@ -3400,7 +3400,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	u64 now = cfs_rq_clock_task(cfs_rq);
+	u64 now = cfs_rq_clock_pelt(cfs_rq);
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 	int decayed;
@@ -7285,7 +7285,7 @@ static void update_blocked_averages(int cpu)
 		if (throttled_hierarchy(cfs_rq))
 			continue;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
 			update_tg_load_avg(cfs_rq, 0);
 
 		/* Propagate pending load changes to the parent, if any: */
@@ -7306,8 +7306,8 @@ static void update_blocked_averages(int cpu)
 	}
 
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7377,11 +7377,11 @@ static inline void update_blocked_averages(int cpu)
 
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
index 35475c0..48f4f07 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -30,6 +30,72 @@
 #include "pelt.h"
 
 /*
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
+void update_rq_clock_pelt(struct rq *rq, s64 delta)
+{
+
+	if (is_idle_task(rq->curr)) {
+		u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
+		u32 overload = rq->cfs.avg.util_sum + LOAD_AVG_MAX;
+		overload += rq->avg_rt.util_sum;
+		overload += rq->avg_dl.util_sum;
+
+		/*
+		 * Reflecting some stolen time makes sense only if the idle
+		 * phase would be present at max capacity. As soon as the
+		 * utilization of a rq has reached the maximum value, it is
+		 * considered as an always runnnig rq without idle time to
+		 * steal. This potential idle time is considered as lost in
+		 * this case. We keep track of this lost idle time compare to
+		 * rq's clock_task.
+		 */
+		if (overload >= divider)
+			rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+
+
+		/* The rq is idle, we can sync to clock_task */
+		rq->clock_pelt  = rq_clock_task(rq);
+
+
+	} else {
+		/*
+		 * When a rq runs at a lower compute capacity, it will need
+		 * more time to do the same amount of work than at max
+		 * capacity: either because it takes more time to compute the
+		 * same amount of work or because taking more time means
+		 * sharing more often the CPU between entities.
+		 * In order to be invariant, we scale the delta to reflect how
+		 * much work has been really done.
+		 * Running at lower capacity also means running longer to do
+		 * the same amount of work and this results in stealing some
+		 * idle time that will disturb the load signal compared to
+		 * max capacity; This stolen idle time will be automaticcally
+		 * reflected when the rq will be idle and the clock will be
+		 * synced with rq_clock_task.
+		 */
+
+		/*
+		 * scale the elapsed time to reflect the real amount of
+		 * computation
+		 */
+		delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
+		delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+
+		rq->clock_pelt += delta;
+	}
+}
+
+/*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
  */
@@ -106,16 +172,12 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
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
 
@@ -137,13 +199,12 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
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
@@ -221,7 +282,7 @@ ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
+	if (!accumulate_sum(delta, sa, load, runnable, running))
 		return 0;
 
 	return 1;
@@ -371,12 +432,21 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
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
index d2894db..b4ce173 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -42,6 +42,29 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+void update_rq_clock_pelt(struct rq *rq, s64 delta);
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
@@ -67,6 +90,10 @@ update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
 }
+
+static inline void
+update_rq_clock_pelt(struct rq *rq, s64 delta) {}
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
index 3990818..d987f50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -848,6 +848,8 @@ struct rq {
 	unsigned int		clock_update_flags;
 	u64			clock;
 	u64			clock_task;
+	u64			clock_pelt;
+	unsigned long		lost_idle_time;
 
 	atomic_t		nr_iowait;
 
-- 
2.7.4


Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50101272A3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50101272A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965663AbeF1Lll (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:41:41 -0400
Received: from foss.arm.com ([217.140.101.70]:45890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeF1Llf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603531529;
        Thu, 28 Jun 2018 04:41:35 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492B23F266;
        Thu, 28 Jun 2018 04:41:31 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point indicator
Date:   Thu, 28 Jun 2018 12:40:39 +0100
Message-Id: <20180628114043.24724-9-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

Energy-aware scheduling is only meant to be active while the system is
_not_ over-utilized. That is, there are spare cycles available to shift
tasks around based on their actual utilization to get a more
energy-efficient task distribution without depriving any tasks. When
above the tipping point task placement is done the traditional way based
on load_avg, spreading the tasks across as many cpus as possible based
on priority scaled load to preserve smp_nice. Below the tipping point we
want to use util_avg instead. We need to define a criteria for when we
make the switch.

The util_avg for each cpu converges towards 100% (1024) regardless of
how many task additional task we may put on it. If we define
over-utilized as:

sum_{cpus}(rq.cfs.avg.util_avg) + margin > sum_{cpus}(rq.capacity)

some individual cpus may be over-utilized running multiple tasks even
when the above condition is false. That should be okay as long as we try
to spread the tasks out to avoid per-cpu over-utilization as much as
possible and if all tasks have the _same_ priority. If the latter isn't
true, we have to consider priority to preserve smp_nice.

For example, we could have n_cpus nice=-10 util_avg=55% tasks and
n_cpus/2 nice=0 util_avg=60% tasks. Balancing based on util_avg we are
likely to end up with nice=-10 tasks sharing cpus and nice=0 tasks
getting their own as we 1.5*n_cpus tasks in total and 55%+55% is less
over-utilized than 55%+60% for those cpus that have to be shared. The
system utilization is only 85% of the system capacity, but we are
breaking smp_nice.

To be sure not to break smp_nice, we have defined over-utilization
conservatively as when any cpu in the system is fully utilized at it's
highest frequency instead:

cpu_rq(any).cfs.avg.util_avg + margin > cpu_rq(any).capacity

IOW, as soon as one cpu is (nearly) 100% utilized, we switch to load_avg
to factor in priority to preserve smp_nice.

With this definition, we can skip periodic load-balance as no cpu has an
always-running task when the system is not over-utilized. All tasks will
be periodic and we can balance them at wake-up. This conservative
condition does however mean that some scenarios that could benefit from
energy-aware decisions even if one cpu is fully utilized would not get
those benefits.

For system where some cpus might have reduced capacity on some cpus
(RT-pressure and/or big.LITTLE), we want periodic load-balance checks as
soon a just a single cpu is fully utilized as it might one of those with
reduced capacity and in that case we want to migrate it.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c  | 48 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  3 +++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05aab7f..4f74c6d0a79e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5374,6 +5374,24 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_SMP
+static inline unsigned long cpu_util(int cpu);
+static unsigned long capacity_of(int cpu);
+
+static inline bool cpu_overutilized(int cpu)
+{
+	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
+}
+
+static inline void update_overutilized_status(struct rq *rq)
+{
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		WRITE_ONCE(rq->rd->overutilized, 1);
+}
+#else
+static inline void update_overutilized_status(struct rq *rq) { }
+#endif
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5384,6 +5402,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5431,8 +5450,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
+		if (!task_new)
+			update_overutilized_status(rq);
+
+	}
 
 	hrtick_update(rq);
 }
@@ -8114,11 +8137,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
  * @overload: Indicate more than one runnable task for any CPU.
+ * @overutilized: Indicate overutilization for any CPU.
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
 			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+			bool *overload, int *overutilized)
 {
 	unsigned long load;
 	int i, nr_running;
@@ -8145,6 +8169,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (nr_running > 1)
 			*overload = true;
 
+		if (cpu_overutilized(i))
+			*overutilized = 1;
+
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
 		sgs->nr_preferred_running += rq->nr_preferred_running;
@@ -8282,6 +8309,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
 	bool overload = false;
+	int overutilized = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -8308,7 +8336,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+						&overload, &overutilized);
 
 		if (local_group)
 			goto next_group;
@@ -8360,6 +8388,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		/* update overload indicator if we are at root domain */
 		if (env->dst_rq->rd->overload != overload)
 			env->dst_rq->rd->overload = overload;
+
+		/* Update over-utilization (tipping point, U >= 0) indicator */
+		if (READ_ONCE(env->dst_rq->rd->overutilized) != overutilized)
+			WRITE_ONCE(env->dst_rq->rd->overutilized, overutilized);
+	} else {
+		if (!READ_ONCE(env->dst_rq->rd->overutilized) && overutilized)
+			WRITE_ONCE(env->dst_rq->rd->overutilized, 1);
 	}
 }
 
@@ -8579,6 +8614,11 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
+
+	if (rd_freq_domain(env->dst_rq->rd) &&
+				!READ_ONCE(env->dst_rq->rd->overutilized))
+		goto out_balanced;
+
 	local = &sds.local_stat;
 	busiest = &sds.busiest_stat;
 
@@ -9936,6 +9976,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_overutilized_status(task_rq(curr));
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5d4e9bbe9e53..4e6548e4afc5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -698,6 +698,9 @@ struct root_domain {
 	/* Indicate more than one runnable task for any CPU */
 	bool			overload;
 
+	/* Indicate one or more cpus over-utilized (tipping point) */
+	int			overutilized;
+
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
 	 * than one runnable -deadline task (as it is below for RT tasks).
-- 
2.17.1


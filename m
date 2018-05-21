Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeEUOZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:51 -0400
Received: from foss.arm.com ([217.140.101.70]:51018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbeEUOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:49 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 06/10] sched: Add over-utilization/tipping point indicator
Date: Mon, 21 May 2018 15:25:01 +0100
Message-Id: <20180521142505.6522-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 kernel/sched/fair.c  | 47 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  3 +++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f6a23a5b451..ec797d7ede83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5345,6 +5345,24 @@ static inline void hrtick_update(struct rq *rq)
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
@@ -5355,6 +5373,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -5394,8 +5413,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
+		if (!task_new)
+			update_overutilized_status(rq);
+
+	}
 
 	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
@@ -8121,11 +8144,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
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
@@ -8152,6 +8176,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (nr_running > 1)
 			*overload = true;
 
+		if (cpu_overutilized(i))
+			*overutilized = 1;
+
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
 		sgs->nr_preferred_running += rq->nr_preferred_running;
@@ -8289,6 +8316,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
 	bool overload = false;
+	int overutilized = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -8315,7 +8343,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+						&overload, &overutilized);
 
 		if (local_group)
 			goto next_group;
@@ -8367,6 +8395,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
 
@@ -8586,6 +8621,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
+
+	if (sched_energy_enabled() && !READ_ONCE(env->dst_rq->rd->overutilized))
+		goto out_balanced;
+
 	local = &sds.local_stat;
 	busiest = &sds.busiest_stat;
 
@@ -9943,6 +9982,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_overutilized_status(task_rq(curr));
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7c517076a74a..ef5d4ebc205e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -692,6 +692,9 @@ struct root_domain {
 	/* Indicate more than one runnable task for any CPU */
 	bool			overload;
 
+	/* Indicate one or more cpus over-utilized (tipping point) */
+	int			overutilized;
+
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
 	 * than one runnable -deadline task (as it is below for RT tasks).
-- 
2.17.0

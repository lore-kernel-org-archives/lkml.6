Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425790AbeBOQWw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:22:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425691AbeBOQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:29 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 3/7] sched/fair: Consider misfit tasks when load-balancing
Date: Thu, 15 Feb 2018 16:20:50 +0000
Message-Id: <1518711654-23503-4-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On asymmetric cpu capacity systems load intensive tasks can end up on
cpus that don't suit their compute demand.  In this scenarios 'misfit'
tasks should be migrated to cpus with higher compute capacity to ensure
better throughput. group_misfit_task indicates this scenario, but tweaks
to the load-balance code are needed to make the migrations happen.

Misfit balancing only makes sense between a source group of lower
per-cpu capacity and destination group of higher compute capacity.
Otherwise, misfit balancing is ignored. group_misfit_task has lowest
priority so any imbalance due to overload is dealt with first.

The modifications are:

1. Only pick a group containing misfit tasks as the busiest group if the
   destination group has higher capacity and has spare capacity.
2. When the busiest group is a 'misfit' group, skip the usual average
   load and group capacity checks.
3. Set the imbalance for 'misfit' balancing sufficiently high for a task
   to be pulled ignoring average load.
4. Pick the first cpu with the rq->misfit flag raised as the source cpu.
5. If the misfit task is alone on the source cpu, go for active
   balancing.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bdca97ea516e..0d70838ed711 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7004,6 +7004,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
+	enum group_type		src_grp_type;
 	struct list_head	tasks;
 };
 
@@ -7894,6 +7895,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 {
 	struct sg_lb_stats *busiest = &sds->busiest_stat;
 
+	/*
+	 * Don't try to pull misfit tasks we can't help.
+	 */
+	if (sgs->group_type == group_misfit_task &&
+	    (!group_smaller_cpu_capacity(sg, sds->local) ||
+	     !group_has_capacity(env, &sds->local_stat)))
+		return false;
+
 	if (sgs->group_type > busiest->group_type)
 		return true;
 
@@ -8199,8 +8208,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * factors in sg capacity and sgs with smaller group_type are
 	 * skipped when updating the busiest sg:
 	 */
-	if (busiest->avg_load <= sds->avg_load ||
-	    local->avg_load >= sds->avg_load) {
+	if (busiest->group_type != group_misfit_task &&
+	    (busiest->avg_load <= sds->avg_load ||
+	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
 		return fix_small_imbalance(env, sds);
 	}
@@ -8234,6 +8244,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		(sds->avg_load - local->avg_load) * local->group_capacity
 	) / SCHED_CAPACITY_SCALE;
 
+	/* Boost imbalance to allow misfit task to be balanced. */
+	if (busiest->group_type == group_misfit_task) {
+		env->imbalance = max_t(long, env->imbalance,
+				       busiest->group_misfit_task_load);
+	}
+
 	/*
 	 * if *imbalance is less than the average load per runnable task
 	 * there is no guarantee that any tasks will be moved so we'll have
@@ -8300,6 +8316,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->group_no_capacity)
 		goto force_balance;
 
+	/* Misfit tasks should be dealt with regardless of the avg load */
+	if (busiest->group_type == group_misfit_task)
+		goto force_balance;
+
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
@@ -8337,6 +8357,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
+	env->src_grp_type = busiest->group_type;
 	calculate_imbalance(env, &sds);
 	return sds.busiest;
 
@@ -8384,6 +8405,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
+		/*
+		 * For ASYM_CPUCAPACITY domains with misfit tasks we ignore
+		 * load.
+		 */
+		if (env->src_grp_type == group_misfit_task &&
+		    rq->misfit_task_load)
+			return rq;
+
 		capacity = capacity_of(i);
 
 		wl = weighted_cpuload(rq);
@@ -8453,6 +8482,9 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
+	if (env->src_grp_type == group_misfit_task)
+		return 1;
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
-- 
2.7.4

Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A382C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F9520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F9520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeFTJKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:10:13 -0400
Received: from foss.arm.com ([217.140.101.70]:33962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752915AbeFTJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F126B15B2;
        Wed, 20 Jun 2018 02:06:41 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A51B3F246;
        Wed, 20 Jun 2018 02:06:40 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv3 2/9] sched/fair: Add group_misfit_task load-balance type
Date:   Wed, 20 Jun 2018 10:05:42 +0100
Message-Id: <1529485549-5191-3-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maximize throughput in systems with asymmetric cpu capacities (e.g.
ARM big.LITTLE) load-balancing has to consider task and cpu utilization
as well as per-cpu compute capacity when load-balancing in addition to
the current average load based load-balancing policy. Tasks with high
utilization that are scheduled on a lower capacity cpu need to be
identified and migrated to a higher capacity cpu if possible to maximize
throughput.

To implement this additional policy an additional group_type
(load-balance scenario) is added: group_misfit_task. This represents
scenarios where a sched_group has one or more tasks that are not
suitable for its per-cpu capacity. group_misfit_task is only considered
if the system is not overloaded or imbalanced (group_imbalanced or
group_overloaded).

Identifying misfit tasks requires the rq lock to be held. To avoid
taking remote rq locks to examine source sched_groups for misfit tasks,
each cpu is responsible for tracking misfit tasks themselves and update
the rq->misfit_task flag. This means checking task utilization when
tasks are scheduled and on sched_tick.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |  2 ++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6116d1b7e441..ed7eb2ac068f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -697,6 +697,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
+static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
 void init_entity_runnable_average(struct sched_entity *se)
@@ -1448,7 +1449,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 static unsigned long weighted_cpuload(struct rq *rq);
 static unsigned long source_load(int cpu, int type);
 static unsigned long target_load(int cpu, int type);
-static unsigned long capacity_of(int cpu);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -4043,6 +4043,29 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	WRITE_ONCE(p->se.avg.util_est, ue);
 }
 
+static inline int task_fits_capacity(struct task_struct *p, long capacity)
+{
+	return capacity * 1024 > task_util_est(p) * capacity_margin;
+}
+
+static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
+{
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return;
+
+	if (!p) {
+		rq->misfit_task_load = 0;
+		return;
+	}
+
+	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
+		rq->misfit_task_load = 0;
+		return;
+	}
+
+	rq->misfit_task_load = task_h_load(p);
+}
+
 #else /* CONFIG_SMP */
 
 static inline int
@@ -4078,6 +4101,7 @@ util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 static inline void
 util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
 		 bool task_sleep) {}
+static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
 
@@ -6598,7 +6622,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !task_fits_capacity(p, min_cap);
 }
 
 /*
@@ -7015,9 +7039,12 @@ done: __maybe_unused;
 	if (hrtick_enabled(rq))
 		hrtick_start_fair(rq, p);
 
+	update_misfit_status(p, rq);
+
 	return p;
 
 idle:
+	update_misfit_status(NULL, rq);
 	new_tasks = idle_balance(rq, rf);
 
 	/*
@@ -7223,6 +7250,13 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 
 enum fbq_type { regular, remote, all };
 
+enum group_type {
+	group_other = 0,
+	group_misfit_task,
+	group_imbalanced,
+	group_overloaded,
+};
+
 #define LBF_ALL_PINNED	0x01
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
@@ -7764,12 +7798,6 @@ static unsigned long task_h_load(struct task_struct *p)
 
 /********** Helpers for find_busiest_group ************************/
 
-enum group_type {
-	group_other = 0,
-	group_imbalanced,
-	group_overloaded,
-};
-
 /*
  * sg_lb_stats - stats of a sched_group required for load_balancing
  */
@@ -7785,6 +7813,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	unsigned long group_misfit_task_load; /* A cpu has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -8084,6 +8113,9 @@ group_type group_classify(struct sched_group *group,
 	if (sg_imbalanced(group))
 		return group_imbalanced;
 
+	if (sgs->group_misfit_task_load)
+		return group_misfit_task;
+
 	return group_other;
 }
 
@@ -8158,6 +8190,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 */
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
+
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		    sgs->group_misfit_task_load < rq->misfit_task_load)
+			sgs->group_misfit_task_load = rq->misfit_task_load;
 	}
 
 	/* Adjust by relative CPU capacity of the group */
@@ -9939,6 +9975,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_misfit_status(curr, rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0fbfbcf5c551..273d07dedc90 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -815,6 +815,8 @@ struct rq {
 
 	unsigned char		idle_balance;
 
+	unsigned long		misfit_task_load;
+
 	/* For active balancing */
 	int			active_balance;
 	int			push_cpu;
-- 
2.7.4


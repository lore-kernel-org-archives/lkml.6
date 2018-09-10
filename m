Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BDC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CD120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CD120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIJPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:07:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:07:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AADoXu1807861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:13:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AADon51807858;
        Mon, 10 Sep 2018 03:13:50 -0700
Date:   Mon, 10 Sep 2018 03:13:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-3b1baa6496e6b7ad016342a9d256bdfb072ce902@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1530699470-29808-3-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-3-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Add 'group_misfit_task' load-balance
 type
Git-Commit-ID: 3b1baa6496e6b7ad016342a9d256bdfb072ce902
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

Commit-ID:  3b1baa6496e6b7ad016342a9d256bdfb072ce902
Gitweb:     https://git.kernel.org/tip/3b1baa6496e6b7ad016342a9d256bdfb072ce902
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:40 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:49 +0200

sched/fair: Add 'group_misfit_task' load-balance type

To maximize throughput in systems with asymmetric CPU capacities (e.g.
ARM big.LITTLE) load-balancing has to consider task and CPU utilization
as well as per-CPU compute capacity when load-balancing in addition to
the current average load based load-balancing policy. Tasks with high
utilization that are scheduled on a lower capacity CPU need to be
identified and migrated to a higher capacity CPU if possible to maximize
throughput.

To implement this additional policy an additional group_type
(load-balance scenario) is added: 'group_misfit_task'. This represents
scenarios where a sched_group has one or more tasks that are not
suitable for its per-CPU capacity. 'group_misfit_task' is only considered
if the system is not overloaded or imbalanced ('group_imbalanced' or
'group_overloaded').

Identifying misfit tasks requires the rq lock to be held. To avoid
taking remote rq locks to examine source sched_groups for misfit tasks,
each CPU is responsible for tracking misfit tasks themselves and update
the rq->misfit_task flag. This means checking task utilization when
tasks are scheduled and on sched_tick.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-3-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |  2 ++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e5071aeb117..6e04bea5b11a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -693,6 +693,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
+static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
 void init_entity_runnable_average(struct sched_entity *se)
@@ -1446,7 +1447,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 static unsigned long weighted_cpuload(struct rq *rq);
 static unsigned long source_load(int cpu, int type);
 static unsigned long target_load(int cpu, int type);
-static unsigned long capacity_of(int cpu);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -3647,6 +3647,29 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
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
 
 #define UPDATE_TG	0x0
@@ -3676,6 +3699,7 @@ util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 static inline void
 util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
 		 bool task_sleep) {}
+static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
 
@@ -6201,7 +6225,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !task_fits_capacity(p, min_cap);
 }
 
 /*
@@ -6618,9 +6642,12 @@ done: __maybe_unused;
 	if (hrtick_enabled(rq))
 		hrtick_start_fair(rq, p);
 
+	update_misfit_status(p, rq);
+
 	return p;
 
 idle:
+	update_misfit_status(NULL, rq);
 	new_tasks = idle_balance(rq, rf);
 
 	/*
@@ -6826,6 +6853,13 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 
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
@@ -7399,12 +7433,6 @@ static unsigned long task_h_load(struct task_struct *p)
 
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
@@ -7420,6 +7448,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -7712,6 +7741,9 @@ group_type group_classify(struct sched_group *group,
 	if (sg_imbalanced(group))
 		return group_imbalanced;
 
+	if (sgs->group_misfit_task_load)
+		return group_misfit_task;
+
 	return group_other;
 }
 
@@ -7786,6 +7818,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 */
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
+
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		    sgs->group_misfit_task_load < rq->misfit_task_load)
+			sgs->group_misfit_task_load = rq->misfit_task_load;
 	}
 
 	/* Adjust by relative CPU capacity of the group */
@@ -9567,6 +9603,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_misfit_status(curr, rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f36adc31ba5..7dbf67d147a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -842,6 +842,8 @@ struct rq {
 
 	unsigned char		idle_balance;
 
+	unsigned long		misfit_task_load;
+
 	/* For active balancing */
 	int			active_balance;
 	int			push_cpu;

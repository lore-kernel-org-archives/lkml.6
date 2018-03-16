Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeCPLZ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:25:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36933 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbeCPLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:55 -0400
X-Google-Smtp-Source: AG47ELunT2n/TDfKKlL9PhkgwK6vsrugGG+uS6wVQ6slcS9oLLtQo/Wrh/1W81Lup4D0YpYxx24jcQ==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/4 v4] sched/rt: add rt_rq utilization tracking
Date: Fri, 16 Mar 2018 12:25:39 +0100
Message-Id: <1521199541-15308-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
tasks are running. When the CPU is overloaded by cfs and rt tasks, cfs
tasks are preempted by rt tasks and in this case util_avg reflects the
remaining capacity that is used by cfs task but not what cfs want to use.
In such case, schedutil can select a lower OPP whereas the CPU is
overloaded. In order to have a more accurate view of the utilization of
the CPU, we track the utilization that is "stolen" by RT tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  2 ++
 kernel/sched/pelt.c  | 23 +++++++++++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/rt.c    |  8 ++++++++
 kernel/sched/sched.h |  2 ++
 5 files changed, 42 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfd56bc..60e3c4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7190,6 +7190,7 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
+	update_rt_rq_load_avg(rq_clock_task(rq), cpu, &rq->rt, 0);
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7255,6 +7256,7 @@ static inline void update_blocked_averages(int cpu)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), cpu, &rq->rt, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
 	if (!cfs_rq_has_blocked(cfs_rq))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index d693e5e..cd51576 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -306,3 +306,26 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 
 	return 0;
 }
+
+/*
+ * rt_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_rt_rq_load_avg(u64 now, int cpu, struct rt_rq *rt_rq, int running)
+{
+	if (___update_load_sum(now, cpu, &rt_rq->avg,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rt_rq->avg, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index c312d8c..78a2107 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -3,6 +3,7 @@
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
+int update_rt_rq_load_avg(u64 now, int cpu, struct rt_rq *rt_rq, int running);
 
 #else
 
@@ -12,6 +13,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int
+update_rt_rq_load_avg(u64 now, int cpu, struct rt_rq *rt_rq, int running)
+{
+	return 0;
+}
+
 #endif
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 86b7798..c48078e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,6 +5,8 @@
  */
 #include "sched.h"
 
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 
@@ -1570,6 +1572,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	rt_queue_push_tasks(rq);
 
+	update_rt_rq_load_avg(rq_clock_task(rq), cpu_of(rq), rt_rq,
+		rq->curr->sched_class == &rt_sched_class);
+
 	return p;
 }
 
@@ -1577,6 +1582,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
+	update_rt_rq_load_avg(rq_clock_task(rq), cpu_of(rq), &rq->rt, 1);
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
@@ -2306,6 +2313,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), cpu_of(rq), &rq->rt, 1);
 
 	watchdog(rq, p);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 783eacf..a8003a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -592,6 +592,8 @@ struct rt_rq {
 	unsigned long		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
+
+	struct sched_avg avg;
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936159AbeEYNOk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:14:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37120 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934540AbeEYNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:45 -0400
X-Google-Smtp-Source: ADUXVKJ+GvfBghZr6uueA9x5G0zHP1XLgfHSohubIXHeqFNTZjEzM7ubFM6zIdCIZOF4TSlD4bF5KA==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 04/10] sched/dl: add dl_rq utilization tracking
Date: Fri, 25 May 2018 15:12:25 +0200
Message-Id: <1527253951-22709-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what happens with rt tasks, cfs tasks can be preempted by dl
tasks and the cfs's utilization might no longer describes the real
utilization level.
Current dl bandwidth reflects the requirements to meet deadline when tasks are
enqueued but not the current utilization of the dl sched class. We track
dl class utilization to estimate the system utilization.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c |  5 +++++
 kernel/sched/fair.c     | 11 ++++++++---
 kernel/sched/pelt.c     | 23 +++++++++++++++++++++++
 kernel/sched/pelt.h     |  6 ++++++
 kernel/sched/sched.h    |  1 +
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd..950b3fb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -1761,6 +1762,8 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	deadline_queue_push_tasks(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq,
+		rq->curr->sched_class == &dl_sched_class);
 	return p;
 }
 
@@ -1768,6 +1771,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -1784,6 +1788,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb18bcc..967e873 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,11 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool rt_rq_has_blocked(struct rq *rq)
+static inline bool others_rqs_have_blocked(struct rq *rq)
 {
 	if (rq->avg_rt.util_avg)
 		return true;
 
+	if (rq->avg_dl.util_avg)
+		return true;
+
 	return false;
 }
 
@@ -7358,8 +7361,9 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (rt_rq_has_blocked(rq))
+	if (others_rqs_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7427,9 +7431,10 @@ static inline void update_blocked_averages(int cpu)
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 213b922..b07db80 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -332,3 +332,26 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+/*
+ * dl_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rq->avg_dl, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index b2983b7..0e4f912 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -4,6 +4,7 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -45,6 +46,11 @@ update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+static inline int
+update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7a16de9..4526ba6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -849,6 +849,7 @@ struct rq {
 	u64			rt_avg;
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
+	struct sched_avg	avg_dl;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4

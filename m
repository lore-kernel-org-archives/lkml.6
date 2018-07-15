Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFE5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9975E2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9975E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeGOXv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:51:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56639 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeGOXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:51:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNR3KO921262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:27:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNR3SJ921259;
        Sun, 15 Jul 2018 16:27:03 -0700
Date:   Sun, 15 Jul 2018 16:27:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-371bf42732694d142b0de026e152266c039b97d3@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <1530200714-4504-3-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-3-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/rt: Add rt_rq utilization tracking
Git-Commit-ID: 371bf42732694d142b0de026e152266c039b97d3
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

Commit-ID:  371bf42732694d142b0de026e152266c039b97d3
Gitweb:     https://git.kernel.org/tip/371bf42732694d142b0de026e152266c039b97d3
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:05 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:20 +0200

sched/rt: Add rt_rq utilization tracking

schedutil governor relies on cfs_rq's util_avg to choose the OPP when CFS
tasks are running. When the CPU is overloaded by CFS and RT tasks, CFS tasks
are preempted by RT tasks and in this case util_avg reflects the remaining
capacity but not what CFS want to use. In such case, schedutil can select a
lower OPP whereas the CPU is overloaded. In order to have a more accurate
view of the utilization of the CPU, we track the utilization of RT tasks.
Only util_avg is correctly tracked but not load_avg and runnable_load_avg
which are useless for rt_rq.

rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
the same at the root group level, so the PELT windows of the util_sum are
aligned.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Cc: viresh.kumar@linaro.org
Link: http://lkml.kernel.org/r/1530200714-4504-3-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 15 ++++++++++++++-
 kernel/sched/pelt.c  | 25 +++++++++++++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/rt.c    | 13 +++++++++++++
 kernel/sched/sched.h |  7 +++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39ab46cea6c5..5b453213cd18 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,6 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
+static inline bool rt_rq_has_blocked(struct rq *rq)
+{
+	if (READ_ONCE(rq->avg_rt.util_avg))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7349,6 +7357,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	/* Don't need periodic decay once load/util_avg are null */
+	if (rt_rq_has_blocked(rq))
+		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7414,9 +7426,10 @@ static inline void update_blocked_averages(int cpu)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index e6ecbb2b8698..a00b1ba3dd5b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -309,3 +309,28 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 
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
+ *   load_avg and runnable_load_avg are not supported and meaningless.
+ *
+ */
+
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rq->avg_rt, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9cac73efd64a..b2983b741d57 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -3,6 +3,7 @@
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -38,6 +39,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int
+update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
+
 #endif
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 572567078b60..0dc8ad1915e6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,6 +5,8 @@
  */
 #include "sched.h"
 
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 
@@ -1576,6 +1578,14 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	rt_queue_push_tasks(rq);
 
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1583,6 +1593,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
@@ -2312,6 +2324,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
 
 	watchdog(rq, p);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 00d6f2594c4e..405dd9ba6b39 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -594,6 +594,7 @@ struct rt_rq {
 	unsigned long		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
+
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
@@ -854,6 +855,7 @@ struct rq {
 
 	u64			rt_avg;
 	u64			age_stamp;
+	struct sched_avg	avg_rt;
 	u64			idle_stamp;
 	u64			avg_idle;
 
@@ -2212,4 +2214,9 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 	return util;
 }
+
+static inline unsigned long cpu_util_rt(struct rq *rq)
+{
+	return rq->avg_rt.util_avg;
+}
 #endif

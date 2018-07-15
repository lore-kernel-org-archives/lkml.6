Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD82ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053052089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053052089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeGOXw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:52:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeGOXw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:52:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNS466921350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:28:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNS3lG921347;
        Sun, 15 Jul 2018 16:28:03 -0700
Date:   Sun, 15 Jul 2018 16:28:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-3727e0e16340cbdf83818f5bf0113505c6876057@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: vincent.guittot@linaro.org, torvalds@linux-foundation.org,
          hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1530200714-4504-5-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-5-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/dl: Add dl_rq utilization tracking
Git-Commit-ID: 3727e0e16340cbdf83818f5bf0113505c6876057
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

Commit-ID:  3727e0e16340cbdf83818f5bf0113505c6876057
Gitweb:     https://git.kernel.org/tip/3727e0e16340cbdf83818f5bf0113505c6876057
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:07 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:20 +0200

sched/dl: Add dl_rq utilization tracking

Similarly to what happens with RT tasks, CFS tasks can be preempted by DL
tasks and the CFS's utilization might no longer describes the real
utilization level.

Current DL bandwidth reflects the requirements to meet deadline when tasks are
enqueued but not the current utilization of the DL sched class. We track
DL class utilization to estimate the system utilization.

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
Link: http://lkml.kernel.org/r/1530200714-4504-5-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c |  6 ++++++
 kernel/sched/fair.c     | 11 ++++++++---
 kernel/sched/pelt.c     | 23 +++++++++++++++++++++++
 kernel/sched/pelt.h     |  6 ++++++
 kernel/sched/sched.h    |  1 +
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..f4de26982d80 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -1761,6 +1762,9 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	deadline_queue_push_tasks(rq);
 
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1768,6 +1772,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -1784,6 +1789,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b453213cd18..f096275c7df2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,11 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool rt_rq_has_blocked(struct rq *rq)
+static inline bool others_rqs_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_dl.util_avg))
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
index a00b1ba3dd5b..8b78b6320cda 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -334,3 +334,26 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
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
index b2983b741d57..0e4f912461ad 100644
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
index 405dd9ba6b39..ab8b5296b5f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -856,6 +856,7 @@ struct rq {
 	u64			rt_avg;
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
+	struct sched_avg	avg_dl;
 	u64			idle_stamp;
 	u64			avg_idle;
 

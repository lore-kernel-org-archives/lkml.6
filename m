Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeE3Ohu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbeE3OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:24 -0400
Message-Id: <20180530143105.977759909@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 02/11] sched/fair: Age the average idle time
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-2.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently select_idle_cpu()'s proportional scheme uses the average
idle time *for when we are idle*, that is temporally challenged.

When we're not at all idle, we'll happily continue using whatever
value we did see when we did go idle. To fix this, introduce a seprate
average idle and age it (the existing value still makes sense for
things like new-idle balancing, which happens when we do go idle).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |    5 +++++
 kernel/sched/fair.c     |   29 ++++++++++++++++++++++++-----
 kernel/sched/features.h |    2 ++
 kernel/sched/sched.h    |    3 +++
 4 files changed, 34 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1674,6 +1674,9 @@ static void ttwu_do_wakeup(struct rq *rq
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle / 2;
+
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -6051,6 +6054,8 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6378,11 +6378,30 @@ static int select_idle_cpu(struct task_s
 	if (!this_sd)
 		return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
+	if (sched_feat(SIS_AGE)) {
+		unsigned long now = jiffies;
+		struct rq *this_rq = this_rq();
+
+		/*
+		 * If we're busy, the assumption that the last idle period
+		 * predicts the future is flawed; age away the remaining
+		 * predicted idle time.
+		 */
+		if (unlikely(this_rq->wake_stamp < now)) {
+			while (this_rq->wake_stamp < now && this_rq->wake_avg) {
+				this_rq->wake_stamp++;
+				this_rq->wake_avg >>= 1;
+			}
+		}
+
+		avg_idle = this_rq->wake_avg;
+	} else {
+		/*
+		 * Due to large variance we need a large fuzz factor; hackbench
+		 * in particularly is sensitive here.
+		 */
+		avg_idle = this_rq()->avg_idle / 512;
+	}
 	avg_cost = this_sd->avg_scan_cost + 1;
 
 	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -58,6 +58,8 @@ SCHED_FEAT(TTWU_QUEUE, true)
 SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
+SCHED_FEAT(SIS_AGE, true)
+
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -831,6 +831,9 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
+	unsigned long		wake_stamp;
+	u64			wake_avg;
+
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 #endif

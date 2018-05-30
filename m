Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeE3OhZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeE3OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:17 -0400
Message-Id: <20180530143106.396633083@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 10/11] sched/fair: Remove SIS_AGE/SIS_ONCE
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-10.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new scheme is clearly better (XXX need !hackbench numbers), clean
up the mess.

This leaves everything under SIS_PROP, which I think Facebook still
uses (to disable), Rik?

Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   43 ++++++++++++++++++-------------------------
 kernel/sched/features.h |    3 ---
 2 files changed, 18 insertions(+), 28 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6432,16 +6432,18 @@ static int select_idle_cpu(struct task_s
 	int cpu, loops = 0, nr = INT_MAX;
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
-	u64 time, cost;
-	s64 delta;
+	struct rq *this_rq;
+	u64 time;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
 		return -1;
 
-	if (sched_feat(SIS_AGE)) {
+	if (sched_feat(SIS_PROP)) {
 		unsigned long now = jiffies;
-		struct rq *this_rq = this_rq();
+		u64 span_avg;
+
+		this_rq = this_rq();
 
 		/*
 		 * If we're busy, the assumption that the last idle period
@@ -6456,24 +6458,16 @@ static int select_idle_cpu(struct task_s
 		}
 
 		avg_idle = this_rq->wake_avg;
-	} else {
-		/*
-		 * Due to large variance we need a large fuzz factor; hackbench
-		 * in particularly is sensitive here.
-		 */
-		avg_idle = this_rq()->avg_idle / 512;
-	}
-	avg_cost = this_sd->avg_scan_cost + 1;
+		avg_cost = this_sd->avg_scan_cost + 1;
 
-	if (sched_feat(SIS_PROP)) {
-		u64 span_avg = sd->span_weight * avg_idle;
+		span_avg = sd->span_weight * avg_idle;
 		if (span_avg > sis_min_cores * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
 			nr = sis_min_cores;
-	}
 
-	time = local_clock();
+		time = local_clock();
+	}
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_feat(SIS_FOLD) && static_branch_likely(&sched_smt_present) &&
@@ -6483,26 +6477,25 @@ static int select_idle_cpu(struct task_s
 #endif
 	cpu = __select_idle_cpu(p, sd, target, nr * sched_smt_weight, &loops);
 
-	time = local_clock() - time;
+	if (sched_feat(SIS_PROP)) {
+		s64 delta;
 
-	if (sched_feat(SIS_ONCE)) {
-		struct rq *this_rq = this_rq();
+		time = local_clock() - time;
 
 		/*
 		 * We need to consider the cost of all wakeups between
 		 * consequtive idle periods. We can only use the predicted
 		 * idle time once.
 		 */
-		if (this_rq->wake_avg > time)
+		if (avg_idle > time)
 			this_rq->wake_avg -= time;
 		else
 			this_rq->wake_avg = 0;
-	}
 
-	time = div_u64(time, loops);
-	cost = this_sd->avg_scan_cost;
-	delta = (s64)(time - cost) / 8;
-	this_sd->avg_scan_cost += delta;
+		time = div_u64(time, loops);
+		delta = (s64)(time - avg_cost) / 8;
+		this_sd->avg_scan_cost += delta;
+	}
 
 	return cpu;
 }
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -56,9 +56,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
 SCHED_FEAT(SIS_PROP, true)
-
-SCHED_FEAT(SIS_AGE, true)
-SCHED_FEAT(SIS_ONCE, true)
 SCHED_FEAT(SIS_FOLD, true)
 
 /*

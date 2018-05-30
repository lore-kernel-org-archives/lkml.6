Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeE3Ohl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50284 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbeE3OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:24 -0400
Message-Id: <20180530143105.926359095@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 01/11] sched/fair: Fix select_idle_cpu()s cost accounting
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-1.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We compute the average cost of the total scan, but then use it as a
per-cpu scan cost when computing the scan proportion. Fix this by
properly computing a per-cpu scan cost.

This also fixes a bug where we would terminate early (!--nr, case) and
not account that cost at all.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6368,11 +6368,11 @@ static inline int select_idle_smt(struct
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
+	int cpu, loops = 0, nr = INT_MAX;
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6399,8 +6399,10 @@ static int select_idle_cpu(struct task_s
 	time = local_clock();
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
-		if (!--nr)
-			return -1;
+		if (loops++ >= nr) {
+			cpu = -1;
+			break;
+		}
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
 		if (available_idle_cpu(cpu))
@@ -6408,6 +6410,7 @@ static int select_idle_cpu(struct task_s
 	}
 
 	time = local_clock() - time;
+	time = div_u64(time, loops);
 	cost = this_sd->avg_scan_cost;
 	delta = (s64)(time - cost) / 8;
 	this_sd->avg_scan_cost += delta;

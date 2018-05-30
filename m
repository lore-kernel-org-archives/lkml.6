Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753792AbeE3Oj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:39:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeE3OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:17 -0400
Message-Id: <20180530143106.448422984@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 11/11] sched/fair: Remove SIS_FOLD
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-8.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new code works, remove the old.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   90 +-----------------------------------------------
 kernel/sched/features.h |    4 +-
 2 files changed, 4 insertions(+), 90 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6291,65 +6291,6 @@ void __update_idle_core(struct rq *rq)
 	rcu_read_unlock();
 }
 
-/*
- * Scan the entire LLC domain for idle cores; this dynamically switches off if
- * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
- */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int core, cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	if (!test_idle_cores(target, false))
-		return -1;
-
-	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
-
-	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
-
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
-				idle = false;
-		}
-
-		if (idle)
-			return core;
-	}
-
-	/*
-	 * Failed to find an idle core; stop looking for one.
-	 */
-	set_idle_cores(target, 0);
-
-	return -1;
-}
-
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
-		if (available_idle_cpu(cpu))
-			return cpu;
-	}
-
-	return -1;
-}
-
 static int __select_idle_core(struct task_struct *p, struct sched_domain *sd,
 			      int target, int nr, int *ploops)
 {
@@ -6391,16 +6332,6 @@ static int __select_idle_core(struct tas
 
 #define sched_smt_weight	1
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
 #endif /* CONFIG_SCHED_SMT */
 
 static int __select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
@@ -6470,8 +6401,7 @@ static int select_idle_cpu(struct task_s
 	}
 
 #ifdef CONFIG_SCHED_SMT
-	if (sched_feat(SIS_FOLD) && static_branch_likely(&sched_smt_present) &&
-	    test_idle_cores(target, false))
+	if (static_branch_likely(&sched_smt_present) && test_idle_cores(target, false))
 		cpu = __select_idle_core(p, sd, target, nr, &loops);
 	else
 #endif
@@ -6536,25 +6466,9 @@ static int select_idle_sibling(struct ta
 	if (!sd)
 		return target;
 
-	if (sched_feat(SIS_FOLD)) {
-		i = select_idle_cpu(p, sd, target);
-		if ((unsigned)i < nr_cpumask_bits)
-			target = i;
-
-		return target;
-	}
-
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
-	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		target = i;
 
 	return target;
 }
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -53,10 +53,10 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
 SCHED_FEAT(TTWU_QUEUE, true)
 
 /*
- * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
+ * When doing wakeups, attempt to limit scanning cost of the LLC proportional
+ * to the average idle time.
  */
 SCHED_FEAT(SIS_PROP, true)
-SCHED_FEAT(SIS_FOLD, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls

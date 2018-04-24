Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeDXAjD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:39:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53814 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbeDXAi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:38:59 -0400
From: subhra mazumdar <subhra.mazumdar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, daniel.lezcano@linaro.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, subhra.mazumdar@oracle.com
Subject: [PATCH 1/3] sched: remove select_idle_core() for scalability
Date: Mon, 23 Apr 2018 17:41:14 -0700
Message-Id: <20180424004116.28151-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_core() can potentially search all cpus to find the fully idle
core even if there is one such core. Removing this is necessary to achieve
scalability in the fast path.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 include/linux/sched/topology.h |  1 -
 kernel/sched/fair.c            | 97 ------------------------------------------
 kernel/sched/idle.c            |  1 -
 kernel/sched/sched.h           | 10 -----
 4 files changed, 109 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2634774..ac7944d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -71,7 +71,6 @@ struct sched_group;
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e..d1d4769 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6239,94 +6239,6 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 
 #ifdef CONFIG_SCHED_SMT
 
-static inline void set_idle_cores(int cpu, int val)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
-}
-
-static inline bool test_idle_cores(int cpu, bool def)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
-
-	return def;
-}
-
-/*
- * Scans the local SMT mask to see if the entire core is idle, and records this
- * information in sd_llc_shared->has_idle_cores.
- *
- * Since SMT siblings share all cache levels, inspecting this limited remote
- * state should be fairly cheap.
- */
-void __update_idle_core(struct rq *rq)
-{
-	int core = cpu_of(rq);
-	int cpu;
-
-	rcu_read_lock();
-	if (test_idle_cores(core, true))
-		goto unlock;
-
-	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (cpu == core)
-			continue;
-
-		if (!idle_cpu(cpu))
-			goto unlock;
-	}
-
-	set_idle_cores(core, 1);
-unlock:
-	rcu_read_unlock();
-}
-
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
-			if (!idle_cpu(cpu))
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
 /*
  * Scan the local SMT mask for idle CPUs.
  */
@@ -6349,11 +6261,6 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
 static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
@@ -6451,10 +6358,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1a3e9bd..7ca8e18 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -392,7 +392,6 @@ static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	put_prev_task(rq, prev);
-	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
 
 	return rq->idle;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c2..3f1874c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -899,16 +899,6 @@ static inline int cpu_of(struct rq *rq)
 
 extern struct static_key_false sched_smt_present;
 
-extern void __update_idle_core(struct rq *rq);
-
-static inline void update_idle_core(struct rq *rq)
-{
-	if (static_branch_unlikely(&sched_smt_present))
-		__update_idle_core(rq);
-}
-
-#else
-static inline void update_idle_core(struct rq *rq) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-- 
2.9.3

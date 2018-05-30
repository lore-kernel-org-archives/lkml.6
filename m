Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeE3Ohp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeE3OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:24 -0400
Message-Id: <20180530143106.082002139@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 04/11] sched/topology: Introduce sched_domain_cores()
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-4.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to more efficiently iterate cores/smt, we need a cpumask
containing only the first thread of each core (for the LLC domain).

And since we're iterating SMT specific things, move sched_init_smt()
over there. Also track how many threads per core we have.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/topology.h |    9 +++++++++
 kernel/sched/core.c            |   18 ------------------
 kernel/sched/fair.c            |    3 +++
 kernel/sched/sched.h           |    2 ++
 kernel/sched/topology.c        |   35 +++++++++++++++++++++++++++++++++--
 5 files changed, 47 insertions(+), 20 deletions(-)

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -72,6 +72,8 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+
+	unsigned long core_mask[0];
 };
 
 struct sched_domain {
@@ -162,6 +164,13 @@ static inline struct cpumask *sched_doma
 	return to_cpumask(sd->span);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static inline struct cpumask *sched_domain_cores(struct sched_domain *sd)
+{
+	return to_cpumask(sd->shared->core_mask);
+}
+#endif
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,22 +5854,6 @@ int sched_cpu_dying(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_SCHED_SMT
-DEFINE_STATIC_KEY_FALSE(sched_smt_present);
-
-static void sched_init_smt(void)
-{
-	/*
-	 * We've enumerated all CPUs and will assume that if any CPU
-	 * has SMT siblings, CPU0 will too.
-	 */
-	if (cpumask_weight(cpu_smt_mask(0)) > 1)
-		static_branch_enable(&sched_smt_present);
-}
-#else
-static inline void sched_init_smt(void) { }
-#endif
-
 void __init sched_init_smp(void)
 {
 	sched_init_numa();
@@ -5891,8 +5875,6 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
-	sched_init_smt();
-
 	sched_smp_initialized = true;
 }
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6238,6 +6238,9 @@ static inline int find_idlest_cpu(struct
 }
 
 #ifdef CONFIG_SCHED_SMT
+DEFINE_STATIC_KEY_FALSE(sched_smt_present);
+
+__read_mostly int sched_smt_weight = 1;
 
 static inline void set_idle_cores(int cpu, int val)
 {
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -910,6 +910,8 @@ static inline void update_idle_core(stru
 		__update_idle_core(rq);
 }
 
+extern __read_mostly int sched_smt_weight;
+
 #else
 static inline void update_idle_core(struct rq *rq) { }
 #endif
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1190,8 +1190,39 @@ sd_init(struct sched_domain_topology_lev
 	 */
 	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		if (atomic_read(&sd->shared->ref)) {
+			atomic_inc(&sd->shared->ref);
+		} else {
+#ifdef CONFIG_SCHED_SMT
+			int core, smt, smt_weight;
+
+			/*
+			 * Set the first SMT sibling of each core present in
+			 * the domain span.
+			 */
+			for_each_cpu(core, sched_domain_span(sd)) {
+				for_each_cpu(smt, cpu_smt_mask(core)) {
+					if (cpumask_test_cpu(smt, sched_domain_span(sd))) {
+						__cpumask_set_cpu(smt, sched_domain_cores(sd));
+						break;
+					}
+				}
+
+				/*
+				 * And track the presence and number of threads per core.
+				 */
+
+				smt_weight = cpumask_weight(cpu_smt_mask(core));
+				if (smt_weight > sched_smt_weight) {
+					sched_smt_weight = smt_weight;
+					static_branch_enable(&sched_smt_present);
+				}
+			}
+#endif
+
+			atomic_set(&sd->shared->ref, 1);
+		}
 	}
 
 	sd->private = sdd;
@@ -1537,7 +1568,7 @@ static int __sdt_alloc(const struct cpum
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;

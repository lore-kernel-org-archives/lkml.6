Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755832AbeDYRtR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:49:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754880AbeDYRtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:49:15 -0400
Date: Wed, 25 Apr 2018 19:49:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
Message-ID: <20180425174909.GB4043@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 02:45:50PM -0700, Subhra Mazumdar wrote:
> So what you said makes sense in theory but is not borne out by real
> world results. This indicates that threads of these benchmarks care more
> about running immediately on any idle cpu rather than spending time to find
> fully idle core to run on.

But you only ran on Intel which emunerates siblings far apart in the
cpuid space. Which is not something we should rely on.

> > So by only doing a linear scan on CPU number you will actually fill
> > cores instead of equally spreading across cores. Worse still, by
> > limiting the scan to _4_ you only barely even get onto a next core for
> > SMT4 hardware, never mind SMT8.

> Again this doesn't matter for the benchmarks I ran. Most are happy to make
> the tradeoff on x86 (SMT2). Limiting the scan is mitigated by the fact that
> the scan window is rotated over all cpus, so idle cpus will be found soon.

You've not been reading well. The Intel machine you tested this on most
likely doesn't suffer that problem because of the way it happens to
iterate SMT threads.

How does Sparc iterate its SMT siblings in cpuid space?

Also, your benchmarks chose an unfortunate nr of threads vs topology.
The 2^n thing chosen never hits the 100% core case (6,22 resp.).

> > So while I'm not adverse to limiting the empty core search; I do feel it
> > is important to have. Overloading cores when you don't have to is not
> > good.

> Can we have a config or a way for enabling/disabling select_idle_core?

I like Rohit's suggestion of folding select_idle_core and
select_idle_cpu much better, then it stays SMT aware.

Something like the completely untested patch below.

---
 include/linux/sched/topology.h |   1 -
 kernel/sched/fair.c            | 148 +++++++++++++----------------------------
 kernel/sched/idle.c            |   1 -
 kernel/sched/sched.h           |  10 ---
 4 files changed, 47 insertions(+), 113 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..ac7944dd8bc6 100644
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
index 54dc31e7ab9b..95fed8dcea7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6239,124 +6239,72 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 
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
 /*
- * Scan the entire LLC domain for idle cores; this dynamically switches off if
- * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
+ * Scan the LLC domain for idlest cores; this is dynamically regulated by
+ * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
+ * average idle time for this rq (as found in rq->avg_idle).
  */
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int best_busy = UINT_MAX, best_cpu = -1;
+	struct sched_domain *this_sd;
+	u64 avg_cost, avg_idle;
+	int nr = INT_MAX;
+	u64 time, cost;
 	int core, cpu;
+	s64 delta;
 
-	if (!static_branch_likely(&sched_smt_present))
+	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+	if (!this_sd)
 		return -1;
 
-	if (!test_idle_cores(target, false))
-		return -1;
+	avg_idle = this_rq()->avg_idle / 512;
+	avg_cost = this_sd->avg_scan_cost + 1;
+
+	if (sched_feat(SIS_PROP)) {
+		u64 span_avg = sd->span_weight * avg_idle;
+		if (span_avg > 2*avg_cost)
+			nr = div_u64(span_avg, avg_cost);
+		else
+			nr = 2;
+	}
+
+	time = local_clock();
 
 	cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
 
 	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
+		int first_idle = -1;
+		int busy = 0;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			cpumask_clear_cpu(cpu, cpus);
 			if (!idle_cpu(cpu))
-				idle = false;
+				busy++;
+			else if (first_idle < 0)
+				first_idle = cpu;
 		}
 
-		if (idle)
+		if (!busy)
 			return core;
-	}
-
-	/*
-	 * Failed to find an idle core; stop looking for one.
-	 */
-	set_idle_cores(target, 0);
-
-	return -1;
-}
 
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
+		if (busy < best_busy) {
+			best_busy = busy;
+			best_cpu = cpu;
+		}
 
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
-		if (idle_cpu(cpu))
-			return cpu;
+		if (!--nr)
+			break;
 	}
 
-	return -1;
-}
-
-#else /* CONFIG_SCHED_SMT */
-
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
+	time = local_clock() - time;
+	cost = this_sd->avg_scan_cost;
+	// XXX we should normalize @time on @nr
+	delta = (s64)(time - cost) / 8;
+	this_sd->avg_scan_cost += delta;
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
+	return best_cpu;
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6451,15 +6399,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
-	i = select_idle_cpu(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+#ifdef CONFIG_SCHED_SMT
+	if (static_branch_likely(&sched_smt_present))
+		i = select_idle_core(p, sd, target);
+	else
+#endif
+		i = select_idle_cpu(p, sd, target);
 
-	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1a3e9bddd17b..7ca8e18b0018 100644
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
index 15750c222ca2..3f1874c345b1 100644
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

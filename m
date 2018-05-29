Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967428AbeE2VgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:36:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967003AbeE2VgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:36:04 -0400
Date: Tue, 29 May 2018 23:36:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
Message-ID: <20180529213600.GC12180@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
 <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
 <20180501180348.GI12217@hirez.programming.kicks-ass.net>
 <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 02:58:42PM -0700, Subhra Mazumdar wrote:
> I re-ran the test after fixing that bug but still get similar regressions
> for hackbench

> Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
> (lower is better):
> groups  baseline       %stdev  patch %stdev
> 1       0.5742         21.13   0.5131 (10.64%) 4.11
> 2       0.5776         7.87    0.5387 (6.73%) 2.39
> 4       0.9578         1.12    1.0549 (-10.14%) 0.85
> 8       1.7018         1.35    1.8516 (-8.8%) 1.56
> 16      2.9955         1.36    3.2466 (-8.38%) 0.42
> 32      5.4354         0.59    5.7738 (-6.23%) 0.38

On my IVB-EP (2 socket, 10 core/socket, 2 threads/core):

bench:

  perf stat --null --repeat 10 -- perf bench sched messaging -g $i -t -l 10000 2>&1 | grep "seconds time elapsed"

config + results:

ORIG (SIS_PROP, shift=9)

1:        0.557325175 seconds time elapsed                                          ( +-  0.83% )
2:        0.620646551 seconds time elapsed                                          ( +-  1.46% )
5:        2.313514786 seconds time elapsed                                          ( +-  2.11% )
10:        3.796233615 seconds time elapsed                                          ( +-  1.57% )
20:        6.319403172 seconds time elapsed                                          ( +-  1.61% )
40:        9.313219134 seconds time elapsed                                          ( +-  1.03% )

PROP+AGE+ONCE shift=0

1:        0.559497993 seconds time elapsed                                          ( +-  0.55% )
2:        0.631549599 seconds time elapsed                                          ( +-  1.73% )
5:        2.195464815 seconds time elapsed                                          ( +-  1.77% )
10:        3.703455811 seconds time elapsed                                          ( +-  1.30% )
20:        6.440869566 seconds time elapsed                                          ( +-  1.23% )
40:        9.537849253 seconds time elapsed                                          ( +-  2.00% )

FOLD+AGE+ONCE+PONIES shift=0

1:        0.558893325 seconds time elapsed                                          ( +-  0.98% )
2:        0.617426276 seconds time elapsed                                          ( +-  1.07% )
5:        2.342727231 seconds time elapsed                                          ( +-  1.34% )
10:        3.850449091 seconds time elapsed                                          ( +-  1.07% )
20:        6.622412262 seconds time elapsed                                          ( +-  0.85% )
40:        9.487138039 seconds time elapsed                                          ( +-  2.88% )

FOLD+AGE+ONCE+PONIES+PONIES2 shift=0

10:       3.695294317 seconds time elapsed                                          ( +-  1.21% )


Which seems to not hurt anymore.. can you confirm?

Also, I didn't run anything other than hackbench on it so far.

(sorry, the code is a right mess, it's what I ended up with after a day
of poking with no cleanups)


---
 include/linux/sched/topology.h |   7 ++
 kernel/sched/core.c            |   8 ++
 kernel/sched/fair.c            | 201 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h        |   9 ++
 kernel/sched/sched.h           |   3 +
 kernel/sched/topology.c        |  13 ++-
 6 files changed, 228 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..1a53a805547e 100644
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
@@ -162,6 +164,11 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+static inline struct cpumask *sched_domain_cores(struct sched_domain *sd)
+{
+	return to_cpumask(sd->shared->core_mask);
+}
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d59b259af4a..2e2ee0df9e4d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1674,6 +1674,12 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle / 2;
+
+		if (sched_feat(SIS_TRACE))
+			trace_printk("delta: %Lu %Lu %Lu\n", delta, rq->avg_idle, rq->wake_avg);
+
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -6051,6 +6057,8 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05aab7f..8fe1c2404092 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6361,6 +6361,16 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+static DEFINE_PER_CPU(int, sis_rotor);
+
+unsigned long sched_sis_shift = 9;
+unsigned long sched_sis_min = 2;
+unsigned long sched_sis_max = INT_MAX;
+
+module_param(sched_sis_shift, ulong, 0644);
+module_param(sched_sis_min, ulong, 0644);
+module_param(sched_sis_max, ulong, 0644);
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6372,17 +6382,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, best_cpu = -1, loops = 0, nr = sched_sis_max;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
 		return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
+	if (sched_feat(SIS_AGE)) {
+		/* age the remaining idle time */
+		unsigned long now = jiffies;
+		struct rq *this_rq = this_rq();
+
+		if (unlikely(this_rq->wake_stamp < now)) {
+			while (this_rq->wake_stamp < now && this_rq->wake_avg) {
+				this_rq->wake_stamp++;
+				this_rq->wake_avg >>= 1;
+			}
+		}
+
+		avg_idle = this_rq->wake_avg;
+	} else {
+		avg_idle = this_rq()->avg_idle;
+	}
+
+	avg_idle >>= sched_sis_shift;
 	avg_cost = this_sd->avg_scan_cost + 1;
 
 	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
@@ -6390,29 +6413,170 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > 2*sched_sis_min*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = 2*sched_sis_min;
 	}
 
 	time = local_clock();
 
+	if (sched_feat(SIS_ROTOR))
+		target = this_cpu_read(sis_rotor);
+
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
-		if (!--nr)
-			return -1;
+		if (loops++ >= nr)
+			break;
+		this_cpu_write(sis_rotor, cpu);
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (available_idle_cpu(cpu))
+		if (available_idle_cpu(cpu)) {
+			best_cpu = cpu;
+			break;
+		}
+	}
+
+	time = local_clock() - time;
+	time = div_u64(time, loops);
+	cost = this_sd->avg_scan_cost;
+	delta = (s64)(time - cost) / 8;
+	this_sd->avg_scan_cost += delta;
+
+	if (sched_feat(SIS_TRACE))
+	trace_printk("cpu: wake_avg: %Lu avg_idle: %Lu avg_idle: %Lu avg_cost: %Lu nr: %d loops: %d best_cpu: %d time: %Lu\n", 
+			this_rq()->wake_avg, this_rq()->avg_idle,
+			avg_idle, avg_cost, nr, loops, cpu,
+			time);
+
+	if (sched_feat(SIS_ONCE)) {
+		struct rq *this_rq = this_rq();
+
+		if (this_rq->wake_avg > time)
+			this_rq->wake_avg -= time;
+		else
+			this_rq->wake_avg = 0;
+	}
+
+	return best_cpu;
+}
+
+
+/*
+ * Scan the LLC domain for idlest cores; this is dynamically regulated by
+ * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
+ * average idle time for this rq (as found in rq->avg_idle).
+ */
+static int select_idle_core_fold(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	int best_busy = UINT_MAX, best_cpu = -1;
+	struct sched_domain *this_sd;
+	u64 avg_cost, avg_idle;
+	int nr = sched_sis_max, loops = 0;
+	u64 time, cost;
+	int core, cpu;
+	s64 delta;
+	bool has_idle_cores = true;
+
+	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+	if (!this_sd)
+		return -1;
+
+	if (sched_feat(SIS_ROTOR))
+		target = this_cpu_read(sis_rotor);
+
+	if (sched_feat(SIS_PONIES))
+		has_idle_cores = test_idle_cores(target, false);
+
+	if (sched_feat(SIS_AGE)) {
+		/* age the remaining idle time */
+		unsigned long now = jiffies;
+		struct rq *this_rq = this_rq();
+
+		if (unlikely(this_rq->wake_stamp < now)) {
+			while (this_rq->wake_stamp < now && this_rq->wake_avg) {
+				this_rq->wake_stamp++;
+				this_rq->wake_avg >>= 1;
+			}
+		}
+
+		avg_idle = this_rq->wake_avg;
+	} else {
+		avg_idle = this_rq()->avg_idle;
+	}
+
+	avg_idle >>= sched_sis_shift;
+	avg_cost = this_sd->avg_scan_cost + 1;
+
+	if (sched_feat(SIS_PROP)) {
+		u64 span_avg = sd->span_weight * avg_idle;
+		if (span_avg > sched_sis_min*avg_cost)
+			nr = div_u64(span_avg, avg_cost);
+		else
+			nr = sched_sis_min;
+	}
+
+	time = local_clock();
+
+	for_each_cpu_wrap(core, sched_domain_cores(sd), target) {
+		int first_idle = -1;
+		int busy = 0;
+
+		if (loops++ >= nr)
 			break;
+
+		this_cpu_write(sis_rotor, core);
+
+		for (cpu = core; cpu < nr_cpumask_bits; cpu = cpumask_next(cpu, cpu_smt_mask(core))) {
+			if (!idle_cpu(cpu))
+				busy++;
+			else if (first_idle < 0 && cpumask_test_cpu(cpu, &p->cpus_allowed)) {
+				if (!has_idle_cores) {
+					best_cpu = cpu;
+					goto out;
+				}
+				first_idle = cpu;
+			}
+		}
+
+		if (first_idle < 0)
+			continue;
+
+		if (!busy) {
+			best_cpu = first_idle;
+			goto out;
+		}
+
+		if (busy < best_busy) {
+			best_busy = busy;
+			best_cpu = first_idle;
+		}
 	}
 
+	set_idle_cores(target, 0);
+
+out:
 	time = local_clock() - time;
+	time = div_u64(time, loops);
 	cost = this_sd->avg_scan_cost;
 	delta = (s64)(time - cost) / 8;
 	this_sd->avg_scan_cost += delta;
 
-	return cpu;
+	if (sched_feat(SIS_TRACE))
+	trace_printk("fold: wake_avg: %Lu avg_idle: %Lu avg_idle: %Lu avg_cost: %Lu nr: %d loops: %d best_cpu: %d time: %Lu\n", 
+			this_rq()->wake_avg, this_rq()->avg_idle,
+			avg_idle, avg_cost, nr, loops, best_cpu,
+			time);
+
+	if (sched_feat(SIS_ONCE)) {
+		struct rq *this_rq = this_rq();
+
+		if (this_rq->wake_avg > time)
+			this_rq->wake_avg -= time;
+		else
+			this_rq->wake_avg = 0;
+	}
+
+	return best_cpu;
 }
 
 /*
@@ -6451,7 +6615,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	if (sched_feat(SIS_FOLD)) {
+		if (sched_feat(SIS_PONIES2) && !test_idle_cores(target, false))
+			i = select_idle_cpu(p, sd, target);
+		else
+			i = select_idle_core_fold(p, sd, target);
+		goto out;
+	}
+
 	i = select_idle_core(p, sd, target);
+	if (sched_feat(SIS_TRACE))
+		trace_printk("select_idle_core: %d\n", i);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
@@ -6460,6 +6634,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return i;
 
 	i = select_idle_smt(p, sd, target);
+	if (sched_feat(SIS_TRACE))
+		trace_printk("select_idle_smt: %d\n", i);
+out:
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..bb572f949e5f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -58,6 +58,15 @@ SCHED_FEAT(TTWU_QUEUE, true)
 SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
+SCHED_FEAT(SIS_FOLD, true)
+SCHED_FEAT(SIS_AGE, true)
+SCHED_FEAT(SIS_ONCE, true)
+SCHED_FEAT(SIS_ROTOR, false)
+SCHED_FEAT(SIS_PONIES, false)
+SCHED_FEAT(SIS_PONIES2, true)
+
+SCHED_FEAT(SIS_TRACE, false)
+
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67702b4d9ac7..240c35a4c6e0 100644
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
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 61a1125c1ae4..a47a6fc9796e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1189,9 +1189,20 @@ sd_init(struct sched_domain_topology_level *tl,
 	 * instance.
 	 */
 	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+		int core, smt;
+
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+
+		for_each_cpu(core, sched_domain_span(sd)) {
+			for_each_cpu(smt, cpu_smt_mask(core)) {
+				if (cpumask_test_cpu(smt, sched_domain_span(sd))) {
+					__cpumask_set_cpu(smt, sched_domain_cores(sd));
+					break;
+				}
+			}
+		}
 	}
 
 	sd->private = sdd;
@@ -1537,7 +1548,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;

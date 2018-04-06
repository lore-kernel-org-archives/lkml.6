Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx4+nu86kCZOnCzyKIRqn/UyaYcmu1+cIJbJRxUW/ndZWL2r+VUV6WZciwOjJJlJVwdaVPVSt
ARC-Seal: i=1; a=rsa-sha256; t=1523029026; cv=none;
        d=google.com; s=arc-20160816;
        b=SCSKeqsvE3RpPHSfvGSdGJi7Xie5+Ljk3IpxQ9bep911juPg7sBwkG4pXmyiGk0cqI
         jNPd5T+kmygYBtZ+o6EISPhoD2Xm8r9l95Gj64XlojccIoe7q3gvA/qoGV19H92ixtfm
         o4B6YTUqydtOyGzE04CDX4uPN+8rYDbzGBj6H72RcHhg+DGqGhaAw+4IdRIa0Zb9OkTk
         85Vv0JT8/28Xrxcl/b1nCPGKPKA6jNMvdQmPil8yqW9h580R6q6xWbLCyBUahEyzFRex
         B5yKtaJnhJlnOP7jt1md0k/3NisoKN2Dzi21xaTJSqHwOYYaIhA7gCWtXV2Ea4PjumZk
         MnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0h/Q1Zfo7DcfA2EW3rumtnmzAgYJ8OqgC0garcmXuOc=;
        b=f125P0SaWHGS4a/szJrRPCpdZG8kQzNHGnXNuDY9gEj0ScIu2V8lzjeb3uWi0lfeIf
         7MV3ZvWWyReDo8pLYE1tfgGE28Gd1/XX0DEk7DdNTXPKMxMJomI4IcmlCTMsPh14Aqf2
         kIklXAgHT0S4bhspDddo7ioD1ZJAU8Vrlh5OfJYGAYb0wE2yYQmVRBiEZWcWuB0rdIaK
         JMOIdfds6JDLL3HP6xr3QS5rV8Suw+pmJ+xSN1dj9cCrQ/h0OP7g2HX1eWda5btfJOin
         OMHZOA7sVEPjX2G8aPxCNzy9vaAzqEBzN5p/lZHB19vju8nq3KIGaQUqYctg43EccEZb
         mV1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point indicator
Date: Fri,  6 Apr 2018 16:36:04 +0100
Message-Id: <20180406153607.17815-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1597011684825023112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thara Gopinath <thara.gopinath@linaro.org>

Energy-aware scheduling should only operate when the system is not
overutilized. There must be cpu time available to place tasks based on
utilization in an energy-aware fashion, i.e. to pack tasks on
energy-efficient cpus without harming the overall throughput.

In case the system operates above this tipping point the tasks have to
be placed based on task and cpu load in the classical way of spreading
tasks across as many cpus as possible.

The point in which a system switches from being not overutilized to
being overutilized is called the tipping point.

Such a tipping point indicator on a sched domain as the system
boundary is introduced here. As soon as one cpu of a sched domain is
overutilized the whole sched domain is declared overutilized as well.
A cpu becomes overutilized when its utilization is higher that 80%
(capacity_margin) of its capacity.

The implementation takes advantage of the shared sched domain which is
shared across all per-cpu views of a sched domain level. The new
overutilized flag is placed in this shared sched domain.

Load balancing is skipped in case the energy model is present and the
sched domain is not overutilized because under this condition the
predominantly load-per-capacity driven load-balancer should not
interfere with the energy-aware wakeup placement based on utilization.

In case the total utilization of a sched domain is greater than the
total sched domain capacity the overutilized flag is set at the parent
sched domain level to let other sched groups help getting rid of the
overutilization of cpus.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 62 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        | 12 +++-----
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..dd001c232646 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -72,6 +72,7 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	int		overutilized;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a76ad2ef022..6960e5ef3c14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5345,6 +5345,28 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_SMP
+static inline int cpu_overutilized(int cpu);
+
+static inline int sd_overutilized(struct sched_domain *sd)
+{
+	return READ_ONCE(sd->shared->overutilized);
+}
+
+static inline void update_overutilized_status(struct rq *rq)
+{
+	struct sched_domain *sd;
+
+	rcu_read_lock();
+	sd = rcu_dereference(rq->sd);
+	if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
+		WRITE_ONCE(sd->shared->overutilized, 1);
+	rcu_read_unlock();
+}
+#else
+static inline void update_overutilized_status(struct rq *rq) {}
+#endif /* CONFIG_SMP */
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
+		update_overutilized_status(rq);
+	}
 
 	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
@@ -6579,6 +6603,11 @@ static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
 	return capacity * 1024 > util * capacity_margin;
 }
 
+static inline int cpu_overutilized(int cpu)
+{
+	return !util_fits_capacity(cpu_util(cpu), capacity_of(cpu));
+}
+
 /*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
@@ -7817,6 +7846,7 @@ struct sd_lb_stats {
 	unsigned long total_running;
 	unsigned long total_load;	/* Total load of all groups in sd */
 	unsigned long total_capacity;	/* Total capacity of all groups in sd */
+	unsigned long total_util;	/* Total util of all groups in sd */
 	unsigned long avg_load;	/* Average load across all groups in sd */
 
 	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
@@ -7837,6 +7867,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_running = 0UL,
 		.total_load = 0UL,
 		.total_capacity = 0UL,
+		.total_util = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
 			.sum_nr_running = 0,
@@ -8133,11 +8164,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
  * @overload: Indicate more than one runnable task for any CPU.
+ * @overutilized: Indicate overutilization for any CPU.
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
 			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+			bool *overload, int *overutilized)
 {
 	unsigned long load;
 	int i, nr_running;
@@ -8174,6 +8206,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 */
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
+
+		if (cpu_overutilized(i))
+			*overutilized = 1;
 	}
 
 	/* Adjust by relative CPU capacity of the group */
@@ -8301,6 +8336,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
 	bool overload = false;
+	int overutilized = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -8327,7 +8363,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+						&overload, &overutilized);
 
 		if (local_group)
 			goto next_group;
@@ -8359,6 +8395,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sds->total_running += sgs->sum_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
+		sds->total_util += sgs->group_util;
 
 		sg = sg->next;
 	} while (sg != env->sd->groups);
@@ -8380,6 +8417,17 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		if (env->dst_rq->rd->overload != overload)
 			env->dst_rq->rd->overload = overload;
 	}
+
+	if (sd_overutilized(env->sd) != overutilized)
+		WRITE_ONCE(env->sd->shared->overutilized, overutilized);
+
+	/*
+	 * If the domain util is greater that domain capacity, load balancing
+	 * needs to be done at the next sched domain level as well.
+	 */
+	if (env->sd->parent &&
+	    !util_fits_capacity(sds->total_util, sds->total_capacity))
+		WRITE_ONCE(env->sd->parent->shared->overutilized, 1);
 }
 
 /**
@@ -9255,6 +9303,9 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 		max_cost += sd->max_newidle_lb_cost;
 
+		if (sched_energy_enabled() && !sd_overutilized(sd))
+			continue;
+
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
 
@@ -9822,6 +9873,9 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 			break;
 		}
 
+		if (sched_energy_enabled() && !sd_overutilized(sd))
+			continue;
+
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			t0 = sched_clock_cpu(this_cpu);
 
@@ -9955,6 +10009,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_overutilized_status(rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3deaee7a7a2..5d552c0d7109 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -11,6 +11,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/deadline.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/energy.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/idle.h>
 #include <linux/sched/init.h>
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..c8b7c7665ab2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1184,15 +1184,11 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->idle_idx = 1;
 	}
 
-	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
-	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+
+	if (sd->flags & SD_SHARE_PKG_RESOURCES)
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
 
 	sd->private = sdd;
 
-- 
2.11.0

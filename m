Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELu7HsEKCZZffURzrlgzaJiwGmj0t7/O+SGAFDhnL+Jb1UlvfWKT1aBpwc4KLlIcBj3G/Tut
ARC-Seal: i=1; a=rsa-sha256; t=1521539055; cv=none;
        d=google.com; s=arc-20160816;
        b=gxw5En9rh+DzZ2o8HGYkQ7Zxe2peJ4kAPCYtXGPPJjkMbUyitK3QokgXCmxG923W0k
         FKFhAr0ip/DYgh4GkUqTkVmpMoeDuCZhvf3FWmocTnxkJ3fBkvzJ0qLCbDU7Cq34z0oL
         DVEtQjZlvw9TumIpEqxDyGqKTPnLhwQXve52t8IKhs14wmkAJaHgEv7jKbpaH9zVVYhK
         65SCuamKwhUmojBIsO/WRbROqd2pzpDx12NamJxkgATx0y2fc0Sfi6XcLIOtirxvIgTZ
         C06ex0ZHeGnABVjhHcFce7T+p5WHs/x/tmfjmcAvHjgFagroqQFO6FS8g5Itqb5UKSuJ
         KtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Qt6SuAl082TpmDH3pVNGUYn/j6/B1uwW1lo2S3ymx4U=;
        b=aH8gCLdeh2WXeC0kDBlgLuFeqrLEkmBSVASOIHfAvqHuUUPcLF1Ilv9Yhx01aZqH50
         YNR/6KVvZdF8yx2GPskg7B11siwHRQKlYFUy+Pwsw2DYlJZ90wK27sGjg3Kkz5XoBZNy
         fR8x1OdPqA5jIVd16DvFsaNg+0opgMi0yICyr0BqZNgTAwC34N0qKCxxyqo65afuf8Mk
         aQZWhywcuKBNGqf6uHoAS5W4P/u7RzIQlcUaNvzi4kehUjU7XGkjHG+mwMfDdKDe/jQh
         EaSu0Kunk/AS6xog8rbhoojaEeYp1aUq3eKVKJhk96tETLTlq/sR2tHkNx1b2r/wrj40
         A8xQ==
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
	Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH 3/6] sched: Add over-utilization/tipping point indicator
Date: Tue, 20 Mar 2018 09:43:09 +0000
Message-Id: <20180320094312.24081-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449336588138126?=
X-GMAIL-MSGID: =?utf-8?q?1595449336588138126?=
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
 kernel/sched/fair.c            | 64 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        | 12 +++-----
 4 files changed, 67 insertions(+), 11 deletions(-)

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
index bf7b485ddf60..6c72a5e7b1b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5197,6 +5197,28 @@ static inline void hrtick_update(struct rq *rq)
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
@@ -5246,8 +5268,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	if (!se) {
 		add_nr_running(rq, 1);
+		update_overutilized_status(rq);
+	}
 
 	hrtick_update(rq);
 }
@@ -6379,6 +6403,11 @@ static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
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
@@ -7617,6 +7646,7 @@ struct sd_lb_stats {
 	unsigned long total_running;
 	unsigned long total_load;	/* Total load of all groups in sd */
 	unsigned long total_capacity;	/* Total capacity of all groups in sd */
+	unsigned long total_util;	/* Total util of all groups in sd */
 	unsigned long avg_load;	/* Average load across all groups in sd */
 
 	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
@@ -7637,6 +7667,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_running = 0UL,
 		.total_load = 0UL,
 		.total_capacity = 0UL,
+		.total_util = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
 			.sum_nr_running = 0,
@@ -7933,11 +7964,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
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
@@ -7974,6 +8006,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 */
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
+
+		if (cpu_overutilized(i))
+			*overutilized = 1;
 	}
 
 	/* Adjust by relative CPU capacity of the group */
@@ -8101,6 +8136,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
 	bool overload = false;
+	int overutilized = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -8127,7 +8163,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+						&overload, &overutilized);
 
 		if (local_group)
 			goto next_group;
@@ -8159,6 +8195,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sds->total_running += sgs->sum_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
+		sds->total_util += sgs->group_util;
 
 		sg = sg->next;
 	} while (sg != env->sd->groups);
@@ -8180,6 +8217,17 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		if (env->dst_rq->rd->overload != overload)
 			env->dst_rq->rd->overload = overload;
 	}
+
+	if (READ_ONCE(env->sd->shared->overutilized) != overutilized)
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
@@ -9055,6 +9103,10 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 		max_cost += sd->max_newidle_lb_cost;
 
+		if (static_branch_unlikely(&sched_energy_present) &&
+		    !sd_overutilized(sd))
+			continue;
+
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
 
@@ -9622,6 +9674,10 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 			break;
 		}
 
+		if (static_branch_unlikely(&sched_energy_present) &&
+		    !sd_overutilized(sd))
+			continue;
+
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			t0 = sched_clock_cpu(this_cpu);
 
@@ -9755,6 +9811,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_overutilized_status(rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22909ffc04fb..55ec6a4c4712 100644
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

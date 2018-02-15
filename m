Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425813AbeBOQXY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:23:24 -0500
Received: from foss.arm.com ([217.140.101.70]:57078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424438AbeBOQV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:26 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 1/7] sched: Add static_key for asymmetric cpu capacity optimizations
Date: Thu, 15 Feb 2018 16:20:48 +0000
Message-Id: <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing asymmetric cpu capacity code should cause minimal overhead
for others. Putting it behind a static_key, it has been done for SMT
optimizations, would make it easier to extend and improve without
causing harm to others moving forward.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     |  3 +++
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1070803cb423..452ad2e6f1a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6291,6 +6291,9 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e95505e23c6..a06184906640 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1095,6 +1095,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 034cbed7f88b..517c57d312df 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -393,6 +393,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -420,6 +421,13 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
 }
 
+static void update_asym_cpucapacity(int cpu)
+{
+	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
+	    lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
+		static_branch_enable(&sched_asym_cpucapacity);
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
@@ -1697,6 +1705,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 		cpu_attach_domain(sd, d.rd, i);
 	}
+
+	update_asym_cpucapacity(cpumask_first(cpu_map));
 	rcu_read_unlock();
 
 	if (rq && sched_debug_enabled) {
-- 
2.7.4

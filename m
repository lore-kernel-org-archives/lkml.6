Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeCOOr2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:47:28 -0400
Received: from foss.arm.com ([217.140.101.70]:40002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932388AbeCOOr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:47:26 -0400
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv2 1/7] sched: Add static_key for asymmetric cpu capacity optimizations
Date: Thu, 15 Mar 2018 14:46:58 +0000
Message-Id: <1521125224-15434-2-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
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
 kernel/sched/fair.c     | 3 +++
 kernel/sched/sched.h    | 1 +
 kernel/sched/topology.c | 9 +++++++++
 3 files changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117e1580..e4ce572113a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6385,6 +6385,9 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22909ffc04fb..017f62069e0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1140,6 +1140,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..b023a5b3665a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -398,6 +398,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -425,6 +426,12 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
 }
 
+static void update_asym_cpucapacity(int cpu)
+{
+	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
+		static_branch_enable(&sched_asym_cpucapacity);
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
@@ -1705,6 +1712,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 		cpu_attach_domain(sd, d.rd, i);
 	}
+
+	update_asym_cpucapacity(cpumask_first(cpu_map));
 	rcu_read_unlock();
 
 	if (rq && sched_debug_enabled) {
-- 
2.7.4

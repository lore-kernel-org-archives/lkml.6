Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDAC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD8D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD8D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeILORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:17:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbeILORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:17:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12F267A9;
        Wed, 12 Sep 2018 02:14:18 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF70D3F703;
        Wed, 12 Sep 2018 02:14:13 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v7 13/14] sched/topology: Make Energy Aware Scheduling depend on schedutil
Date:   Wed, 12 Sep 2018 10:13:08 +0100
Message-Id: <20180912091309.7551-14-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Energy Aware Scheduling (EAS) is designed with the assumption that
frequencies of CPUs follow their utilization value. When using a CPUFreq
governor other than schedutil, the chances of this assumption being true
are small, if any. When schedutil is being used, EAS' predictions are at
least consistent with the frequency requests. Although those requests
have no guarantees to be honored by the hardware, they should at least
guide DVFS in the right direction and provide some hope in regards to the
EAS model being accurate.

To make sure EAS is only used in a sane configuration, create a strong
dependency on schedutil being used. Since having sugov compiled-in does
not provide that guarantee, make CPUFreq call a scheduler function on
on governor changes hence letting it rebuild the scheduling domains,
check the governors of the online CPUs, and enable/disable EAS
accordingly.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/cpufreq.c        |  2 ++
 include/linux/sched/cpufreq.h    |  9 ++++++++
 kernel/sched/cpufreq_schedutil.c | 37 ++++++++++++++++++++++++++++++--
 kernel/sched/sched.h             |  4 +---
 kernel/sched/topology.c          | 23 ++++++++++++++++----
 5 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..c0d21eb900e3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/sched/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -2271,6 +2272,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
 			pr_debug("cpufreq: governor change\n");
+			sched_cpufreq_governor_change(policy, old_gov);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index afa940cd50dc..a2ead52feb17 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_CPUFREQ_H
 #define _LINUX_SCHED_CPUFREQ_H
 
+#include <linux/cpufreq.h>
 #include <linux/types.h>
 
 /*
@@ -28,4 +29,12 @@ static inline unsigned long map_util_freq(unsigned long util,
 }
 #endif /* CONFIG_CPU_FREQ */
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov);
+#else
+static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov) { }
+#endif
+
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 8356cb0072a6..d2236d1166f4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -632,7 +632,7 @@ static struct kobj_type sugov_tunables_ktype = {
 
 /********************** cpufreq governor interface *********************/
 
-static struct cpufreq_governor schedutil_gov;
+struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 {
@@ -891,7 +891,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 	sg_policy->need_freq_update = true;
 }
 
-static struct cpufreq_governor schedutil_gov = {
+struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
 	.dynamic_switching	= true,
@@ -914,3 +914,36 @@ static int __init sugov_register(void)
 	return cpufreq_register_governor(&schedutil_gov);
 }
 fs_initcall(sugov_register);
+
+#ifdef CONFIG_ENERGY_MODEL
+extern bool sched_energy_update;
+static DEFINE_MUTEX(rebuild_sd_mutex);
+
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	mutex_lock(&rebuild_sd_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&rebuild_sd_mutex);
+}
+static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
+
+/*
+ * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+ * on governor changes to make sure the scheduler knows about it.
+ */
+void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+				  struct cpufreq_governor *old_gov)
+{
+	if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
+		/*
+		 * When called from the cpufreq_register_driver() path, the
+		 * cpu_hotplug_lock is already held, so use a work item to
+		 * avoid nested locking in rebuild_sched_domains().
+		 */
+		schedule_work(&rebuild_sd_work);
+	}
+
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 309c0287004c..b16417beb92e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2264,10 +2264,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 #define perf_domain_span(pd) (to_cpumask(((pd)->obj->cpus)))
 #else
 #define perf_domain_span(pd) NULL
 #endif
-#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0d18d69b719c..3fb32de1bb28 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,7 +201,9 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+bool sched_energy_update;
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -275,6 +277,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
  *    1. the ENERGY_AWARE sched_feat is enabled;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. the EM complexity is low enough to keep scheduling overheads low;
+ *    4. schedutil is driving the frequency of all CPUs of the rd;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -294,12 +297,15 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
  */
 #define EM_MAX_COMPLEXITY 2048
 
+extern struct cpufreq_governor schedutil_gov;
 static void build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
+	struct cpufreq_policy *policy;
+	struct cpufreq_governor *gov;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
@@ -315,6 +321,15 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 		if (find_pd(pd, i))
 			continue;
 
+		/* Do not attempt EAS if schedutil is not being used. */
+		policy = cpufreq_cpu_get(i);
+		if (!policy)
+			goto free;
+		gov = policy->governor;
+		cpufreq_cpu_put(policy);
+		if (gov != &schedutil_gov)
+			goto free;
+
 		/* Create the new pd and add it to the local list. */
 		tmp = pd_init(i);
 		if (!tmp)
@@ -357,7 +372,7 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
-#endif /* CONFIG_ENERGY_MODEL */
+#endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
 
 static void free_rootdomain(struct rcu_head *rcu)
 {
@@ -2158,10 +2173,10 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	/* Build perf. domains: */
 	for (i = 0; i < ndoms_new; i++) {
-		for (j = 0; j < n; j++) {
+		for (j = 0; j < n && !sched_energy_update; j++) {
 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
 			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
 				goto match3;
-- 
2.18.0


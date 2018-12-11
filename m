Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005EF2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005EF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeLKPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:36:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:36:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFa6094043143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:36:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFa58t4043140;
        Tue, 11 Dec 2018 07:36:05 -0800
Date:   Tue, 11 Dec 2018 07:36:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-531b5c9f5cd05ead53324f419b32685a22eebe8b@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        rjw@rjwysocki.net, efault@gmx.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        quentin.perret@arm.com
Reply-To: rjw@rjwysocki.net, peterz@infradead.org,
          torvalds@linux-foundation.org, quentin.perret@arm.com,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          efault@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <20181203095628.11858-9-quentin.perret@arm.com>
References: <20181203095628.11858-9-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Git-Commit-ID: 531b5c9f5cd05ead53324f419b32685a22eebe8b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  531b5c9f5cd05ead53324f419b32685a22eebe8b
Gitweb:     https://git.kernel.org/tip/531b5c9f5cd05ead53324f419b32685a22eebe8b
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:21 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:00 +0100

sched/topology: Make Energy Aware Scheduling depend on schedutil

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
governor changes hence letting it rebuild the scheduling domains, check
the governors of the online CPUs, and enable/disable EAS accordingly.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-9-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/cpufreq/cpufreq.c        |  1 +
 include/linux/cpufreq.h          |  8 ++++++++
 kernel/sched/cpufreq_schedutil.c | 37 +++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h             |  4 +---
 kernel/sched/topology.c          | 28 ++++++++++++++++++++++++----
 5 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dcad2175..6f23ebb395f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2277,6 +2277,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
 			pr_debug("cpufreq: governor change\n");
+			sched_cpufreq_governor_change(policy, old_gov);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..c86d6d8bdfed 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -950,6 +950,14 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 }
 #endif
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov);
+#else
+static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov) { }
+#endif
+
 extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 90128be27712..c2e53d1a3143 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -624,7 +624,7 @@ static struct kobj_type sugov_tunables_ktype = {
 
 /********************** cpufreq governor interface *********************/
 
-static struct cpufreq_governor schedutil_gov;
+struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 {
@@ -883,7 +883,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 	sg_policy->need_freq_update = true;
 }
 
-static struct cpufreq_governor schedutil_gov = {
+struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
 	.dynamic_switching	= true,
@@ -906,3 +906,36 @@ static int __init sugov_register(void)
 	return cpufreq_register_governor(&schedutil_gov);
 }
 fs_initcall(sugov_register);
+
+#ifdef CONFIG_ENERGY_MODEL
+extern bool sched_energy_update;
+extern struct mutex sched_energy_mutex;
+
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	mutex_lock(&sched_energy_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&sched_energy_mutex);
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
index 75c403674706..fd84900b0b21 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2291,10 +2291,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 #define perf_domain_span(pd) (to_cpumask(((pd)->em_pd->cpus)))
 #else
 #define perf_domain_span(pd) NULL
 #endif
-#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ddb804b2dec..0a5a1d3a4eae 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,7 +201,10 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+DEFINE_MUTEX(sched_energy_mutex);
+bool sched_energy_update;
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -275,6 +278,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. the EM complexity is low enough to keep scheduling overheads low;
+ *    4. schedutil is driving the frequency of all CPUs of the rd;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -294,12 +298,15 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
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
@@ -315,6 +322,19 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 		if (find_pd(pd, i))
 			continue;
 
+		/* Do not attempt EAS if schedutil is not being used. */
+		policy = cpufreq_cpu_get(i);
+		if (!policy)
+			goto free;
+		gov = policy->governor;
+		cpufreq_cpu_put(policy);
+		if (gov != &schedutil_gov) {
+			if (rd->pd)
+				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
+						cpumask_pr_args(cpu_map));
+			goto free;
+		}
+
 		/* Create the new pd and add it to the local list. */
 		tmp = pd_init(i);
 		if (!tmp)
@@ -356,7 +376,7 @@ free:
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
-#endif /* CONFIG_ENERGY_MODEL */
+#endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
 
 static void free_rootdomain(struct rcu_head *rcu)
 {
@@ -2152,10 +2172,10 @@ match2:
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

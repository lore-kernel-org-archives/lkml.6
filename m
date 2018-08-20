Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7632C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1182098B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1182098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeHTNAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:00:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:00:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CD2D80D;
        Mon, 20 Aug 2018 02:45:30 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92713F2EA;
        Mon, 20 Aug 2018 02:45:25 -0700 (PDT)
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
Subject: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling depend on schedutil
Date:   Mon, 20 Aug 2018 10:44:19 +0100
Message-Id: <20180820094420.26590-14-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
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
not provide that guarantee, extend the existing CPUFreq policy notifier
with a new case on governor changes. That allows the scheduler to
register a callback on this notifier to rebuild the scheduling domains
when governors are changed, and enable/disable EAS accordingly.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---
This patch could probably be squashed into another one, but I kept it
separate to ease the review. Also, it's probably optional as not having
it will not 'break' things per se.

I went for the smallest possible solution I could find, which has the
good side of being simple, but it's definitely not the only one.

Another possibility would be to hook things in sugov_start() and
sugov_stop(), but that requires some more work. In this case, it
wouldn't be possible to just re-build the sched_domains() from there,
because when sugov_stop() is called, the 'governor' field of the policy
hasn't been updated yet, so the condition (if gov == schedutil) in
build_freq_domains() doesn't work.

To workaround the issue we'll need to find a way to pass a cpumask to
the topology code to specifically say 'sugov has been stopped on these
CPUs'. That would mean more code to handle that, but that would also
mean we don't have to mess around with the CPUFreq notifiers ...

Not sure what's best, so all feedback is more than welcome.
---
 drivers/cpufreq/cpufreq.c        |  4 +++
 include/linux/cpufreq.h          |  1 +
 kernel/sched/cpufreq_schedutil.c | 47 ++++++++++++++++++++++++++++++--
 kernel/sched/sched.h             |  4 +--
 kernel/sched/topology.c          | 20 ++++++++++++--
 5 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..bed0a511c504 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2271,6 +2271,10 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		ret = cpufreq_start_governor(policy);
 		if (!ret) {
 			pr_debug("cpufreq: governor change\n");
+			/* Notification of the new governor */
+			blocking_notifier_call_chain(
+					&cpufreq_policy_notifier_list,
+					CPUFREQ_GOVERNOR, policy);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..a4435b5ef3f9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -437,6 +437,7 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
+#define CPUFREQ_GOVERNOR		(2)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 8356cb0072a6..e138b5288af4 100644
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
@@ -914,3 +914,46 @@ static int __init sugov_register(void)
 	return cpufreq_register_governor(&schedutil_gov);
 }
 fs_initcall(sugov_register);
+
+#ifdef CONFIG_ENERGY_MODEL
+extern bool sched_energy_update;
+static DEFINE_MUTEX(rebuild_sd_mutex);
+/*
+ * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+ * on governor changes to make sure the scheduler knows about it.
+ */
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
+static int rebuild_sd_callback(struct notifier_block *nb, unsigned long val,
+			       void *data)
+{
+	if (val != CPUFREQ_GOVERNOR)
+		return 0;
+	/*
+	 * Sched_domains cannot be rebuild from a notifier context, so use a
+	 * workqueue.
+	 */
+	schedule_work(&rebuild_sd_work);
+
+	return 0;
+}
+
+static struct notifier_block rebuild_sd_notifier = {
+	.notifier_call = rebuild_sd_callback,
+};
+
+static int register_cpufreq_notifier(void)
+{
+	return cpufreq_register_notifier(&rebuild_sd_notifier,
+					 CPUFREQ_POLICY_NOTIFIER);
+}
+core_initcall(register_cpufreq_notifier);
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e594a854977f..915766600568 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2265,10 +2265,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
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
index 1cb86a0ef00f..2b6df8edca2a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -209,7 +209,9 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
  */
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+bool sched_energy_update;
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -291,12 +293,15 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
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
@@ -312,6 +317,15 @@ static void build_perf_domains(const struct cpumask *cpu_map)
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
@@ -2184,10 +2198,10 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
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
2.17.1


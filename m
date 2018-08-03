Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59F62175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59F62175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeHCOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:38:21 -0400
Received: from foss.arm.com ([217.140.101.70]:42318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbeHCOiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:38:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0048218A;
        Fri,  3 Aug 2018 05:42:11 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8E653F5D0;
        Fri,  3 Aug 2018 05:42:06 -0700 (PDT)
Date:   Fri, 3 Aug 2018 13:42:05 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     skannan@codeaurora.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180803124202.arhtq5z7xqk237wt@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
 <20180802124511.GN2512@hirez.programming.kicks-ass.net>
 <20180802152109.2k45jqbfquef6u62@queper01-lin>
 <20180802173601.GO2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802173601.GO2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 19:36:01 (+0200), Peter Zijlstra wrote:
> Using a !schedutil governor doesn't even get us that and we're basically
> running on random input without any feedback to close the loop. Not
> something I feel we should support or care for.

Fair enough, supporting users using something else than sugov doesn't
sound like a good idea indeed ...

Creating the dependency between sugov and EAS requires a bit of work. I
assume we don't want to check the current CPUFreq policy of all CPUs of
the current rd in the wakeup path ... So one possibility is to check that
from the topology code (build_freq_domains(), ...) and get a notification
from CPUFreq on governor change to call rebuild_sched_domains().

I following seems to do the trick. How ugly does that look ?

------------------>8------------------
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
index d23a480bac7b..16c7a4ad1a77 100644
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
index e224e90a36c3..861be053f2d2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2267,8 +2267,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern struct static_key_false sched_energy_present;
 /**
  * rd_freq_domain - Get the frequency domains of a root domain.
@@ -2290,4 +2289,3 @@ static inline struct freq_domain *rd_freq_domain(struct root_domain *rd)
 }
 #define freq_domain_span(fd) NULL
 #endif
-#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e95223b7a7f6..35246707a8e0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,7 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 static void free_fd(struct freq_domain *fd)
 {
 	struct freq_domain *tmp;
@@ -287,13 +287,15 @@ static void destroy_freq_domain_rcu(struct rcu_head *rp)
  */
 #define EM_MAX_COMPLEXITY 2048
 
-
+extern struct cpufreq_governor schedutil_gov;
 static void build_freq_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_fd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct freq_domain *fd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
+	struct cpufreq_policy *policy;
+	struct cpufreq_governor *gov;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
@@ -309,6 +311,13 @@ static void build_freq_domains(const struct cpumask *cpu_map)
 		if (find_fd(fd, i))
 			continue;
 
+		/* Do not attempt EAS if schedutil is not being used. */
+		policy = cpufreq_cpu_get(i);
+		gov = policy->governor;
+		cpufreq_cpu_put(policy);
+		if (gov != &schedutil_gov)
+			goto free;
+
 		/* Create the new fd and add it to the local list. */
 		tmp = fd_init(i);
 		if (!tmp)
@@ -355,6 +364,7 @@ static void build_freq_domains(const struct cpumask *cpu_map)
  *    3. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  */
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
+bool sched_energy_update = false;
 
 static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
 {
@@ -2187,10 +2197,10 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
-#ifdef CONFIG_ENERGY_MODEL
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	/* Build freq domains: */
 	for (i = 0; i < ndoms_new; i++) {
-		for (j = 0; j < n; j++) {
+		for (j = 0; j < n && !sched_energy_update; j++) {
 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
 			    cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)
 				goto match3;


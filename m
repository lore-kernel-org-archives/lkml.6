Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47181C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D889D2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeIGUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:10:56 -0400
Received: from foss.arm.com ([217.140.101.70]:33640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbeIGUK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:10:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45CDF18A;
        Fri,  7 Sep 2018 08:29:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DE5A3F5BC;
        Fri,  7 Sep 2018 08:29:27 -0700 (PDT)
Date:   Fri, 7 Sep 2018 16:29:25 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin>
 <1545744.fI5ZvP8FO0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545744.fI5ZvP8FO0@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 Sep 2018 at 10:52:01 (+0200), Rafael J. Wysocki wrote:
> On Thursday, September 6, 2018 4:38:44 PM CEST Quentin Perret wrote:
> > Hi Rafael,
> > 
> > On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> > > I'm not a particular fan of notifiers to be honest and you don't need
> > > to add an extra chain just in order to be able to register a callback
> > > from a single user.
> > 
> > Right. I agree there are alternatives to using notifiers. I used them
> > because they're existing infrastructure, and because they let me do what
> > I want without too much troubles, which are two important points.
> > 
> > > That can be achieved with a single callback
> > > pointer too, but also you could just call a function exported by the
> > > scheduler directly from where in the cpufreq code it needs to be
> > > called.
> > 
> > Are you thinking about something comparable to what is done in
> > cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
> > That would probably have the same drawback as my current implementation,
> > that is that the scheduler is notified of _all_ governor changes, not
> > only changes to/from sugov although this is the only thing we care about
> > for EAS.
> 
> Well, why don't you implement it as something like "if the governor changes
> from sugov to something else (or the other way around), call this function
> from the scheduler"?

I just gave it a try and ended up with the diff below. It's basically
the exact same patch with a direct function call instead of a notifier.
(I also tried the sugov_start/stop thing I keep mentioning but it is
more complex, so let's see if the simplest solution could work first).

What do you think ?

----------8<----------
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..6300668ac67a 100644
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
+			sched_governor_change(policy, old_gov);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index afa940cd50dc..33b77eed8a41 100644
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
+void sched_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov);
+#else
+static inline void sched_governor_change(struct cpufreq_policy *policy,
+			struct cpufreq_governor *old_gov) { }
+#endif
+
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 8356cb0072a6..2ff40b2a8ba0 100644
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
@@ -914,3 +914,32 @@ static int __init sugov_register(void)
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
+void sched_governor_change(struct cpufreq_policy *policy,
+				  struct cpufreq_governor *old_gov)
+{
+	if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
+		/* Sched domains cannot be rebuilt directly from this context */
+		schedule_work(&rebuild_sd_work);
+	}
+
+}
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
index ae329447a082..781f3eba840e 100644
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
@@ -297,12 +299,15 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
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
@@ -318,6 +323,15 @@ static void build_perf_domains(const struct cpumask *cpu_map)
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
@@ -389,7 +403,7 @@ static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
-#endif /* CONFIG_ENERGY_MODEL */
+#endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
 
 static void free_rootdomain(struct rcu_head *rcu)
 {
@@ -2190,10 +2204,10 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
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


Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF97C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CFE20836
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CFE20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeHTM77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:59:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTM76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E741315BE;
        Mon, 20 Aug 2018 02:45:03 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02973F2EA;
        Mon, 20 Aug 2018 02:44:59 -0700 (PDT)
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
Subject: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present static key
Date:   Mon, 20 Aug 2018 10:44:13 +0100
Message-Id: <20180820094420.26590-8-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure a minimal performance impact on non-energy-aware
systems, introduce a static_key guarding the access to Energy-Aware
Scheduling (EAS) code.

The static key is set iff all the following conditions are met for at
least one root domain:
  1. all online CPUs of the root domain are covered by the Energy
     Model (EM);
  2. the complexity of the root domain's EM is low enough to keep
     scheduling overheads low;
  3. the root domain has an asymmetric CPU capacity topology (detected
     by looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
     hierarchy).

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 77 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4b884e467545..cb3d6afdb114 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1421,6 +1421,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
+extern struct static_key_false sched_energy_present;
 
 static inline u64 global_rt_period(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4c6a36a8d7b8..1cb86a0ef00f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -200,6 +200,14 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	return 1;
 }
+/*
+ * This static_key is set if at least one root domain meets all the following
+ * conditions:
+ *    1. all CPUs of the root domain are covered by the EM;
+ *    2. the EM complexity is low enough to keep scheduling overheads low;
+ *    3. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
+ */
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 
 #ifdef CONFIG_ENERGY_MODEL
 static void free_pd(struct perf_domain *pd)
@@ -270,12 +278,34 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+/*
+ * The complexity of the Energy Model is defined as: nr_pd * (nr_cpus + nr_cs)
+ * with: 'nr_pd' the number of performance domains; 'nr_cpus' the number of
+ * CPUs; and 'nr_cs' the sum of the capacity states numbers of all performance
+ * domains.
+ *
+ * It is generally not a good idea to use such a model in the wake-up path on
+ * very complex platforms because of the associated scheduling overheads. The
+ * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
+ * with per-CPU DVFS and less than 8 capacity states each, for example.
+ */
+#define EM_MAX_COMPLEXITY 2048
+
 static void build_perf_domains(const struct cpumask *cpu_map)
 {
+	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
+					cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
 
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
@@ -288,6 +318,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
+
+		/*
+		 * Count performance domains and capacity states for the
+		 * complexity check.
+		 */
+		nr_pd++;
+		nr_cs += em_pd_nr_cap_states(pd->obj);
+	}
+
+	/* Bail out if the Energy Model complexity is too high. */
+	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
+		if (sched_debug())
+			pr_info("rd %*pbl: EM complexity is too high\n ",
+						cpumask_pr_args(cpu_map));
+		goto free;
 	}
 
 	perf_domain_debug(cpu_map, pd);
@@ -307,6 +352,35 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 }
+
+static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
+{
+	/*
+	 * The conditions for EAS to start are checked during the creation of
+	 * root domains. If one of them meets all conditions, it will have a
+	 * non-null list of performance domains.
+	 */
+	while (ndoms_new) {
+		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
+			goto enable;
+		ndoms_new--;
+	}
+
+	if (static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: stopping EAS\n", __func__);
+		static_branch_disable_cpuslocked(&sched_energy_present);
+	}
+
+	return;
+
+enable:
+	if (!static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: starting EAS\n", __func__);
+		static_branch_enable_cpuslocked(&sched_energy_present);
+	}
+}
 #else
 static void free_pd(struct perf_domain *pd) { }
 #endif
@@ -2123,6 +2197,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
 		;
 	}
+	sched_energy_start(ndoms_new, doms_new);
 #endif
 
 	/* Remember the new sched domains: */
-- 
2.17.1


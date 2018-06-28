Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27149C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D25272A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D25272A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965689AbeF1Llp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:41:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965628AbeF1Llb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E0A80D;
        Thu, 28 Jun 2018 04:41:31 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60213F266;
        Thu, 28 Jun 2018 04:41:26 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 07/12] sched/topology: Introduce sched_energy_present static key
Date:   Thu, 28 Jun 2018 12:40:38 +0100
Message-Id: <20180628114043.24724-8-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
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

The static key is checked in the rd_freq_domain() function which returns
the frequency domains of a root domain when they are available. As EAS
cannot be enabled with CONFIG_ENERGY_MODEL=n, rd_freq_domain() is
stubbed to 'NULL' to let the compiler remove the unused EAS code by
constant propagation.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com
---
 kernel/sched/sched.h    | 17 ++++++++++
 kernel/sched/topology.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c32714aed0d..5d4e9bbe9e53 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2188,8 +2188,25 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_ENERGY_MODEL
+extern struct static_key_false sched_energy_present;
+/**
+ * rd_freq_domain - Get the frequency domains of a root domain.
+ *
+ * Must be called from a RCU read-side critical section.
+ */
+static inline struct freq_domain *rd_freq_domain(struct root_domain *rd)
+{
+	if (!static_branch_unlikely(&sched_energy_present))
+		return NULL;
+
+	return rcu_dereference(rd->fd);
+}
 #define freq_domain_span(fd) (to_cpumask(((fd)->obj->cpus)))
 #else
+static inline struct freq_domain *rd_freq_domain(struct root_domain *rd)
+{
+	return NULL;
+}
 #define freq_domain_span(fd) NULL
 #endif
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 368669fbf0f0..cb5f0cfe2a7d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1713,12 +1713,31 @@ static void destroy_freq_domain_rcu(struct rcu_head *rp)
 	free_fd(fd);
 }
 
+/*
+ * The complexity of the Energy Model is defined as: nr_fd * (nr_cpus + nr_cs)
+ * with: 'nr_fd' the number of frequency domains; 'nr_cpus' the number of CPUs;
+ * and 'nr_cs' the sum of the capacity states numbers of all frequency domains.
+ *
+ * It is generally not a good idea to use such a model in the wake-up path on
+ * very complex platforms because of the associated scheduling overheads. The
+ * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
+ * with per-CPU DVFS and less than 8 capacity states each, for example.
+ */
+#define EM_MAX_COMPLEXITY 2048
+
 static void build_freq_domains(const struct cpumask *cpu_map)
 {
+	int i, nr_fd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct freq_domain *fd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	if (!per_cpu(sd_ea, cpu)) {
+		if (sched_debug())
+			pr_info("rd %*pbl: !sd_ea\n", cpumask_pr_args(cpu_map));
+		goto free;
+	}
 
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
@@ -1731,6 +1750,18 @@ static void build_freq_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = fd;
 		fd = tmp;
+
+		/* Count freq. doms and perf states for the complexity check. */
+		nr_fd++;
+		nr_cs += em_fd_nr_cap_states(fd->obj);
+	}
+
+	/* Bail out if the Energy Model complexity is too high. */
+	if (nr_fd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
+		if (sched_debug())
+			pr_info("rd %*pbl: EM complexity is too high\n ",
+						cpumask_pr_args(cpu_map));
+		goto free;
 	}
 
 	sched_energy_fd_debug(cpu_map, fd);
@@ -1750,6 +1781,44 @@ static void build_freq_domains(const struct cpumask *cpu_map)
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_freq_domain_rcu);
 }
+
+/*
+ * This static_key is set if at least one root domain meets all the following
+ * conditions:
+ *    1. all CPUs of the root domain are covered by the EM;
+ *    2. the EM complexity is low enough to keep scheduling overheads low;
+ *    3. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
+ */
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
+
+static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
+{
+	/*
+	 * The conditions for EAS to start are checked during the creation of
+	 * root domains. If one of them meets all conditions, it will have a
+	 * non-null list of frequency domains.
+	 */
+	while (ndoms_new) {
+		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->fd)
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
 #endif
 
 
@@ -2044,6 +2113,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
 		;
 	}
+	sched_energy_start(ndoms_new, doms_new);
 #endif
 
 	/* Remember the new sched domains: */
-- 
2.17.1


Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E710C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B6A214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B6A214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLCJ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:57:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32792 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:57:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5ADF169E;
        Mon,  3 Dec 2018 01:57:17 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 992C33F59C;
        Mon,  3 Dec 2018 01:57:13 -0800 (PST)
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
Subject: [PATCH v10 09/15] sched: Introduce sched_energy_present static key
Date:   Mon,  3 Dec 2018 09:56:22 +0000
Message-Id: <20181203095628.11858-10-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203095628.11858-1-quentin.perret@arm.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure Energy Aware Scheduling (EAS) will not impact
systems where no Energy Model is available, introduce a static key
guarding the access to EAS code. Since EAS is enabled on a
per-root-domain basis, the static key is enabled when at least one root
domain meets all conditions for EAS.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  4 ++++
 kernel/sched/topology.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6236081d68bf..8decb3bc0e3f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2298,3 +2298,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #else
 #define perf_domain_span(pd) NULL
 #endif
+
+#ifdef CONFIG_SMP
+extern struct static_key_false sched_energy_present;
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 70492d4bfed6..24d211ca384d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
@@ -273,6 +274,19 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+static void sched_energy_set(bool has_eas)
+{
+	if (!has_eas && static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: stopping EAS\n", __func__);
+		static_branch_disable_cpuslocked(&sched_energy_present);
+	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: starting EAS\n", __func__);
+		static_branch_enable_cpuslocked(&sched_energy_present);
+	}
+}
+
 /*
  * EAS can be used on a root domain if it meets all the following conditions:
  *    1. an Energy Model (EM) is available;
@@ -299,7 +313,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 #define EM_MAX_COMPLEXITY 2048
 
 extern struct cpufreq_governor schedutil_gov;
-static void build_perf_domains(const struct cpumask *cpu_map)
+static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
@@ -365,7 +379,7 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
-	return;
+	return !!pd;
 
 free:
 	free_pd(pd);
@@ -373,6 +387,8 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	rcu_assign_pointer(rd->pd, NULL);
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
+
+	return false;
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
@@ -2116,6 +2132,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			     struct sched_domain_attr *dattr_new)
 {
+	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
@@ -2179,14 +2196,17 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !sched_energy_update; j++) {
 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
-			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
+			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd) {
+				has_eas = true;
 				goto match3;
+			}
 		}
 		/* No match - add perf. domains for a new rd */
-		build_perf_domains(doms_new[i]);
+		has_eas |= build_perf_domains(doms_new[i]);
 match3:
 		;
 	}
+	sched_energy_set(has_eas);
 #endif
 
 	/* Remember the new sched domains: */
-- 
2.19.2


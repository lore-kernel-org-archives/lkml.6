Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A794C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F8D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F8D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeILORe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:17:34 -0400
Received: from foss.arm.com ([217.140.101.70]:55956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeILORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:17:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B3421596;
        Wed, 12 Sep 2018 02:13:56 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 337D33F703;
        Wed, 12 Sep 2018 02:13:52 -0700 (PDT)
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
Subject: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate platforms
Date:   Wed, 12 Sep 2018 10:13:03 +0100
Message-Id: <20180912091309.7551-9-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Energy Aware Scheduling (EAS) in its current form is most relevant on
platforms with asymmetric CPU topologies (e.g. Arm big.LITTLE) since
this is where there is a lot of potential for saving energy through
scheduling. This is particularly true since the Energy Model only
includes the active power costs of CPUs, hence not providing enough data
to compare packing-vs-spreading strategies.

As such, disable EAS on root domains where the SD_ASYM_CPUCAPACITY flag
is not set. While at it, disable EAS on systems where the complexity of
the Energy Model is too high since that could lead to unacceptable
scheduling overhead.

All in all, EAS can be used on a root domain if and only if:
  1. the ENERGY_AWARE sched_feat is enabled;
  2. the root domain has an asymmetric CPU capacity topology;
  3. the complexity of the root domain's EM is low enough to keep
     scheduling overheads low.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/topology.c | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10e37ffea19a..0d18d69b719c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -270,12 +270,45 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+/*
+ * EAS can be used on a root domain if it meets all the following conditions:
+ *    1. the ENERGY_AWARE sched_feat is enabled;
+ *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
+ *    3. the EM complexity is low enough to keep scheduling overheads low;
+ *
+ * The complexity of the Energy Model is defined as:
+ *
+ *              C = nr_pd * (nr_cpus + nr_cs)
+ *
+ * with parameters defined as:
+ *  - nr_pd:    the number of performance domains
+ *  - nr_cpus:  the number of CPUs
+ *  - nr_cs:    the sum of the number of capacity states of all performance
+ *              domains (for example, on a system with 2 performance domains,
+ *              with 10 capacity states each, nr_cs = 2 * 10 = 20).
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
@@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
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
-- 
2.18.0


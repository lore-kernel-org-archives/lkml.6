Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3306C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE02098B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CE02098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeHTNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:00:16 -0400
Received: from foss.arm.com ([217.140.101.70]:35098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTNAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:00:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546DA80D;
        Mon, 20 Aug 2018 02:45:21 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D79C3F2EA;
        Mon, 20 Aug 2018 02:45:17 -0700 (PDT)
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
Subject: [PATCH v6 11/14] sched/fair: Introduce an energy estimation helper function
Date:   Mon, 20 Aug 2018 10:44:17 +0100
Message-Id: <20180820094420.26590-12-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the definition of an energy-aware wakeup path,
introduce a helper function to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the capacity state to be reached by all performance domains
and estimates the consumption of each online CPU according to its Energy
Model and its percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00729ff55fa3..c4e34368795b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6262,6 +6262,83 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return !task_fits_capacity(p, min_cap);
 }
 
+/*
+ * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
+ * to @dst_cpu.
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	/*
+	 * If @p migrates from @cpu to another, remove its contribution. Or,
+	 * if @p migrates from another CPU to @cpu, add its contribution. In
+	 * the other cases, @cpu is not impacted by the migration, so the
+	 * util_avg should already be correct.
+	 */
+	if (task_cpu(p) == cpu && dst_cpu != cpu)
+		util = max_t(long, util - task_util(p), 0);
+	else if (task_cpu(p) != cpu && dst_cpu == cpu)
+		util += task_util(p);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * During wake-up, the task isn't enqueued yet and doesn't
+		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
+		 * so just add it (if needed) to "simulate" what will be
+		 * cpu_util() after the task has been enqueued.
+		 */
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+
+		util = max(util, util_est);
+	}
+
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
+}
+
+/*
+ * compute_energy(): Estimates the energy that would be consumed if @p was
+ * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
+ * landscape of the * CPUs after the task migration, and uses the Energy Model
+ * to compute what would be the energy if we decided to actually migrate that
+ * task.
+ */
+static long compute_energy(struct task_struct *p, int dst_cpu,
+							struct perf_domain *pd)
+{
+	long util, max_util, sum_util, energy = 0;
+	int cpu;
+
+	while (pd) {
+		max_util = sum_util = 0;
+		/*
+		 * The capacity state of CPUs of the current rd can be driven by
+		 * CPUs of another rd if they belong to the same performance
+		 * domain. So, account for the utilization of these CPUs too
+		 * by masking pd with cpu_online_mask instead of the rd span.
+		 *
+		 * If an entire performance domain is outside of the current rd,
+		 * it will not appear in its pd list and will not be accounted
+		 * by compute_energy().
+		 */
+		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util = schedutil_freq_util(cpu, util, ENERGY_UTIL);
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		energy += em_pd_energy(pd->obj, max_util, sum_util);
+		pd = pd->next;
+	}
+
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
-- 
2.17.1


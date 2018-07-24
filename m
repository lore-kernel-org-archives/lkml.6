Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CBA20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CBA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbeGXNcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:32:36 -0400
Received: from foss.arm.com ([217.140.101.70]:50166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbeGXNcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:32:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5817E15AB;
        Tue, 24 Jul 2018 05:26:21 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED723F6A8;
        Tue, 24 Jul 2018 05:26:17 -0700 (PDT)
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
Subject: [PATCH v5 11/14] sched/fair: Introduce an energy estimation helper function
Date:   Tue, 24 Jul 2018 13:25:18 +0100
Message-Id: <20180724122521.22109-12-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the definition of an energy-aware wakeup path,
introduce a helper function to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the capacity state to be reached by all frequency domains and
estimates the consumption of each online CPU according to its Energy
Model and its percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4aaa9132e840..dce2b1160cf4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6292,6 +6292,83 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return min_cap * 1024 < task_util(p) * capacity_margin;
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
+							struct freq_domain *fd)
+{
+	long util, max_util, sum_util, energy = 0;
+	int cpu;
+
+	while (fd) {
+		max_util = sum_util = 0;
+		/*
+		 * The frequency of CPUs of the current rd can be driven by
+		 * CPUs of another rd if they belong to the same frequency
+		 * domain. So, account for the utilization of these CPUs too
+		 * by masking fd with cpu_online_mask instead of the rd span.
+		 *
+		 * If an entire frequency domain is outide of the current rd,
+		 * it will not appear in its fd list and will not be accounted
+		 * by compute_energy().
+		 */
+		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util = schedutil_freq_util(cpu, util, energy_util);
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		energy += em_fd_energy(fd->obj, max_util, sum_util);
+		fd = fd->next;
+	}
+
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
-- 
2.18.0


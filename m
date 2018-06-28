Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54471272B3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54471272B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965742AbeF1Lmr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:42:47 -0400
Received: from foss.arm.com ([217.140.101.70]:45920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965645AbeF1Llk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B857C16A3;
        Thu, 28 Jun 2018 04:41:39 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C593F266;
        Thu, 28 Jun 2018 04:41:35 -0700 (PDT)
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
Subject: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation helper function
Date:   Thu, 28 Jun 2018 12:40:40 +0100
Message-Id: <20180628114043.24724-10-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
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
 kernel/sched/fair.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4f74c6d0a79e..f50c4e83a488 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6621,6 +6621,75 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
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
+	 * util_avg should already be what we want.
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
+ * Estimates the total energy that would be consumed by all online CPUs if @p
+ * was migrated to @dst_cpu. compute_energy() predicts what will be the
+ * utilization landscape of all CPUs after the task migration, and uses the
+ * Energy Model to compute what would be the system energy if we decided to
+ * actually migrate that task.
+ */
+static long compute_energy(struct task_struct *p, int dst_cpu,
+							struct freq_domain *fd)
+{
+	long util, max_util, sum_util, energy = 0;
+	int cpu;
+
+	while (fd) {
+		max_util = sum_util = 0;
+		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util += cpu_util_dl(cpu_rq(cpu));
+			/* XXX: add RT util_avg when available. */
+
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4e6548e4afc5..009e5fc9a375 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2170,7 +2170,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+#ifdef CONFIG_SMP
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-- 
2.17.1


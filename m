Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeEUOZ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeEUOZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:53 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation helper function
Date: Mon, 21 May 2018 15:25:02 +0100
Message-Id: <20180521142505.6522-8-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the definition of an energy-aware wakeup path, a
helper function is provided to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the capacity state to be reached by all frequency domains and
estimates the consumption of each online CPU according to its Energy Model
and its percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ec797d7ede83..1f7029258df2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6628,6 +6628,61 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return min_cap * 1024 < task_util(p) * capacity_margin;
 }
 
+/*
+ * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, util_est;
+	struct cfs_rq *cfs_rq;
+
+	/* Task is where it should be, or has no impact on cpu */
+	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
+		return cpu_util(cpu);
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	if (dst_cpu == cpu)
+		util += task_util(p);
+	else
+		util = max_t(long, util - task_util(p), 0);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+		else
+			util_est = max_t(long, util_est - _task_util_est(p), 0);
+		util = max(util, util_est);
+	}
+
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
+}
+
+static long compute_energy(struct task_struct *p, int dst_cpu)
+{
+	long util, max_util, sum_util, energy = 0;
+	struct sched_energy_fd *sfd;
+	int cpu;
+
+	for_each_freq_domain(sfd) {
+		max_util = sum_util = 0;
+		for_each_cpu_and(cpu, freq_domain_span(sfd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util += cpu_util_dl(cpu_rq(cpu));
+			/* XXX: add RT util_avg when available. */
+
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		energy += em_fd_energy(sfd->fd, max_util, sum_util);
+	}
+
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef5d4ebc205e..0dd895554f78 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2148,7 +2148,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+#ifdef CONFIG_SMP
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeEUOZd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeEUOZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:27 -0400
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
Subject: [RFC PATCH v3 01/10] sched: Relocate arch_scale_cpu_capacity
Date: Mon, 21 May 2018 15:24:56 +0100
Message-Id: <20180521142505.6522-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, arch_scale_cpu_capacity() is only visible from within the
kernel/sched folder. Relocate it to include/linux/sched/topology.h to
make it visible to other clients needing to know about the capacity of
CPUs, such as the Energy Model framework.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/topology.h | 19 +++++++++++++++++++
 kernel/sched/sched.h           | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..1e24e88bee6d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -202,6 +202,17 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
+		return sd->smt_gain / sd->span_weight;
+
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -217,6 +228,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #endif	/* !CONFIG_SMP */
 
 static inline int task_node(const struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..ce562d3b7526 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1724,30 +1724,12 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #ifdef CONFIG_SMP
 extern void sched_avg_update(struct rq *rq);
 
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
 	sched_avg_update(rq);
 }
 #else
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
 static inline void sched_avg_update(struct rq *rq) { }
 #endif
-- 
2.17.0

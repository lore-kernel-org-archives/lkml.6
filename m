Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244620880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbeGXNcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:32:32 -0400
Received: from foss.arm.com ([217.140.101.70]:50136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbeGXNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0082B80D;
        Tue, 24 Jul 2018 05:26:17 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2183F6A8;
        Tue, 24 Jul 2018 05:26:12 -0700 (PDT)
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
Subject: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization aggregation method
Date:   Tue, 24 Jul 2018 13:25:17 +0100
Message-Id: <20180724122521.22109-11-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
to decide which frequency to request. Energy Aware Scheduling (EAS)
needs to be able to predict those requests to assess the energy impact
of scheduling decisions. However, the PELT signals aggregation is only
done in schedutil for now, hence making it hard to synchronize it with
EAS.

To address this issue, introduce schedutil_freq_util() to perform the
aforementioned aggregation and make it available to other parts of the
scheduler. Since frequency selection and energy estimation still need
to deal with RT and DL signals slightly differently, schedutil_freq_util()
is called with a different 'type' parameter in those two contexts, and
returns an aggregated utilization signal accordingly.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 86 +++++++++++++++++++++-----------
 kernel/sched/sched.h             | 14 ++++++
 2 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 810193c8e4cd..af86050edcf5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -198,15 +198,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
+unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
+				  enum schedutil_type type)
 {
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	struct rq *rq = cpu_rq(cpu);
 	unsigned long util, irq, max;
 
-	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->bw_dl = cpu_bw_dl(rq);
+	max = arch_scale_cpu_capacity(NULL, cpu);
 
-	if (rt_rq_is_runnable(&rq->rt))
+	if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
 		return max;
 
 	/*
@@ -224,20 +224,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
 	 */
-	util = cpu_util_cfs(rq);
+	util = util_cfs;
 	util += cpu_util_rt(rq);
 
-	/*
-	 * We do not make cpu_util_dl() a permanent part of this sum because we
-	 * want to use cpu_bw_dl() later on, but we need to check if the
-	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
-	 * f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
-	 */
-	if ((util + cpu_util_dl(rq)) >= max)
-		return max;
+	if (type == frequency_util) {
+		/*
+		 * For frequency selection we do not make cpu_util_dl() a
+		 * permanent part of this sum because we want to use
+		 * cpu_bw_dl() later on, but we need to check if the
+		 * CFS+RT+DL sum is saturated (ie. no idle time) such
+		 * that we select f_max when there is no idle time.
+		 *
+		 * NOTE: numerical errors or stop class might cause us
+		 * to not quite hit saturation when we should --
+		 * something for later.
+		 */
+
+		if ((util + cpu_util_dl(rq)) >= max)
+			return max;
+	} else {
+		/*
+		 * OTOH, for energy computation we need the estimated
+		 * running time, so include util_dl and ignore dl_bw.
+		 */
+		util += cpu_util_dl(rq);
+		if (util >= max)
+			return max;
+	}
 
 	/*
 	 * There is still idle time; further improve the number by using the
@@ -252,17 +265,34 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	util /= max;
 	util += irq;
 
-	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
-	 */
-	return min(max, util + sg_cpu->bw_dl);
+	if (type == frequency_util) {
+		/*
+		 * Bandwidth required by DEADLINE must always be granted
+		 * while, for FAIR and RT, we use blocked utilization of
+		 * IDLE CPUs as a mechanism to gracefully reduce the
+		 * frequency when no tasks show up for longer periods of
+		 * time.
+		 *
+		 * Ideally we would like to set bw_dl as min/guaranteed
+		 * freq and util + bw_dl as requested freq. However,
+		 * cpufreq is not yet ready for such an interface. So,
+		 * we only do the latter for now.
+		 */
+		util += cpu_bw_dl(rq);
+	}
+
+	return min(max, util);
+}
+
+static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
+{
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util = cpu_util_cfs(rq);
+
+	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
+
+	return schedutil_freq_util(sg_cpu->cpu, util, frequency_util);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6d08ccd1e7a4..51e7f113ee23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2185,7 +2185,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
+enum schedutil_type {
+	frequency_util,
+	energy_util,
+};
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
+				  enum schedutil_type type);
+
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
@@ -2225,6 +2233,12 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
 }
 
 #endif
+#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
+				  enum schedutil_type type)
+{
+	return util;
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.18.0


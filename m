Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46698C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29B621570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29B621570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeHTNAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:00:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35068 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F321E15BE;
        Mon, 20 Aug 2018 02:45:16 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC1773F2EA;
        Mon, 20 Aug 2018 02:45:12 -0700 (PDT)
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
Subject: [PATCH v6 10/14] sched/cpufreq: Refactor the utilization aggregation method
Date:   Mon, 20 Aug 2018 10:44:16 +0100
Message-Id: <20180820094420.26590-11-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
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
index f5206c950143..8356cb0072a6 100644
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
+	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
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
+	if (type == FREQUENCY_UTIL) {
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
@@ -251,17 +264,34 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	util = scale_irq_capacity(util, irq, max);
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
+	if (type == FREQUENCY_UTIL) {
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
+	return schedutil_freq_util(sg_cpu->cpu, util, FREQUENCY_UTIL);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a0f8d1ca2d2..e594a854977f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2194,7 +2194,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
+enum schedutil_type {
+	FREQUENCY_UTIL,
+	ENERGY_UTIL,
+};
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
+				  enum schedutil_type type);
+
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
@@ -2221,6 +2229,12 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
+#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
+				  enum schedutil_type type)
+{
+	return util;
+}
 #endif
 
 #ifdef HAVE_SCHED_AVG_IRQ
-- 
2.17.1


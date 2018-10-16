Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DCFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EC22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJPSGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:06:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeJPSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B41A78;
        Tue, 16 Oct 2018 03:15:32 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6673F59C;
        Tue, 16 Oct 2018 03:15:28 -0700 (PDT)
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
Subject: [PATCH v8 02/15] sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
Date:   Tue, 16 Oct 2018 11:15:00 +0100
Message-Id: <20181016101513.26919-3-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Schedutil requests frequency by aggregating utilization signals from
the scheduler (CFS, RT, DL, IRQ) and applying a 25% margin on top of
them. Since Energy Aware Scheduling (EAS) needs to be able to predict
the frequency requests, it needs to forecast the decisions made by the
governor.

In order to prepare the introduction of EAS, introduce
schedutil_freq_util() to centralize the aforementioned signal
aggregation and make it available to both schedutil and EAS. Since
frequency selection and energy estimation still need to deal with RT and
DL signals slightly differently, schedutil_freq_util() is called with a
different 'type' parameter in those two contexts, and returns an
aggregated utilization signal accordingly. While at it, introduce the
map_util_freq() function which is designed to make schedutil's 25%
margin usable easily for both sugov and EAS.

As EAS will be able to predict schedutil's frequency requests more
accurately than any other governor by design, it'd be sensible to make
sure EAS cannot be used without schedutil. This will be done later, once
EAS has actually been introduced.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/cpufreq.h    |  6 +++
 kernel/sched/cpufreq_schedutil.c | 92 +++++++++++++++++++++-----------
 kernel/sched/sched.h             | 30 +++++++++++
 3 files changed, 97 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 59667444669f..afa940cd50dc 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -20,6 +20,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
                        void (*func)(struct update_util_data *data, u64 time,
 				    unsigned int flags));
 void cpufreq_remove_update_util_hook(int cpu);
+
+static inline unsigned long map_util_freq(unsigned long util,
+					unsigned long freq, unsigned long cap)
+{
+	return (freq + (freq >> 2)) * util / cap;
+}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3bc8a8..105cf70fcb69 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -13,6 +13,7 @@
 
 #include "sched.h"
 
+#include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
 struct sugov_tunables {
@@ -167,7 +168,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
-	freq = (freq + (freq >> 2)) * util / max;
+	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
@@ -197,15 +198,13 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
+unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
+				  unsigned long max, enum schedutil_type type)
 {
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util, irq, max;
-
-	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->bw_dl = cpu_bw_dl(rq);
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long util, irq;
 
-	if (rt_rq_is_runnable(&rq->rt))
+	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
 		return max;
 
 	/*
@@ -223,20 +222,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
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
@@ -250,17 +262,35 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
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
+	unsigned long max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+
+	sg_cpu->max = max;
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
+
+	return schedutil_freq_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ad12d11af0b2..440009115c64 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2173,6 +2173,31 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+/**
+ * enum schedutil_type - CPU utilization type
+ * @FREQUENCY_UTIL:	Utilization used to select frequency
+ * @ENERGY_UTIL:	Utilization used during energy calculation
+ *
+ * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
+ * need to be aggregated differently depending on the usage made of them. This
+ * enum is used within schedutil_freq_util() to differentiate the types of
+ * utilization expected by the callers, and adjust the aggregation accordingly.
+ */
+enum schedutil_type {
+	FREQUENCY_UTIL,
+	ENERGY_UTIL,
+};
+
+unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
+			          unsigned long max, enum schedutil_type type);
+
+static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
+{
+	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+
+	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
+}
+
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
@@ -2199,6 +2224,11 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
+#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
+{
+	return cfs;
+}
 #endif
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.19.1


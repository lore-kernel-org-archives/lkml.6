Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F68C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DF20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeLKPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:33:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:33:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFX7kf4042340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:33:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFX7wb4042336;
        Tue, 11 Dec 2018 07:33:07 -0800
Date:   Tue, 11 Dec 2018 07:33:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-938e5e4b0d1502a93e787985cb95b136b40717b7@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, efault@gmx.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        quentin.perret@arm.com, torvalds@linux-foundation.org,
        hpa@zytor.com
Reply-To: efault@gmx.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, tglx@linutronix.de, quentin.perret@arm.com
In-Reply-To: <20181203095628.11858-3-quentin.perret@arm.com>
References: <20181203095628.11858-3-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Prepare schedutil for Energy Aware
 Scheduling
Git-Commit-ID: 938e5e4b0d1502a93e787985cb95b136b40717b7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  938e5e4b0d1502a93e787985cb95b136b40717b7
Gitweb:     https://git.kernel.org/tip/938e5e4b0d1502a93e787985cb95b136b40717b7
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:15 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:16:58 +0100

sched/cpufreq: Prepare schedutil for Energy Aware Scheduling

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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-3-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/cpufreq.h    |  6 +++++
 kernel/sched/cpufreq_schedutil.c | 53 ++++++++++++++++++++++++++++------------
 kernel/sched/sched.h             | 30 +++++++++++++++++++++++
 3 files changed, 74 insertions(+), 15 deletions(-)

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
index 3fffad3bc8a8..90128be27712 100644
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
+	unsigned long dl_util, util, irq;
+	struct rq *rq = cpu_rq(cpu);
 
-	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->bw_dl = cpu_bw_dl(rq);
-
-	if (rt_rq_is_runnable(&rq->rt))
+	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
 		return max;
 
 	/*
@@ -223,21 +222,30 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
 	 */
-	util = cpu_util_cfs(rq);
+	util = util_cfs;
 	util += cpu_util_rt(rq);
 
+	dl_util = cpu_util_dl(rq);
+
 	/*
-	 * We do not make cpu_util_dl() a permanent part of this sum because we
-	 * want to use cpu_bw_dl() later on, but we need to check if the
-	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
-	 * f_max when there is no idle time.
+	 * For frequency selection we do not make cpu_util_dl() a permanent part
+	 * of this sum because we want to use cpu_bw_dl() later on, but we need
+	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
+	 * that we select f_max when there is no idle time.
 	 *
 	 * NOTE: numerical errors or stop class might cause us to not quite hit
 	 * saturation when we should -- something for later.
 	 */
-	if ((util + cpu_util_dl(rq)) >= max)
+	if (util + dl_util >= max)
 		return max;
 
+	/*
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
+
 	/*
 	 * There is still idle time; further improve the number by using the
 	 * irq metric. Because IRQ/steal time is hidden from the task clock we
@@ -260,7 +268,22 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
 	 * an interface. So, we only do the latter for now.
 	 */
-	return min(max, util + sg_cpu->bw_dl);
+	if (type == FREQUENCY_UTIL)
+		util += cpu_bw_dl(rq);
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
index 66067152a831..2eafa228aebf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2191,6 +2191,31 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
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
+				  unsigned long max, enum schedutil_type type);
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
@@ -2217,6 +2242,11 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
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

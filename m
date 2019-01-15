Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB44620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfAOKQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:16:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfAOKQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:16:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDAAF1596;
        Tue, 15 Jan 2019 02:16:03 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A71663F70D;
        Tue, 15 Jan 2019 02:16:00 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v6 11/16] sched/fair: Add uclamp support to energy_compute()
Date:   Tue, 15 Jan 2019 10:15:08 +0000
Message-Id: <20190115101513.2822-12-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Aware Scheduler (AES) estimates the energy impact of waking
up a task on a given CPU. This estimation is based on:
 a) an (active) power consumptions defined for each CPU frequency
 b) an estimation of which frequency will be used on each CPU
 c) an estimation of the busy time (utilization) of each CPU

Utilization clamping can affect both b) and c) estimations. A CPU is
expected to run:
 - on an higher than required frequency, but for a shorter time, in case
   its estimated utilization will be smaller then the minimum utilization
   enforced by uclamp
 - on a smaller than required frequency, but for a longer time, in case
   its estimated utilization is bigger then the maximum utilization
   enforced by uclamp

While effects on busy time for both boosted/capped tasks are already
considered by compute_energy(), clamping effects on frequency selection
are currently ignored by that function.

Fix it by considering how CPU clamp values will be affected by a
task waking up and being RUNNABLE on that CPU.

Do that by refactoring schedutil_freq_util() to take an additional
task_struct* which allows EAS to evaluate the impact on clamp values of
a task being eventually queued in a CPU. Clamp values are applied to the
RT+CFS utilization only when a FREQUENCY_UTIL is required by
compute_energy().

Since we are at that:
- rename schedutil_freq_util() into schedutil_cpu_util(),
  since it's not only used for frequency selection.
- use "unsigned int" instead of "unsigned long" whenever the tracked
  utilization value is not expected to overflow 32bit.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 +++++++++++-----------
 kernel/sched/fair.c              | 37 ++++++++++++++++++++++++++------
 kernel/sched/sched.h             | 19 +++++-----------
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 38a05a4f78cc..4e02b419c482 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -195,10 +195,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type)
+unsigned int schedutil_cpu_util(int cpu, unsigned int util_cfs,
+				 unsigned int max, enum schedutil_type type,
+				 struct task_struct *p)
 {
-	unsigned long dl_util, util, irq;
+	unsigned int dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
 	/*
@@ -222,13 +223,9 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 * When there are no CFS RUNNABLE tasks, clamps are released and
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL) {
-		util += cpu_util_cfs(rq);
-		util  = uclamp_util(rq, util);
-	} else {
-		util += util_cfs;
-	}
+	util = cpu_util_rt(rq) + util_cfs;
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
@@ -282,13 +279,14 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util = cpu_util_cfs(rq);
-	unsigned long max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	unsigned int util_cfs = cpu_util_cfs(rq);
+	unsigned int cpu_cap = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 
-	sg_cpu->max = max;
+	sg_cpu->max = cpu_cap;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_freq_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL);
+	return schedutil_cpu_util(sg_cpu->cpu, util_cfs, cpu_cap,
+				  FREQUENCY_UTIL, NULL);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5de061b055d2..7f8ca3b02dec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6424,11 +6424,20 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
-	long util, max_util, sum_util, energy = 0;
+	unsigned int max_util, cfs_util, cpu_util, cpu_cap;
+	unsigned long sum_util, energy = 0;
 	int cpu;
 
 	for (; pd; pd = pd->next) {
+		struct cpumask *pd_mask = perf_domain_span(pd);
+
+		/*
+		 * The energy model mandate all the CPUs of a performance
+		 * domain have the same capacity.
+		 */
+		cpu_cap = arch_scale_cpu_capacity(NULL, cpumask_first(pd_mask));
 		max_util = sum_util = 0;
+
 		/*
 		 * The capacity state of CPUs of the current rd can be driven by
 		 * CPUs of another rd if they belong to the same performance
@@ -6439,11 +6448,27 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * it will not appear in its pd list and will not be accounted
 		 * by compute_energy().
 		 */
-		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
-			util = cpu_util_next(cpu, p, dst_cpu);
-			util = schedutil_energy_util(cpu, util);
-			max_util = max(util, max_util);
-			sum_util += util;
+		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+			cfs_util = cpu_util_next(cpu, p, dst_cpu);
+
+			/*
+			 * Busy time computation: utilization clamping is not
+			 * required since the ratio (sum_util / cpu_capacity)
+			 * is already enough to scale the EM reported power
+			 * consumption at the (eventually clamped) cpu_capacity.
+			 */
+			sum_util += schedutil_cpu_util(cpu, cfs_util, cpu_cap,
+						       ENERGY_UTIL, NULL);
+
+			/*
+			 * Performance domain frequency: utilization clamping
+			 * must be considered since it affects the selection
+			 * of the performance domain frequency.
+			 */
+			cpu_util = schedutil_cpu_util(cpu, cfs_util, cpu_cap,
+						      FREQUENCY_UTIL,
+						      cpu == dst_cpu ? p : NULL);
+			max_util = max(max_util, cpu_util);
 		}
 
 		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b7ce3023d023..a70f4bf66285 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2317,7 +2317,6 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
@@ -2333,15 +2332,10 @@ enum schedutil_type {
 	ENERGY_UTIL,
 };
 
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type);
-
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
-{
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
-
-	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
-}
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+unsigned int schedutil_cpu_util(int cpu, unsigned int util_cfs,
+				unsigned int max, enum schedutil_type type,
+				struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
@@ -2370,10 +2364,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 #else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
-{
-	return cfs;
-}
+#define schedutil_cpu_util(cpu, util_cfs, max, type, p) 0
 #endif
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.19.2


Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C20C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AF62080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AF62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeJ3DX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbeJ3DXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 806E51596;
        Mon, 29 Oct 2018 11:34:04 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F8973F6A8;
        Mon, 29 Oct 2018 11:34:01 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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
Subject: [PATCH v5 10/15] sched/cpufreq: uclamp: add utilization clamping for RT tasks
Date:   Mon, 29 Oct 2018 18:33:05 +0000
Message-Id: <20181029183311.29175-12-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently schedutil enforces a maximum frequency when RT tasks are
RUNNABLE.  Such a mandatory policy can be made more tunable from
userspace thus allowing for example to define a max frequency which is
still reasonable for the execution of a specific RT workload.
This will contribute to make the RT class more friendly for power/energy
sensitive use-cases.

This patch extends the usage of util_{min,max} to the RT scheduling
class. Whenever a task in this class is RUNNABLE, the util required is
defined by its task specific clamp value. However, we still want to run
at maximum capacity RT tasks which do not have task specific clamp
values.

Let's add uclamp_default_perf, a special set of clamp value to be used
for tasks that require maximum performance. This set of clamps are then
used whenever the above conditions matches for an RT task being enqueued
on a CPU.

Since utilization clamping applies now to both CFS and RT tasks, we
clamp the combined utilization of these two classes.
This approach, contrary to combining individually clamped utilizations,
is more power efficient. Indeed, it selects lower frequencies when we
have both RT and CFS clamped tasks.
However, it could also affect performance of the lower priority CFS
class, since the CFS's minimum utilization clamp could be completely
eclipsed by the RT workloads.

The IOWait boost value also is subject to clamping for RT tasks.
This is to ensure that RT tasks as well as CFS ones are always subject
to the set of current utilization clamping constraints.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v5:
 Others:
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180813150112.GE2605@e110439-lin>
 - remove UCLAMP_SCHED_CLASS policy since we do not have in the current
   implementation a proper per-sched_class clamp tracking support
 Message-ID: <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
 - add default boost for not clamped RT tasks
 Others:
 - rebased on v4.19-rc1
Changes in v3:
 - rebased on tip/sched/core
Changes in v2:
 - rebased on v4.18-rc4
---
 kernel/sched/core.c              | 19 +++++++++++++++----
 kernel/sched/cpufreq_schedutil.c | 22 ++++++++++------------
 kernel/sched/rt.c                |  4 ++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8421ef96ec97..b9dd1980ec93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -745,6 +745,7 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
  * Tasks's clamp values are required to be within this range
  */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
+static struct uclamp_se uclamp_default_perf[UCLAMP_CNT];
 
 /**
  * uclamp_map: reference count utilization clamp groups
@@ -895,6 +896,7 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
 						     unsigned int clamp_id)
 {
+	struct uclamp_se *default_clamp;
 	unsigned int clamp_value;
 	unsigned int group_id;
 
@@ -906,15 +908,20 @@ static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
 	clamp_value = p->uclamp[clamp_id].value;
 	group_id = p->uclamp[clamp_id].group_id;
 
+	/* RT tasks have different default values */
+	default_clamp = task_has_rt_policy(p)
+		? uclamp_default_perf
+		: uclamp_default;
+
 	/* System default restriction */
-	if (unlikely(clamp_value < uclamp_default[UCLAMP_MIN].value ||
-		     clamp_value > uclamp_default[UCLAMP_MAX].value)) {
+	if (unlikely(clamp_value < default_clamp[UCLAMP_MIN].value ||
+		     clamp_value > default_clamp[UCLAMP_MAX].value)) {
 		/*
 		 * Unconditionally enforce system defaults, which is a simpler
 		 * solution compared to a proper clamping.
 		 */
-		clamp_value = uclamp_default[clamp_id].value;
-		group_id = uclamp_default[clamp_id].group_id;
+		clamp_value = default_clamp[clamp_id].value;
+		group_id = default_clamp[clamp_id].group_id;
 	}
 
 	p->uclamp[clamp_id].effective.value = clamp_value;
@@ -1381,6 +1388,10 @@ static void __init init_uclamp(void)
 
 		uc_se = &uclamp_default[clamp_id];
 		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
+
+		/* RT tasks by default will go to max frequency */
+		uc_se = &uclamp_default_perf[clamp_id];
+		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(UCLAMP_MAX));
 	}
 }
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index fd3fe55d605b..1156c7117fc2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -205,9 +205,6 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	if (rt_rq_is_runnable(&rq->rt))
-		return max;
-
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
 	 * because of inaccuracies in how we track these -- see
@@ -223,13 +220,16 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
 	 *
-	 * CFS utilization can be boosted or capped, depending on utilization
-	 * clamp constraints requested by currently RUNNABLE tasks.
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
 	 * When there are no CFS RUNNABLE tasks, clamps are released and OPPs
 	 * will be gracefully reduced with the utilization decay.
 	 */
-	util  = uclamp_util(rq, cpu_util_cfs(rq));
-	util += cpu_util_rt(rq);
+	util = cpu_util_rt(rq) + cpu_util_cfs(rq);
+	util = uclamp_util(rq, util);
+	if (unlikely(util >= max))
+		return max;
 
 	/*
 	 * We do not make cpu_util_dl() a permanent part of this sum because we
@@ -333,13 +333,11 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	 *
 	 * Since DL tasks have a much more advanced bandwidth control, it's
 	 * safe to assume that IO boost does not apply to those tasks.
-	 * Instead, since RT tasks are not utiliation clamped, we don't want
-	 * to apply clamping on IO boost while there is blocked RT
-	 * utilization.
+	 * Instead, for CFS and RT tasks we clamp the IO boost max value
+	 * considering the current constraints for the CPU.
 	 */
 	max_boost = sg_cpu->iowait_boost_max;
-	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
-		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
+	max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..06ec33467dd9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2404,6 +2404,10 @@ const struct sched_class rt_sched_class = {
 	.switched_to		= switched_to_rt,
 
 	.update_curr		= update_curr_rt,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.18.0


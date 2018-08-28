Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227C5C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84382087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84382087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeH1RrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:11 -0400
Received: from foss.arm.com ([217.140.101.70]:38678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE6C1BC0;
        Tue, 28 Aug 2018 06:54:49 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEDA83F5BD;
        Tue, 28 Aug 2018 06:54:46 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v4 16/16] sched/cpufreq: uclamp: add utilization clamping for RT tasks
Date:   Tue, 28 Aug 2018 14:53:24 +0100
Message-Id: <20180828135324.21976-17-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently schedutil enforces a maximum frequency when RT tasks are
RUNNABLE.  Such a mandatory policy can be made more tunable from
userspace thus allowing for example to define a max frequency which is
still reasonable for the execution of a specific RT workload. This
will contribute to make the RT class more friendly for power/energy
sensitive use-cases.

This patch extends the usage of util_{min,max} to the RT scheduling
class. Whenever a task in this class is RUNNABLE, the util required is
defined by its task specific clamp value. However, we still want to run
at maximum capacity RT tasks which:
 - do not have task specific clamp values
 - run either in the root task group or an autogroup

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

The IO wait boost value also is subject to clamping for RT tasks.
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
 kernel/sched/core.c              | 30 ++++++++++++++++++++++++------
 kernel/sched/cpufreq_schedutil.c | 22 ++++++++++++----------
 kernel/sched/rt.c                |  4 ++++
 3 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f71e15eaf152..9761457af1ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -741,6 +741,7 @@ unsigned int sysctl_sched_uclamp_util_min;
 unsigned int sysctl_sched_uclamp_util_max = 100;
 
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
+static struct uclamp_se uclamp_default_perf[UCLAMP_CNT];
 
 /**
  * uclamp_map: reference counts a utilization "clamp value"
@@ -1052,10 +1053,15 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
 	 */
 	if (unclamped && (task_group_is_autogroup(task_group(p)) ||
 			  task_group(p) == &root_task_group)) {
-		p->uclamp[clamp_id].effective.value =
-			uclamp_default[clamp_id].value;
 
-		return uclamp_default[clamp_id].group_id;
+		/* Unclamped RT tasks: max perfs by default */
+		uc_se = task_has_rt_policy(p)
+			? &uclamp_default_perf[clamp_id]
+			: &uclamp_default[clamp_id];
+
+		p->uclamp[clamp_id].effective.value = uc_se->value;
+
+		return uc_se->group_id;
 	}
 
 	/* Use TG's clamp value to limit task specific values */
@@ -1069,10 +1075,15 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
 #else
 	/* By default, all tasks get the system default clamp value */
 	if (unclamped) {
-		p->uclamp[clamp_id].effective.value =
-			uclamp_default[clamp_id].value;
 
-		return uclamp_default[clamp_id].group_id;
+		/* Unclamped RT tasks: max perfs by default */
+		uc_se = task_has_rt_policy(p)
+			? &uclamp_default_perf[clamp_id]
+			: &uclamp_default[clamp_id];
+
+		p->uclamp[clamp_id].effective.value = uc_se->value;
+
+		return uc_se->group_id;
 	}
 #endif
 
@@ -1761,6 +1772,13 @@ static void __init init_uclamp(void)
 		uc_se->group_id = UCLAMP_NOT_VALID;
 		uclamp_group_get(NULL, NULL, clamp_id, 0, uc_se,
 				 uclamp_none(clamp_id));
+
+		/* Init max perf clamps: default for RT tasks */
+		uc_se = &uclamp_default_perf[clamp_id];
+		uc_se->group_id = UCLAMP_NOT_VALID;
+		uclamp_group_get(NULL, NULL, clamp_id, 0, uc_se,
+				 uclamp_none(UCLAMP_MAX));
+
 	}
 }
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 949082555ee8..8a2d12a691eb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -205,7 +205,10 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	if (rt_rq_is_runnable(&rq->rt))
+	util = rt_rq_is_runnable(&rq->rt)
+		? uclamp_util(rq, SCHED_CAPACITY_SCALE)
+		: cpu_util_rt(rq);
+	if (unlikely(util >= max))
 		return max;
 
 	/*
@@ -223,13 +226,14 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
 	 *
-	 * CFS utilization can be boosted or capped, depending on utilization
-	 * clamp constraints configured for currently RUNNABLE tasks.
+	 * CFS and RT utilizations can be boosted or capped, depending on
+	 * utilization constraints enforce by currently RUNNABLE tasks.
 	 */
-	util = cpu_util_cfs(rq);
+	util += cpu_util_cfs(rq);
 	if (util)
 		util = uclamp_util(rq, util);
-	util += cpu_util_rt(rq);
+	if (unlikely(util >= max))
+		return max;
 
 	/*
 	 * We do not make cpu_util_dl() a permanent part of this sum because we
@@ -333,13 +337,11 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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


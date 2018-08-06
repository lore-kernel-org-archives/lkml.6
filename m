Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A06C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669521A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669521A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeHFSum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41814 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 189E815A2;
        Mon,  6 Aug 2018 09:40:48 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B9883F5D0;
        Mon,  6 Aug 2018 09:40:45 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping for RT tasks
Date:   Mon,  6 Aug 2018 17:39:38 +0100
Message-Id: <20180806163946.28380-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
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
class.  Whenever a task in this class is RUNNABLE, the util required is
defined by the constraints of the CPU control group the task belongs to.

Since utilization clamping applies now to both CFS and RT task, there
can be two alternative approaches:
 A) clamp the combined utilization
 B) combine the clamped utilizations
which have pros and cons.
Approach A) is more power efficient, since it generally selects lower
frequencies when we have both RT and CFS utilization. However, this
could affect performance of the lower priority CFS class, since the
minimum utilization clamp could be completely eclipsed by the RT
utilization.
Approach B) is more fair to the lower priority CFS class since it always
adds the required minimum utilization to that class too. For that reason
it could be less power efficient and, since we do not distinguish clamp
values based on the scheduling class, it could also end up boosting CFS
tasks more then required (e.g. when the current min utilization of a CPU
is required by an RT task). That's why this approach is masked behind a
sched feature.

The IO wait boost value is thus subject to clamping for RT tasks too.
This is to ensure that RT tasks as well as CFS ones are always subject
to the set of current utilization clamping constraints.
It's worth to notice that, by default, clamp values are
    min_util, max_util = (0, SCHED_CAPACITY_SCALE)
and thus, RT tasks always run at the maximum OPP if not otherwise
constrained by userspace.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 - rebased on tip/sched/core

Changes in v2:
 - rebased on v4.18-rc4
---
 kernel/sched/cpufreq_schedutil.c | 33 +++++++++++++++++++++-----------
 kernel/sched/features.h          |  5 +++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a7affc729c25..bb25ef66c2d3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -200,6 +200,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util_cfs, util_rt;
 	unsigned long util, irq, max;
 
 	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
@@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
 	 *
-	 * CFS utilization can be boosted or capped, depending on utilization
-	 * clamp constraints configured for currently RUNNABLE tasks.
+	 * CFS and RT utilizations can be boosted or capped, depending on
+	 * utilization constraints enforce by currently RUNNABLE tasks.
+	 * They are individually clamped to ensure fairness across classes,
+	 * meaning that CFS always gets (if possible) the (minimum) required
+	 * bandwidth on top of that required by higher priority classes.
 	 */
-	util = cpu_util_cfs(rq);
-	if (util)
-		util = uclamp_util(cpu_of(rq), util);
-	util += cpu_util_rt(rq);
+	util_cfs = cpu_util_cfs(rq);
+	util_rt  = cpu_util_rt(rq);
+	if (sched_feat(UCLAMP_SCHED_CLASS)) {
+		util = 0;
+		if (util_cfs)
+			util += uclamp_util(cpu_of(rq), util_cfs);
+		if (util_rt)
+			util += uclamp_util(cpu_of(rq), util_rt);
+	} else {
+		util  = cpu_util_cfs(rq);
+		util += cpu_util_rt(rq);
+		util  = uclamp_util(cpu_of(rq), util);
+	}
 
 	/*
 	 * We do not make cpu_util_dl() a permanent part of this sum because we
@@ -333,13 +346,11 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	 *
 	 * Since DL tasks have a much more advanced bandwidth control, it's
 	 * safe to assume that IO boost does not apply to those tasks.
-	 * Instead, since RT tasks are currently not utiliation clamped,
-	 * we don't want to apply clamping on IO boost while there is
-	 * blocked RT utilization.
+	 * Instead, for CFS and RT tasks we clamp the IO boost max value
+	 * considering the current constraints for the CPU.
 	 */
 	max_boost = sg_cpu->iowait_boost_max;
-	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
-		max_boost = uclamp_util(sg_cpu->cpu, max_boost);
+	max_boost = uclamp_util(sg_cpu->cpu, max_boost);
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..a3ca449e36c1 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,8 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+
+/*
+ * Per class CPU's utilization clamping.
+ */
+SCHED_FEAT(UCLAMP_SCHED_CLASS, false)
-- 
2.18.0


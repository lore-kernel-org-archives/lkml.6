Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F56C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819752080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfBHKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:06:44 -0500
Received: from foss.arm.com ([217.140.101.70]:47586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBHKGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:06:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067F3A78;
        Fri,  8 Feb 2019 02:06:40 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E44E23F557;
        Fri,  8 Feb 2019 02:06:36 -0800 (PST)
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
Subject: [PATCH v7 08/15] sched/cpufreq: uclamp: Add clamps for FAIR and RT tasks
Date:   Fri,  8 Feb 2019 10:05:47 +0000
Message-Id: <20190208100554.32196-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each time a frequency update is required via schedutil, a frequency is
selected to (possibly) satisfy the utilization reported by each
scheduling class. However, when utilization clamping is in use, the
frequency selection should consider userspace utilization clamping
hints.  This will allow, for example, to:

 - boost tasks which are directly affecting the user experience
   by running them at least at a minimum "requested" frequency

 - cap low priority tasks not directly affecting the user experience
   by running them only up to a maximum "allowed" frequency

These constraints are meant to support a per-task based tuning of the
frequency selection thus supporting a fine grained definition of
performance boosting vs energy saving strategies in kernel space.

Add support to clamp the utilization of RUNNABLE FAIR and RT tasks
within the boundaries defined by their aggregated utilization clamp
constraints.

Do that by considering the max(min_util, max_util) to give boosted tasks
the performance they need even when they happen to be co-scheduled with
other capped tasks.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
Changes in v7:
 Message-ID: <CAJZ5v0j2NQY_gKJOAy=rP5_1Dk9TODKNhW0vuvsynTN3BUmYaQ@mail.gmail.com>
 - merged FAIR and RT integration patches in this one
 Message-ID: <20190123142455.454u4w253xaxzar3@e110439-lin>
 - dropped clamping for IOWait boost
 Message-ID: <20190122123704.6rb3xemvxbp5yfjq@e110439-lin>
 - fixed go to max for RT tasks on !CONFIG_UCLAMP_TASK
---
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 kernel/sched/fair.c              |  4 ++++
 kernel/sched/rt.c                |  4 ++++
 kernel/sched/sched.h             | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 033ec7c45f13..70a8b87fa29c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -201,8 +201,10 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
-	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
+	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
+	}
 
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -218,9 +220,16 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = util_cfs;
-	util += cpu_util_rt(rq);
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_util(rq, util);
 
 	dl_util = cpu_util_dl(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ffd1ae7237e7..8c0aa76af90a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10587,6 +10587,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	.task_change_group	= task_change_group_fair,
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 90fa23d36565..d968f7209656 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2400,6 +2400,10 @@ const struct sched_class rt_sched_class = {
 	.switched_to		= switched_to_rt,
 
 	.update_curr		= update_curr_rt,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3274b2423f8..f07048a0e845 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2277,6 +2277,29 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+
+	/*
+	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
+	 * RUNNABLE tasks with _different_ clamps, we can end up with an
+	 * invertion, which we can fix at usage time.
+	 */
+	if (unlikely(min_util >= max_util))
+		return min_util;
+
+	return clamp(util, min_util, max_util);
+}
+#else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return util;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
-- 
2.20.1


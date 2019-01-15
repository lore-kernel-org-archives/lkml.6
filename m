Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B6620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfAOKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:15:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfAOKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:15:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE83A15AD;
        Tue, 15 Jan 2019 02:15:53 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97DE13F70D;
        Tue, 15 Jan 2019 02:15:50 -0800 (PST)
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
Subject: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping for FAIR tasks
Date:   Tue, 15 Jan 2019 10:15:05 +0000
Message-Id: <20190115101513.2822-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
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

Add support to clamp the utilization and IOWait boost of RUNNABLE FAIR
tasks within the boundaries defined by their aggregated utilization
clamp constraints.
Based on the max(min_util, max_util) of each task, max-aggregated the
CPU clamp value in a way to give the boosted tasks the performance they
need when they happen to be co-scheduled with other capped tasks.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
Changes in v6:
 Message-ID: <20181107113849.GC14309@e110439-lin>
 - sanity check util_max >= util_min
 Others:
 - wholesale s/group/bucket/
 - wholesale s/_{get,put}/_{inc,dec}/ to match refcount APIs
---
 kernel/sched/cpufreq_schedutil.c | 27 ++++++++++++++++++++++++---
 kernel/sched/sched.h             | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 033ec7c45f13..520ee2b785e7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -218,8 +218,15 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS utilization can be boosted or capped, depending on utilization
+	 * clamp constraints requested by currently RUNNABLE tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = util_cfs;
+	util = (type == ENERGY_UTIL)
+		? util_cfs
+		: uclamp_util(rq, util_cfs);
 	util += cpu_util_rt(rq);
 
 	dl_util = cpu_util_dl(rq);
@@ -327,6 +334,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned int flags)
 {
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+	unsigned int max_boost;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sg_cpu->iowait_boost &&
@@ -342,11 +350,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 		return;
 	sg_cpu->iowait_boost_pending = true;
 
+	/*
+	 * Boost FAIR tasks only up to the CPU clamped utilization.
+	 *
+	 * Since DL tasks have a much more advanced bandwidth control, it's
+	 * safe to assume that IO boost does not apply to those tasks.
+	 * Instead, since RT tasks are not utilization clamped, we don't want
+	 * to apply clamping on IO boost while there is blocked RT
+	 * utilization.
+	 */
+	max_boost = sg_cpu->iowait_boost_max;
+	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
+		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
+
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
 		sg_cpu->iowait_boost <<= 1;
-		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		if (sg_cpu->iowait_boost > max_boost)
+			sg_cpu->iowait_boost = max_boost;
 		return;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b7f3ee8ba164..95d62a2a0b44 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2267,6 +2267,29 @@ static inline unsigned int uclamp_none(int clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
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
2.19.2


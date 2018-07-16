Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D79320779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGPI4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:56:03 -0400
Received: from foss.arm.com ([217.140.101.70]:54386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbeGPI4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:56:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD1815A1;
        Mon, 16 Jul 2018 01:29:47 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 837DB3F5A0;
        Mon, 16 Jul 2018 01:29:44 -0700 (PDT)
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
Subject: [PATCH v2 06/12] sched/cpufreq: uclamp: add utilization clamping for RT tasks
Date:   Mon, 16 Jul 2018 09:29:00 +0100
Message-Id: <20180716082906.6061-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
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
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 70aea6ec3c08..b05a63055e70 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -188,27 +188,35 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 }
 
+/**
+ * sugov_aggregate_util() - Aggregate scheduling classes requests.
+ * @sg_cpu: the sugov data for the CPU to get utilization from
+ *
+ * Utilization required by DEADLINE must always be granted while, for
+ * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
+ * gracefully reduce the frequency when no tasks show up for longer
+ * periods of time.
+ *
+ * Ideally we would like to set util_dl as min/guaranteed freq and
+ * util_cfs + util_dl as requested freq. However, cpufreq is not yet
+ * ready for such an interface. So, we only do the latter for now.
+ *
+ * RT and CFS utilization are clamped, according to the current CPU
+ * constrains. They are individually clamped to ensure fairness across
+ * classes, meaning that CFS always gets (if possible) the (minimum)
+ * required bandwidth on top of that required by higher priority
+ * classes.
+ */
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
+	unsigned long util = sg_cpu->util_dl;
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util_cfs;
 
 	if (rt_rq_is_runnable(&rq->rt))
-		return sg_cpu->max;
-
-	/*
-	 * Utilization required by DEADLINE must always be granted while, for
-	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
-	 * gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set util_dl as min/guaranteed freq and
-	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
-	 * ready for such an interface. So, we only do the latter for now.
-	 */
-	util_cfs = uclamp_util(sg_cpu->cpu, sg_cpu->util_cfs);
+		util += uclamp_util(sg_cpu->cpu, sg_cpu->max);
+	util += uclamp_util(sg_cpu->cpu, sg_cpu->util_cfs);
 
-	return min(sg_cpu->max, (sg_cpu->util_dl + util_cfs));
+	return min(sg_cpu->max, util);
 }
 
 /**
@@ -276,8 +284,8 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	 *
 	 * Since DL tasks have a much more advanced bandwidth control, it's
 	 * safe to assume that IO boost does not apply to those tasks.
-	 * Instead, since for RT tasks we are already going to max, we don't
-	 * rally care about clamping the IO boost max value for them too.
+	 * Instead, for CFS and RT tasks we clamp the IO boost max value
+	 * considering the current constraints for the CPU.
 	 */
 	max_boost = sg_cpu->iowait_boost_max;
 	max_boost = uclamp_util(sg_cpu->cpu, max_boost);
-- 
2.17.1


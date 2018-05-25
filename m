Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935882AbeEYNMv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:12:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50639 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeEYNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:43 -0400
X-Google-Smtp-Source: ADUXVKLPOC9cKhmFkzNgUrgcWHnxMTsX/RCEgYDUFA6GEi3np98Vzwv55fXZXkQw5j2ruarO6uZl3Q==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Date: Fri, 25 May 2018 15:12:24 +0200
Message-Id: <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both cfs and rt utilization when selecting an OPP for cfs tasks as rt
can preempt and steal cfs's running time.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 28592b6..a84b5a5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -178,14 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util;
 
-	if (rq->rt.rt_nr_running)
-		return sg_cpu->max;
+	if (rq->rt.rt_nr_running) {
+		util = sg_cpu->max;
+	} else {
+		util = sg_cpu->util_dl;
+		util += sg_cpu->util_cfs;
+		util += sg_cpu->util_rt;
+	}
 
 	/*
 	 * Utilization required by DEADLINE must always be granted while, for
@@ -197,7 +205,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
+	return min(sg_cpu->max, util);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
-- 
2.7.4

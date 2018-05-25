Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936128AbeEYNNm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:13:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52388 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935724AbeEYNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:49 -0400
X-Google-Smtp-Source: ADUXVKIo3xHgg2XhAKVVbZODEQfefzrRfujfOPmCNcZCCGJFNm36QPrS3598+J6BUujXLDTmgHXe9A==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 08/10] cpufreq/schedutil: take into account interrupt
Date: Fri, 25 May 2018 15:12:29 +0200
Message-Id: <1527253951-22709-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time spent under interrupt can be significant but it is not reflected
in the utilization of CPU when deciding to choose an OPP. Now that we have
access to this metric, schedutil can take it into account when selecting
the OPP for a CPU.
The CPU utilization is :
  irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg

A test with iperf on hikey (octo arm64) gives:
iperf -c server_address -r -t 5

w/o patch		w/ patch
Tx 276 Mbits/sec        304 Mbits/sec +10%
Rx 299 Mbits/sec        328 Mbits/sec +09%

8 iterations
stdev is lower than 1%
Only WFI idle state is enable (shallowest diel state)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 10 ++++++++++
 kernel/sched/sched.h             |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a84b5a5..06f2080 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -57,6 +57,7 @@ struct sugov_cpu {
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
 	unsigned long		util_rt;
+	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -180,6 +181,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
+	sg_cpu->util_irq = cpu_util_irq(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
@@ -190,9 +192,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	if (rq->rt.rt_nr_running) {
 		util = sg_cpu->max;
 	} else {
+		/* Sum rq utilization*/
 		util = sg_cpu->util_dl;
 		util += sg_cpu->util_cfs;
 		util += sg_cpu->util_rt;
+
+		/* Weight rq's utilization to the normal context */
+		util *= (sg_cpu->max - sg_cpu->util_irq);
+		util /= sg_cpu->max;
+
+		/* Add interrupt utilization */
+		util += sg_cpu->util_irq;
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f7e8d5b..718c55d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2218,4 +2218,9 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return rq->avg_rt.util_avg;
 }
+
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return rq->avg_irq.util_avg;
+}
 #endif
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeCPL0i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:26:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55446 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753884AbeCPLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:56 -0400
X-Google-Smtp-Source: AG47ELtjWEHqPXvIBNpWArvRNHS6qWoHEfYozPiw8gGvtZztTra9DAuM0lUYPaLQ9YNzkbYMT8keBA==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4 v4] cpufreq/schedutil: add rt utilization tracking
Date: Fri, 16 Mar 2018 12:25:40 +0100
Message-Id: <1521199541-15308-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add both cfs and rt utilization when selecting an OPP as rt can preempt and
steal cfs's running time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 +++-
 kernel/sched/sched.h             | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 89fe78e..7ce0643 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -178,6 +179,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
@@ -190,7 +192,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	} else {
 		util = sg_cpu->util_dl;
 		if (rq->cfs.h_nr_running)
-			util += sg_cpu->util_cfs;
+			util += sg_cpu->util_cfs + sg_cpu->util_rt;
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8003a9..b8784be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2186,4 +2186,11 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
 	return rq->cfs.avg.util_avg;
 }
+
+static inline unsigned long cpu_util_rt(struct rq *rq)
+{
+	return rq->rt.avg.util_avg;
+}
+
+
 #endif
-- 
2.7.4

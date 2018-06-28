Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B740C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB0A2762F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv2mNDwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0A2762F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030213AbeF1Ppd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:45:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37887 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeF1PpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so6009549wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=40iPUFhsx7XM6LB0p73GtKzFTWtCVEeSOv4I54ZfXIE=;
        b=Gv2mNDwh3lU9Ld5fyu0O/sXrMTZBQDsNekOPwau0a6lFKKGSqzGeEsE01F5w8tNy5b
         0JOwdISDQss/e/nM633nn7Od18kiWovlzy2YIrPUeMsfc5TnqaOYN+A8l6uTvlN/iLi0
         G3flSo1y9vxrEgLo0m2Rdqe3vzLW4FVs2rDD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=40iPUFhsx7XM6LB0p73GtKzFTWtCVEeSOv4I54ZfXIE=;
        b=HgBtL/sFznIq3ADbHksjJWp2la6Q4rxHWeEcD36CayFkHlLzAiCgFpF2TyJceya0aR
         gu0Dn4WfsGUuLKgc82EZPacHPNrnTGhAvkcbYCRnC4vtWOFEfSb/QXre0KIXAmeZHpqZ
         Lv0iYG+I0xhKElZd5q02WRCD0BpH7eC8aeX4/Q9BAn/aNuH2NpT0xe3z+ycFNoC2fCdn
         C5AOeOIgH31dL2dGr6dc5Qe+DKrUU9sRMpBaVNoqMiXbTivSvzXRF6eDMqRlk/zHPNvz
         JYf10HMbTG97q9uaCMEgveFEBt3o97AbP3gv+2G75St7qFrCeoaQ2bLvVXe3t+1C80r/
         xo/A==
X-Gm-Message-State: APt69E3mjfmdwv3j6+3208B8ze1+JVQKblcax1YF++dJL6yT1FK1S8g+
        TiwqwUFRc0YCRGYAY/xqcHEKuw==
X-Google-Smtp-Source: AAOMgpf3V+Ai5mfChYTeAGhWhU7e6ZUV5IOhtV+tt2T53cSihX6IyUNmtYbA38MMk2Spl8D9fQHowQ==
X-Received: by 2002:adf:ab95:: with SMTP id s21-v6mr9617322wrc.90.1530200724460;
        Thu, 28 Jun 2018 08:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:23 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 02/11] sched/rt: add rt_rq utilization tracking
Date:   Thu, 28 Jun 2018 17:45:05 +0200
Message-Id: <1530200714-4504-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
tasks are running. When the CPU is overloaded by cfs and rt tasks, cfs tasks
are preempted by rt tasks and in this case util_avg reflects the remaining
capacity but not what cfs want to use. In such case, schedutil can select a
lower OPP whereas the CPU is overloaded. In order to have a more accurate
view of the utilization of the CPU, we track the utilization of rt tasks.
Only util_avg is correctly tracked but not load_avg and runnable_load_avg
which are useless for rt_rq.

rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
the same at the root group level, so the PELT windows of the util_sum are
aligned.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 15 ++++++++++++++-
 kernel/sched/pelt.c  | 25 +++++++++++++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/rt.c    | 13 +++++++++++++
 kernel/sched/sched.h |  7 +++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bdab9ed..328bedc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,6 +7289,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
+static inline bool rt_rq_has_blocked(struct rq *rq)
+{
+	if (READ_ONCE(rq->avg_rt.util_avg))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7348,6 +7356,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	/* Don't need periodic decay once load/util_avg are null */
+	if (rt_rq_has_blocked(rq))
+		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7413,9 +7425,10 @@ static inline void update_blocked_averages(int cpu)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index e6ecbb2..a00b1ba 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -309,3 +309,28 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 
 	return 0;
 }
+
+/*
+ * rt_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ *   load_avg and runnable_load_avg are not supported and meaningless.
+ *
+ */
+
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rq->avg_rt, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9cac73e..b2983b7 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -3,6 +3,7 @@
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -38,6 +39,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int
+update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
+
 #endif
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 47556b0..0e3e57a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,6 +5,8 @@
  */
 #include "sched.h"
 
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 
@@ -1572,6 +1574,14 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	rt_queue_push_tasks(rq);
 
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1579,6 +1589,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
@@ -2308,6 +2320,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
 
 	watchdog(rq, p);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db6878e..f2b12b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -592,6 +592,7 @@ struct rt_rq {
 	unsigned long		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
+
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
@@ -847,6 +848,7 @@ struct rq {
 
 	u64			rt_avg;
 	u64			age_stamp;
+	struct sched_avg	avg_rt;
 	u64			idle_stamp;
 	u64			avg_idle;
 
@@ -2205,4 +2207,9 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 	return util;
 }
+
+static inline unsigned long cpu_util_rt(struct rq *rq)
+{
+	return rq->avg_rt.util_avg;
+}
 #endif
-- 
2.7.4


Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299922763F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMylM3Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299922763F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeF1Prf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:47:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40292 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967006AbeF1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id l2-v6so5423754wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IhPXEvdETPjS/XrwEpztFR59irmHT4gle9wfp3C4/H8=;
        b=jMylM3SmtzQYOB7WHvsl0+vWSB4Mk2WBbrl8EnV4gN9vfaAemPus3Bob0eTO9+EJ3r
         wiz1URLF2nvxZk0dUpsxjR7pogsFXOsVfwaWSo5+rRVTTBWboqTYfdCuj61zbda+Z/+N
         oEnYgkRhIwuwgA9pAQ7FJGSVYTGmKYDs/Y3EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IhPXEvdETPjS/XrwEpztFR59irmHT4gle9wfp3C4/H8=;
        b=NdNUFa4XrzTWwlBUaG1XJT3qnMo3UPOXSQuILMnNSzt85RT5hMD2+5Nf0Asyqa1XOr
         AH3acbh/H2zPc0VhV6Z8KQ+gyia2Q4rPVz1wlJGatflo2SF3a1UfWe8xjUcVXH+mx8Wm
         8bubVBP7LGxr8andba+WMPE0zQFfzncF9C1GScUJ32WN+1JkMSd64G9mUoqWp9VEYtKM
         5iMO793y8oRUmv0z7cf7T1qu+JGYfX7xFNzO4LB89qAcWsaByaoLFRiiUHd0HUSywVab
         tDt1PiHvGds7XtiXFibQYrq0/Yd9LXI3w8/1xbp7TKNZAGFETemGEE+4V6G7DhpIhAN+
         uP6g==
X-Gm-Message-State: APt69E2AsQAShLkMxehnNaUYNDWOswWwcmCu8k+8EYbMEV1xzy2QP7PY
        Z2ahwjlP2YkZvsHNv/N4RNQsVw==
X-Google-Smtp-Source: AAOMgpdxhzdbKUOYgxD2eltZv8Vp5MBrGgnJcEDcwTd45GrEx8QwXsTRzHnB+oq3CqQPCZ7jU8gWaA==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr9579165wrd.53.1530200727293;
        Thu, 28 Jun 2018 08:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:26 -0700 (PDT)
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
Subject: [PATCH 04/11] sched/dl: add dl_rq utilization tracking
Date:   Thu, 28 Jun 2018 17:45:07 +0200
Message-Id: <1530200714-4504-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what happens with rt tasks, cfs tasks can be preempted by dl
tasks and the cfs's utilization might no longer describes the real
utilization level.
Current dl bandwidth reflects the requirements to meet deadline when tasks are
enqueued but not the current utilization of the dl sched class. We track
dl class utilization to estimate the system utilization.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c |  6 ++++++
 kernel/sched/fair.c     | 11 ++++++++---
 kernel/sched/pelt.c     | 23 +++++++++++++++++++++++
 kernel/sched/pelt.h     |  6 ++++++
 kernel/sched/sched.h    |  1 +
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1..f4de2698 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -1761,6 +1762,9 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	deadline_queue_push_tasks(rq);
 
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1768,6 +1772,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -1784,6 +1789,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 328bedc..ffce4b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,11 +7289,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool rt_rq_has_blocked(struct rq *rq)
+static inline bool others_rqs_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_dl.util_avg))
+		return true;
+
 	return false;
 }
 
@@ -7357,8 +7360,9 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (rt_rq_has_blocked(rq))
+	if (others_rqs_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7426,9 +7430,10 @@ static inline void update_blocked_averages(int cpu)
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a00b1ba..8b78b63 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -334,3 +334,26 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+/*
+ * dl_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rq->avg_dl, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index b2983b7..0e4f912 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -4,6 +4,7 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -45,6 +46,11 @@ update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+static inline int
+update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f2b12b0..7d7d4f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -849,6 +849,7 @@ struct rq {
 	u64			rt_avg;
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
+	struct sched_avg	avg_dl;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4


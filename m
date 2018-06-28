Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDDBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7998227637
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnY9KF/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7998227637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935527AbeF1Pqw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:46:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36611 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967319AbeF1Ppb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so9602254wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khbfR0A1jc9cKblSJKeoc1wGMCANZRoaQHs1pMgMrS0=;
        b=EnY9KF/AmhXIp6ruDeq4SkXzGchRIRzF1759AjT3m3rjhJPCmhGvZjOMAxaeJ2NOTx
         FxfMOULgBvxNmmurjAiJERwozC++180LRCvJlMeNNiDIMzg1HK2J5CYbqB1F1b8iB+ge
         kgLCNfhQHx/BzbiyaVl4lgovMS+/v/jUlet28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=khbfR0A1jc9cKblSJKeoc1wGMCANZRoaQHs1pMgMrS0=;
        b=OgfIt3/jnPvE12oDUEEB3K4pbjM2cvjq2Tv2TPtvsXf8XgvSpQbUgwinqR92zqhgXN
         gZLgL2hkX676bre5BoofdgjEJf6UUtAwNQNe6DNe4Vy+Xcxt9ALCzFJRFUx1jLVG8N5E
         3vK11qvh3IlkHlG4TZplnxKhT04lXhNTSANrD63LmJ+bekooQVtOtQduH1/MPhhrPNRi
         qG+97quLhq7glNnKF4ZPXbtbbLb4LUzma6MR3TTV3LrbFFWRebSAkJLknJBYxy8w0Of0
         Y6LTvq+HrFsMEyeOiE9Xt3vpfAVfIrjrk3/ssOhrHmNPosXCBRkKfwtj/XNfBsEc4Boh
         XXww==
X-Gm-Message-State: APt69E3lfrqlxMOuvsE/gsdZqY/znRug/c0scu1io4n01YLQAVyYtCiX
        q/eziLi0ro3jKJutIbkq7ziRVQ==
X-Google-Smtp-Source: AAOMgpfsffkTKRmDhGqZkArnrLqva3O4BBYQ1FCMxXJsAIRCe3hF5bYWt+sKrkdFxphj0g2tr6vVOg==
X-Received: by 2002:a1c:afd4:: with SMTP id y203-v6mr8286102wme.55.1530200729927;
        Thu, 28 Jun 2018 08:45:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:29 -0700 (PDT)
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
Subject: [PATCH 06/11] sched/irq: add irq utilization tracking
Date:   Thu, 28 Jun 2018 17:45:09 +0200
Message-Id: <1530200714-4504-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt and steal time are the only remaining activities tracked by
rt_avg. Like for sched classes, we can use PELT to track their average
utilization of the CPU. But unlike sched class, we don't track when
entering/leaving interrupt; Instead, we take into account the time spent
under interrupt context when we update rqs' clock (rq_clock_task).
This also means that we have to decay the normal context time and account
for interrupt time during the update.

That's also important to note that because
  rq_clock == rq_clock_task + interrupt time
and rq_clock_task is used by a sched class to compute its utilization, the
util_avg of a sched class only reflects the utilization of the time spent
in normal context and not of the whole time of the CPU. The utilization of
interrupt gives an more accurate level of utilization of CPU.
The CPU utilization is :
  avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq

Most of the time, avg_irq is small and neglictible so the use of the
approximation CPU utilization = /Sum avg_rq was enough

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/fair.c  | 13 ++++++++++---
 kernel/sched/pelt.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  | 16 ++++++++++++++++
 kernel/sched/sched.h |  3 +++
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8fac..e5263a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -18,6 +18,8 @@
 #include "../workqueue_internal.h"
 #include "../smpboot.h"
 
+#include "pelt.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
@@ -186,7 +188,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
-		sched_rt_avg_update(rq, irq_delta + steal);
+		update_irq_load_avg(rq, irq_delta + steal);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ffce4b2..d2758e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,7 +7289,7 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool others_rqs_have_blocked(struct rq *rq)
+static inline bool others_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
@@ -7297,6 +7297,11 @@ static inline bool others_rqs_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	if (READ_ONCE(rq->avg_irq.util_avg))
+		return true;
+#endif
+
 	return false;
 }
 
@@ -7361,8 +7366,9 @@ static void update_blocked_averages(int cpu)
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (others_rqs_have_blocked(rq))
+	if (others_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7431,9 +7437,10 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 8b78b63..ead6d8b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -357,3 +357,43 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+/*
+ * irq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_irq_load_avg(struct rq *rq, u64 running)
+{
+	int ret = 0;
+	/*
+	 * We know the time that has been used by interrupt since last update
+	 * but we don't when. Let be pessimistic and assume that interrupt has
+	 * happened just before the update. This is not so far from reality
+	 * because interrupt will most probably wake up task and trig an update
+	 * of rq clock during which the metric si updated.
+	 * We start to decay with normal context time and then we add the
+	 * interrupt context time.
+	 * We can safely remove running from rq->clock because
+	 * rq->clock += delta with delta >= running
+	 */
+	ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
+				0,
+				0,
+				0);
+	ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
+				1,
+				1,
+				1);
+
+	if (ret)
+		___update_load_avg(&rq->avg_irq, 1, 1);
+
+	return ret;
+}
+#endif
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 0e4f912..d2894db 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,16 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+int update_irq_load_avg(struct rq *rq, u64 running);
+#else
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
+#endif
+
 /*
  * When a task is dequeued, its estimated utilization should not be update if
  * its util_avg has not been updated at least once.
@@ -51,6 +61,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	return 0;
 }
+
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef5d6aa..377be2b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -850,6 +850,9 @@ struct rq {
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	struct sched_avg	avg_irq;
+#endif
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4


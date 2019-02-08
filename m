Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AF2080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfBHKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:06:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfBHKGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:06:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD6D1596;
        Fri,  8 Feb 2019 02:06:19 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C539C3F557;
        Fri,  8 Feb 2019 02:06:16 -0800 (PST)
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
Subject: [PATCH v7 02/15] sched/core: uclamp: Enforce last task UCLAMP_MAX
Date:   Fri,  8 Feb 2019 10:05:41 +0000
Message-Id: <20190208100554.32196-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the task sleeps, it removes its max utilization clamp from its CPU.
However, the blocked utilization on that CPU can be higher than the max
clamp value enforced while the task was running. This allows undesired
CPU frequency increases while a CPU is idle, for example, when another
CPU on the same frequency domain triggers a frequency update, since
schedutil can now see the full not clamped blocked utilization of the
idle CPU.

Fix this by using
  uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
    uclamp_rq_update(rq, UCLAMP_MAX, clamp_value)
to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition.

Don't track any minimum utilization clamps since an idle CPU never
requires a minimum frequency. The decay of the blocked utilization is
good enough to reduce the CPU frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  | 52 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  2 ++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ecf5470058c..e4f5e8c426ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -741,11 +741,47 @@ static inline unsigned int uclamp_none(int clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
+static inline unsigned int
+uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
+{
+	/*
+	 * Avoid blocked utilization pushing up the frequency when we go
+	 * idle (which drops the max-clamp) by retaining the last known
+	 * max-clamp.
+	 */
+	if (clamp_id == UCLAMP_MAX) {
+		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+		return clamp_value;
+	}
+
+	return uclamp_none(UCLAMP_MIN);
+}
+
+static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+				     unsigned int clamp_value)
+{
+	/* Reset max-clamp retention only on idle exit */
+	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		return;
+
+	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
+
+	/*
+	 * This function is called for both UCLAMP_MIN (before) and UCLAMP_MAX
+	 * (after). The idle flag is reset only the second time, when we know
+	 * that UCLAMP_MIN has been already updated.
+	 */
+	if (clamp_id == UCLAMP_MAX)
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+}
+
+static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id,
+				    unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	unsigned int max_value = uclamp_none(clamp_id);
 	unsigned int bucket_id;
+	bool active = false;
 
 	/*
 	 * Both min and max clamps are MAX aggregated, thus the topmost
@@ -757,9 +793,13 @@ static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
 		if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
 			continue;
 		max_value = bucket[bucket_id].value;
+		active = true;
 		break;
 	} while (bucket_id);
 
+	if (unlikely(!active))
+		max_value = uclamp_idle_value(rq, clamp_id, clamp_value);
+
 	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
 }
 
@@ -781,12 +821,14 @@ static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
 	unsigned int rq_clamp, bkt_clamp, tsk_clamp;
 
 	rq->uclamp[clamp_id].bucket[bucket_id].tasks++;
+	/* Reset clamp holds on idle exit */
+	tsk_clamp = p->uclamp[clamp_id].value;
+	uclamp_idle_reset(rq, clamp_id, tsk_clamp);
 
 	/*
 	 * Local clamping: rq's buckets always track the max "requested"
 	 * clamp value from all RUNNABLE tasks in that bucket.
 	 */
-	tsk_clamp = p->uclamp[clamp_id].value;
 	bkt_clamp = rq->uclamp[clamp_id].bucket[bucket_id].value;
 	rq->uclamp[clamp_id].bucket[bucket_id].value = max(bkt_clamp, tsk_clamp);
 
@@ -830,7 +872,7 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
 		 */
 		rq->uclamp[clamp_id].bucket[bucket_id].value =
 			uclamp_bucket_value(rq_clamp);
-		uclamp_rq_update(rq, clamp_id);
+		uclamp_rq_update(rq, clamp_id, bkt_clamp);
 	}
 }
 
@@ -861,8 +903,10 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		cpu_rq(cpu)->uclamp_flags = 0;
+	}
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		unsigned int clamp_value = uclamp_none(clamp_id);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ea9e28723946..b3274b2423f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -880,6 +880,8 @@ struct rq {
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+	unsigned int		uclamp_flags;
+#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
-- 
2.20.1


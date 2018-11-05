Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013FD2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013FD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbeKFAOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:14:35 -0500
Received: from foss.arm.com ([217.140.101.70]:45334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387428AbeKFAOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:14:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AE6615BF;
        Mon,  5 Nov 2018 06:54:29 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 465683F5CF;
        Mon,  5 Nov 2018 06:54:27 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 3/3] sched/fair: add lsub_positive and use it consistently
Date:   Mon,  5 Nov 2018 14:54:00 +0000
Message-Id: <20181105145400.935-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181105145400.935-1-patrick.bellasi@arm.com>
References: <20181105145400.935-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following pattern:

   var -= min_t(typeof(var), var, val);

is used multiple times in fair.c.

The existing sub_positive() already capture that pattern but it adds
also explicit load-sotre to properly support lockless observations.
In other cases, the patter above is used to update local, and/or not
concurrently accessed, variables.

Let's add a simpler version of sub_positive, targeted to local variables
updates, which gives the same readability benefits at calling sites
without enforcing {READ,WRITE}_ONCE barriers.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Link: https://lore.kernel.org/lkml/20181031184527.GA3178@hirez.programming.kicks-ass.net
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aeb37fe4dbb1..d50c739127d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2734,6 +2734,17 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	WRITE_ONCE(*ptr, res);					\
 } while (0)
 
+/*
+ * Remove and clamp on negative, from a local variable.
+ *
+ * A variant of sub_positive which do not use explicit load-store
+ * and thus optimized for local variable updates.
+ */
+#define lsub_positive(_ptr, _val) do {				\
+	typeof(_ptr) ptr = (_ptr);				\
+	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
+} while (0)
+
 #ifdef CONFIG_SMP
 static inline void
 enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -4639,7 +4650,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
 
-		cfs_b->runtime -= min(runtime, cfs_b->runtime);
+		lsub_positive(&cfs_b->runtime, runtime);
 	}
 
 	/*
@@ -4773,7 +4784,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 
 	raw_spin_lock(&cfs_b->lock);
 	if (expires == cfs_b->runtime_expires)
-		cfs_b->runtime -= min(runtime, cfs_b->runtime);
+		lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock(&cfs_b->lock);
 }
@@ -6240,7 +6251,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	/* Discount task's util from CPU's util */
-	util -= min_t(unsigned int, util, task_util(p));
+	lsub_positive(&util, task_util(p));
 
 	/*
 	 * Covered cases:
@@ -6289,10 +6300,9 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 		 * properly fix the execl regression and it helps in further
 		 * reducing the chances for the above race.
 		 */
-		if (unlikely(task_on_rq_queued(p) || current == p)) {
-			estimated -= min_t(unsigned int, estimated,
-					   _task_util_est(p));
-		}
+		if (unlikely(task_on_rq_queued(p) || current == p))
+			lsub_positive(&estimated, _task_util_est(p));
+
 		util = max(util, estimated);
 	}
 
-- 
2.18.0


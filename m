Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D052085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D052085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbeKFAOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:14:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387428AbeKFAOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:14:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E82E015AD;
        Mon,  5 Nov 2018 06:54:25 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3C1B3F5CF;
        Mon,  5 Nov 2018 06:54:23 -0800 (PST)
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
Subject: [PATCH v2 2/3] sched/fair: util_est: mask UTIL_AVG_UNCHANGED usages
Date:   Mon,  5 Nov 2018 14:53:59 +0000
Message-Id: <20181105145400.935-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181105145400.935-1-patrick.bellasi@arm.com>
References: <20181105145400.935-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _task_util_est() is mainly used to add/remove the task contribution
to/from the rq's estimated utilization at task enqueue/dequeue time.
In both cases we ensure the UTIL_AVG_UNCHANGED flag is set to keep
consistency between enqueue and dequeue time while still being
transparent to update_load_avg calls which will eventually reset the
flag.

Let's move the flag forcing within _task_util_est() itself so that we
can simplify calling code by hiding that estimated utilization
implementation detail into one of its internal functions.

This will affect also the "public" API task_util_est() but we know that
the flag will (eventually) impact just on the LSB of the estimated
utilization, thus it's certainly acceptable.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 473a9cc559e8..aeb37fe4dbb1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3604,7 +3604,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
 
-	return max(ue.ewma, ue.enqueued);
+	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -3622,7 +3622,7 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 
 	/* Update root cfs_rq's estimated utilization */
 	enqueued  = cfs_rq->avg.util_est.enqueued;
-	enqueued += (_task_util_est(p) | UTIL_AVG_UNCHANGED);
+	enqueued += _task_util_est(p);
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
 }
 
@@ -3650,8 +3650,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 
 	/* Update root cfs_rq's estimated utilization */
 	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-	ue.enqueued -= min_t(unsigned int, ue.enqueued,
-			     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
+	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
 	/*
@@ -6292,7 +6291,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 		 */
 		if (unlikely(task_on_rq_queued(p) || current == p)) {
 			estimated -= min_t(unsigned int, estimated,
-					   (_task_util_est(p) | UTIL_AVG_UNCHANGED));
+					   _task_util_est(p));
 		}
 		util = max(util, estimated);
 	}
-- 
2.18.0


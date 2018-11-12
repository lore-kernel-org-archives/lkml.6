Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0A121722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0A121722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbeKLPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:55:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:55:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC63Lkf3546957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:03:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC63K493546951;
        Sun, 11 Nov 2018 22:03:20 -0800
Date:   Sun, 11 Nov 2018 22:03:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-92a801e5d5b7a893881c1676b15dd246727ccd16@git.kernel.org>
Cc:     dietmar.eggemann@arm.com, tkjos@google.com, juri.lelli@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        patrick.bellasi@arm.com, mingo@kernel.org, surenb@google.com,
        smuckle@google.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com
Reply-To: smuckle@google.com, vincent.guittot@linaro.org,
          quentin.perret@arm.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, dietmar.eggemann@arm.com, tkjos@google.com,
          juri.lelli@redhat.com, morten.rasmussen@arm.com,
          patrick.bellasi@arm.com, tglx@linutronix.de, surenb@google.com,
          mingo@kernel.org
In-Reply-To: <20181105145400.935-3-patrick.bellasi@arm.com>
References: <20181105145400.935-3-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Mask UTIL_AVG_UNCHANGED usages
Git-Commit-ID: 92a801e5d5b7a893881c1676b15dd246727ccd16
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92a801e5d5b7a893881c1676b15dd246727ccd16
Gitweb:     https://git.kernel.org/tip/92a801e5d5b7a893881c1676b15dd246727ccd16
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Mon, 5 Nov 2018 14:53:59 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 06:17:52 +0100

sched/fair: Mask UTIL_AVG_UNCHANGED usages

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/20181105145400.935-3-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1ccf1ddd37a..28ee60cabba1 100644
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

Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B62C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D420A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbeHWMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbeHWMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:22 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9E1DC5C;
        Thu, 23 Aug 2018 08:52:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 169/324] sched/fair: Fix bandwidth timer clock drift condition
Date:   Thu, 23 Aug 2018 09:53:55 +0200
Message-Id: <20180823075004.638353859@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xunlei Pang <xlpang@linux.alibaba.com>

[ Upstream commit 512ac999d2755d2b7109e996a76b6fb8b888631d ]

I noticed that cgroup task groups constantly get throttled even
if they have low CPU usage, this causes some jitters on the response
time to some of our business containers when enabling CPU quotas.

It's very simple to reproduce:

  mkdir /sys/fs/cgroup/cpu/test
  cd /sys/fs/cgroup/cpu/test
  echo 100000 > cpu.cfs_quota_us
  echo $$ > tasks

then repeat:

  cat cpu.stat | grep nr_throttled  # nr_throttled will increase steadily

After some analysis, we found that cfs_rq::runtime_remaining will
be cleared by expire_cfs_rq_runtime() due to two equal but stale
"cfs_{b|q}->runtime_expires" after period timer is re-armed.

The current condition to judge clock drift in expire_cfs_rq_runtime()
is wrong, the two runtime_expires are actually the same when clock
drift happens, so this condtion can never hit. The orginal design was
correctly done by this commit:

  a9cf55b28610 ("sched: Expire invalid runtime")

... but was changed to be the current implementation due to its locking bug.

This patch introduces another way, it adds a new field in both structures
cfs_rq and cfs_bandwidth to record the expiration update sequence, and
uses them to figure out if clock drift happens (true if they are equal).

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
Link: http://lkml.kernel.org/r/20180620101834.24455-1-xlpang@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c  |   14 ++++++++------
 kernel/sched/sched.h |    6 ++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4549,6 +4549,7 @@ void __refill_cfs_bandwidth_runtime(stru
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4571,6 +4572,7 @@ static int assign_cfs_rq_runtime(struct
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
 	u64 amount = 0, min_amount, expires;
+	int expires_seq;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -4587,6 +4589,7 @@ static int assign_cfs_rq_runtime(struct
 			cfs_b->idle = 0;
 		}
 	}
+	expires_seq = cfs_b->expires_seq;
 	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
@@ -4596,8 +4599,10 @@ static int assign_cfs_rq_runtime(struct
 	 * spread between our sched_clock and the one on which runtime was
 	 * issued.
 	 */
-	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
+	if (cfs_rq->expires_seq != expires_seq) {
+		cfs_rq->expires_seq = expires_seq;
 		cfs_rq->runtime_expires = expires;
+	}
 
 	return cfs_rq->runtime_remaining > 0;
 }
@@ -4623,12 +4628,9 @@ static void expire_cfs_rq_runtime(struct
 	 * has not truly expired.
 	 *
 	 * Fortunately we can check determine whether this the case by checking
-	 * whether the global deadline has advanced. It is valid to compare
-	 * cfs_b->runtime_expires without any locks since we only care about
-	 * exact equality, so a partial write will still work.
+	 * whether the global deadline(cfs_b->expires_seq) has advanced.
 	 */
-
-	if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
+	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
 		/* extend local deadline, drift is bounded above by 2 ticks */
 		cfs_rq->runtime_expires += TICK_NSEC;
 	} else {
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -334,9 +334,10 @@ struct cfs_bandwidth {
 	u64			runtime;
 	s64			hierarchical_quota;
 	u64			runtime_expires;
+	int			expires_seq;
 
-	int			idle;
-	int			period_active;
+	short			idle;
+	short			period_active;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
@@ -551,6 +552,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
+	int			expires_seq;
 	u64			runtime_expires;
 	s64			runtime_remaining;
 



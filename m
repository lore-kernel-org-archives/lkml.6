Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75E420869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75E420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeKLFzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51910 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730720AbeKLFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:35 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsu-0000lK-Kx; Sun, 11 Nov 2018 19:59:04 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001fA-8Q; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Xunlei Pang" <xlpang@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ben Segall" <bsegall@google.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.946269930@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 218/366] sched/fair: Fix bandwidth timer clock drift
 condition
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xunlei Pang <xlpang@linux.alibaba.com>

commit 512ac999d2755d2b7109e996a76b6fb8b888631d upstream.

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
[bwh: Backported to 3.16:
 - Drop changes to other member types in struct cfs_bandwidth
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/sched/fair.c  | 14 ++++++++------
 kernel/sched/sched.h |  6 ++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3143,6 +3143,7 @@ void __refill_cfs_bandwidth_runtime(stru
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -3165,6 +3166,7 @@ static int assign_cfs_rq_runtime(struct
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
 	u64 amount = 0, min_amount, expires;
+	int expires_seq;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -3190,6 +3192,7 @@ static int assign_cfs_rq_runtime(struct
 			cfs_b->idle = 0;
 		}
 	}
+	expires_seq = cfs_b->expires_seq;
 	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
@@ -3199,8 +3202,10 @@ static int assign_cfs_rq_runtime(struct
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
@@ -3226,12 +3231,9 @@ static void expire_cfs_rq_runtime(struct
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
@@ -186,6 +186,7 @@ struct cfs_bandwidth {
 	u64 quota, runtime;
 	s64 hierarchal_quota;
 	u64 runtime_expires;
+	int expires_seq;
 
 	int idle, timer_active;
 	struct hrtimer period_timer, slack_timer;
@@ -375,6 +376,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int runtime_enabled;
+	int expires_seq;
 	u64 runtime_expires;
 	s64 runtime_remaining;
 


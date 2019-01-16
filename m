Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F641C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EED020868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GH8bSZNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfAPTwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:52:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:3575 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1547668338; x=1579204338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gnVmayem9rEUqt10OEJCKuSodmD9It35lu8lKUZkShY=;
  b=GH8bSZNyOur+I4ER5VK3f6O5qWnqanX/vDugYlB1gZTvmfgcvkEncY7W
   7UZK0iy/w5v/xeu3QmFdMEb4BmzU+Ev8g48jhYZu6lIB9z8KOirNIY5wj
   TC+GTo14/CeCjyHQXfdM7hI56jJMrRWi6+7W7oKwR/H9xPTWb1Qki3pdk
   4=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="713144239"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 19:52:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0GJqDWW047994
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 16 Jan 2019 19:52:15 GMT
Received: from EX13D17UWC003.ant.amazon.com (10.43.162.206) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 16 Jan 2019 19:52:14 +0000
Received: from dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com
 (10.43.160.211) by EX13D17UWC003.ant.amazon.com (10.43.162.206) with
 Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Jan 2019 19:52:14 +0000
Date:   Wed, 16 Jan 2019 19:52:08 +0000
From:   Alakesh Haloi <alakeshh@amazon.com>
To:     <stable@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH] sched/fair: Fix bandwidth timer clock drift condition
Message-ID: <20190116195202.GA89178@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
 EX13D17UWC003.ant.amazon.com (10.43.162.206)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
[alakeshh: backport: Fixed merge conflicts:
 - sched.h: Fix the indentation and order in which the variables are
   declared to match with coding style of the existing code in 4.14
   Struct members of same type were declared in separate lines in
   upstream patch which has been changed back to having multiple
   members of same type in the same line.
   e.g. int a; int b; ->  int a, b; ]
Signed-off-by: Alakesh Haloi <alakeshh@amazon.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
Link: http://lkml.kernel.org/r/20180620101834.24455-1-xlpang@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 14 ++++++++------
 kernel/sched/sched.h |  4 +++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7240bb4a4090..e03fb6b2eb94 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4088,6 +4088,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4110,6 +4111,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
 	u64 amount = 0, min_amount, expires;
+	int expires_seq;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -4126,6 +4128,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 			cfs_b->idle = 0;
 		}
 	}
+	expires_seq = cfs_b->expires_seq;
 	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
@@ -4135,8 +4138,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
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
@@ -4162,12 +4167,9 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3ba6e5e99f2..452b56923c6d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -281,8 +281,9 @@ struct cfs_bandwidth {
 	u64 quota, runtime;
 	s64 hierarchical_quota;
 	u64 runtime_expires;
+	int expires_seq;
 
-	int idle, period_active;
+	short idle, period_active;
 	struct hrtimer period_timer, slack_timer;
 	struct list_head throttled_cfs_rq;
 
@@ -488,6 +489,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int runtime_enabled;
+	int expires_seq;
 	u64 runtime_expires;
 	s64 runtime_remaining;
 
-- 
2.14.4


Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94524C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D94524C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeGCHvD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:51:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbeGCHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:51:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637oc8P201864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:50:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637ocdL201861;
        Tue, 3 Jul 2018 00:50:38 -0700
Date:   Tue, 3 Jul 2018 00:50:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xunlei Pang <tipbot@zytor.com>
Message-ID: <tip-f1d1be8aee6c461652aea8f58bedebaa73d7f4d3@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, bsegall@google.com,
        xlpang@linux.alibaba.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          xlpang@linux.alibaba.com, bsegall@google.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de
In-Reply-To: <20180620101834.24455-2-xlpang@linux.alibaba.com>
References: <20180620101834.24455-2-xlpang@linux.alibaba.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Advance global expiration when period
 timer is restarted
Git-Commit-ID: f1d1be8aee6c461652aea8f58bedebaa73d7f4d3
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

Commit-ID:  f1d1be8aee6c461652aea8f58bedebaa73d7f4d3
Gitweb:     https://git.kernel.org/tip/f1d1be8aee6c461652aea8f58bedebaa73d7f4d3
Author:     Xunlei Pang <xlpang@linux.alibaba.com>
AuthorDate: Wed, 20 Jun 2018 18:18:34 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:17:29 +0200

sched/fair: Advance global expiration when period timer is restarted

When period gets restarted after some idle time, start_cfs_bandwidth()
doesn't update the expiration information, expire_cfs_rq_runtime() will
see cfs_rq->runtime_expires smaller than rq clock and go to the clock
drift logic, wasting needless CPU cycles on the scheduler hot path.

Update the global expiration in start_cfs_bandwidth() to avoid frequent
expire_cfs_rq_runtime() calls once a new period begins.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180620101834.24455-2-xlpang@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 791707c56886..840b92ee6f89 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
+	u64 overrun;
+
 	lockdep_assert_held(&cfs_b->lock);
 
-	if (!cfs_b->period_active) {
-		cfs_b->period_active = 1;
-		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
-	}
+	if (cfs_b->period_active)
+		return;
+
+	cfs_b->period_active = 1;
+	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
+	cfs_b->expires_seq++;
+	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)

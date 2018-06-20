Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CBC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24D320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24D320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeFTKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:18:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42057 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752747AbeFTKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:18:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T32GEb7_1529489915;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T32GEb7_1529489915)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jun 2018 18:18:35 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] sched/fair: Advance global expiration when period timer is restarted
Date:   Wed, 20 Jun 2018 18:18:34 +0800
Message-Id: <20180620101834.24455-2-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
In-Reply-To: <20180620101834.24455-1-xlpang@linux.alibaba.com>
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When period gets restarted after some idle time, start_cfs_bandwidth()
doesn't update the expiration information, expire_cfs_rq_runtime() will
see cfs_rq->runtime_expires smaller than rq clock and go to the clock
drift logic, wasting needless cpu cycles on the scheduler hot path.

Update the global expiration in start_cfs_bandwidth() to avoid frequent
expire_cfs_rq_runtime() calls once a new period begins.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 kernel/sched/fair.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e6bb68d52962..f167aca066cc 100644
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
-- 
2.14.1.40.g8e62ba1


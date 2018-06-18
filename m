Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56EFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69810208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69810208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966877AbeFRJRV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:17:21 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48949 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966608AbeFRJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:17:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T2wsk0g_1529313417;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T2wsk0g_1529313417)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jun 2018 17:17:05 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/fair: Advance global expiration when period timer is restarted
Date:   Mon, 18 Jun 2018 17:16:57 +0800
Message-Id: <20180618091657.21939-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the group frequently got throttled even it consumed
low cpu usage, this caused some jitters on the response time
to some of our business containers enabling cpu quota.

It's very easy to reproduce:
mkdir /sys/fs/cgroup/cpu/test
cd /sys/fs/cgroup/cpu/test
echo 100000 > cpu.cfs_quota_us
echo $$ > tasks
then repeat:
cat cpu.stat |grep nr_throttled  // nr_throttled will increase

After some analysis, we found that cfs_rq::runtime_remaining will
be cleared by expire_cfs_rq_runtime() due to two equal but stale
"cfs_{b|q}->runtime_expires" after period timer is re-armed.

The global expiration should be advanced accordingly when the
bandwidth period timer is restarted.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 kernel/sched/fair.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f384264e832..bb006e671609 100644
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


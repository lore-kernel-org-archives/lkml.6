Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B349276AF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B349276AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935685AbeF1Ql0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:41:26 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41500 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935628AbeF1QlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:41:11 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGa0BZ014758;
        Thu, 28 Jun 2018 11:40:52 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2jvdqwun5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 11:40:52 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod2.natinst.com (8.16.0.22/8.16.0.22) with ESMTPS id w5SGepDv018133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 11:40:51 -0500
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 28 Jun 2018 11:40:51 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 28 Jun 2018 11:40:51 -0500
Received: from harisdt.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Thu, 28 Jun 2018 11:40:51 -0500
From:   Haris Okanovic <haris.okanovic@ni.com>
To:     <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <haris.okanovic@ni.com>, <harisokn@gmail.com>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>,
        <anna-maria@linutronix.de>, <daniel@bristot.me>, <efault@gmx.de>
Subject: [PATCH v5 2/2] timers: Don't search for expired timers while TIMER_SOFTIRQ is scheduled
Date:   Thu, 28 Jun 2018 11:40:36 -0500
Message-ID: <20180628164036.27378-2-haris.okanovic@ni.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628164036.27378-1-haris.okanovic@ni.com>
References: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
 <20180628164036.27378-1-haris.okanovic@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change avoids needlessly searching for more timers in
run_local_timers() (hard interrupt context) when they can't fire.
For example, when ktimersoftd/run_timer_softirq() is scheduled but
preempted due to cpu contention. When it runs, run_timer_softirq() will
discover newly expired timers up to current jiffies in addition to
firing previously expired timers.

However, this change also adds an edge case where non-hrtimer firing
is sometimes delayed by an additional tick. This is acceptable since we
don't make latency guarantees for non-hrtimers and would prefer to
minimize hard interrupt time instead.

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
---
[PATCH v3]
 - Split block_softirq into separate commit
[PATCH v4]
 - Rebase onto v4.14.20-rt17
[PATCH v5]
   no change

https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v7
---
 kernel/time/timer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dd67c18c16d0..723c3667de2b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -207,6 +207,7 @@ struct timer_base {
 	unsigned int		cpu;
 	bool			is_idle;
 	bool			must_forward_clk;
+	bool			block_softirq;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 	struct hlist_head	expired_lists[LVL_DEPTH];
@@ -1404,9 +1405,11 @@ static int __collect_expired_timers(struct timer_base *base)
 
 	/*
 	 * expire_timers() must be called at least once before we can
-	 * collect more timers.
+	 * collect more timers. We should never hit this case unless
+	 * TIMER_SOFTIRQ got raised without expired timers.
 	 */
-	if (base->expired_levels)
+	if (WARN_ONCE(base->expired_levels,
+			"Must expire collected timers before collecting more"))
 		return base->expired_levels;
 
 	clk = base->clk;
@@ -1748,6 +1751,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+
+	/* Allow new TIMER_SOFTIRQs to get scheduled by run_local_timers() */
+	base->block_softirq = false;
 }
 
 /*
@@ -1758,6 +1764,14 @@ void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
+
+	/*
+	 * Skip if TIMER_SOFTIRQ is already running on this CPU, since it
+	 * will find and expire all timers up to current jiffies.
+	 */
+	if (base->block_softirq)
+		return;
+
 	/* Raise the softirq only if required. */
 	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
@@ -1766,7 +1780,10 @@ void run_local_timers(void)
 		base++;
 		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
 			return;
+		base--;
 	}
+
+	base->block_softirq = true;
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
-- 
2.17.1


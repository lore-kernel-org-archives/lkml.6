Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB606C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629542083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629542083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeGZKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:04:14 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:50994 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728827AbeGZKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:04:14 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 06:04:12 EDT
X-IronPort-AV: E=Sophos;i="5.51,404,1526322600"; 
   d="scan'208";a="113498"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Jul 2018 14:12:05 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8965"; a="661274"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg02-blr.qualcomm.com with ESMTP; 26 Jul 2018 14:12:05 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id 8754A3092; Thu, 26 Jul 2018 14:12:04 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH] timers: Clear must_forward_clk inside base lock
Date:   Thu, 26 Jul 2018 14:12:02 +0530
Message-Id: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While migrating timer to new base, there is a need
to update base clk by calling forward_timer_base to
avoid stale clock , but at the same time if run_timer
is exectuing in new core it may set must_forward_clk
to false and due to this forward base logic may fail as
per below check:

if (likely(!base->must_forward_clk))
                return;

So preventing the same by putting must_forward_clk inside
base lock.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e..675241d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1657,6 +1657,19 @@ static inline void __run_timers(struct timer_base *base)
 
 	raw_spin_lock_irq(&base->lock);
 
+	/*
+	 * must_forward_clk must be cleared before running timers so that any
+	 * timer functions that call mod_timer will not try to forward the
+	 * base. idle trcking / clock forwarding logic is only used with
+	 * BASE_STD timers.
+	 *
+	 * The deferrable base does not do idle tracking at all, so we do
+	 * not forward it. This can result in very large variations in
+	 * granularity for deferrable timers, but they can be deferred for
+	 * long periods due to idle.
+	 */
+	base->must_forward_clk = false;
+
 	while (time_after_eq(jiffies, base->clk)) {
 
 		levels = collect_expired_timers(base, heads);
@@ -1676,19 +1689,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
-	/*
-	 * must_forward_clk must be cleared before running timers so that any
-	 * timer functions that call mod_timer will not try to forward the
-	 * base. idle trcking / clock forwarding logic is only used with
-	 * BASE_STD timers.
-	 *
-	 * The deferrable base does not do idle tracking at all, so we do
-	 * not forward it. This can result in very large variations in
-	 * granularity for deferrable timers, but they can be deferred for
-	 * long periods due to idle.
-	 */
-	base->must_forward_clk = false;
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-- 
1.9.1


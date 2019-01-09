Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BA72173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAIXTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:19:48 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:35514 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:19:48 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994074AbfAIXTpoBnBl (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Thu, 10 Jan 2019 00:19:45 +0100
Date:   Thu, 10 Jan 2019 00:19:44 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] PM/runtime: Fix 'jiffies' in comments after move to
 hrtimers
Message-ID: <20190109231944.GA21177@lenoch>
References: <20190109172336.GA1711@lenoch>
 <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM-runtime now uses the hrtimers infrastructure for autosuspend, however
comments still reference 'jiffies'.

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: Reword comment accoring to Rafael's suggestion

 drivers/base/power/runtime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 70624695b6d5..a282e74d1a16 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
  * Compute the autosuspend-delay expiration time based on the device's
  * power.last_busy time.  If the delay has already expired or is disabled
  * (negative) or the power.use_autosuspend flag isn't set, return 0.
- * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
+ * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
  *
  * This function may be called either with or without dev->power.lock held.
  * Either way it can be racy, since power.last_busy may be updated at any time.
@@ -905,7 +905,10 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	expires = dev->power.timer_expires;
-	/* If 'expire' is after 'jiffies' we've been called too early. */
+	/*
+	 * If 'expires' is after the current time, we've been called
+	 * too early.
+	 */
 	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
-- 
2.20.1


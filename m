Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38FB20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbfA3VkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:40:22 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:49372 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3VkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:40:21 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992792AbfA3VkSjTYCh (ORCPT
        <rfc822;linux-renesas-soc@vger.kernel.org> + 3 others);
        Wed, 30 Jan 2019 22:40:18 +0100
Date:   Wed, 30 Jan 2019 22:40:17 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM/runtime: Optimize pm_runtime_autosuspend_expiration()
Message-ID: <20190130214017.GA5038@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_autosuspend_expiration calls ktime_get_mono_fast_ns
even when its returned value may be unused. Therefore get
current time later and remove gotos while there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 This patch is based on top of bleeding-edge branch, where
 "[PATCH v2 ] PM-runtime: fix deadlock with ktime" is sitting.
 I expect v3 of that patch, which should not harm this one.
 It is meant to replace "PM/runtime: Do not needlessly call ktime_get"
 sent earlier.

 drivers/base/power/runtime.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 65e2b5f48e0c..7bbe28faca8d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -145,24 +145,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
 u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
-	u64 last_busy, expires = 0;
-	u64 now = ktime_get_mono_fast_ns();
+	u64 expires;
 
 	if (!dev->power.use_autosuspend)
-		goto out;
+		return 0;
 
 	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
 	if (autosuspend_delay < 0)
-		goto out;
-
-	last_busy = READ_ONCE(dev->power.last_busy);
+		return 0;
 
-	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
-	if (expires <= now)
-		expires = 0;	/* Already expired. */
+	expires  = READ_ONCE(dev->power.last_busy);
+	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
+	if (expires > ktime_get_mono_fast_ns())
+		return expires;	/* Expires in the future */
 
- out:
-	return expires;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
 
-- 
2.20.1


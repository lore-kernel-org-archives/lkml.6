Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FBC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7C920989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7C920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeKUDuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:21 -0500
Received: from anholt.net ([50.246.234.109]:50686 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbeKUDuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D1A0810A0B73;
        Tue, 20 Nov 2018 09:20:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id U9zRuxXkSd8t; Tue, 20 Nov 2018 09:20:05 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 53A8B10A15B1;
        Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 14F862FE1FE9; Tue, 20 Nov 2018 09:20:00 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/8] soc: bcm: bcm2835-pm: Stop using _relaxed mmio accessors.
Date:   Tue, 20 Nov 2018 09:19:55 -0800
Message-Id: <20181120172000.15102-4-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We definitely don't want I/O to be reordered here (like the setting of
the WDT timeout before enabling the WDT).  None of this is performance
critical, anyway.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/soc/bcm/bcm2835-pm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-pm.c b/drivers/soc/bcm/bcm2835-pm.c
index ca37145e4e40..decc316fbe40 100644
--- a/drivers/soc/bcm/bcm2835-pm.c
+++ b/drivers/soc/bcm/bcm2835-pm.c
@@ -67,11 +67,11 @@ static int bcm2835_wdt_start(struct watchdog_device *wdog)
 
 	spin_lock_irqsave(&pm->lock, flags);
 
-	writel_relaxed(PM_PASSWORD | (SECS_TO_WDOG_TICKS(wdog->timeout) &
-				PM_WDOG_TIME_SET), pm->base + PM_WDOG);
-	cur = readl_relaxed(pm->base + PM_RSTC);
-	writel_relaxed(PM_PASSWORD | (cur & PM_RSTC_WRCFG_CLR) |
-		  PM_RSTC_WRCFG_FULL_RESET, pm->base + PM_RSTC);
+	writel(PM_PASSWORD | (SECS_TO_WDOG_TICKS(wdog->timeout) &
+			      PM_WDOG_TIME_SET), pm->base + PM_WDOG);
+	cur = readl(pm->base + PM_RSTC);
+	writel(PM_PASSWORD | (cur & PM_RSTC_WRCFG_CLR) |
+	       PM_RSTC_WRCFG_FULL_RESET, pm->base + PM_RSTC);
 
 	spin_unlock_irqrestore(&pm->lock, flags);
 
@@ -82,7 +82,7 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 {
 	struct bcm2835_pm *pm = watchdog_get_drvdata(wdog);
 
-	writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, pm->base + PM_RSTC);
+	writel(PM_PASSWORD | PM_RSTC_RESET, pm->base + PM_RSTC);
 	return 0;
 }
 
@@ -90,7 +90,7 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 {
 	struct bcm2835_pm *pm = watchdog_get_drvdata(wdog);
 
-	uint32_t ret = readl_relaxed(pm->base + PM_WDOG);
+	uint32_t ret = readl(pm->base + PM_WDOG);
 	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
 }
 
@@ -99,11 +99,11 @@ static void __bcm2835_restart(struct bcm2835_pm *pm)
 	u32 val;
 
 	/* use a timeout of 10 ticks (~150us) */
-	writel_relaxed(10 | PM_PASSWORD, pm->base + PM_WDOG);
-	val = readl_relaxed(pm->base + PM_RSTC);
+	writel(10 | PM_PASSWORD, pm->base + PM_WDOG);
+	val = readl(pm->base + PM_RSTC);
 	val &= PM_RSTC_WRCFG_CLR;
 	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
-	writel_relaxed(val, pm->base + PM_RSTC);
+	writel(val, pm->base + PM_RSTC);
 
 	/* No sleeping, possibly atomic. */
 	mdelay(1);
@@ -159,9 +159,9 @@ static void bcm2835_power_off(void)
 	 * from the normal (full) reset. bootcode.bin will not reboot after a
 	 * hard reset.
 	 */
-	val = readl_relaxed(pm->base + PM_RSTS);
+	val = readl(pm->base + PM_RSTS);
 	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
-	writel_relaxed(val, pm->base + PM_RSTS);
+	writel(val, pm->base + PM_RSTS);
 
 	/* Continue with normal reset mechanism */
 	__bcm2835_restart(pm);
-- 
2.19.1


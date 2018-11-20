Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF0C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C4208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341C4208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeKUDuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:19 -0500
Received: from anholt.net ([50.246.234.109]:50648 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbeKUDuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B989310A15F5;
        Tue, 20 Nov 2018 09:20:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Me05flsQgnvf; Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1B0B910A0396;
        Tue, 20 Nov 2018 09:20:01 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 197242FE1FEA; Tue, 20 Nov 2018 09:20:00 -0800 (PST)
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
Subject: [PATCH 4/8] soc: bcm: bcm2835-pm: Make some little accessor macros for the mmio area.
Date:   Tue, 20 Nov 2018 09:19:56 -0800
Message-Id: <20181120172000.15102-5-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is more legible than trying to remember to set PM_PASSWORD on
everything.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/soc/bcm/bcm2835-pm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-pm.c b/drivers/soc/bcm/bcm2835-pm.c
index decc316fbe40..e504381556cf 100644
--- a/drivers/soc/bcm/bcm2835-pm.c
+++ b/drivers/soc/bcm/bcm2835-pm.c
@@ -32,6 +32,9 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTC_RESET			0x00000102
 
+#define PM_READ(reg) readl(pm->base + (reg))
+#define PM_WRITE(reg, val) writel(PM_PASSWORD | (val), pm->base + (reg))
+
 /*
  * The Raspberry Pi firmware uses the RSTS register to know which partition
  * to boot from. The partition value is spread into bits 0, 2, 4, 6, 8, 10.
@@ -54,7 +57,7 @@ static bool bcm2835_wdt_is_running(struct bcm2835_pm *pm)
 {
 	uint32_t cur;
 
-	cur = readl(pm->base + PM_RSTC);
+	cur = PM_READ(PM_RSTC);
 
 	return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
 }
@@ -67,11 +70,9 @@ static int bcm2835_wdt_start(struct watchdog_device *wdog)
 
 	spin_lock_irqsave(&pm->lock, flags);
 
-	writel(PM_PASSWORD | (SECS_TO_WDOG_TICKS(wdog->timeout) &
-			      PM_WDOG_TIME_SET), pm->base + PM_WDOG);
-	cur = readl(pm->base + PM_RSTC);
-	writel(PM_PASSWORD | (cur & PM_RSTC_WRCFG_CLR) |
-	       PM_RSTC_WRCFG_FULL_RESET, pm->base + PM_RSTC);
+	PM_WRITE(PM_WDOG, SECS_TO_WDOG_TICKS(wdog->timeout) & PM_WDOG_TIME_SET);
+	cur = PM_READ(PM_RSTC);
+	PM_WRITE(PM_RSTC, (cur & PM_RSTC_WRCFG_CLR) | PM_RSTC_WRCFG_FULL_RESET);
 
 	spin_unlock_irqrestore(&pm->lock, flags);
 
@@ -82,7 +83,7 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 {
 	struct bcm2835_pm *pm = watchdog_get_drvdata(wdog);
 
-	writel(PM_PASSWORD | PM_RSTC_RESET, pm->base + PM_RSTC);
+	PM_WRITE(PM_RSTC, PM_RSTC_RESET);
 	return 0;
 }
 
@@ -90,7 +91,7 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 {
 	struct bcm2835_pm *pm = watchdog_get_drvdata(wdog);
 
-	uint32_t ret = readl(pm->base + PM_WDOG);
+	uint32_t ret = PM_READ(PM_WDOG);
 	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
 }
 
@@ -100,7 +101,7 @@ static void __bcm2835_restart(struct bcm2835_pm *pm)
 
 	/* use a timeout of 10 ticks (~150us) */
 	writel(10 | PM_PASSWORD, pm->base + PM_WDOG);
-	val = readl(pm->base + PM_RSTC);
+	val = PM_READ(PM_RSTC);
 	val &= PM_RSTC_WRCFG_CLR;
 	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
 	writel(val, pm->base + PM_RSTC);
@@ -159,7 +160,7 @@ static void bcm2835_power_off(void)
 	 * from the normal (full) reset. bootcode.bin will not reboot after a
 	 * hard reset.
 	 */
-	val = readl(pm->base + PM_RSTS);
+	val = PM_READ(PM_RSTS);
 	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
 	writel(val, pm->base + PM_RSTS);
 
-- 
2.19.1


Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8782CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ECF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ECF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeH3PwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:20 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8629 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeH3PwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:19 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="19080216"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/6] power: reset: at91-poweroff: use only one poweroff function
Date:   Thu, 30 Aug 2018 14:50:07 +0300
Message-ID: <1535629811-13403-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use only one poweroff function for sama5d2 and adapt it to work for both
scenarios (having LPDDR or not).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index dd6297bd7b6a..94ad79d0d82e 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -110,18 +110,6 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 
 static void at91_poweroff(void)
 {
-	/* Switch the master clock source to slow clock. */
-	writel(readl(at91_shdwc->pmc_base + AT91_PMC_MCKR) & ~AT91_PMC_CSS,
-	       at91_shdwc->pmc_base + AT91_PMC_MCKR);
-	while (!(readl(at91_shdwc->pmc_base + AT91_PMC_SR) & AT91_PMC_MCKRDY))
-		;
-
-	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
-	       at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
-}
-
-static void at91_lpddr_poweroff(void)
-{
 	asm volatile(
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -130,16 +118,18 @@ static void at91_lpddr_poweroff(void)
 		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
 
 		/* Power down SDRAM0 */
+		"	tst	%0, #0\n\t"
+		"	beq	1f\n\t"
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 
 		/* Switch the master clock source to slow clock. */
-		"	ldr	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
+		"1:	ldr	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
 		"	bic	r6, r6,  #" __stringify(AT91_PMC_CSS) "\n\t"
 		"	str	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
 		/* Wait for clock switch. */
-		"1:	ldr	r6, [%4, #" __stringify(AT91_PMC_SR) "]\n\t"
+		"2:	ldr	r6, [%4, #" __stringify(AT91_PMC_SR) "]\n\t"
 		"	tst	r6, #"	    __stringify(AT91_PMC_MCKRDY) "\n\t"
-		"	beq	1b\n\t"
+		"	beq	2b\n\t"
 
 		/* Shutdown CPU */
 		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
@@ -326,10 +316,8 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	pm_power_off = at91_poweroff;
 
 	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
-	if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
-	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3)) {
-		pm_power_off = at91_lpddr_poweroff;
-	} else {
+	if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
+	    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
 		iounmap(mpddrc_base);
 		mpddrc_base = NULL;
 	}
@@ -348,8 +336,7 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 
-	if (pm_power_off == at91_poweroff ||
-	    pm_power_off == at91_lpddr_poweroff)
+	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
 
 	/* Reset values to disable wake-up features  */
-- 
2.7.4


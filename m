Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A71C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9973C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9973C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeH3PwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:17 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8629 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeH3PwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:16 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="19080214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/6] power: reset: at91-poweroff: switch to slow clock before shutdown
Date:   Thu, 30 Aug 2018 14:50:06 +0300
Message-ID: <1535629811-13403-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAMA5D2 NRST input signal is resynchronized with the SLCK clock and it
can take up to 2 SLCK cycles (about 90us) for the internal reset to be
effective. During this delay, the VDDCORE current consumption may still be
high (application-dependent) with the VDDCORE regulator already OFF. Under
such conditions, VDDCORE may operate below its operating range leading to
potential register corruption.

To prevent such situation, it is recommended to decrease significantly the
power consumption of the device once the voltage regulator is  turned-off.
This can be achieved by operating the device at a much lower low frequency.

To solve this switch the master clock to slock clock just before writing
shutdown command to shutdown controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Suggested-by: Patrice Vilchez <patrice.vilchez@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S          |  8 ++++
 drivers/power/reset/at91-sama5d2_shdwc.c | 66 ++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index a7c6ae13c945..bfe1c4d06901 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -149,6 +149,14 @@ exit_suspend:
 ENDPROC(at91_pm_suspend_in_sram)
 
 ENTRY(at91_backup_mode)
+	/* Switch the master clock source to slow clock. */
+	ldr	pmc, .pmc_base
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
 	/*BUMEN*/
 	ldr	r0, .sfr
 	mov	tmp1, #0x1
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 0206cce328b3..dd6297bd7b6a 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/at91_pmc.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -70,6 +71,7 @@ struct shdwc_config {
 struct shdwc {
 	const struct shdwc_config *cfg;
 	void __iomem *at91_shdwc_base;
+	void __iomem *pmc_base;
 };
 
 /*
@@ -108,6 +110,12 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 
 static void at91_poweroff(void)
 {
+	/* Switch the master clock source to slow clock. */
+	writel(readl(at91_shdwc->pmc_base + AT91_PMC_MCKR) & ~AT91_PMC_CSS,
+	       at91_shdwc->pmc_base + AT91_PMC_MCKR);
+	while (!(readl(at91_shdwc->pmc_base + AT91_PMC_SR) & AT91_PMC_MCKRDY))
+		;
+
 	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
 	       at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
 }
@@ -123,6 +131,16 @@ static void at91_lpddr_poweroff(void)
 
 		/* Power down SDRAM0 */
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
+
+		/* Switch the master clock source to slow clock. */
+		"	ldr	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
+		"	bic	r6, r6,  #" __stringify(AT91_PMC_CSS) "\n\t"
+		"	str	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
+		/* Wait for clock switch. */
+		"1:	ldr	r6, [%4, #" __stringify(AT91_PMC_SR) "]\n\t"
+		"	tst	r6, #"	    __stringify(AT91_PMC_MCKRDY) "\n\t"
+		"	beq	1b\n\t"
+
 		/* Shutdown CPU */
 		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
 
@@ -131,7 +149,8 @@ static void at91_lpddr_poweroff(void)
 		: "r" (mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->at91_shdwc_base),
-		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
+		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
+		  "r" (at91_shdwc->pmc_base)
 		: "r6");
 }
 
@@ -276,26 +295,53 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
 	at91_shdwc_dt_configure(pdev);
 
-	pm_power_off = at91_poweroff;
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-pmc");
+	if (!np) {
+		ret = -ENODEV;
+		goto clk_disable;
+	}
+
+	at91_shdwc->pmc_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!at91_shdwc->pmc_base) {
+		ret = -ENOMEM;
+		goto clk_disable;
+	}
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
-	if (!np)
-		return 0;
+	if (!np) {
+		ret = -ENODEV;
+		goto unmap;
+	}
 
 	mpddrc_base = of_iomap(np, 0);
 	of_node_put(np);
 
-	if (!mpddrc_base)
-		return 0;
+	if (!mpddrc_base) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	pm_power_off = at91_poweroff;
 
 	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
 	if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
-	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
+	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3)) {
 		pm_power_off = at91_lpddr_poweroff;
-	else
+	} else {
 		iounmap(mpddrc_base);
+		mpddrc_base = NULL;
+	}
 
 	return 0;
+
+unmap:
+	iounmap(at91_shdwc->pmc_base);
+clk_disable:
+	clk_disable_unprepare(sclk);
+
+	return ret;
 }
 
 static int __exit at91_shdwc_remove(struct platform_device *pdev)
@@ -310,6 +356,10 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
 
+	if (mpddrc_base)
+		iounmap(mpddrc_base);
+	iounmap(shdw->pmc_base);
+
 	clk_disable_unprepare(sclk);
 
 	return 0;
-- 
2.7.4


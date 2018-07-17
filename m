Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E9120C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E9120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeGQI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:58:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:47548 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbeGQI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:58:53 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="14237673"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 01:27:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 01:27:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] ARM: at91: pm: configure wakeup sources for ULP1 mode
Date:   Tue, 17 Jul 2018 11:26:57 +0300
Message-ID: <1531816017-31986-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for ULP1 PM mode of SAMA5D2 the wakeup sources are limited and
well known add a method to check if these wakeup sources are defined by
user (either via DT or filesystem). In case there are no wakeup sources
defined for ULP1 the PM suspend will fail, otherwise these will be
configured in fast startup registers of PMC. Since wakeup sources of
ULP1 need also to be configured in SHDWC registers the code was a bit
changed to map the SHDWC also in case ULP1 is requested by user (this
was done in the initialization phase). In case the ULP1 initialization
fails the ULP0 mode is used (this mode was also used in case backup mode
initialization failed).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 165 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 143 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 099d8094018c..c8ef696b83b6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -80,6 +80,87 @@ static struct at91_pm_bu {
 	phys_addr_t resume;
 } *pm_bu;
 
+struct wakeup_source_info {
+	unsigned int pmc_fsmr_bit;
+	unsigned int shdwc_mr_bit;
+	bool set_polarity;
+};
+
+static const struct wakeup_source_info ws_info[] = {
+	{ .pmc_fsmr_bit = AT91_PMC_FSTT(10),	.set_polarity = true },
+	{ .pmc_fsmr_bit = AT91_PMC_RTCAL,	.shdwc_mr_bit = BIT(17) },
+	{ .pmc_fsmr_bit = AT91_PMC_USBAL },
+	{ .pmc_fsmr_bit = AT91_PMC_SDMMC_CD },
+};
+
+static const struct of_device_id sama5d2_ws_ids[] = {
+	{ .compatible = "atmel,sama5d2-gem",		.data = &ws_info[0] },
+	{ .compatible = "atmel,at91rm9200-rtc",		.data = &ws_info[1] },
+	{ .compatible = "atmel,sama5d3-udc",		.data = &ws_info[2] },
+	{ .compatible = "atmel,at91rm9200-ohci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
+	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
+	{ .compatible = "atmel,sama5d2-sdhci",		.data = &ws_info[3] },
+	{ /* sentinel */ }
+};
+
+static int at91_pm_config_ws(unsigned int pm_mode, bool set)
+{
+	const struct wakeup_source_info *wsi;
+	const struct of_device_id *match;
+	struct platform_device *pdev;
+	struct device_node *np;
+	unsigned int mode = 0, polarity = 0, val = 0;
+
+	if (pm_mode != AT91_PM_ULP1)
+		return 0;
+
+	if (!pm_data.pmc || !pm_data.shdwc)
+		return -EPERM;
+
+	if (!set) {
+		writel(mode, pm_data.pmc + AT91_PMC_FSMR);
+		return 0;
+	}
+
+	/* SHDWC.WUIR */
+	val = readl(pm_data.shdwc + 0x0c);
+	mode |= (val & 0x3ff);
+	polarity |= ((val >> 16) & 0x3ff);
+
+	/* SHDWC.MR */
+	val = readl(pm_data.shdwc + 0x04);
+
+	/* Loop through defined wakeup sources. */
+	for_each_matching_node_and_match(np, sama5d2_ws_ids, &match) {
+		pdev = of_find_device_by_node(np);
+		if (!pdev)
+			continue;
+
+		if (device_may_wakeup(&pdev->dev)) {
+			wsi = match->data;
+
+			/* Check if enabled on SHDWC. */
+			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
+				continue;
+
+			mode |= wsi->pmc_fsmr_bit;
+			if (wsi->set_polarity)
+				polarity |= wsi->pmc_fsmr_bit;
+		}
+	}
+
+	if (mode) {
+		writel(mode, pm_data.pmc + AT91_PMC_FSMR);
+		writel(polarity, pm_data.pmc + AT91_PMC_FSPR);
+	} else {
+		pr_err("AT91: PM: no ULP1 wakeup sources found!");
+	}
+
+	return mode ? 0 : -EPERM;
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -98,7 +179,7 @@ static int at91_pm_begin(suspend_state_t state)
 		pm_data.mode = -1;
 	}
 
-	return 0;
+	return at91_pm_config_ws(pm_data.mode, true);
 }
 
 /*
@@ -234,6 +315,7 @@ static int at91_pm_enter(suspend_state_t state)
  */
 static void at91_pm_end(void)
 {
+	at91_pm_config_ws(pm_data.mode, false);
 }
 
 
@@ -479,31 +561,28 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
-static void __init at91_pm_backup_init(void)
+static bool __init at91_is_pm_mode_active(int pm_mode)
+{
+	return (pm_data.standby_mode == pm_mode ||
+		pm_data.suspend_mode == pm_mode);
+}
+
+static int __init at91_pm_backup_init(void)
 {
 	struct gen_pool *sram_pool;
 	struct device_node *np;
 	struct platform_device *pdev = NULL;
+	int ret = -ENODEV;
 
-	if ((pm_data.standby_mode != AT91_PM_BACKUP) &&
-	    (pm_data.suspend_mode != AT91_PM_BACKUP))
-		return;
+	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
+		return 0;
 
 	pm_bu = NULL;
 
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-shdwc");
-	if (!np) {
-		pr_warn("%s: failed to find shdwc!\n", __func__);
-		return;
-	}
-
-	pm_data.shdwc = of_iomap(np, 0);
-	of_node_put(np);
-
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
 	if (!np) {
 		pr_warn("%s: failed to find sfrbu!\n", __func__);
-		goto sfrbu_fail;
+		return ret;
 	}
 
 	pm_data.sfrbu = of_iomap(np, 0);
@@ -530,6 +609,7 @@ static void __init at91_pm_backup_init(void)
 	pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
 	if (!pm_bu) {
 		pr_warn("%s: unable to alloc securam!\n", __func__);
+		ret = -ENOMEM;
 		goto securam_fail;
 	}
 
@@ -537,21 +617,62 @@ static void __init at91_pm_backup_init(void)
 	pm_bu->canary = __pa_symbol(&canary);
 	pm_bu->resume = __pa_symbol(cpu_resume);
 
-	return;
+	return 0;
 
-sfrbu_fail:
-	iounmap(pm_data.shdwc);
-	pm_data.shdwc = NULL;
 securam_fail:
 	iounmap(pm_data.sfrbu);
 	pm_data.sfrbu = NULL;
+	return ret;
+}
 
-	if (pm_data.standby_mode == AT91_PM_BACKUP)
+static void __init at91_pm_use_default_mode(int pm_mode)
+{
+	if (pm_mode != AT91_PM_ULP1 && pm_mode != AT91_PM_BACKUP)
+		return;
+
+	if (pm_data.standby_mode == pm_mode)
 		pm_data.standby_mode = AT91_PM_ULP0;
-	if (pm_data.suspend_mode == AT91_PM_BACKUP)
+	if (pm_data.suspend_mode == pm_mode)
 		pm_data.suspend_mode = AT91_PM_ULP0;
 }
 
+static void __init at91_pm_modes_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	if (!at91_is_pm_mode_active(AT91_PM_BACKUP) &&
+	    !at91_is_pm_mode_active(AT91_PM_ULP1))
+		return;
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-shdwc");
+	if (!np) {
+		pr_warn("%s: failed to find shdwc!\n", __func__);
+		goto ulp1_default;
+	}
+
+	pm_data.shdwc = of_iomap(np, 0);
+	of_node_put(np);
+
+	ret = at91_pm_backup_init();
+	if (ret) {
+		if (!at91_is_pm_mode_active(AT91_PM_ULP1))
+			goto unmap;
+		else
+			goto backup_default;
+	}
+
+	return;
+
+unmap:
+	iounmap(pm_data.shdwc);
+	pm_data.shdwc = NULL;
+ulp1_default:
+	at91_pm_use_default_mode(AT91_PM_ULP1);
+backup_default:
+	at91_pm_use_default_mode(AT91_PM_BACKUP);
+}
+
 struct pmc_info {
 	unsigned long uhp_udp_mask;
 };
@@ -645,7 +766,7 @@ void __init sama5d2_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
-	at91_pm_backup_init();
+	at91_pm_modes_init();
 	sama5_pm_init();
 }
 
-- 
2.7.4


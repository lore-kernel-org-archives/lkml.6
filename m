Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C09C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76883205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76883205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeH3PwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:23 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8629 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeH3PwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:22 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="19080218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:36 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/6] power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
Date:   Thu, 30 Aug 2018 14:50:08 +0300
Message-ID: <1535629811-13403-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mpddrc_base part of struct shdwc since there is also only one
instance of struct shdwc *at91_shdwc in system and to have all data
specific to SHDWC grouped together.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 94ad79d0d82e..c9994103248e 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -71,6 +71,7 @@ struct shdwc_config {
 struct shdwc {
 	const struct shdwc_config *cfg;
 	void __iomem *at91_shdwc_base;
+	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
 };
 
@@ -80,7 +81,6 @@ struct shdwc {
  */
 static struct shdwc *at91_shdwc;
 static struct clk *sclk;
-static void __iomem *mpddrc_base;
 
 static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
@@ -136,7 +136,7 @@ static void at91_poweroff(void)
 
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->at91_shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
@@ -305,21 +305,22 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 		goto unmap;
 	}
 
-	mpddrc_base = of_iomap(np, 0);
+	at91_shdwc->mpddrc_base = of_iomap(np, 0);
 	of_node_put(np);
 
-	if (!mpddrc_base) {
+	if (!at91_shdwc->mpddrc_base) {
 		ret = -ENOMEM;
 		goto unmap;
 	}
 
 	pm_power_off = at91_poweroff;
 
-	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
+	ddr_type = readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
+			 AT91_DDRSDRC_MD;
 	if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
 	    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
-		iounmap(mpddrc_base);
-		mpddrc_base = NULL;
+		iounmap(at91_shdwc->mpddrc_base);
+		at91_shdwc->mpddrc_base = NULL;
 	}
 
 	return 0;
@@ -343,8 +344,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
 	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
 
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (shdw->mpddrc_base)
+		iounmap(shdw->mpddrc_base);
 	iounmap(shdw->pmc_base);
 
 	clk_disable_unprepare(sclk);
-- 
2.7.4


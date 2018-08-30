Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C574C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214B52082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214B52082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeH3PwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:25 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41749 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeH3PwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:25 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="18692641"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:39 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/6] power: reset: at91-poweroff: make sclk part of struct shdwc
Date:   Thu, 30 Aug 2018 14:50:09 +0300
Message-ID: <1535629811-13403-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sclk part of struct shdwc to have all the data specific to SHDWC
grouped together in one structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index c9994103248e..945b41b4086a 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -70,6 +70,7 @@ struct shdwc_config {
 
 struct shdwc {
 	const struct shdwc_config *cfg;
+	struct clk *sclk;
 	void __iomem *at91_shdwc_base;
 	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
@@ -80,7 +81,6 @@ struct shdwc {
  * since pm_power_off itself is global.
  */
 static struct shdwc *at91_shdwc;
-static struct clk *sclk;
 
 static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
@@ -271,11 +271,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
 	at91_shdwc->cfg = match->data;
 
-	sclk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc->sclk))
+		return PTR_ERR(at91_shdwc->sclk);
 
-	ret = clk_prepare_enable(sclk);
+	ret = clk_prepare_enable(at91_shdwc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -328,7 +328,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 unmap:
 	iounmap(at91_shdwc->pmc_base);
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc->sclk);
 
 	return ret;
 }
@@ -348,7 +348,7 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 		iounmap(shdw->mpddrc_base);
 	iounmap(shdw->pmc_base);
 
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(shdw->sclk);
 
 	return 0;
 }
-- 
2.7.4


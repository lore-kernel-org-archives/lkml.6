Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36570C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111C520821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfBFSMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:12:50 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40479 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:12:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26383923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 11:12:33 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Wed, 6 Feb 2019 11:12:33 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60 SoC
Date:   Wed, 6 Feb 2019 19:12:21 +0100
Message-ID: <20190206181221.27914-3-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206181221.27914-1-nicolas.ferre@microchip.com>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for additional reset causes and the proper compatibility
string for sam9x60 SoC. The restart function is the same as the samx7.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
v2: split series and collect tag

Sebastian,
I add your Acked-by tag here but as I would like that you take the 3 patches on
your tree now, I let you modify it on your side. I'm expecting Alexandre or
Ludovic to have a look as well.

Best regards,
  Nicolas

 drivers/power/reset/at91-reset.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index f44a9ffcc2ab..44ca983a49a1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -44,6 +44,9 @@ enum reset_type {
 	RESET_TYPE_WATCHDOG	= 2,
 	RESET_TYPE_SOFTWARE	= 3,
 	RESET_TYPE_USER		= 4,
+	RESET_TYPE_CPU_FAIL	= 6,
+	RESET_TYPE_XTAL_FAIL	= 7,
+	RESET_TYPE_ULP2		= 8,
 };
 
 static void __iomem *at91_ramc_base[2], *at91_rstc_base;
@@ -164,6 +167,15 @@ static void __init at91_reset_status(struct platform_device *pdev)
 	case RESET_TYPE_USER:
 		reason = "user reset";
 		break;
+	case RESET_TYPE_CPU_FAIL:
+		reason = "CPU clock failure detection";
+		break;
+	case RESET_TYPE_XTAL_FAIL:
+		reason = "32.768 kHz crystal failure detection";
+		break;
+	case RESET_TYPE_ULP2:
+		reason = "ULP2 reset";
+		break;
 	default:
 		reason = "unknown reset";
 		break;
@@ -183,6 +195,7 @@ static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ .compatible = "atmel,samx7-rstc", .data = samx7_restart },
+	{ .compatible = "microchip,sam9x60-rstc", .data = samx7_restart },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
-- 
2.17.1


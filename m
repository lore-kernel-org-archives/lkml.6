Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5065C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfAPJ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:58:10 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46525 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404027AbfAPJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:58:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25386569"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 02:58:06 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:58:05 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Date:   Wed, 16 Jan 2019 10:57:42 +0100
Message-ID: <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for additional reset causes and the proper compatibility
string for sam9x60 SoC. The restart function is the same as the samx7.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
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


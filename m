Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545E0214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545E0214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeHBMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:25:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39185 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbeHBMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:25:08 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1flAw9-0004Zy-Mn; Thu, 02 Aug 2018 12:34:29 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1flAw6-0000oy-V7; Thu, 02 Aug 2018 12:34:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH v9 5/6] regulator: pfuze100-regulator: provide pm_power_off_prepare handler
Date:   Thu,  2 Aug 2018 12:34:24 +0200
Message-Id: <20180802103425.3053-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802103425.3053-1-o.rempel@pengutronix.de>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards the SoC can use one pin "PMIC_STBY_REQ" to notify th PMIC
about state changes. In this case internal state of PMIC must be
preconfigured for upcomming state change.
It works fine with the current regulator framework, except with the
power-off case.

This patch is providing an optional pm_power_off_prepare handler
which will configure standby state of the PMIC to disable all power lines.

In my power consumption test on RIoTBoard, I got the following results:
power off without this patch:	320 mA
power off with this patch:	2   mA
suspend to ram:			40  mA

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/pfuze100-regulator.c | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 31c3a236120a..1e43a9de3bd5 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -31,11 +31,17 @@
 
 #define PFUZE100_COINVOL	0x1a
 #define PFUZE100_SW1ABVOL	0x20
+#define PFUZE100_SW1ABMODE	0x23
 #define PFUZE100_SW1CVOL	0x2e
+#define PFUZE100_SW1CMODE	0x31
 #define PFUZE100_SW2VOL		0x35
+#define PFUZE100_SW2MODE	0x38
 #define PFUZE100_SW3AVOL	0x3c
+#define PFUZE100_SW3AMODE	0x3f
 #define PFUZE100_SW3BVOL	0x43
+#define PFUZE100_SW3BMODE	0x46
 #define PFUZE100_SW4VOL		0x4a
+#define PFUZE100_SW4MODE	0x4d
 #define PFUZE100_SWBSTCON1	0x66
 #define PFUZE100_VREFDDRCON	0x6a
 #define PFUZE100_VSNVSVOL	0x6b
@@ -46,6 +52,13 @@
 #define PFUZE100_VGEN5VOL	0x70
 #define PFUZE100_VGEN6VOL	0x71
 
+#define PFUZE100_SWxMODE_MASK	0xf
+#define PFUZE100_SWxMODE_APS_APS	0x8
+#define PFUZE100_SWxMODE_APS_OFF	0x4
+
+#define PFUZE100_VGENxLPWR	BIT(6)
+#define PFUZE100_VGENxSTBY	BIT(5)
+
 enum chips { PFUZE100, PFUZE200, PFUZE3000 = 3, PFUZE3001 = 0x31, };
 
 struct pfuze_regulator {
@@ -559,6 +572,69 @@ static inline struct device_node *match_of_node(int index)
 }
 #endif
 
+static struct pfuze_chip *syspm_pfuze_chip;
+
+static void pfuze_power_off_prepare(void)
+{
+	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power off");
+
+	/* Switch from default mode: APS/APS to APS/Off */
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1ABMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1CMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW2MODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3AMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW3BMODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW4MODE,
+			   PFUZE100_SWxMODE_MASK, PFUZE100_SWxMODE_APS_OFF);
+
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN1VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN2VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN3VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN4VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN5VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
+			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
+			   PFUZE100_VGENxSTBY);
+}
+
+static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
+{
+	if (pfuze_chip->chip_id != PFUZE100) {
+		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
+		return -ENODEV;
+	}
+
+	if (pm_power_off_prepare) {
+		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
+		return -EBUSY;
+	}
+
+	if (syspm_pfuze_chip) {
+		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
+		return -EBUSY;
+	}
+
+	syspm_pfuze_chip = pfuze_chip;
+	pm_power_off_prepare = pfuze_power_off_prepare;
+
+	return 0;
+}
+
 static int pfuze_identify(struct pfuze_chip *pfuze_chip)
 {
 	unsigned int value;
@@ -753,6 +829,20 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 		}
 	}
 
+	if (of_property_read_bool(client->dev.of_node,
+				  "fsl,pmic-stby-poweroff"))
+		return pfuze_power_off_prepare_init(pfuze_chip);
+
+	return 0;
+}
+
+static int pfuze100_regulator_remove(struct i2c_client *client)
+{
+	if (syspm_pfuze_chip) {
+		syspm_pfuze_chip = NULL;
+		pm_power_off_prepare = NULL;
+	}
+
 	return 0;
 }
 
@@ -763,6 +853,7 @@ static struct i2c_driver pfuze_driver = {
 		.of_match_table = pfuze_dt_ids,
 	},
 	.probe = pfuze100_regulator_probe,
+	.remove = pfuze100_regulator_remove,
 };
 module_i2c_driver(pfuze_driver);
 
-- 
2.18.0


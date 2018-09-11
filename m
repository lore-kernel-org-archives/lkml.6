Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3068CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38AF2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lFyNTMxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38AF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIKUTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:19:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36992 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=W64h5PH4caSnNBLUaNb6etzb5ovl/NxzKiaoBGN3FWs=; b=lFyNTMxeF8D2
        8jhE2WAFbt8m0AjBkvhaEPT8DgPCuyGbElpCbt1tl2orSCBA26mIK/uoOyKhIUyGpm170yOxlFL1S
        nQEr01NtKxzcnDOaRd/4Yzzhs5g/V8V6RJxgjWd/NI5MPgZNG66g/kYgqYcLEHDZnXuf+R2kmP2OZ
        pB3hU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzkS7-0004yB-TD; Tue, 11 Sep 2018 15:19:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A336E1121B1F; Tue, 11 Sep 2018 16:19:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100-regulator: provide pm_power_off_prepare handler" to the regulator tree
In-Reply-To: 
Message-Id: <20180911151943.A336E1121B1F@debutante.sirena.org.uk>
Date:   Tue, 11 Sep 2018 16:19:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100-regulator: provide pm_power_off_prepare handler

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From c29daffa322ad36978cbce487f8ebcd9c3c3f7c0 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 2 Aug 2018 12:34:24 +0200
Subject: [PATCH] regulator: pfuze100-regulator: provide pm_power_off_prepare
 handler

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2


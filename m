Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B3DC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1462087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="gUJPeyIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfA3JHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:07:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41615 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:07:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so10775466plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFpH/LFKq6cj1JtU5kThBc1TATjp4OQx5J43SNcVP5Q=;
        b=gUJPeyIb/Xw6pVY6BgbolXRBztuaYLAg20drbdCyLOsGGokF5lGzmcbIZ2KaIbiB5t
         27vBBCvr+PZuqEbz8Anx/wGXsS2gwTezxkRGLczi4BZVKQjVOhYNGrEYxiAHoh9NFcmK
         z2xRceEG2ieYUHwoGHfts2iSwusqFl8MaCFF6IRbIJmjLt+1d088mZWDRv/hR+K3zZpb
         Yz7i5WNU+QzwqbakRJpXPIdTb3BrHPxxllOIluZLnOm/0JVTZ03k4U8QoJO8+3GYhnCv
         jCUh+Dm64Yp/rqEtW/yiGO9Gn5GzoKqc7Tr64i5xHOjb/AB1uj7hly9roO2lcW3PMDEF
         Fplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFpH/LFKq6cj1JtU5kThBc1TATjp4OQx5J43SNcVP5Q=;
        b=e3T42Um6WKkkB0UMhZIlH+p4pj68doaj6DKHuyO0v9BBmPTAUBdp1iMCEEUnhBXXWn
         1fUDPUDjoZHt7w9t6ysjV+fQoUgSXU6hss8BtO9C1zmkpgrepHDE7K7RdJWLTy9q8Lol
         eA8yn7/vZ9Zqd3X03WrUwUAlUSe+mJTKOrqXPaEF5/oRSOzBjxBUn4pXIVMBtXJjwDSR
         mTh1QWVKjXAMpGo5IFR0Mimw0JT3ztF9Xx2x+6P1LU79DZKbnEgx0gpMZVcXNfrvBmjj
         2cgJWTTk4ruNxNG1dE97HV2VOTW4lD52tMuzAd6s+yR71T5G7rwZPkVVm3wsD5OXZHgG
         ij1A==
X-Gm-Message-State: AJcUukcgn3KdL8p2KqjxrroYljMUrW+HNyeizxtAAUnkhj30ea2JwBCp
        SL3SncFitr9R66yB4EMOEk98/1FKTeM=
X-Google-Smtp-Source: ALg8bN5aAvX6YDtxQJZFQvQ1+C975AFmpVBEYcFhK9DrlYAggxTgvqD3NEhziAU8pIIzR+dkFEs1Cw==
X-Received: by 2002:a17:902:7d82:: with SMTP id a2mr29767883plm.163.1548839257574;
        Wed, 30 Jan 2019 01:07:37 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id k14sm4486805pgs.52.2019.01.30.01.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:07:36 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: max77650: Convert to use regulator_enable/disable/is_enabled_regmap
Date:   Wed, 30 Jan 2019 17:07:22 +0800
Message-Id: <20190130090722.24134-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130090722.24134-1-axel.lin@ingics.com>
References: <20190130090722.24134-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting enable_reg, enable_mask, enable_val and disable_val, we can
use the regulator_enable/disable/is_enabled_regmap helpers. With this
change, then regB field can be removed from struct max77650_regulator_desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Bartosz,
I don't have this h/w, please help to review and test it.

I think the only difference is the is_enabled checking:
Before the patch, it returns en != MAX77650_REGULATOR_DISABLED;
After the patch, it returns en == MAX77650_REGULATOR_ENABLED
I'm not sure if this difference does matter or not.

Thanks,
Axel
 drivers/regulator/max77650-regulator.c | 87 +++++++-------------------
 1 file changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5afb91400832..90c0f73f3fad 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -13,8 +13,6 @@
 #include <linux/regulator/driver.h>
 
 #define MAX77650_REGULATOR_EN_CTRL_MASK		GENMASK(3, 0)
-#define MAX77650_REGULATOR_EN_CTRL_BITS(_reg) \
-		((_reg) & MAX77650_REGULATOR_EN_CTRL_MASK)
 #define MAX77650_REGULATOR_ENABLED		GENMASK(2, 1)
 #define MAX77650_REGULATOR_DISABLED		BIT(2)
 
@@ -41,7 +39,6 @@ enum {
 struct max77650_regulator_desc {
 	struct regulator_desc desc;
 	unsigned int regA;
-	unsigned int regB;
 };
 
 static const u32 max77651_sbb1_regulator_volt_table[] = {
@@ -86,50 +83,6 @@ static const int max77650_current_limit_table[] = {
 	1000000, 866000, 707000, 500000,
 };
 
-static int max77650_regulator_is_enabled(struct regulator_dev *rdev)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-	int val, rv, en;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	rv = regmap_read(map, rdesc->regB, &val);
-	if (rv)
-		return rv;
-
-	en = MAX77650_REGULATOR_EN_CTRL_BITS(val);
-
-	return en != MAX77650_REGULATOR_DISABLED;
-}
-
-static int max77650_regulator_enable(struct regulator_dev *rdev)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	return regmap_update_bits(map, rdesc->regB,
-				  MAX77650_REGULATOR_EN_CTRL_MASK,
-				  MAX77650_REGULATOR_ENABLED);
-}
-
-static int max77650_regulator_disable(struct regulator_dev *rdev)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	return regmap_update_bits(map, rdesc->regB,
-				  MAX77650_REGULATOR_EN_CTRL_MASK,
-				  MAX77650_REGULATOR_DISABLED);
-}
-
 static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					      unsigned int sel)
 {
@@ -140,7 +93,7 @@ static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	 * If the regulator is disabled, we can program the desired
 	 * voltage right away.
 	 */
-	if (!max77650_regulator_is_enabled(rdev))
+	if (!regulator_is_enabled_regmap(rdev))
 		return regulator_set_voltage_sel_regmap(rdev, sel);
 
 	/*
@@ -189,7 +142,7 @@ static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
 	 * If the regulator is disabled, we can program the desired
 	 * voltage right away.
 	 */
-	if (!max77650_regulator_is_enabled(rdev))
+	if (!regulator_is_enabled_regmap(rdev))
 		return regulator_set_voltage_sel_regmap(rdev, sel);
 
 	curr = regulator_get_voltage_sel_regmap(rdev);
@@ -264,9 +217,9 @@ static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
 }
 
 static const struct regulator_ops max77650_regulator_LDO_ops = {
-	.is_enabled		= max77650_regulator_is_enabled,
-	.enable			= max77650_regulator_enable,
-	.disable		= max77650_regulator_disable,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -275,9 +228,9 @@ static const struct regulator_ops max77650_regulator_LDO_ops = {
 };
 
 static const struct regulator_ops max77650_regulator_SBB_ops = {
-	.is_enabled		= max77650_regulator_is_enabled,
-	.enable			= max77650_regulator_enable,
-	.disable		= max77650_regulator_disable,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -289,9 +242,9 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 
 /* Special case for max77651 SBB1 - non-linear voltage mapping. */
 static const struct regulator_ops max77651_SBB1_regulator_ops = {
-	.is_enabled		= max77650_regulator_is_enabled,
-	.enable			= max77650_regulator_enable,
-	.disable		= max77650_regulator_disable,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_table,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
@@ -313,6 +266,10 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.n_voltages		= 128,
 		.vsel_mask		= MAX77650_REGULATOR_V_LDO_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_LDO_A,
+		.enable_reg		= MAX77650_REG_CNFG_LDO_B,
+		.enable_mask		= MAX77650_REGULATOR_EN_CTRL_MASK,
+		.enable_val		= MAX77650_REGULATOR_ENABLED,
+		.disable_val		= MAX77650_REGULATOR_DISABLED,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
 		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
 		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
@@ -321,7 +278,6 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_LDO_A,
-	.regB		= MAX77650_REG_CNFG_LDO_B,
 };
 
 static struct max77650_regulator_desc max77650_SBB0_desc = {
@@ -337,6 +293,10 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.n_voltages		= 64,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB0_A,
+		.enable_reg		= MAX77650_REG_CNFG_LDO_B,
+		.enable_mask		= MAX77650_REGULATOR_EN_CTRL_MASK,
+		.enable_val		= MAX77650_REGULATOR_ENABLED,
+		.disable_val		= MAX77650_REGULATOR_DISABLED,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
 		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
 		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
@@ -345,7 +305,6 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB0_A,
-	.regB		= MAX77650_REG_CNFG_SBB0_B,
 };
 
 static struct max77650_regulator_desc max77650_SBB1_desc = {
@@ -361,6 +320,10 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.n_voltages		= 64,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.enable_reg		= MAX77650_REG_CNFG_LDO_B,
+		.enable_mask		= MAX77650_REGULATOR_EN_CTRL_MASK,
+		.enable_val		= MAX77650_REGULATOR_ENABLED,
+		.disable_val		= MAX77650_REGULATOR_DISABLED,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
 		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
 		.active_discharge_mask	= MAX77650_REGULATOR_AD_MASK,
@@ -369,7 +332,6 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
-	.regB		= MAX77650_REG_CNFG_SBB1_B,
 };
 
 static struct max77650_regulator_desc max77651_SBB1_desc = {
@@ -392,7 +354,6 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
-	.regB		= MAX77650_REG_CNFG_SBB1_B,
 };
 
 static struct max77650_regulator_desc max77650_SBB2_desc = {
@@ -416,7 +377,6 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
-	.regB		= MAX77650_REG_CNFG_SBB2_B,
 };
 
 static struct max77650_regulator_desc max77651_SBB2_desc = {
@@ -440,7 +400,6 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.type			= REGULATOR_VOLTAGE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
-	.regB		= MAX77650_REG_CNFG_SBB2_B,
 };
 
 static int max77650_regulator_probe(struct platform_device *pdev)
-- 
2.17.1


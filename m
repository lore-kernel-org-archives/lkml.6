Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD800C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59BC2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="O0WRi/yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59BC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeLJSnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:43:07 -0500
Received: from plaes.org ([188.166.43.21]:55100 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeLJSm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:42:28 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id DA06C41289;
        Mon, 10 Dec 2018 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544467346; bh=f2mcC9Dpd0QYLyRmz8so1Ckg3Nv64+LbaTC/FIJ10Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0WRi/ydRMrVKhFvfrIp9rdhWemlVVSJizeZzDNYiH9lyZrQZiTltvzHazv628ABN
         ik2L4ipxvpqsfKM/qbJQ4CbD8bTRBZo9cWM3WNL4y7d/3dl54cr6sVi3idNrpzbbQs
         T7H1+TJiSgY7E4vI9oKsPFY8YwktCr81J5QHkbThIzhLh7v0FS3BNneH3+Nx5I1QaC
         6PyyrBpTTy5dFGZT3jqn7S+sFel22dumtTbCGSLSEY+NPjgk0Jq3O9FZM4Lq/H9Cng
         3O/KEY46u5lIuRWND//h5WUyFLRJ68BLGkiN3+vERefiOOU+t0F7boHxKgxF+W6AgA
         LEk5vNM2DmaBA==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 2/8] regulator: axp20x: add support for set_ramp_delay for AXP209
Date:   Mon, 10 Dec 2018 20:42:13 +0200
Message-Id: <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3.

This patch adds preliminary support for the regulator-ramp-delay property
for these 2 regulators. Note that the voltage ramp only works when
regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/axp20x-regulator.c | 85 +++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 9a2db28..1d9fa62 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -51,6 +51,17 @@
 #define AXP20X_PWR_OUT_DCDC2_MASK	BIT_MASK(4)
 #define AXP20X_PWR_OUT_LDO3_MASK	BIT_MASK(6)
 
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK	BIT_MASK(0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(x) \
+	((x) << 0)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK		BIT_MASK(1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(x) \
+	((x) << 1)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK		BIT_MASK(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN		BIT(2)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK		BIT_MASK(3)
+#define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN		BIT(3)
+
 #define AXP20X_LDO4_V_OUT_1250mV_START	0x0
 #define AXP20X_LDO4_V_OUT_1250mV_STEPS	0
 #define AXP20X_LDO4_V_OUT_1250mV_END	\
@@ -346,6 +357,79 @@
 		.ops		= &axp20x_ops_range,				\
 	}
 
+static const int axp209_dcdc2_ldo3_slew_rates[] = {
+	1600,
+	 800,
+};
+
+static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	const struct regulator_desc *desc = rdev->desc;
+	u8 reg, mask, enable, cfg = 0xff;
+	const int *slew_rates;
+	int rate_count = 0;
+
+	if (!rdev)
+		return -EINVAL;
+
+	switch (axp20x->variant) {
+	case AXP209_ID:
+		if (desc->id == AXP20X_DCDC2) {
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
+			break;
+		}
+
+		if (desc->id == AXP20X_LDO3) {
+			slew_rates = axp209_dcdc2_ldo3_slew_rates;
+			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
+			reg = AXP20X_DCDC2_LDO3_V_RAMP;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
+			enable = (ramp > 0) ?
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
+				 !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
+			break;
+		}
+
+		if (rate_count > 0)
+			break;
+
+		/* fall through */
+	default:
+		/* Not supported for this regulator */
+		return -ENOTSUPP;
+	}
+
+	if (ramp == 0) {
+		cfg = enable;
+	} else {
+		int i;
+
+		for (i = 0; i < rate_count; i++) {
+			if (ramp <= slew_rates[i])
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
+			else
+				break;
+		}
+
+		if (cfg == 0xff) {
+			dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
+			return -EINVAL;
+		}
+
+		cfg |= enable;
+	}
+
+	return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
+}
+
 static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
@@ -366,6 +450,7 @@ static const struct regulator_ops axp20x_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_ramp_delay		= axp20x_set_ramp_delay,
 };
 
 static const struct regulator_ops axp20x_ops_sw = {
-- 
git-series 0.9.1

Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26917C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44192084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="nwDVyYnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44192084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJECfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:30 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:47768 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbeJECf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 0734B1F99C;
        Thu,  4 Oct 2018 21:34:46 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538681684; x=
        1541273685; bh=nH9jCOZMiAQffXTRDY0K3dj/dvc9nqOMIuTRGT/kQII=; b=n
        wDVyYnnghr9vuNsXK1c5b5qHjuRF3JxK6NVVaKTyYTVZ/Z3YIll9u9Y72HOLSATx
        MGC1o6Ng07odZuUGa+FoW6ijqAGEt3CvaceaXyJA8d3Fe7TjCdwdJVmDvrl9a6Kx
        ZfWR4Vuo1U+7c/KdLzZ6nJeudYLg+afNF6LqX+zt1q1rdU+V0hwQbWs0Nz7DoXH4
        zyUxQdA4Lz+HIyKQuxkw+KURN/b7+sOUeilqEzTqMIepGhuCgLM3xcwsKkyugRaC
        eDnCqEggV1osDkjgL4ykSQkmW9iT1nV14l23WlaJBUcpVhDaT2vGIwV6p27seXK+
        6IDbmH/aSiiO3oLe1VE2w+t+ycno4ui6dz516OvdwSX1xFx8Pz7XvFJ7EkROf7v6
        6SXhemnXqR88U2CUKFKQpgbXfXa4ZK7+l0ayKyNacU6IFjIfM2MweekcRuP1AaIu
        U84l6X13363NQno0p4TNjXmPS+z7/QzgIvc6CNkqDOtsMeGi8dF1KBp5Nvw4lK8s
        M7J0yrc2PRTRA1dMygwn3Q0pfZUz5eEJzsUT4KmHlOnPol+x3y8k6Z32lpJlOkZm
        ngiLL0lrqHWzTea6SQO9V0Agb1FEPy15jQ+0HYXsKMWKGgWhVy3hqoYZKT61cfQb
        3L/plzddvr1aDA1sTz0zeKYX/mUwyoN0BnqppB8Bog=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BwkJ3V_T2fzg; Thu,  4 Oct 2018 21:34:44 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 0EC8A1FBF3;
        Thu,  4 Oct 2018 21:34:44 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] power: supply: add AXP803/AXP813 AC and battery power supply support
Date:   Thu,  4 Oct 2018 22:34:10 +0300
Message-Id: <20181004193410.7265-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 PMIC is register compatible with AXP813.

Added support for AXP803/AXP813 AC power supply.
AXP8x3 is capable to limit input current and minimum input voltage.
Both of these register values are writeable.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/iio/adc/axp20x_adc.c           |   1 +
 drivers/mfd/axp20x.c                   |  22 ++-
 drivers/pinctrl/pinctrl-axp209.c       |   1 +
 drivers/power/supply/axp20x_ac_power.c | 194 +++++++++++++++++++++++++
 drivers/power/supply/axp20x_battery.c  |   3 +
 include/linux/mfd/axp20x.h             |   1 +
 6 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 5be789269353..f919a16a8533 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -641,6 +641,7 @@ static const struct axp_data axp813_data = {
 static const struct of_device_id axp20x_adc_of_match[] = {
 	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
 	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
+	{ .compatible = "x-powers,axp803-adc", .data = (void *)&axp813_data, },
 	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
 	{ /* sentinel */ }
 };
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..c540f17549d5 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
 		.name			= "axp221-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator"
+	}, {
+		.name			= "axp20x-gpio",
+		.of_compatible		= "x-powers,axp803-gpio",
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp803-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp803-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp803-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
-	{	.name			= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
@@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 };
 
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index afd0b533c40a..21859579e0a2 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -387,6 +387,7 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_pctl_match[] = {
 	{ .compatible = "x-powers,axp209-gpio", .data = &axp20x_data, },
+	{ .compatible = "x-powers,axp803-gpio", .data = &axp813_data, },
 	{ .compatible = "x-powers,axp813-gpio", .data = &axp813_data, },
 	{ }
 };
diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 0771f951b11f..3247efb81cd1 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -27,6 +27,23 @@
 #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
+#define AXP8X3_PWR_ACIN_VHOLD		GENMASK(5, 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_0V	(0 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_1V	(1 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_2V	(2 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_3V	(3 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_4V	(4 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_5V	(5 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_6V	(6 << 3)
+#define AXP8X3_PWR_ACIN_VHOLD_4_7V	(7 << 3)
+#define AXP8X3_PWR_ACIN_CURR_LIMIT	GENMASK(2, 0)
+#define AXP8X3_PWR_ACIN_CURR_1_5A	0
+#define AXP8X3_PWR_ACIN_CURR_2_0A	1
+#define AXP8X3_PWR_ACIN_CURR_2_5A	2
+#define AXP8X3_PWR_ACIN_CURR_3_0A	3
+#define AXP8X3_PWR_ACIN_CURR_3_5A	4
+#define AXP8X3_PWR_ACIN_CURR_4_0A	5
+
 #define DRVNAME "axp20x-ac-power-supply"
 
 struct axp20x_ac_power {
@@ -102,6 +119,72 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 
 		return 0;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		switch (reg & AXP8X3_PWR_ACIN_VHOLD) {
+		case AXP8X3_PWR_ACIN_VHOLD_4_0V:
+			val->intval = 4000000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_1V:
+			val->intval = 4100000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_2V:
+			val->intval = 4200000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_3V:
+			val->intval = 4300000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_4V:
+			val->intval = 4400000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_5V:
+			val->intval = 4500000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_6V:
+			val->intval = 4600000;
+			break;
+		case AXP8X3_PWR_ACIN_VHOLD_4_7V:
+			val->intval = 4700000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		switch (reg & AXP8X3_PWR_ACIN_CURR_LIMIT) {
+		case AXP8X3_PWR_ACIN_CURR_1_5A:
+			val->intval = 1500000;
+			break;
+		case AXP8X3_PWR_ACIN_CURR_2_0A:
+			val->intval = 2000000;
+			break;
+		case AXP8X3_PWR_ACIN_CURR_2_5A:
+			val->intval = 2500000;
+			break;
+		case AXP8X3_PWR_ACIN_CURR_3_0A:
+			val->intval = 3000000;
+			break;
+		case AXP8X3_PWR_ACIN_CURR_3_5A:
+			val->intval = 3500000;
+			break;
+		case AXP8X3_PWR_ACIN_CURR_4_0A:
+			val->intval = 4000000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -109,6 +192,88 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+static int axp20x_ac_power_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
+	int setval;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		switch (val->intval) {
+		case 4000000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_0V;
+			break;
+		case 4100000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_1V;
+			break;
+		case 4200000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_2V;
+			break;
+		case 4300000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_3V;
+			break;
+		case 4400000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_4V;
+			break;
+		case 4500000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_5V;
+			break;
+		case 4600000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_6V;
+			break;
+		case 4700000:
+			setval = AXP8X3_PWR_ACIN_VHOLD_4_7V;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
+					  AXP8X3_PWR_ACIN_VHOLD, setval);
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+
+		switch (val->intval) {
+		case 1500000:
+			setval = AXP8X3_PWR_ACIN_CURR_1_5A;
+			break;
+		case 2000000:
+			setval = AXP8X3_PWR_ACIN_CURR_2_0A;
+			break;
+		case 2500000:
+			setval = AXP8X3_PWR_ACIN_CURR_2_5A;
+			break;
+		case 3000000:
+			setval = AXP8X3_PWR_ACIN_CURR_3_0A;
+			break;
+		case 3500000:
+			setval = AXP8X3_PWR_ACIN_CURR_3_5A;
+			break;
+		case 4000000:
+			setval = AXP8X3_PWR_ACIN_CURR_4_0A;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
+					  AXP8X3_PWR_ACIN_CURR_LIMIT, setval);
+
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp20x_ac_power_prop_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
 static enum power_supply_property axp20x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -123,6 +288,14 @@ static enum power_supply_property axp22x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
+static enum power_supply_property axp8x3_ac_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
 static const struct power_supply_desc axp20x_ac_power_desc = {
 	.name = "axp20x-ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
@@ -139,6 +312,16 @@ static const struct power_supply_desc axp22x_ac_power_desc = {
 	.get_property = axp20x_ac_power_get_property,
 };
 
+static const struct power_supply_desc axp8x3_ac_power_desc = {
+	.name = "axp8x3-ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = axp8x3_ac_power_properties,
+	.num_properties = ARRAY_SIZE(axp8x3_ac_power_properties),
+	.property_is_writeable = axp20x_ac_power_prop_writeable,
+	.get_property = axp20x_ac_power_get_property,
+	.set_property = axp20x_ac_power_set_property,
+};
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	bool				acin_adc;
@@ -154,6 +337,11 @@ static const struct axp_data axp22x_data = {
 	.acin_adc = false,
 };
 
+static const struct axp_data axp8x3_data = {
+	.power_desc = &axp8x3_ac_power_desc,
+	.acin_adc = false,
+};
+
 static int axp20x_ac_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -234,6 +422,12 @@ static const struct of_device_id axp20x_ac_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp221-ac-power-supply",
 		.data = &axp22x_data,
+	}, {
+		.compatible = "x-powers,axp803-ac-power-supply",
+		.data = &axp8x3_data,
+	}, {
+		.compatible = "x-powers,axp813-ac-power-supply",
+		.data = &axp8x3_data,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index e84b6e4da14a..932027f4a993 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -537,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp803-battery-power-supply",
+		.data = (void *)&axp813_data,
 	}, {
 		.compatible = "x-powers,axp813-battery-power-supply",
 		.data = (void *)&axp813_data,
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60eecbcb..23d58e243d01 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -266,6 +266,7 @@ enum axp20x_variants {
 #define AXP288_RT_BATT_V_H		0xa0
 #define AXP288_RT_BATT_V_L		0xa1
 
+#define AXP803_ACIN_PATH_CTRL		0x3a
 #define AXP813_ADC_RATE			0x85
 
 /* Fuel Gauge */
-- 
2.17.1


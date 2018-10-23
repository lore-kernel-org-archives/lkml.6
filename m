Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AF2C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="KoSrQYuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17920813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeJXDSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:18:53 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:45920 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeJXDSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:18:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 4DF481FBEA;
        Tue, 23 Oct 2018 20:54:12 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1540320851; x=
        1542912852; bh=VTqnN3XdOSfhFJGNVAMrr6Pwli+yu6G7D3SxrMjYacw=; b=K
        oSrQYuyBAkQUcvFDaPNxf5QL7L2+VbuRuT+F0oIT9YHDdT+L1FEtsKr/yB4ETVtU
        jb2coSycX+QjxUHswCWKVR3HMhaJljlomesKJxCp2Os5JMnv/MNg2FEy5RMtESrK
        oVt5dlrKbm9St5p3s8W3JDUXwZcLA0hSQJk4TaNeMCWSWEqniuqC69zgwAF34Jun
        C7OgFyxQAvDcLyDT34HzpUqbcfhOnZnk/w56bteBqwKZOZMTheOgFoGOblKuWrxp
        ZTcF4T0LwNQT64xn44JOr7MlQHrTv4I1vUDT3EdPPZ6xfWRoY479mCIt7mNS12tS
        57dO39D7r2ob7NriOMcCTmVlgMOu0I2XM+6vXmCSuXSEPKDcHLcTwIG/qx9PjGMz
        Bu8jDa6UUOD+07MWgbuMDt6RVw2pKgNDJiO/iiCC1XeHG3WXjuSt5QGMeyOKZUiZ
        ViabVs8JYKY2CG8DMwbKdLZJWT3n1NeQawd7b4hHSfoYRo3ZoAya0M0QY8QhsZn9
        RIR22RXBmkinAZhNeOcoWR3ABby5o+lgv4N09Jf7LOqZTOh7nmPHfIUelRxzmnby
        InCOZkIKcAKtDtDvDY3kohqFCWeE2iTCXG5eTevkSl1DQK6vhlZLygNLdvCj2Jf7
        n7lZdsZesfDnJxOMO4Qo+nbmKrsznWH/OhewmfyHhY=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fwaj7tHpKyBy; Tue, 23 Oct 2018 20:54:11 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 73DAD1FBE8;
        Tue, 23 Oct 2018 20:54:10 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 09/11] power: supply: add AC power supply driver for AXP813
Date:   Tue, 23 Oct 2018 21:53:28 +0300
Message-Id: <20181023185330.10472-10-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 and AXP803 PMICs can control input current and minimum voltage.

Both of these values are configurable.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/power/supply/axp20x_ac_power.c | 94 ++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h             |  1 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 0771f951b11f..59b4c8d3b961 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -27,6 +27,16 @@
 #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
+#define AXP813_VHOLD_MASK		GENMASK(5, 3)
+#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
+#define AXP813_VHOLD_REG_TO_UV(x)	\
+	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
+
+#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
+#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
+#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
+	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
+
 #define DRVNAME "axp20x-ac-power-supply"
 
 struct axp20x_ac_power {
@@ -102,6 +112,57 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 
 		return 0;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP813_VHOLD_REG_TO_UV(reg);
+
+		return 0;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP813_CURR_LIMIT_REG_TO_UA(reg);
+		/* AXP813 datasheet defines values 11x as 4000mA */
+		if (val->intval > 4000000)
+			val->intval = 4000000;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp813_ac_power_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		if (val->intval < 4000000 || val->intval > 4700000)
+			return -EINVAL;
+
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_VHOLD_MASK,
+					  AXP813_VHOLD_UV_TO_BIT(val->intval));
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval < 1500000 || val->intval > 4000000)
+			return -EINVAL;
+
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_CURR_LIMIT_MASK,
+					  AXP813_CURR_LIMIT_UA_TO_BIT(val->intval));
+
 	default:
 		return -EINVAL;
 	}
@@ -109,6 +170,13 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+static int axp813_ac_power_prop_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
 static enum power_supply_property axp20x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -123,6 +191,14 @@ static enum power_supply_property axp22x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
+static enum power_supply_property axp813_ac_power_properties[] = {
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
@@ -139,6 +215,16 @@ static const struct power_supply_desc axp22x_ac_power_desc = {
 	.get_property = axp20x_ac_power_get_property,
 };
 
+static const struct power_supply_desc axp813_ac_power_desc = {
+	.name = "axp813-ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = axp813_ac_power_properties,
+	.num_properties = ARRAY_SIZE(axp813_ac_power_properties),
+	.property_is_writeable = axp813_ac_power_prop_writeable,
+	.get_property = axp20x_ac_power_get_property,
+	.set_property = axp813_ac_power_set_property,
+};
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	bool				acin_adc;
@@ -154,6 +240,11 @@ static const struct axp_data axp22x_data = {
 	.acin_adc = false,
 };
 
+static const struct axp_data axp813_data = {
+	.power_desc = &axp813_ac_power_desc,
+	.acin_adc = false,
+};
+
 static int axp20x_ac_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -234,6 +325,9 @@ static const struct of_device_id axp20x_ac_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp221-ac-power-supply",
 		.data = &axp22x_data,
+	}, {
+		.compatible = "x-powers,axp813-ac-power-supply",
+		.data = &axp813_data,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60eecbcb..2302b620d238 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -266,6 +266,7 @@ enum axp20x_variants {
 #define AXP288_RT_BATT_V_H		0xa0
 #define AXP288_RT_BATT_V_L		0xa1
 
+#define AXP813_ACIN_PATH_CTRL		0x3a
 #define AXP813_ADC_RATE			0x85
 
 /* Fuel Gauge */
-- 
2.17.1


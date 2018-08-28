Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE209C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245A2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XygVPOth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeH1MyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:54:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeH1MyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:54:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so401177pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qXRvqOnYL87To37wNXk+Urj+o+uDAqsmxRDQBZeOZzs=;
        b=XygVPOthwFdgnXybDdV0GcPXSEuxqM0suQlkl162vhGmweukTRC/T7+ZisHeCNhEdZ
         TjERW2caStj2nzhrwB199Dgs+XV/tmRqR7z30A+Ec8wHnAmceGYCdxnCSEYnpK+IQfkm
         LX9d50KT3Dxg/Gh8XH9tkyHYqX0ekicOGkV1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qXRvqOnYL87To37wNXk+Urj+o+uDAqsmxRDQBZeOZzs=;
        b=KpgkeHcra4ldAImqa8fo/8S6JYYg/MZGGcAU3eOxyUsVob+5oQSppAXlbpwmBCxYE8
         7jiNmeolbUcpzgQs+XZmFhlfIqwOBfKGBGyrarwkvckEYi6LngUumDt+vOlwzZXN+zE9
         duadwxENZ53SIoAisVR2nxXpppa+mwrHdb28FC9VJBhWaIgdQITH3hkYoh4A3SZJpmmd
         xdCLhCOt5Qc9DAEnRLZiD/I6KtWnFCQuZecMmruR/cyHVCeaAVRARbAWTrox5KqY37Kp
         CRUdMpT0cyv/7tCw+XX38kibDXElVtnt7hCA6ABpqgSc4uUR7CIoVZB9JsyNfYzm4VOc
         gcVw==
X-Gm-Message-State: APzg51BhG7DThYR72F+88lFokxULP8pKnETRCueKDsrKRBoITF4cWXQV
        ToNuIb8NOXIdw7uWApYmeNfJvw==
X-Google-Smtp-Source: ANB0VdYIBMhuT1I/bUIDOjdz0ijTsAtZSoTBn22lkj0miVji6K1TrhClBZh5ld9aKsKUkdY4Z8cnHQ==
X-Received: by 2002:a63:fc05:: with SMTP id j5-v6mr630754pgi.1.1535447009028;
        Tue, 28 Aug 2018 02:03:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v140-v6sm1979292pgb.45.2018.08.28.02.03.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 02:03:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 2/2] power: supply: Add Spreadtrum SC2731 charger support
Date:   Tue, 28 Aug 2018 17:02:23 +0800
Message-Id: <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
In-Reply-To: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SC2731 PMIC switch charger support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/Kconfig          |    7 +
 drivers/power/supply/Makefile         |    1 +
 drivers/power/supply/sc2731_charger.c |  451 +++++++++++++++++++++++++++++++++
 3 files changed, 459 insertions(+)
 create mode 100644 drivers/power/supply/sc2731_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ff6dab0..f27cf07 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -645,4 +645,11 @@ config CHARGER_CROS_USBPD
 	  what is connected to USB PD ports from the EC and converts
 	  that into power_supply properties.
 
+config CHARGER_SC2731
+	tristate "Spreadtrum SC2731 charger driver"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	help
+	 Say Y here to enable support for battery charging with SC2731
+	 PMIC chips.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a26b402..767105b 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
+obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
new file mode 100644
index 0000000..49ae16a
--- /dev/null
+++ b/drivers/power/supply/sc2731_charger.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Spreadtrum Communications Inc.
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/usb/phy.h>
+#include <linux/regmap.h>
+#include <linux/extcon.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+
+/* PMIC global registers definition */
+#define SC2731_CHARGE_STATUS		0xedc
+#define SC2731_CHARGE_FULL		BIT(4)
+#define SC2731_MODULE_EN1		0xc0c
+#define SC2731_CHARGE_EN		BIT(5)
+
+/* SC2731 switch charger registers definition */
+#define SC2731_CHG_CFG0			0x0
+#define SC2731_CHG_CFG1			0x4
+#define SC2731_CHG_CFG2			0x8
+#define SC2731_CHG_CFG3			0xc
+#define SC2731_CHG_CFG4			0x10
+#define SC2731_CHG_CFG5			0x28
+
+/* SC2731_CHG_CFG0 register definition */
+#define SC2731_PRECHG_RNG_SHIFT		11
+#define SC2731_PRECHG_RNG_MASK		GENMASK(12, 11)
+
+#define SC2731_TERMINATION_VOL_MASK	GENMASK(2, 1)
+#define SC2731_TERMINATION_VOL_SHIFT	1
+#define SC2731_TERMINATION_VOL_CAL_MASK	GENMASK(8, 3)
+#define SC2731_TERMINATION_VOL_CAL_SHIFT	3
+#define SC2731_TERMINATION_CUR_MASK	GENMASK(2, 0)
+
+#define SC2731_CC_EN			BIT(13)
+#define SC2731_CHARGER_PD		BIT(0)
+
+/* SC2731_CHG_CFG1 register definition */
+#define SC2731_CUR_MASK			GENMASK(5, 0)
+
+/* SC2731_CHG_CFG5 register definition */
+#define SC2731_CUR_LIMIT_SHIFT		8
+#define SC2731_CUR_LIMIT_MASK		GENMASK(9, 8)
+
+#define SC2731_CURRENT_LIMIT_100	100
+#define SC2731_CURRENT_LIMIT_500	500
+#define SC2731_CURRENT_LIMIT_900	900
+#define SC2731_CURRENT_LIMIT_2000	2000
+
+#define SC2731_CURRENT_PRECHG		450
+#define SC2731_CURRENT_STEP		50
+
+struct sc2731_charger_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct usb_phy *usb_phy;
+	struct notifier_block usb_notify;
+	struct power_supply *psy_usb;
+	bool charging;
+	u32 base;
+};
+
+static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
+{
+	regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+			   SC2731_CC_EN, 0);
+
+	regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+			   SC2731_CHARGER_PD, SC2731_CHARGER_PD);
+}
+
+static int sc2731_charger_start_charge(struct sc2731_charger_info *info)
+{
+	int ret;
+
+	/* Enable charger constant current mode */
+	ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+				 SC2731_CC_EN, SC2731_CC_EN);
+	if (ret)
+		return ret;
+
+	/* Start charging */
+	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+				  SC2731_CHARGER_PD, 0);
+}
+
+static int sc2731_charger_set_current_limit(struct sc2731_charger_info *info,
+					    u32 limit)
+{
+	u32 val;
+
+	if (limit <= SC2731_CURRENT_LIMIT_100)
+		val = 0;
+	else if (limit <= SC2731_CURRENT_LIMIT_500)
+		val = 3;
+	else if (limit <= SC2731_CURRENT_LIMIT_900)
+		val = 2;
+	else
+		val = 1;
+
+	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG5,
+				  SC2731_CUR_LIMIT_MASK,
+				  val << SC2731_CUR_LIMIT_SHIFT);
+}
+
+static int sc2731_charger_set_current(struct sc2731_charger_info *info, u32 cur)
+{
+	u32 val;
+	int ret;
+
+	if (cur > SC2731_CURRENT_LIMIT_2000)
+		cur = SC2731_CURRENT_LIMIT_2000;
+	else if (cur < SC2731_CURRENT_PRECHG)
+		cur = SC2731_CURRENT_PRECHG;
+
+	/* Calculte the step value, each step is 50 mA */
+	val = (cur - SC2731_CURRENT_PRECHG) / SC2731_CURRENT_STEP;
+
+	/* Set pre-charge current as 450 mA */
+	ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+				 SC2731_PRECHG_RNG_MASK,
+				 0x3 << SC2731_PRECHG_RNG_SHIFT);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG1,
+				  SC2731_CUR_MASK, val);
+}
+
+static int sc2731_charger_get_status(struct sc2731_charger_info *info)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(info->regmap, SC2731_CHARGE_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (val & SC2731_CHARGE_FULL)
+		return POWER_SUPPLY_STATUS_FULL;
+
+	return POWER_SUPPLY_STATUS_CHARGING;
+}
+
+static int sc2731_charger_get_current(struct sc2731_charger_info *info,
+				      u32 *cur)
+{
+	int ret;
+	u32 val;
+
+	ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG1, &val);
+	if (ret)
+		return ret;
+
+	val &= SC2731_CUR_MASK;
+	*cur = val * SC2731_CURRENT_STEP + SC2731_CURRENT_PRECHG;
+	return 0;
+}
+
+static int sc2731_charger_get_current_limit(struct sc2731_charger_info *info,
+					    u32 *cur)
+{
+	int ret;
+	u32 val;
+
+	ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG5, &val);
+	if (ret)
+		return ret;
+
+	val = (val & SC2731_CUR_LIMIT_MASK) >> SC2731_CUR_LIMIT_SHIFT;
+
+	switch (val) {
+	case 0:
+		*cur = SC2731_CURRENT_LIMIT_100;
+		break;
+
+	case 1:
+		*cur = SC2731_CURRENT_LIMIT_2000;
+		break;
+
+	case 2:
+		*cur = SC2731_CURRENT_LIMIT_900;
+		break;
+
+	case 3:
+		*cur = SC2731_CURRENT_LIMIT_500;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+sc2731_charger_usb_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = sc2731_charger_set_current(info, val->intval);
+		if (ret < 0)
+			dev_warn(info->dev, "set charge current failed\n");
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = sc2731_charger_set_current_limit(info, val->intval);
+		if (ret < 0)
+			dev_warn(info->dev, "set input current limit failed\n");
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int sc2731_charger_usb_get_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
+{
+	struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
+	u32 cur;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (info->charging)
+			val->intval = sc2731_charger_get_status(info);
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		if (!info->charging) {
+			val->intval = 0;
+			break;
+		}
+
+		ret = sc2731_charger_get_current(info, &cur);
+		if (ret)
+			return ret;
+
+		val->intval = cur;
+		break;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (!info->charging) {
+			val->intval = 0;
+			break;
+		}
+
+		ret = sc2731_charger_get_current_limit(info, &cur);
+		if (ret)
+			return ret;
+
+		val->intval = cur;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sc2731_charger_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = 1;
+		break;
+	default:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static enum power_supply_property sc2731_usb_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
+static const struct power_supply_desc sc2731_charger_desc = {
+	.name			= "sc2731_charger",
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.properties		= sc2731_usb_props,
+	.num_properties		= ARRAY_SIZE(sc2731_usb_props),
+	.get_property		= sc2731_charger_usb_get_property,
+	.set_property		= sc2731_charger_usb_set_property,
+	.property_is_writeable	= sc2731_charger_property_is_writeable,
+};
+
+static int sc2731_charger_usb_change(struct notifier_block *nb,
+				     unsigned long limit, void *data)
+{
+	struct sc2731_charger_info *info =
+		container_of(nb, struct sc2731_charger_info, usb_notify);
+	int ret;
+
+	/* set current limitation and start to charge */
+	if (limit > 0) {
+		ret = sc2731_charger_set_current_limit(info, limit);
+		if (ret)
+			return ret;
+
+		ret = sc2731_charger_set_current(info, limit);
+		if (ret)
+			return ret;
+
+		ret = sc2731_charger_start_charge(info);
+		if (ret)
+			return ret;
+
+		info->charging = true;
+		return 0;
+	}
+
+	/* Stop charging */
+	sc2731_charger_stop_charge(info);
+	info->charging = false;
+
+	return 0;
+}
+
+static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
+{
+	int ret;
+
+	/* Enable charger module */
+	ret = regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
+				 SC2731_CHARGE_EN, SC2731_CHARGE_EN);
+	if (ret)
+		return ret;
+
+	/* Set default charge termination current to 120 mA */
+	ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG2,
+				 SC2731_TERMINATION_CUR_MASK, 0x2);
+	if (ret)
+		goto error;
+
+	/* Set default charge termination voltage to 4.35V */
+	ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
+				 SC2731_TERMINATION_VOL_MASK |
+				 SC2731_TERMINATION_VOL_CAL_MASK,
+				 (0x1 << SC2731_TERMINATION_VOL_SHIFT) |
+				 (0x6 << SC2731_TERMINATION_VOL_CAL_SHIFT));
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	regmap_update_bits(info->regmap, SC2731_MODULE_EN1, SC2731_CHARGE_EN, 0);
+	return ret;
+}
+
+static int sc2731_charger_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sc2731_charger_info *info;
+	struct power_supply_config charger_cfg = { };
+	int ret;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!info->regmap) {
+		dev_err(&pdev->dev, "failed to get charger regmap\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "reg", &info->base);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get register address\n");
+		return -ENODEV;
+	}
+
+	info->dev = &pdev->dev;
+	ret = sc2731_charger_hw_init(info);
+	if (ret)
+		return ret;
+
+	charger_cfg.drv_data = info;
+	info->psy_usb = devm_power_supply_register(&pdev->dev,
+						   &sc2731_charger_desc,
+						   &charger_cfg);
+	if (IS_ERR(info->psy_usb)) {
+		dev_err(&pdev->dev, "failed to register power supply\n");
+		return PTR_ERR(info->psy_usb);
+	}
+
+	info->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "phys", 0);
+	if (IS_ERR(info->usb_phy)) {
+		dev_err(&pdev->dev, "failed to find USB phy\n");
+		return PTR_ERR(info->usb_phy);
+	}
+
+	info->usb_notify.notifier_call = sc2731_charger_usb_change;
+	ret = usb_register_notifier(info->usb_phy, &info->usb_notify);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sc2731_charger_remove(struct platform_device *pdev)
+{
+	struct sc2731_charger_info *info = platform_get_drvdata(pdev);
+
+	usb_unregister_notifier(info->usb_phy, &info->usb_notify);
+
+	return 0;
+}
+
+static const struct of_device_id sc2731_charger_of_match[] = {
+	{ .compatible = "sprd,sc2731-charger", },
+	{ }
+};
+
+static struct platform_driver sc2731_charger_driver = {
+	.driver = {
+		.name = "sc2731-charger",
+		.of_match_table = sc2731_charger_of_match,
+	},
+	.probe = sc2731_charger_probe,
+	.remove = sc2731_charger_remove,
+};
+
+module_platform_driver(sc2731_charger_driver);
+
+MODULE_DESCRIPTION("Spreadtrum SC2731 Charger Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5


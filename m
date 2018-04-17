Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDQDTR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:19:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40599 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeDQDTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:19:12 -0400
X-Google-Smtp-Source: AIpwx4+rHNrXXVmujOjvj7xEOr3EY4/+HeM7+Qw/r9fCSay4SjuAlNla3Hc2RZFHQOGUkGHzqt6ExQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaotong.lu@spreadtrum.com
Subject: [PATCH 2/2] input: misc: Add Spreadtrum vibrator driver
Date: Tue, 17 Apr 2018 11:18:24 +0800
Message-Id: <b5580f22aaed9845af9b981319d6cefa04fddd35.1523934640.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
References: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
In-Reply-To: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
References: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>

This patch adds the Spreadtrum vibrator driver, which embedded in the
Spreadtrum SC27xx series PMICs.

Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/input/misc/Kconfig        |   10 +++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/sc27xx-vibra.c |  159 +++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/input/misc/sc27xx-vibra.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 572b15f..c761c0c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -841,4 +841,14 @@ config INPUT_RAVE_SP_PWRBUTTON
 	  To compile this driver as a module, choose M here: the
 	  module will be called rave-sp-pwrbutton.
 
+config INPUT_SC27XX_VIBRA
+	tristate "Spreadtrum sc27xx vibrator support"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	select INPUT_FF_MEMLESS
+	help
+	  This option enables support for Spreadtrum sc27xx vibrator driver.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called sc27xx_vibra.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 72cde28..9d0f9d1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
 obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
 obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
 obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
+obj-$(CONFIG_INPUT_SC27XX_VIBRA)	+= sc27xx-vibra.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
diff --git a/drivers/input/misc/sc27xx-vibra.c b/drivers/input/misc/sc27xx-vibra.c
new file mode 100644
index 0000000..a34a315
--- /dev/null
+++ b/drivers/input/misc/sc27xx-vibra.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Spreadtrum Communications Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/input.h>
+#include <linux/workqueue.h>
+
+#define CUR_DRV_CAL_SEL		GENMASK(13, 12)
+#define SLP_LDOVIBR_PD_EN	BIT(9)
+#define LDO_VIBR_PD		BIT(8)
+
+struct vibra_info {
+	struct input_dev	*input_dev;
+	struct work_struct	play_work;
+	struct regmap		*regmap;
+	u32			base;
+	u32			strength;
+	bool			enabled;
+};
+
+static void sc27xx_vibra_set(struct vibra_info *info, bool on)
+{
+	if (on) {
+		regmap_update_bits(info->regmap, info->base, LDO_VIBR_PD, 0);
+		regmap_update_bits(info->regmap, info->base,
+				   SLP_LDOVIBR_PD_EN, 0);
+		info->enabled = true;
+	} else {
+		regmap_update_bits(info->regmap, info->base, LDO_VIBR_PD,
+				   LDO_VIBR_PD);
+		regmap_update_bits(info->regmap, info->base,
+				   SLP_LDOVIBR_PD_EN, SLP_LDOVIBR_PD_EN);
+		info->enabled = false;
+	}
+}
+
+static int sc27xx_vibra_hw_init(struct vibra_info *info)
+{
+	return regmap_update_bits(info->regmap, info->base, CUR_DRV_CAL_SEL, 0);
+}
+
+static void sc27xx_vibra_play_work(struct work_struct *work)
+{
+	struct vibra_info *info = container_of(work, struct vibra_info,
+					       play_work);
+
+	if (info->strength && !info->enabled)
+		sc27xx_vibra_set(info, true);
+	else if (info->enabled)
+		sc27xx_vibra_set(info, false);
+}
+
+static int sc27xx_vibra_play(struct input_dev *input, void *data,
+			     struct ff_effect *effect)
+{
+	struct vibra_info *info = input_get_drvdata(input);
+
+	info->strength = effect->u.rumble.weak_magnitude;
+	schedule_work(&info->play_work);
+
+	return 0;
+}
+
+static void sc27xx_vibra_close(struct input_dev *input)
+{
+	struct vibra_info *info = input_get_drvdata(input);
+
+	cancel_work_sync(&info->play_work);
+	if (info->enabled)
+		sc27xx_vibra_set(info, false);
+}
+
+static int sc27xx_vibra_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct vibra_info *info;
+	int ret;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!info->regmap) {
+		dev_err(&pdev->dev, "failed to get vibrator regmap.\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(node, "reg", &info->base);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get vibrator base address.\n");
+		return ret;
+	}
+
+	info->input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!info->input_dev) {
+		dev_err(&pdev->dev, "failed to allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	info->input_dev->name = "sc27xx:vibrator";
+	info->input_dev->id.version = 0;
+	info->input_dev->dev.parent = pdev->dev.parent;
+	info->input_dev->close = sc27xx_vibra_close;
+
+	input_set_drvdata(info->input_dev, info);
+	input_set_capability(info->input_dev, EV_FF, FF_RUMBLE);
+	INIT_WORK(&info->play_work, sc27xx_vibra_play_work);
+	info->enabled = false;
+
+	ret = input_ff_create_memless(info->input_dev, NULL, sc27xx_vibra_play);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register vibrator to FF.\n");
+		return ret;
+	}
+
+	ret = input_register_device(info->input_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register input device.\n");
+		input_ff_destroy(info->input_dev);
+		return ret;
+	}
+
+	ret = sc27xx_vibra_hw_init(info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize the vibrator.\n");
+		input_ff_destroy(info->input_dev);
+		input_unregister_device(info->input_dev);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, info);
+	return 0;
+}
+
+static const struct of_device_id sc27xx_vibra_of_match[] = {
+	{ .compatible = "sprd,sc27xx-vibrator", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sc27xx_vibra_of_match);
+
+static struct platform_driver sc27xx_vibra_driver = {
+	.driver = {
+		.name = "sc27xx-vibrator",
+		.of_match_table = sc27xx_vibra_of_match,
+	},
+	.probe = sc27xx_vibra_probe,
+};
+
+module_platform_driver(sc27xx_vibra_driver);
+
+MODULE_DESCRIPTION("Spreadtrum SC27xx Vibrator Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
-- 
1.7.9.5

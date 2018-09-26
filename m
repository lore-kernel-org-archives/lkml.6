Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C04C004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D5520676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="eYpcrKQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D5520676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeI0GGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:06:41 -0400
Received: from onstation.org ([52.200.56.107]:46906 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeI0GGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:06:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 935C81974;
        Wed, 26 Sep 2018 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538005876;
        bh=CtkvUjcusfmRyVcj/GW69eg8bClqP4MlAr9PnDZujFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYpcrKQcFbO05PXRyvb20T8RkQJLighzspL7TQS+k4gtwgoqRoDsKWk1ZzzIzcb7R
         Yw92RpO4bKcToEEddT1dCuueP1s833xb4XI0Azo9n0CIzWsP+H+lXQSNeQ60DeYcCp
         A4rWFhb41462iNYS2XnLPm+pGtESJNkntvWVOKDA=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
Subject: [PATCH v2 2/3] pwm: msm-vibrator: new driver for the vibrator found on various MSM SOCs
Date:   Wed, 26 Sep 2018 19:51:11 -0400
Message-Id: <20180926235112.25710-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
References: <20180926235112.25710-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new PWM vibrator driver that supports various
Qualcomm MSM SOCs. It is intended to be wired into the pwm-vibra driver
in the input/misc/ subsystem via device tree. Driver was tested on a
LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/pwm/Kconfig            |   9 ++
 drivers/pwm/Makefile           |   1 +
 drivers/pwm/pwm-msm-vibrator.c | 227 +++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/pwm/pwm-msm-vibrator.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252716f2..49dbcfd60f50 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -273,6 +273,15 @@ config PWM_MESON
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-meson.
 
+config PWM_MSM_VIBRATOR
+	tristate "Qualcomm PWM driver for the MSM vibrator"
+	help
+	  PWM support for the vibrator that is found on various Qualcomm
+          MSM SOCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-msm-vibrator.
+
 config PWM_MTK_DISP
 	tristate "MediaTek display PWM driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0dadf5..60fd9f9b0fbb 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MSM_VIBRATOR)	+= pwm-msm-vibrator.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
diff --git a/drivers/pwm/pwm-msm-vibrator.c b/drivers/pwm/pwm-msm-vibrator.c
new file mode 100644
index 000000000000..00ec40885eb4
--- /dev/null
+++ b/drivers/pwm/pwm-msm-vibrator.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm PWM driver for the MSM vibrator
+ *
+ * Copyright (c) 2018 Brian Masney <masneyb@onstation.org>
+ *
+ * Based on qcom,pwm-vibrator.c from:
+ * Copyright (c) 2018 Jonathan Marek <jonathan@marek.ca>
+ *
+ * Based on msm_pwm_vibrator.c from downstream Android sources:
+ * Copyright (C) 2009-2014 LGE, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regulator/consumer.h>
+
+#define REG_CMD_RCGR		0x00
+#define REG_CFG_RCGR		0x04
+#define REG_M			0x08
+#define REG_N			0x0C
+#define REG_D			0x10
+#define REG_CBCR		0x24
+#define MMSS_CC_M_DEFAULT	1
+
+struct msm_vibra_pwm {
+	struct pwm_chip chip;
+	struct device *dev;
+	void __iomem *base;
+	struct regulator *vcc;
+	struct clk *clk;
+	struct gpio_desc *enable_gpio;
+	bool enabled;
+};
+
+#define to_msm_vibra_pwm(pwm_chip) \
+	container_of(pwm_chip, struct msm_vibra_pwm, chip)
+
+#define msm_vibra_pwm_write(msm_pwm, offset, value) \
+	writel((value), (void __iomem *)((msm_pwm)->base + (offset)))
+
+static int msm_vibra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				int duty_ns, int period_ns)
+{
+	struct msm_vibra_pwm *msm_pwm = to_msm_vibra_pwm(chip);
+	int d_reg_val;
+
+	d_reg_val = 127 - (((duty_ns / 1000) * 126) / (period_ns / 1000));
+
+	msm_vibra_pwm_write(msm_pwm, REG_CFG_RCGR,
+			    (2 << 12) | /* dual edge mode */
+			    (0 << 8) |  /* cxo */
+			    (7 << 0));
+	msm_vibra_pwm_write(msm_pwm, REG_M, 1);
+	msm_vibra_pwm_write(msm_pwm, REG_N, 128);
+	msm_vibra_pwm_write(msm_pwm, REG_D, d_reg_val);
+	msm_vibra_pwm_write(msm_pwm, REG_CMD_RCGR, 1);
+	msm_vibra_pwm_write(msm_pwm, REG_CBCR, 1);
+
+	return 0;
+}
+
+static int msm_vibra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct msm_vibra_pwm *msm_pwm = to_msm_vibra_pwm(chip);
+	int ret;
+
+	ret = clk_set_rate(msm_pwm->clk, 24000);
+	if (ret) {
+		dev_err(msm_pwm->dev, "Failed to set clock rate: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(msm_pwm->clk);
+	if (ret) {
+		dev_err(msm_pwm->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(msm_pwm->vcc);
+	if (ret) {
+		dev_err(msm_pwm->dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(msm_pwm->enable_gpio, 1);
+	msm_pwm->enabled = true;
+
+	return 0;
+}
+
+static void msm_vibra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct msm_vibra_pwm *msm_pwm = to_msm_vibra_pwm(chip);
+
+	gpiod_set_value_cansleep(msm_pwm->enable_gpio, 0);
+	regulator_disable(msm_pwm->vcc);
+	clk_disable_unprepare(msm_pwm->clk);
+	msm_pwm->enabled = false;
+}
+
+static const struct pwm_ops msm_vibra_pwm_ops = {
+	.config = msm_vibra_pwm_config,
+	.enable = msm_vibra_pwm_enable,
+	.disable = msm_vibra_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int msm_vibra_pwm_probe(struct platform_device *pdev)
+{
+	struct msm_vibra_pwm *msm_pwm;
+	struct resource *res;
+
+	msm_pwm = devm_kzalloc(&pdev->dev, sizeof(*msm_pwm), GFP_KERNEL);
+	if (!msm_pwm)
+		return -ENOMEM;
+
+	msm_pwm->dev = &pdev->dev;
+
+	msm_pwm->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(msm_pwm->vcc)) {
+		if (PTR_ERR(msm_pwm->vcc) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get regulator: %ld\n",
+				PTR_ERR(msm_pwm->vcc));
+		return PTR_ERR(msm_pwm->vcc);
+	}
+
+	msm_pwm->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(msm_pwm->enable_gpio)) {
+		dev_err(&pdev->dev, "Failed to get enable gpio: %ld\n",
+			PTR_ERR(msm_pwm->enable_gpio));
+		return PTR_ERR(msm_pwm->enable_gpio);
+	}
+
+	msm_pwm->clk = devm_clk_get(&pdev->dev, "pwm");
+	if (IS_ERR(msm_pwm->clk)) {
+		dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
+			PTR_ERR(msm_pwm->clk));
+		return PTR_ERR(msm_pwm->clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENODEV;
+	}
+
+	msm_pwm->base = devm_ioremap(&pdev->dev, res->start,
+				     resource_size(res));
+	if (IS_ERR(msm_pwm->base)) {
+		dev_err(&pdev->dev, "Failed to iomap resource: %ld\n",
+			PTR_ERR(msm_pwm->base));
+		return PTR_ERR(msm_pwm->base);
+	}
+
+	msm_pwm->chip.dev = &pdev->dev;
+	msm_pwm->chip.ops = &msm_vibra_pwm_ops;
+	msm_pwm->enabled = false;
+	msm_pwm->chip.npwm = 1;
+	msm_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	msm_pwm->chip.of_pwm_n_cells = 3;
+
+	platform_set_drvdata(pdev, msm_pwm);
+
+	return pwmchip_add(&msm_pwm->chip);
+}
+
+static __maybe_unused int msm_vibra_pwm_suspend(struct device *dev)
+{
+	struct msm_vibra_pwm *msm_pwm = dev_get_drvdata(dev);
+	struct pwm_device *pwm = msm_pwm->chip.pwms;
+
+	if (msm_pwm->enabled)
+		msm_vibra_pwm_disable(&msm_pwm->chip, pwm);
+
+	return 0;
+}
+
+static __maybe_unused int msm_vibra_pwm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int msm_vibra_pwm_remove(struct platform_device *pdev)
+{
+	struct msm_vibra_pwm *msm_pwm = platform_get_drvdata(pdev);
+	struct pwm_device *pwm = msm_pwm->chip.pwms;
+
+	if (msm_pwm->enabled)
+		msm_vibra_pwm_disable(&msm_pwm->chip, pwm);
+
+	return pwmchip_remove(&msm_pwm->chip);
+}
+
+static const struct of_device_id msm_vibra_pwm_of_match[] = {
+	{ .compatible = "qcom,msm8226-pwm-vibrator" },
+	{ .compatible = "qcom,msm8974-pwm-vibrator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, msm_vibra_pwm_of_match);
+
+static const struct dev_pm_ops msm_vibra_pwm_pm_ops = {
+	.suspend = msm_vibra_pwm_suspend,
+	.resume  = msm_vibra_pwm_resume,
+};
+
+static struct platform_driver msm_vibra_pwm_driver = {
+	.driver = {
+		.name = "pwm-msm-vibrator",
+		.of_match_table = msm_vibra_pwm_of_match,
+		.pm = &msm_vibra_pwm_pm_ops,
+	},
+	.probe = msm_vibra_pwm_probe,
+	.remove = msm_vibra_pwm_remove,
+};
+module_platform_driver(msm_vibra_pwm_driver);
+
+MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
+MODULE_DESCRIPTION("Qualcomm PWM driver for the MSM vibrator");
+MODULE_LICENSE("GPL");
-- 
2.17.1


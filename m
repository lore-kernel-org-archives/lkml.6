Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA84205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oS1DisIF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aR/7kYit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA84205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeH2XLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93F00606DB; Wed, 29 Aug 2018 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569967;
        bh=2yCS9o7mbyLW6vKxtKTBG9+nEtf5IvrVORC9RHgB1Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS1DisIFNgQ6njOth1NSucQ66aCFyZ3vTbAnNw/xKzI1Sl4Cz3NfYG6axz8/dNYxN
         V8zHq831cqUeu5jq0BpKEsCXz8fsO6SMGyJUBOM1b94eWkb14T6m6Og2x6R1fbOi41
         rWqqFT4GI9Cb8jYN9KbRKvP8JAFOfw+vXpnRm/Yw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50FC7606FC;
        Wed, 29 Aug 2018 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569966;
        bh=2yCS9o7mbyLW6vKxtKTBG9+nEtf5IvrVORC9RHgB1Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR/7kYitSisjk9jLyKL8/YbdQvgLl5SHYLsRy/KHeLDlNp5nQsUB8BS4dyEPStiap
         mg9gbpwFdNs3JcypWgSVEwbShsRKkw/0fIuQwLk9om8zhuXPxcEI3gQylTPTENIQtO
         dS6TPW9gRXpll/65D78/BuUWlKSSjyKvWcEVtfhY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50FC7606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 2/6] reset: qcom: PDC Global (Power Domain Controller) reset controller
Date:   Thu, 30 Aug 2018 00:42:11 +0530
Message-Id: <20180829191215.10071-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
References: <20180829191215.10071-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller for SDM845 SoCs to control reset signals provided
by PDC Global for Modem, Compute, Display, GPU, Debug, AOP, Sensors,
Audio, SP and APPS

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/reset/Kconfig          |   9 +++
 drivers/reset/Makefile         |   1 +
 drivers/reset/reset-qcom-pdc.c | 124 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/reset/reset-qcom-pdc.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 13d28fdbdbb5..c21da9fe51ec 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -98,6 +98,15 @@ config RESET_QCOM_AOSS
 	  reset signals provided by AOSS for Modem, Venus, ADSP,
 	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
 
+config RESET_QCOM_PDC
+	tristate "Qualcomm PDC Reset Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This enables the PDC (Power Domain Controller) reset driver
+	  for Qualcomm Technologies Inc SDM845 SoCs. Say Y if you want
+	  to control reset signals provided by PDC for Modem, Compute,
+	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
+
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
 	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4243c38228e2..d08e8b90046a 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
+obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
new file mode 100644
index 000000000000..ab74bccd4a5b
--- /dev/null
+++ b/drivers/reset/reset-qcom-pdc.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/reset/qcom,sdm845-pdc.h>
+
+#define RPMH_PDC_SYNC_RESET	0x100
+
+struct qcom_pdc_reset_map {
+	u8 bit;
+};
+
+struct qcom_pdc_reset_data {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config sdm845_pdc_regmap_config = {
+	.name		= "pdc-reset",
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x20000,
+	.fast_io	= true,
+};
+
+static const struct qcom_pdc_reset_map sdm845_pdc_resets[] = {
+	[PDC_APPS_SYNC_RESET] = {0},
+	[PDC_SP_SYNC_RESET] = {1},
+	[PDC_AUDIO_SYNC_RESET] = {2},
+	[PDC_SENSORS_SYNC_RESET] = {3},
+	[PDC_AOP_SYNC_RESET] = {4},
+	[PDC_DEBUG_SYNC_RESET] = {5},
+	[PDC_GPU_SYNC_RESET] = {6},
+	[PDC_DISPLAY_SYNC_RESET] = {7},
+	[PDC_COMPUTE_SYNC_RESET] = {8},
+	[PDC_MODEM_SYNC_RESET] = {9},
+};
+
+static inline struct qcom_pdc_reset_data *to_qcom_pdc_reset_data(
+				struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct qcom_pdc_reset_data, rcdev);
+}
+
+static int qcom_pdc_control_assert(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
+
+	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
+				  BIT(sdm845_pdc_resets[idx].bit),
+				  BIT(sdm845_pdc_resets[idx].bit));
+}
+
+static int qcom_pdc_control_deassert(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
+
+	return regmap_update_bits(data->regmap, RPMH_PDC_SYNC_RESET,
+				  BIT(sdm845_pdc_resets[idx].bit), 0);
+}
+
+static const struct reset_control_ops qcom_pdc_reset_ops = {
+	.assert = qcom_pdc_control_assert,
+	.deassert = qcom_pdc_control_deassert,
+};
+
+static int qcom_pdc_reset_probe(struct platform_device *pdev)
+{
+	struct qcom_pdc_reset_data *data;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct resource *res;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	data->regmap = devm_regmap_init_mmio(dev, base,
+					     &sdm845_pdc_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "Unable to initialize regmap\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &qcom_pdc_reset_ops;
+	data->rcdev.nr_resets = ARRAY_SIZE(sdm845_pdc_resets);
+	data->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static const struct of_device_id qcom_pdc_reset_of_match[] = {
+	{ .compatible = "qcom,sdm845-pdc-global" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_pdc_reset_of_match);
+
+static struct platform_driver qcom_pdc_reset_driver = {
+	.probe = qcom_pdc_reset_probe,
+	.driver = {
+		.name = "qcom_pdc_reset",
+		.of_match_table = qcom_pdc_reset_of_match,
+	},
+};
+module_platform_driver(qcom_pdc_reset_driver);
+
+MODULE_DESCRIPTION("Qualcomm PDC Reset Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


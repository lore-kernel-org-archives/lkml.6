Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755011AbeDYPJg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:09:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754862AbeDYPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:09:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E29EF60F5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v4 2/5] reset: qcom: AOSS (always on subsystem) reset controller
Date: Wed, 25 Apr 2018 20:38:40 +0530
Message-Id: <20180425150843.26657-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425150843.26657-1-sibis@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller driver for Qualcomm SDM845 SoC to
control reset signals provided by AOSS for Modem, Venus
ADSP, GPU, Camera, Wireless, Display subsystem

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/reset/Kconfig           |   9 +++
 drivers/reset/Makefile          |   1 +
 drivers/reset/reset-qcom-aoss.c | 133 ++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/reset/reset-qcom-aoss.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c0b292be1b72..756ad2b27d0f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -82,6 +82,15 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_QCOM_AOSS
+	bool "Qcom AOSS Reset Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This enables the AOSS (always on subsystem) reset driver
+	  for Qualcomm SDM845 SoCs. Say Y if you want to control
+	  reset signals provided by AOSS for Modem, Venus, ADSP,
+	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
+
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
 	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index c1261dcfe9ad..6881e4d287f0 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
new file mode 100644
index 000000000000..3b0bbb387f7b
--- /dev/null
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <dt-bindings/reset/qcom,sdm845-aoss.h>
+
+struct qcom_aoss_reset_map {
+	unsigned int reg;
+};
+
+struct qcom_aoss_desc {
+	const struct qcom_aoss_reset_map *resets;
+	size_t num_resets;
+};
+
+struct qcom_aoss_reset_data {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+	const struct qcom_aoss_desc *desc;
+};
+
+static const struct qcom_aoss_reset_map sdm845_aoss_resets[] = {
+	[AOSS_CC_MSS_RESTART] = {0x0},
+	[AOSS_CC_CAMSS_RESTART] = {0x1000},
+	[AOSS_CC_VENUS_RESTART] = {0x2000},
+	[AOSS_CC_GPU_RESTART] = {0x3000},
+	[AOSS_CC_DISPSS_RESTART] = {0x4000},
+	[AOSS_CC_WCSS_RESTART] = {0x10000},
+	[AOSS_CC_LPASS_RESTART] = {0x20000},
+};
+
+static const struct qcom_aoss_desc sdm845_aoss_desc = {
+	.resets = sdm845_aoss_resets,
+	.num_resets = ARRAY_SIZE(sdm845_aoss_resets),
+};
+
+static inline struct qcom_aoss_reset_data *to_qcom_aoss_reset_data(
+				struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct qcom_aoss_reset_data, rcdev);
+}
+
+static int qcom_aoss_control_assert(struct reset_controller_dev *rcdev,
+				    unsigned long idx)
+{
+	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
+	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
+
+	writel(1, data->base + map->reg);
+	/* Wait 6 32kHz sleep cycles for reset */
+	usleep_range(200, 210);
+	return 0;
+}
+
+static int qcom_aoss_control_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long idx)
+{
+	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
+	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
+
+	writel(0, data->base + map->reg);
+	/* Wait 6 32kHz sleep cycles for reset */
+	usleep_range(200, 210);
+	return 0;
+}
+
+static int qcom_aoss_control_reset(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	qcom_aoss_control_assert(rcdev, idx);
+
+	return qcom_aoss_control_deassert(rcdev, idx);
+}
+
+static const struct reset_control_ops qcom_aoss_reset_ops = {
+	.reset = qcom_aoss_control_reset,
+	.assert = qcom_aoss_control_assert,
+	.deassert = qcom_aoss_control_deassert,
+};
+
+static int qcom_aoss_reset_probe(struct platform_device *pdev)
+{
+	struct qcom_aoss_reset_data *data;
+	struct device *dev = &pdev->dev;
+	const struct qcom_aoss_desc *desc;
+	struct resource *res;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->desc = desc;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &qcom_aoss_reset_ops;
+	data->rcdev.nr_resets = desc->num_resets;
+	data->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static const struct of_device_id qcom_aoss_reset_of_match[] = {
+	{ .compatible = "qcom,sdm845-aoss-reset", .data = &sdm845_aoss_desc },
+	{}
+};
+
+static struct platform_driver qcom_aoss_reset_driver = {
+	.probe = qcom_aoss_reset_probe,
+	.driver  = {
+		.name = "qcom_aoss_reset",
+		.of_match_table = qcom_aoss_reset_of_match,
+	},
+};
+
+builtin_platform_driver(qcom_aoss_reset_driver);
+
+MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

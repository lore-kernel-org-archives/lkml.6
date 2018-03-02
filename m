Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425635AbeCBJYr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:24:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425472AbeCBJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:24:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17796602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: sibis <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        robh+dt@kernel.org, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/6] reset: qcom: AOSS (Always on subsystem) reset controller
Date: Fri,  2 Mar 2018 14:53:34 +0530
Message-Id: <1519982619-28336-2-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
References: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller driver for Qualcomm SDM845 SoC to
control reset signals provided by AOSS for Modem, Venus
ADSP, GPU, Camera, Wireless, Display subsystem

Signed-off-by: sibis <sibis@codeaurora.org>
---
 .../devicetree/bindings/reset/qcom,aoss-reset.txt  |  54 +++++++
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-qcom-aoss.c                    | 161 +++++++++++++++++++++
 include/dt-bindings/reset/qcom,aoss-sdm845.h       |  17 +++
 5 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 drivers/reset/reset-qcom-aoss.c
 create mode 100644 include/dt-bindings/reset/qcom,aoss-sdm845.h

diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
new file mode 100644
index 0000000..5318e14
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
@@ -0,0 +1,54 @@
+Qualcomm AOSS Reset Controller
+======================================
+
+This binding describes a reset-controller found on AOSS (Always on SubSysem)
+for Qualcomm SDM845 SoCs.
+
+Required properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be:
+		    "qcom,aoss-reset-sdm845", "syscon"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the
+		    syscon device.
+
+
+- #reset-cells:
+	Usage: required
+	Value type: <uint>
+	Definition: must be 1; cell entry represents the reset index.
+
+example:
+
+aoss_reset: qcom,reset-controller@b2e0100 {
+	compatible = "qcom,aoss-reset-sdm845", "syscon";
+	reg = <0xc2b0000 0x20004>;
+	#reset-cells = <1>;
+};
+
+
+Specifying reset lines connected to IP modules
+==============================================
+
+Device nodes that need access to reset lines should
+specify them as a reset phandle in their corresponding node as
+specified in reset.txt.
+
+Example:
+
+	modem-pil@4080000 {
+		...
+
+		resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
+		reset-names = "mss_restart";
+
+		...
+        };
+
+For list of all valid reset indicies see
+<dt-bindings/reset/qcom,aoss-sdm845.h>
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7fc7769..4b1da86 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -81,6 +81,16 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_QCOM_AOSS
+	bool "Qcom AOSS Reset Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This enables the AOSS (Always On SubSystem) reset driver
+	  for Qcom SoCs. Say Y if you want to control reset signals
+	  provided by AOSS for Modem, Venus, ADSP, GPU, Camera,
+	  Wireless, Display subsystem. Otherwise, say N.
+
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
 	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 132c24f..c30044a 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
new file mode 100644
index 0000000..eb8c69b
--- /dev/null
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+#include <linux/of_device.h>
+#include <dt-bindings/reset/qcom,aoss-sdm845.h>
+
+struct qcom_aoss_reset_map {
+	unsigned int reg;
+	u8 bit;
+};
+
+struct qcom_aoss_desc {
+	const struct regmap_config *config;
+	const struct qcom_aoss_reset_map *resets;
+	int delay;
+	size_t num_resets;
+};
+
+struct qcom_aoss_reset_data {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+	const struct qcom_aoss_desc *desc;
+};
+
+static const struct regmap_config aoss_sdm845_regmap_config = {
+	.name		= "aoss-reset",
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x20000,
+	.fast_io	= true,
+};
+
+static const struct qcom_aoss_reset_map aoss_sdm845_resets[] = {
+	[AOSS_CC_MSS_RESTART] = { 0x0, 0 },
+	[AOSS_CC_CAMSS_RESTART] = { 0x1000, 0 },
+	[AOSS_CC_VENUS_RESTART] = { 0x2000, 0 },
+	[AOSS_CC_GPU_RESTART] = { 0x3000, 0 },
+	[AOSS_CC_DISPSS_RESTART] = { 0x4000, 0 },
+	[AOSS_CC_WCSS_RESTART] = { 0x10000, 0 },
+	[AOSS_CC_LPASS_RESTART] = { 0x20000, 0 },
+};
+
+static const struct qcom_aoss_desc aoss_sdm845_desc = {
+	.config = &aoss_sdm845_regmap_config,
+	.resets = aoss_sdm845_resets,
+	/* Wait 6 32kHz sleep cycles for reset */
+	.delay = 200,
+	.num_resets = ARRAY_SIZE(aoss_sdm845_resets),
+};
+
+static struct qcom_aoss_reset_data *to_qcom_aoss_reset_data(
+				struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct qcom_aoss_reset_data, rcdev);
+}
+
+static int qcom_aoss_control_assert(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
+	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
+
+	if (idx >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap, map->reg,
+					BIT(map->bit), BIT(map->bit));
+}
+
+static int qcom_aoss_control_deassert(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
+	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
+
+	if (idx >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap, map->reg, BIT(map->bit), 0);
+}
+
+static int qcom_aoss_control_reset(struct reset_controller_dev *rcdev,
+					unsigned long idx)
+{
+	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
+	int ret;
+
+	ret = rcdev->ops->assert(rcdev, idx);
+	if (ret)
+		return ret;
+
+	udelay(data->desc->delay);
+
+	ret = rcdev->ops->deassert(rcdev, idx);
+	if (ret)
+		return ret;
+
+	return 0;
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
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->desc = desc;
+	data->regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "Unable to get aoss-reset regmap");
+		return PTR_ERR(data->regmap);
+	}
+	regmap_attach_dev(dev, data->regmap, desc->config);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &qcom_aoss_reset_ops;
+	data->rcdev.nr_resets = desc->num_resets;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+}
+
+static const struct of_device_id qcom_aoss_reset_of_match[] = {
+	{ .compatible = "qcom,aoss-reset-sdm845", .data = &aoss_sdm845_desc},
+	{}
+};
+
+static struct platform_driver qcom_aoss_reset_driver = {
+	.probe = qcom_aoss_reset_probe,
+	.driver  = {
+		.name  = "qcom_aoss_reset",
+		.of_match_table = qcom_aoss_reset_of_match,
+	},
+};
+
+builtin_platform_driver(qcom_aoss_reset_driver);
+
+MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/reset/qcom,aoss-sdm845.h b/include/dt-bindings/reset/qcom,aoss-sdm845.h
new file mode 100644
index 0000000..e9b38fc
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,aoss-sdm845.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
+#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
+
+#define AOSS_CC_MSS_RESTART	0
+#define AOSS_CC_CAMSS_RESTART	1
+#define AOSS_CC_VENUS_RESTART	2
+#define AOSS_CC_GPU_RESTART	3
+#define AOSS_CC_DISPSS_RESTART	4
+#define AOSS_CC_WCSS_RESTART	5
+#define AOSS_CC_LPASS_RESTART	6
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

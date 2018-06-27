Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F97C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892D026175
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ih/OvKy1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PRe5jGqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892D026175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965208AbeF0OZ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:25:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965062AbeF0OZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:25:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 371E560B10; Wed, 27 Jun 2018 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530109524;
        bh=6oqiUu+F5qoo5sysj153WgmrgKsqJUnEtFwleAW+JmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ih/OvKy1ixtc83QW6DVZdf+Ay6eRQJPsT7v1zEhsPMk93KqooZIWrlj1v/ci/PF+n
         RzJKkr5UihBz160HGeHD6hQ3CZvLYXfs63vVu0ZJzclpA4uZHRwdOzKAuk2gDCLqMt
         sob6RZL4IH48zmJM5el4k/W3HanBgZVdFQ6i7dM4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1425160AD8;
        Wed, 27 Jun 2018 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530109523;
        bh=6oqiUu+F5qoo5sysj153WgmrgKsqJUnEtFwleAW+JmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRe5jGqYEf/03noNNK76W3wb4kglco0p0jDyIhZ5aCo+FOQ76LMv9be0VNv+lKlDT
         2zFZkHqn4GmGeZKF5Xq+Zq3jHY5wxaZYa9qpE633y5fJoVIyFd94+yhGLjC4jCKYg6
         5ZgKe6EZWrZctBqN0wzXVL0IeIZdCfP7cLMJt7bk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1425160AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        kyan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v6 2/8] reset: qcom: AOSS (always on subsystem) reset controller
Date:   Wed, 27 Jun 2018 19:54:43 +0530
Message-Id: <20180627142443.1570-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180627142443.1570-1-sibis@codeaurora.org>
References: <20180627142443.1570-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller driver for Qualcomm SDM845 SoC to
control reset signals provided by AOSS for Modem, Venus
ADSP, GPU, Camera, Wireless, Display subsystem

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
index 000000000000..36db96750450
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
+	[AOSS_CC_MSS_RESTART] = {0x10000},
+	[AOSS_CC_CAMSS_RESTART] = {0x11000},
+	[AOSS_CC_VENUS_RESTART] = {0x12000},
+	[AOSS_CC_GPU_RESTART] = {0x13000},
+	[AOSS_CC_DISPSS_RESTART] = {0x14000},
+	[AOSS_CC_WCSS_RESTART] = {0x20000},
+	[AOSS_CC_LPASS_RESTART] = {0x30000},
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
+	usleep_range(200, 300);
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
+	usleep_range(200, 300);
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
+	{ .compatible = "qcom,sdm845-aoss-cc", .data = &sdm845_aoss_desc },
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


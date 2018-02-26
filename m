Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeBZJy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:54:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeBZJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:54:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4843C60BEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v7 04/15] clk: qcom: Add HFPLL driver
Date: Mon, 26 Feb 2018 15:23:20 +0530
Message-Id: <1519638811-17269-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
References: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

On some devices (MSM8974 for example), the HFPLLs are
instantiated within the Krait processor subsystem as separate
register regions. Add a driver for these PLLs so that we can
provide HFPLL clocks for use by the system.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |  8 ++++
 drivers/clk/qcom/Makefile |  1 +
 drivers/clk/qcom/hfpll.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/qcom/hfpll.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index fbf4532..d9ae51e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -226,3 +226,11 @@ config SPMI_PMIC_CLKDIV
 	  Technologies, Inc. SPMI PMIC. It configures the frequency of
 	  clkdiv outputs of the PMIC. These clocks are typically wired
 	  through alternate functions on GPIO pins.
+
+config QCOM_HFPLL
+	tristate "High-Frequency PLL (HFPLL) Clock Controller"
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the high-frequency PLLs present on Qualcomm devices.
+	  Say Y if you want to support CPU frequency scaling on devices
+	  such as MSM8974, APQ8084, etc.
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index a2b7888..c57b808 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
+obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
new file mode 100644
index 0000000..a6de7101
--- /dev/null
+++ b/drivers/clk/qcom/hfpll.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "clk-regmap.h"
+#include "clk-hfpll.h"
+
+static const struct hfpll_data hdata = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x430405d,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.user_val = 0x8,
+	.user_vco_mask = 0x100000,
+	.low_vco_max_rate = 1248000000,
+	.min_rate = 537600000UL,
+	.max_rate = 2900000000UL,
+};
+
+static const struct of_device_id qcom_hfpll_match_table[] = {
+	{ .compatible = "qcom,hfpll" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
+
+static const struct regmap_config hfpll_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x30,
+	.fast_io	= true,
+};
+
+static int qcom_hfpll_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *regmap;
+	struct clk_hfpll *h;
+	struct clk_init_data init = {
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_ops_hfpll,
+	};
+
+	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, &hfpll_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (of_property_read_string_index(dev->of_node, "clock-output-names",
+					  0, &init.name))
+		return -ENODEV;
+
+	h->d = &hdata;
+	h->clkr.hw.init = &init;
+	spin_lock_init(&h->lock);
+
+	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
+}
+
+static struct platform_driver qcom_hfpll_driver = {
+	.probe		= qcom_hfpll_probe,
+	.driver		= {
+		.name	= "qcom-hfpll",
+		.of_match_table = qcom_hfpll_match_table,
+	},
+};
+module_platform_driver(qcom_hfpll_driver);
+
+MODULE_DESCRIPTION("QCOM HFPLL Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-hfpll");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

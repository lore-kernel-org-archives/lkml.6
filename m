Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D821756
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OajXVGms";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YYmGbSCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186D821756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHNPAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:00:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbeHNPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:00:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDCA460D6E; Tue, 14 Aug 2018 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248797;
        bh=vkgik63fQnC5F0q0Dkx/H5aRKK0JF1ogIuXm2mb5mYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OajXVGmswgkNhnwdOq8umFC7dAM/KTE4TN/HhKr5S708bysCQP9g3OHwR36FY2HNW
         tlYNy35JgvZn2I6bH37+/oLULnWRNoezxm7+pJmU0TjR3jCJZDrOQbAJAy1jH34o5C
         XED4adS7WMY5ZcbA9jF5QkAg/sIn7wcBbeFj/p4E=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C31C60BF4;
        Tue, 14 Aug 2018 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248787;
        bh=vkgik63fQnC5F0q0Dkx/H5aRKK0JF1ogIuXm2mb5mYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYmGbSCjKHNwGvC6xhR2Rk7/rRba3ba9LOF0zFqym3wlZ8PRYp2l2UcEDl8Kds53F
         KfMdbVVEAZQhXJUxLHS+5d5vkI7vmq0oDPdYuTf2IJcGkxr250lynLl6zD4sPxh/lF
         TO8CLRRkBTyI42/r9QQURuPvMvtlSChrCqaBwJGU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C31C60BF4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH v12 03/14] clk: qcom: Add HFPLL driver
Date:   Tue, 14 Aug 2018 17:42:22 +0530
Message-Id: <1534248753-2440-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

On some devices (MSM8974 for example), the HFPLLs are
instantiated within the Krait processor subsystem as separate
register regions. Add a driver for these PLLs so that we can
provide HFPLL clocks for use by the system.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |  8 ++++
 drivers/clk/qcom/Makefile |  1 +
 drivers/clk/qcom/hfpll.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/clk/qcom/hfpll.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0647686..21aec10 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -272,3 +272,11 @@ config SPMI_PMIC_CLKDIV
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
index 7818e6c..f82eeac 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
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


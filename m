Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EAE4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30452208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bTcANZU1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGyb34SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30452208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeFNHje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:39:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeFNHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:39:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC3CA607BB; Thu, 14 Jun 2018 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961968;
        bh=VxJzi5PVrCuNSU5GFC7kBuSoKOxaIwkp4Jm5T/hS2WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTcANZU1twAwkNbbIZrzPMCG7xny2DsDgIhyMKyY4e1r+VDTaMVqme4CW7iqGluF9
         9IfnqDYHgBNoskwh9+GzQWf3asehU0KlkWnWaCt88PLj/nlsBpG2lKjExcBISJAF/C
         ppuX2Yo8JxS05KegFX8hNx+duBXTm1iQhwRbEfLg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81822602B8;
        Thu, 14 Jun 2018 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961967;
        bh=VxJzi5PVrCuNSU5GFC7kBuSoKOxaIwkp4Jm5T/hS2WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGyb34SIhHAN2HSQ5pKfNMMuEIZ0+9hOb3MfEB305uWcPUUQDdBqZFy2iAMWwLHoh
         dK04STPbqHlm2Jdxpza5SOimxFGmuHkVzwWhZMOziyFoKaIKeMBHg/KIZvjy6ss2mc
         Ti6rsluHF9x3lobnk5r7LoY6sY2tVRP03s9gV5nI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81822602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Thu, 14 Jun 2018 13:09:03 +0530
Message-Id: <1528961943-12506-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
References: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the lpass clock controller found on SDM845 based devices.
This would allow lpass peripheral loader drivers to control the clocks to
bring the subsystem out of reset.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/Kconfig          |   9 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/lpasscc-sdm845.c | 252 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9c3480d..06b3f2e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -245,6 +245,15 @@ config SDM_VIDEOCC_845
 	  Say Y if you want to support video devices and functionality such as
 	  video encode and decode.

+config SDM_LPASSCC_845
+	tristate "SDM845 LPASS Clock Controller"
+	depends on COMMON_CLK_QCOM
+	select SDM_GCC_845
+	help
+	  Support for the LPASS clock controller on SDM845 devices.
+	  Say Y if you want to use the LPASS branch clocks of the LPASS clock
+	  controller to reset the LPASS subsystem.
+
 config SPMI_PMIC_CLKDIV
 	tristate "SPMI PMIC clkdiv Support"
 	depends on (COMMON_CLK_QCOM && SPMI) || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 762c011..799b9d7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
+obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
new file mode 100644
index 0000000..d04a4c8
--- /dev/null
+++ b/drivers/clk/qcom/lpasscc-sdm845.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,lpass-sdm845.h>
+
+#include "clk-regmap.h"
+#include "clk-branch.h"
+#include "common.h"
+
+static struct clk_branch gcc_lpass_q6_axi_clk = {
+	.halt_reg = 0x0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_lpass_q6_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+struct clk_branch gcc_lpass_sway_clk = {
+	.halt_reg = 0x8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_lpass_sway_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_audio_wrapper_aon_clk = {
+	.halt_reg = 0x098,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_audio_wrapper_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_q6ss_ahbm_aon_clk = {
+	.halt_reg = 0x12000,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x12000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_q6ss_ahbm_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_q6ss_ahbs_aon_clk = {
+	.halt_reg = 0x1f000,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x1f000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_q6ss_ahbs_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_qdsp6ss_xo_clk = {
+	.halt_reg = 0x18,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x18,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_xo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_qdsp6ss_sleep_clk = {
+	.halt_reg = 0x1c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x1c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_qdsp6ss_core_clk = {
+	.halt_reg = 0x0,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct regmap_config lpass_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.fast_io	= true,
+};
+
+static struct clk_regmap *lpass_gcc_sdm845_clocks[] = {
+	[GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
+	[GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
+};
+
+static const struct qcom_cc_desc lpass_gcc_sdm845_desc = {
+	.config = &lpass_regmap_config,
+	.clks = lpass_gcc_sdm845_clocks,
+	.num_clks = ARRAY_SIZE(lpass_gcc_sdm845_clocks),
+};
+
+static const struct of_device_id lpass_gcc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-lpass-gcc" },
+	{ }
+};
+
+static struct clk_regmap *lpass_cc_sdm845_clocks[] = {
+	[LPASS_AUDIO_WRAPPER_AON_CLK] = &lpass_audio_wrapper_aon_clk.clkr,
+	[LPASS_Q6SS_AHBM_AON_CLK] = &lpass_q6ss_ahbm_aon_clk.clkr,
+	[LPASS_Q6SS_AHBS_AON_CLK] = &lpass_q6ss_ahbs_aon_clk.clkr,
+};
+
+static const struct qcom_cc_desc lpass_cc_sdm845_desc = {
+	.config = &lpass_regmap_config,
+	.clks = lpass_cc_sdm845_clocks,
+	.num_clks = ARRAY_SIZE(lpass_cc_sdm845_clocks),
+};
+
+static const struct of_device_id lpasscc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-lpass-cc" },
+	{ }
+};
+
+static struct clk_regmap *lpass_qdsp6ss_sdm845_clocks[] = {
+	[LPASS_QDSP6SS_XO_CLK] = &lpass_qdsp6ss_xo_clk.clkr,
+	[LPASS_QDSP6SS_SLEEP_CLK] = &lpass_qdsp6ss_sleep_clk.clkr,
+	[LPASS_QDSP6SS_CORE_CLK] = &lpass_qdsp6ss_core_clk.clkr,
+};
+
+static const struct qcom_cc_desc lpass_qdsp6ss_sdm845_desc = {
+	.config = &lpass_regmap_config,
+	.clks = lpass_qdsp6ss_sdm845_clocks,
+	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sdm845_clocks),
+};
+
+static const struct of_device_id lpass_qdsp6_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-lpass-qdsp6ss" },
+	{ }
+};
+
+static int lpass_clocks_sdm845_probe(struct platform_device *pdev,
+				     struct device_node *np,
+				     const struct qcom_cc_desc *desc)
+{
+	struct regmap *regmap;
+	struct resource res;
+	void __iomem *base;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENOMEM;
+
+	base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
+	if (IS_ERR(base))
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
+	if (!regmap)
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(pdev, desc, regmap);
+}
+
+/* LPASS CC clock controller */
+static const struct of_device_id lpass_cc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-lpasscc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
+
+static int lpass_cc_sdm845_probe(struct platform_device *pdev)
+{
+	struct device_node *cp;
+	const struct qcom_cc_desc *desc;
+	int ret;
+
+	for_each_available_child_of_node(pdev->dev.of_node, cp) {
+		if (of_match_node(lpass_gcc_sdm845_match_table, cp)) {
+			lpass_regmap_config.name = "lpass_gcc";
+			desc = &lpass_gcc_sdm845_desc;
+		} else if (of_match_node(lpasscc_sdm845_match_table, cp)) {
+			lpass_regmap_config.name = "lpass_cc";
+			desc = &lpass_cc_sdm845_desc;
+		} else if (of_match_node(lpass_qdsp6_sdm845_match_table, cp)) {
+			lpass_regmap_config.name = "lpass_qdsp6ss";
+			desc = &lpass_qdsp6ss_sdm845_desc;
+		} else {
+			dev_err(&pdev->dev, "LPASS child node not defined\n");
+			return -EINVAL;
+		}
+
+		ret = lpass_clocks_sdm845_probe(pdev, cp, desc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver lpass_cc_sdm845_driver = {
+	.probe		= lpass_cc_sdm845_probe,
+	.driver		= {
+		.name	= "sdm845-lpasscc",
+		.of_match_table = lpass_cc_sdm845_match_table,
+	},
+};
+
+static int __init lpass_cc_sdm845_init(void)
+{
+	return platform_driver_register(&lpass_cc_sdm845_driver);
+}
+subsys_initcall(lpass_cc_sdm845_init);
+
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.


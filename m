Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50C620831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jAVwynDr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eHu6Nx3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50C620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392777AbeKVSch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:32:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49174 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKVScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:32:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 39B7460A98; Thu, 22 Nov 2018 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873259;
        bh=9QuWEXaEYW62G0J1TR560WBzVBBvJr3zqypFMpw8/fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAVwynDrDkNORR15QM6Vez7bxVgj7lBWg4eiXNNfzktHbecr3XdnKGG9eBB4k+RH2
         sCi30yr3c7SYG5HPrXRqOIUEZblJPqHEVP+xOGDX1JCZrdeCtZ5eMd78iEp0miEoSG
         1S7Khoz/YgORHa2cXV+2UxH2GUoVbAJBkyajmhOM=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE49860A98;
        Thu, 22 Nov 2018 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542873256;
        bh=9QuWEXaEYW62G0J1TR560WBzVBBvJr3zqypFMpw8/fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHu6Nx3ipLfU9jaNhWX9v0//bGQkSjfz5GjQE2+ORz48NdmbChfZdhYvdjzpxtWD3
         4bvthL7o6wcmIdYUJ+UwW4sGH0zJHOsSvp/ya8bi4y0bY2VMDJsCFHLrJPDlkLZCx5
         q+nxyb/jkSVQzc/qVlvZfkeIgxmk3W0BP8mwjUqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE49860A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v10 3/3] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Thu, 22 Nov 2018 13:23:41 +0530
Message-Id: <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the lpass clock controller found on SDM845 based devices.
This would allow lpass peripheral loader drivers to control the clocks to
bring the subsystem out of reset.
LPASS clocks present on the global clock controller would be registered
with the clock framework based on the protected-clock flag. Also do not
gate these clocks if they are left unused, as the lpass clocks require
the global clock controller lpass clocks to be enabled before they are
accessed. Mark the GCC lpass clocks as CRITICAL, for the LPASS clock
access.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/Kconfig          |   9 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/gcc-sdm845.c     |  30 +++++++
 drivers/clk/qcom/lpasscc-sdm845.c | 179 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a611531..23adc4c 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -293,6 +293,15 @@ config SDM_DISPCC_845
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen.

+config SDM_LPASSCC_845
+	tristate "SDM845 Low Power Audio Subsystem (LPAAS) Clock Controller"
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
index 981882e..3d530b1 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SDM_CAMCC_845) += camcc-sdm845.o
 obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SDM_GCC_660) += gcc-sdm660.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
+obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index f133b7f..ba8ff99 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3153,6 +3153,34 @@ enum {
 	},
 };

+static struct clk_branch gcc_lpass_q6_axi_clk = {
+	.halt_reg = 0x47000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x47000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_lpass_q6_axi_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_lpass_sway_clk = {
+	.halt_reg = 0x47008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x47008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_lpass_sway_clk",
+			.flags = CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
 	.pd = {
@@ -3453,6 +3481,8 @@ enum {
 	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
 	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
 	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
+	[GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
+	[GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
 };

 static const struct qcom_reset_map gcc_sdm845_resets[] = {
diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
new file mode 100644
index 0000000..9c63542
--- /dev/null
+++ b/drivers/clk/qcom/lpasscc-sdm845.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
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
+static struct clk_branch lpass_qdsp6ss_core_clk = {
+	.halt_reg = 0x20,
+	/* CLK_OFF would not toggle until LPASS is not out of reset */
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x20,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_qdsp6ss_xo_clk = {
+	.halt_reg = 0x38,
+	/* CLK_OFF would not toggle until LPASS is not out of reset */
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x38,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_xo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch lpass_qdsp6ss_sleep_clk = {
+	.halt_reg = 0x3c,
+	/* CLK_OFF would not toggle until LPASS is not out of reset */
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x3c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "lpass_qdsp6ss_sleep_clk",
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
+static struct clk_regmap *lpass_cc_sdm845_clocks[] = {
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
+static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int index,
+				     const struct qcom_cc_desc *desc)
+{
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(pdev, desc, regmap);
+}
+
+static int lpass_cc_sdm845_probe(struct platform_device *pdev)
+{
+	const struct qcom_cc_desc *desc;
+	int ret;
+
+	lpass_regmap_config.name = "cc";
+	desc = &lpass_cc_sdm845_desc;
+
+	ret = lpass_clocks_sdm845_probe(pdev, 0, desc);
+	if (ret)
+		return ret;
+
+	lpass_regmap_config.name = "qdsp6ss";
+	desc = &lpass_qdsp6ss_sdm845_desc;
+
+	return lpass_clocks_sdm845_probe(pdev, 1, desc);
+}
+
+static const struct of_device_id lpass_cc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-lpasscc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
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
+static void __exit lpass_cc_sdm845_exit(void)
+{
+	platform_driver_unregister(&lpass_cc_sdm845_driver);
+}
+module_exit(lpass_cc_sdm845_exit);
+
+MODULE_DESCRIPTION("QTI LPASS_CC SDM845 Driver");
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.


Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D75C4161B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3592082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jth30/Fz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ivzZwTK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3592082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeKYP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:26:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeKYP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:26:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F2E860877; Sun, 25 Nov 2018 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543120595;
        bh=Re3B2wLU3xloGYCvOs05Ul2z+lPfeWO+0tFV7Kgpt4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jth30/FzmahOmr6XiLxK644gIi6sapSAOe8xyU6X1qJ2588dScKCQkLh7d9zxCGxe
         ndQrRsKjzkBzdHVKQ689KTVJ/aPEgEML6cQoQLqFyUgvKv1aRs/358DdhaJiNbxEa3
         VycuVmyl87NcTF0iM6Qbnstvyyx38rVrpqoNq62Q=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C09C960541;
        Sun, 25 Nov 2018 04:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543120593;
        bh=Re3B2wLU3xloGYCvOs05Ul2z+lPfeWO+0tFV7Kgpt4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivzZwTK83KZ4N79RD/wny0obI6gVJ8Kc8lYE6RBG6suJu15lBO/LJ+ezAQlo6cdb+
         TFatF+wRteJplSBQbk9a3jR4fSJ34OZm2fxSV1GvnzWHpcazSFTF+cJziv88jHBdmw
         6nNYNjoaOZdbh9niPBToBFBxfYALNdylVTzLF/bk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C09C960541
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
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4 2/2] clk: qcom: Add graphics clock controller driver for SDM845
Date:   Sun, 25 Nov 2018 10:06:08 +0530
Message-Id: <1543120569-14444-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
References: <1543120569-14444-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

Add support for the graphics clock controller found on SDM845
based devices. This would allow graphics drivers to probe and
control their clocks.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/Kconfig        |   9 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/gpucc-sdm845.c | 231 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sdm845.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a611531..6f3e466 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -273,6 +273,15 @@ config SDM_GCC_845
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2C, USB, UFS, SDDC, PCIe, etc.

+config SDM_GPUCC_845
+	tristate "SDM845 Graphics Clock Controller"
+	depends on COMMON_CLK_QCOM
+	select SDM_GCC_845
+	help
+	  Support for the graphics clock controller on SDM845 devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SDM_VIDEOCC_845
 	tristate "SDM845 Video Clock Controller"
 	depends on COMMON_CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 981882e..6ed2827 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SDM_CAMCC_845) += camcc-sdm845.o
 obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SDM_GCC_660) += gcc-sdm660.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
+obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
new file mode 100644
index 0000000..11222f4
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
+
+#include "common.h"
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "gdsc.h"
+
+#define CX_GMU_CBCR_SLEEP_MASK		0xf
+#define CX_GMU_CBCR_SLEEP_SHIFT		4
+#define CX_GMU_CBCR_WAKE_MASK		0xf
+#define CX_GMU_CBCR_WAKE_SHIFT		8
+#define CLK_DIS_WAIT_SHIFT		12
+#define CLK_DIS_WAIT_MASK		(0xf << CLK_DIS_WAIT_SHIFT)
+
+enum {
+	P_BI_TCXO,
+	P_CORE_BI_PLL_TEST_SE,
+	P_GPLL0_OUT_MAIN,
+	P_GPLL0_OUT_MAIN_DIV,
+	P_GPU_CC_PLL1_OUT_EVEN,
+	P_GPU_CC_PLL1_OUT_MAIN,
+	P_GPU_CC_PLL1_OUT_ODD,
+};
+
+static const struct parent_map gpu_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GPLL0_OUT_MAIN, 5 },
+	{ P_GPLL0_OUT_MAIN_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const gpu_cc_parent_names_0[] = {
+	"bi_tcxo",
+	"gpu_cc_pll1",
+	"gcc_gpu_gpll0_clk_src",
+	"gcc_gpu_gpll0_div_clk_src",
+	"core_bi_pll_test_se",
+};
+
+static const struct alpha_pll_config gpu_cc_pll1_config = {
+	.l = 0x1a,
+	.alpha = 0xaab,
+};
+
+static struct clk_alpha_pll gpu_cc_pll1 = {
+	.offset = 0x100,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll1",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
+	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_gmu_clk_src = {
+	.cmd_rcgr = 0x1120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_0,
+	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_gmu_clk_src",
+		.parent_names = gpu_cc_parent_names_0,
+		.num_parents = 6,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_branch gpu_cc_cx_gmu_clk = {
+	.halt_reg = 0x1098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_gmu_clk",
+			.parent_names = (const char *[]){
+				"gpu_cc_gmu_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_clk = {
+	.halt_reg = 0x109c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x109c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cxo_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc gpu_cx_gdsc = {
+	.gdscr = 0x106c,
+	.gds_hw_ctrl = 0x1540,
+	.pd = {
+		.name = "gpu_cx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc gpu_gx_gdsc = {
+	.gdscr = 0x100c,
+	.clamp_io_ctrl = 0x1508,
+	.pd = {
+		.name = "gpu_gx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = CLAMP_IO | AON_RESET | POLL_CFG_GDSCR,
+};
+
+static struct clk_regmap *gpu_cc_sdm845_clocks[] = {
+	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
+	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
+};
+
+static struct gdsc *gpu_cc_sdm845_gdscs[] = {
+	[GPU_CX_GDSC] = &gpu_cx_gdsc,
+	[GPU_GX_GDSC] = &gpu_gx_gdsc,
+};
+
+static const struct regmap_config gpu_cc_sdm845_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x8008,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc gpu_cc_sdm845_desc = {
+	.config = &gpu_cc_sdm845_regmap_config,
+	.clks = gpu_cc_sdm845_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sdm845_clocks),
+	.gdscs = gpu_cc_sdm845_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpu_cc_sdm845_gdscs),
+};
+
+static const struct of_device_id gpu_cc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpu_cc_sdm845_match_table);
+
+static int gpu_cc_sdm845_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	unsigned int value, mask;
+	int ret;
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sdm845_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
+
+	/*
+	 * Configure gpu_cc_cx_gmu_clk with recommended
+	 * wakeup/sleep settings
+	 */
+	mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
+	mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
+	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
+	regmap_update_bits(regmap, 0x1098, mask, value);
+
+	/* Configure clk_dis_wait for gpu_cx_gdsc */
+	regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
+						8 << CLK_DIS_WAIT_SHIFT);
+
+	ret = qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver gpu_cc_sdm845_driver = {
+	.probe = gpu_cc_sdm845_probe,
+	.driver = {
+		.name = "sdm845-gpucc",
+		.of_match_table = gpu_cc_sdm845_match_table,
+	},
+};
+
+static int __init gpu_cc_sdm845_init(void)
+{
+	return platform_driver_register(&gpu_cc_sdm845_driver);
+}
+subsys_initcall(gpu_cc_sdm845_init);
+
+static void __exit gpu_cc_sdm845_exit(void)
+{
+	platform_driver_unregister(&gpu_cc_sdm845_driver);
+}
+module_exit(gpu_cc_sdm845_exit);
+
+MODULE_DESCRIPTION("QTI GPUCC SDM845 Driver");
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.


Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F72C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CC2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g6aJOG+v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oQ3MrSOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfA3Qgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:36:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbfA3Qgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:36:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8250260ADF; Wed, 30 Jan 2019 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866190;
        bh=yXWdexEnY/66pl1eyIfJm+3GENa1HXOyxIntiC5ghhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6aJOG+v9SkAMaUZ1+XZF7BzOc6kVB4llNQk4YiS/swpZARTgEnKGbtGYbTyS/e6b
         s8CheAZbwu6mJilqjbefhNpllJdxZnxWgpOoU02/Xy28y+ee35NyMDxRHzximIV2Qt
         oN4oN2/+ZUY42bQL74qP4tM7Iwh2iMdQrNWEQYbw=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E352F60C6A;
        Wed, 30 Jan 2019 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866180;
        bh=yXWdexEnY/66pl1eyIfJm+3GENa1HXOyxIntiC5ghhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQ3MrSOholDWdwtZBr/HWSkkrkxIp/bEX6cqw5F5Mq828Q6Ymkq4CtZhHTUvRsgAx
         qBjTRC3ETuXGNldYIa1BCuShDZEpCvpMo0Lm2oftiTaH+n+zY1W12+jRR3wX/qEbs6
         +hpojC0+U9MD0A88Bykp11WOAY+XohzBZphv+aFc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E352F60C6A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v1 3/4] clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
Date:   Wed, 30 Jan 2019 09:36:11 -0700
Message-Id: <1548866171-30341-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the multimedia clock controller found on MSM8998
based devices. This should allow most multimedia device drivers
to probe and control their clocks.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/mmcc-msm8998.c               | 2937 +++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8998.h |  210 ++
 4 files changed, 3157 insertions(+)
 create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1c04575c..6c36603 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -221,6 +221,15 @@ config MSM_GCC_8998
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2c, USB, UFS, SD/eMMC, PCIe, etc.
 
+config MSM_MMCC_8998
+	tristate "MSM8998 Multimedia Clock Controller"
+	select MSM_GCC_8998
+	select QCOM_GDSC
+	help
+	  Support for the multimedia clock controller on msm8998 devices.
+	  Say Y if you want to support multimedia devices such as display,
+	  graphics, video encode/decode, camera, etc.
+
 config QCS_GCC_404
 	tristate "QCS404 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ee8d069..d6de24b 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MSM_GCC_8998) += gcc-msm8998.o
 obj-$(CONFIG_MSM_MMCC_8960) += mmcc-msm8960.o
 obj-$(CONFIG_MSM_MMCC_8974) += mmcc-msm8974.o
 obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
+obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8998.o
 obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
 obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
new file mode 100644
index 0000000..5ad2e2a
--- /dev/null
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -0,0 +1,2937 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/clk.h>
+
+#include <dt-bindings/clock/qcom,mmcc-msm8998.h>
+
+#include "common.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-alpha-pll.h"
+#include "clk-rcg.h"
+#include "clk-branch.h"
+#include "reset.h"
+#include "gdsc.h"
+
+enum {
+	P_XO,
+	P_GPLL0,
+	P_GPLL0_DIV,
+	P_MMPLL0_OUT_EVEN,
+	P_MMPLL1_OUT_EVEN,
+	P_MMPLL3_OUT_EVEN,
+	P_MMPLL4_OUT_EVEN,
+	P_MMPLL5_OUT_EVEN,
+	P_MMPLL6_OUT_EVEN,
+	P_MMPLL7_OUT_EVEN,
+	P_MMPLL10_OUT_EVEN,
+	P_DSI0PLL,
+	P_DSI1PLL,
+	P_DSI0PLL_BYTE,
+	P_DSI1PLL_BYTE,
+	P_HDMIPLL,
+	P_DPVCO,
+	P_DPLINK,
+	P_CORE_BI_PLL_TEST_SE,
+};
+
+static const struct parent_map mmss_xo_hdmi_map[] = {
+	{ P_XO, 0 },
+	{ P_HDMIPLL, 1 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_hdmi[] = {
+	"mmss_xo",
+	"hdmi_phy_pll_out",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_dsi0pll_dsi1pll_map[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL, 1 },
+	{ P_DSI1PLL, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_dsi0pll_dsi1pll[] = {
+	"mmss_xo",
+	"dsi0_phy_pll_out_dsiclk",
+	"dsi1_phy_pll_out_dsiclk",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_dsibyte_map[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL_BYTE, 1 },
+	{ P_DSI1PLL_BYTE, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_dsibyte[] = {
+	"mmss_xo",
+	"dsi0_phy_pll_out_byteclk",
+	"dsi1_phy_pll_out_byteclk",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_dp_map[] = {
+	{ P_XO, 0 },
+	{ P_DPLINK, 1 },
+	{ P_DPVCO, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_dp[] = {
+	"mmss_xo",
+	"dp_phy_pll_link_clk",
+	"dp_phy_pll_vco_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_MMPLL1_OUT_EVEN, 2 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmpll1_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_MMPLL5_OUT_EVEN, 2 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmpll5_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_MMPLL3_OUT_EVEN, 3 },
+	{ P_MMPLL6_OUT_EVEN, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmpll3_out_even",
+	"mmpll6_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL4_OUT_EVEN, 1 },
+	{ P_MMPLL7_OUT_EVEN, 2 },
+	{ P_MMPLL10_OUT_EVEN, 3 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll4_out_even",
+	"mmpll7_out_even",
+	"mmpll10_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_MMPLL7_OUT_EVEN, 2 },
+	{ P_MMPLL10_OUT_EVEN, 3 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmpll7_out_even",
+	"mmpll10_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+static const struct parent_map mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0_OUT_EVEN, 1 },
+	{ P_MMPLL4_OUT_EVEN, 2 },
+	{ P_MMPLL7_OUT_EVEN, 3 },
+	{ P_MMPLL10_OUT_EVEN, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 }
+};
+
+static const char * const mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div[] = {
+	"mmss_xo",
+	"mmpll0_out_even",
+	"mmpll4_out_even",
+	"mmpll7_out_even",
+	"mmpll10_out_even",
+	"mmss_gpll0",
+	"mmss_gpll0_div",
+	"core_bi_pll_test_se"
+};
+
+/* dummy clocks to avoid significant re-parenting in probe */
+static struct clk_init_data dummy_xo_init = {
+		.name = "mmss_xo",
+		/* parent_names assigned in probe */
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+};
+static struct clk_fixed_factor dummy_xo = {
+	.mult = 1,
+	.div = 1,
+	.hw.init = &dummy_xo_init,
+};
+
+static struct clk_init_data dummy_gpll0_init = {
+		.name = "mmss_gpll0",
+		/* parent_names assigned in probe */
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+};
+static struct clk_fixed_factor dummy_gpll0 = {
+	.mult = 1,
+	.div = 1,
+	.hw.init = &dummy_gpll0_init,
+};
+/* end dummy clocks */
+
+static struct clk_fixed_factor gpll0_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "mmss_gpll0_div",
+		.parent_names = (const char *[]){ "mmss_gpll0" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static const struct clk_div_table post_div_table_fabia_even[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ 0x3, 4 },
+	{ 0x7, 8 },
+	{ }
+};
+
+static struct clk_alpha_pll mmpll0 = {
+	.offset = 0xc000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x1e0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll0",
+			.parent_names = (const char *[]){ "mmss_xo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll0_out_even = {
+	.offset = 0xc000,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll0_out_even",
+		.parent_names = (const char *[]){ "mmpll0" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll1 = {
+	.offset = 0xc050,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x1e0,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll1",
+			.parent_names = (const char *[]){ "mmss_xo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll1_out_even = {
+	.offset = 0xc050,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll1_out_even",
+		.parent_names = (const char *[]){ "mmpll1" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll3 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll3",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll3_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll3_out_even",
+		.parent_names = (const char *[]){ "mmpll3" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll4 = {
+	.offset = 0x50,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll4",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll4_out_even = {
+	.offset = 0x50,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll4_out_even",
+		.parent_names = (const char *[]){ "mmpll4" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll5 = {
+	.offset = 0xa0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll5",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll5_out_even = {
+	.offset = 0xa0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll5_out_even",
+		.parent_names = (const char *[]){ "mmpll5" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll6 = {
+	.offset = 0xf0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll6",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll6_out_even = {
+	.offset = 0xf0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll6_out_even",
+		.parent_names = (const char *[]){ "mmpll6" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll7 = {
+	.offset = 0x140,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll7",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll7_out_even = {
+	.offset = 0x140,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll7_out_even",
+		.parent_names = (const char *[]){ "mmpll7" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll mmpll10 = {
+	.offset = 0x190,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll10",
+		.parent_names = (const char *[]){ "mmss_xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_fixed_fabia_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv mmpll10_out_even = {
+	.offset = 0x190,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mmpll10_out_even",
+		.parent_names = (const char *[]){ "mmpll10" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static struct clk_rcg2 byte0_clk_src = {
+	.cmd_rcgr = 0x2120,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte0_clk_src",
+		.parent_names = mmss_xo_dsibyte,
+		.num_parents = 4,
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_rcg2 byte1_clk_src = {
+	.cmd_rcgr = 0x2140,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte1_clk_src",
+		.parent_names = mmss_xo_dsibyte,
+		.num_parents = 4,
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct freq_tbl ftbl_cci_clk_src[] = {
+	F(37500000, P_GPLL0, 16, 0, 0),
+	F(50000000, P_GPLL0, 12, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cci_clk_src = {
+	.cmd_rcgr = 0x3300,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_cci_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cci_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cpp_clk_src[] = {
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(384000000, P_MMPLL4_OUT_EVEN, 2, 0, 0),
+	F(404000000, P_MMPLL0_OUT_EVEN, 2, 0, 0),
+	F(480000000, P_MMPLL7_OUT_EVEN, 2, 0, 0),
+	F(576000000, P_MMPLL10_OUT_EVEN, 1, 0, 0),
+	F(600000000, P_GPLL0, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cpp_clk_src = {
+	.cmd_rcgr = 0x3640,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_cpp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cpp_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi_clk_src[] = {
+	F(164571429, P_MMPLL10_OUT_EVEN, 3.5, 0, 0),
+	F(256000000, P_MMPLL4_OUT_EVEN, 3, 0, 0),
+	F(274290000, P_MMPLL7_OUT_EVEN, 3.5, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(384000000, P_MMPLL4_OUT_EVEN, 2, 0, 0),
+	F(576000000, P_MMPLL10_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0_clk_src = {
+	.cmd_rcgr = 0x3090,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi1_clk_src = {
+	.cmd_rcgr = 0x3100,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi2_clk_src = {
+	.cmd_rcgr = 0x3160,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi3_clk_src = {
+	.cmd_rcgr = 0x31c0,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi3_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csiphy_clk_src[] = {
+	F(164571429, P_MMPLL10_OUT_EVEN, 3.5, 0, 0),
+	F(256000000, P_MMPLL4_OUT_EVEN, 3, 0, 0),
+	F(274290000, P_MMPLL7_OUT_EVEN, 3.5, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(384000000, P_MMPLL4_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csiphy_clk_src = {
+	.cmd_rcgr = 0x3800,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csiphy_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csiphy_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csiphytimer_clk_src[] = {
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(269333333, P_MMPLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x3000,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csiphytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0phytimer_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x3030,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csiphytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1phytimer_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi2phytimer_clk_src = {
+	.cmd_rcgr = 0x3060,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csiphytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2phytimer_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_aux_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_aux_clk_src = {
+	.cmd_rcgr = 0x2260,
+	.hid_width = 5,
+	.parent_map = mmss_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_dp_aux_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_aux_clk_src",
+		.parent_names = mmss_xo_gpll0_gpll0_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_crypto_clk_src[] = {
+	F(101250, P_DPLINK, 1, 5, 16),
+	F(168750, P_DPLINK, 1, 5, 16),
+	F(337500, P_DPLINK, 1, 5, 16),
+	{ }
+};
+
+static struct clk_rcg2 dp_crypto_clk_src = {
+	.cmd_rcgr = 0x2220,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dp_map,
+	.freq_tbl = ftbl_dp_crypto_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_crypto_clk_src",
+		.parent_names = mmss_xo_dp,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_link_clk_src[] = {
+	F(162000, P_DPLINK, 2, 0, 0),
+	F(270000, P_DPLINK, 2, 0, 0),
+	F(540000, P_DPLINK, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_link_clk_src = {
+	.cmd_rcgr = 0x2200,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dp_map,
+	.freq_tbl = ftbl_dp_link_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_link_clk_src",
+		.parent_names = mmss_xo_dp,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_pixel_clk_src[] = {
+	F(154000000, P_DPVCO, 1, 0, 0),
+	F(337500000, P_DPVCO, 2, 0, 0),
+	F(675000000, P_DPVCO, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_pixel_clk_src = {
+	.cmd_rcgr = 0x2240,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dp_map,
+	.freq_tbl = ftbl_dp_pixel_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_pixel_clk_src",
+		.parent_names = mmss_xo_dp,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_esc_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 esc0_clk_src = {
+	.cmd_rcgr = 0x2160,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsibyte_map,
+	.freq_tbl = ftbl_esc_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc0_clk_src",
+		.parent_names = mmss_xo_dsibyte,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 esc1_clk_src = {
+	.cmd_rcgr = 0x2180,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsibyte_map,
+	.freq_tbl = ftbl_esc_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc1_clk_src",
+		.parent_names = mmss_xo_dsibyte,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_extpclk_clk_src[] = {
+	{ .src = P_HDMIPLL },
+	{ }
+};
+
+static struct clk_rcg2 extpclk_clk_src = {
+	.cmd_rcgr = 0x2060,
+	.hid_width = 5,
+	.parent_map = mmss_xo_hdmi_map,
+	.freq_tbl = ftbl_extpclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "extpclk_clk_src",
+		.parent_names = mmss_xo_hdmi,
+		.num_parents = 3,
+		.ops = &clk_byte_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct freq_tbl ftbl_fd_core_clk_src[] = {
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(404000000, P_MMPLL0_OUT_EVEN, 2, 0, 0),
+	F(480000000, P_MMPLL7_OUT_EVEN, 2, 0, 0),
+	F(576000000, P_MMPLL10_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 fd_core_clk_src = {
+	.cmd_rcgr = 0x3b00,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_fd_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "fd_core_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_hdmi_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 hdmi_clk_src = {
+	.cmd_rcgr = 0x2100,
+	.hid_width = 5,
+	.parent_map = mmss_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_hdmi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "hdmi_clk_src",
+		.parent_names = mmss_xo_gpll0_gpll0_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_jpeg0_clk_src[] = {
+	F(75000000, P_GPLL0, 8, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(320000000, P_MMPLL7_OUT_EVEN, 3, 0, 0),
+	F(480000000, P_MMPLL7_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 jpeg0_clk_src = {
+	.cmd_rcgr = 0x3500,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_jpeg0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "jpeg0_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_maxi_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(75000000, P_GPLL0_DIV, 4, 0, 0),
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(323200000, P_MMPLL0_OUT_EVEN, 2.5, 0, 0),
+	F(406000000, P_MMPLL1_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 maxi_clk_src = {
+	.cmd_rcgr = 0xf020,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_maxi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "maxi_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mclk_clk_src[] = {
+	F(4800000, P_XO, 4, 0, 0),
+	F(6000000, P_GPLL0_DIV, 10, 1, 5),
+	F(8000000, P_GPLL0_DIV, 1, 2, 75),
+	F(9600000, P_XO, 2, 0, 0),
+	F(16666667, P_GPLL0_DIV, 2, 1, 9),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_GPLL0_DIV, 1, 2, 25),
+	F(33333333, P_GPLL0_DIV, 1, 2, 9),
+	F(48000000, P_GPLL0, 1, 2, 25),
+	F(66666667, P_GPLL0, 1, 2, 9),
+	{ }
+};
+
+static struct clk_rcg2 mclk0_clk_src = {
+	.cmd_rcgr = 0x3360,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk0_clk_src",
+		.parent_names = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk1_clk_src = {
+	.cmd_rcgr = 0x3390,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk1_clk_src",
+		.parent_names = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk2_clk_src = {
+	.cmd_rcgr = 0x33c0,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk2_clk_src",
+		.parent_names = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk3_clk_src = {
+	.cmd_rcgr = 0x33f0,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk3_clk_src",
+		.parent_names = mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mdp_clk_src[] = {
+	F(85714286, P_GPLL0, 7, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(275000000, P_MMPLL5_OUT_EVEN, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(330000000, P_MMPLL5_OUT_EVEN, 2.5, 0, 0),
+	F(412500000, P_MMPLL5_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 mdp_clk_src = {
+	.cmd_rcgr = 0x2040,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mdp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mdp_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vsync_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vsync_clk_src = {
+	.cmd_rcgr = 0x2080,
+	.hid_width = 5,
+	.parent_map = mmss_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_vsync_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vsync_clk_src",
+		.parent_names = mmss_xo_gpll0_gpll0_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ahb_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(40000000, P_GPLL0, 15, 0, 0),
+	F(80800000, P_MMPLL0_OUT_EVEN, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ahb_clk_src = {
+	.cmd_rcgr = 0x5000,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ahb_clk_src",
+		.parent_names = mmss_xo_mmpll0_gpll0_gpll0_div,
+		.num_parents = 5,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_axi_clk_src[] = {
+	F(75000000, P_GPLL0, 8, 0, 0),
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(240000000, P_GPLL0, 2.5, 0, 0),
+	F(323200000, P_MMPLL0_OUT_EVEN, 2.5, 0, 0),
+	F(406000000, P_MMPLL0_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+/* RO to linux */
+static struct clk_rcg2 axi_clk_src = {
+	.cmd_rcgr = 0xd000,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_axi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "axi_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 pclk0_clk_src = {
+	.cmd_rcgr = 0x2000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsi0pll_dsi1pll_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk0_clk_src",
+		.parent_names = mmss_xo_dsi0pll_dsi1pll,
+		.num_parents = 4,
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_rcg2 pclk1_clk_src = {
+	.cmd_rcgr = 0x2020,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmss_xo_dsi0pll_dsi1pll_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk1_clk_src",
+		.parent_names = mmss_xo_dsi0pll_dsi1pll,
+		.num_parents = 4,
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct freq_tbl ftbl_rot_clk_src[] = {
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(275000000, P_MMPLL5_OUT_EVEN, 3, 0, 0),
+	F(330000000, P_MMPLL5_OUT_EVEN, 2.5, 0, 0),
+	F(412500000, P_MMPLL5_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 rot_clk_src = {
+	.cmd_rcgr = 0x21a0,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_rot_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "rot_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_core_clk_src[] = {
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(269330000, P_MMPLL0_OUT_EVEN, 3, 0, 0),
+	F(355200000, P_MMPLL6_OUT_EVEN, 2.5, 0, 0),
+	F(444000000, P_MMPLL6_OUT_EVEN, 2, 0, 0),
+	F(533000000, P_MMPLL3_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_core_clk_src = {
+	.cmd_rcgr = 0x1000,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_video_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "video_core_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 video_subcore0_clk_src = {
+	.cmd_rcgr = 0x1060,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_video_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "video_subcore0_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 video_subcore1_clk_src = {
+	.cmd_rcgr = 0x1080,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_video_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "video_subcore1_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vfe_clk_src[] = {
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(320000000, P_MMPLL7_OUT_EVEN, 3, 0, 0),
+	F(384000000, P_MMPLL4_OUT_EVEN, 2, 0, 0),
+	F(404000000, P_MMPLL0_OUT_EVEN, 2, 0, 0),
+	F(480000000, P_MMPLL7_OUT_EVEN, 2, 0, 0),
+	F(576000000, P_MMPLL10_OUT_EVEN, 1, 0, 0),
+	F(600000000, P_GPLL0, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vfe0_clk_src = {
+	.cmd_rcgr = 0x3600,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_vfe_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe0_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 vfe1_clk_src = {
+	.cmd_rcgr = 0x3620,
+	.hid_width = 5,
+	.parent_map = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_vfe_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe1_clk_src",
+		.parent_names = mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 8,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch misc_ahb_clk = {
+	.halt_reg = 0x328,
+	.clkr = {
+		.enable_reg = 0x328,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "misc_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch video_core_clk = {
+	.halt_reg = 0x1028,
+	.clkr = {
+		.enable_reg = 0x1028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_core_clk",
+			.parent_names = (const char *[]){ "video_core_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch video_ahb_clk = {
+	.halt_reg = 0x1030,
+	.clkr = {
+		.enable_reg = 0x1030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch video_axi_clk = {
+	.halt_reg = 0x1034,
+	.clkr = {
+		.enable_reg = 0x1034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_maxi_clk = {
+	.halt_reg = 0x1038,
+	.clkr = {
+		.enable_reg = 0x1038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_maxi_clk",
+			.parent_names = (const char *[]){ "maxi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch video_subcore0_clk = {
+	.halt_reg = 0x1048,
+	.clkr = {
+		.enable_reg = 0x1048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_subcore0_clk",
+			.parent_names = (const char *[]){ "video_subcore0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch video_subcore1_clk = {
+	.halt_reg = 0x104c,
+	.clkr = {
+		.enable_reg = 0x104c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_subcore1_clk",
+			.parent_names = (const char *[]){ "video_subcore1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_ahb_clk = {
+	.halt_reg = 0x2308,
+	.clkr = {
+		.enable_reg = 0x2308,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_hdmi_dp_ahb_clk = {
+	.halt_reg = 0x230c,
+	.clkr = {
+		.enable_reg = 0x230c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_hdmi_dp_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_axi_clk = {
+	.halt_reg = 0x2310,
+	.clkr = {
+		.enable_reg = 0x2310,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_pclk0_clk = {
+	.halt_reg = 0x2314,
+	.clkr = {
+		.enable_reg = 0x2314,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_pclk0_clk",
+			.parent_names = (const char *[]){ "pclk0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_pclk1_clk = {
+	.halt_reg = 0x2318,
+	.clkr = {
+		.enable_reg = 0x2318,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_pclk1_clk",
+			.parent_names = (const char *[]){ "pclk1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_mdp_clk = {
+	.halt_reg = 0x231c,
+	.clkr = {
+		.enable_reg = 0x231c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_mdp_clk",
+			.parent_names = (const char *[]){ "mdp_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_mdp_lut_clk = {
+	.halt_reg = 0x2320,
+	.clkr = {
+		.enable_reg = 0x2320,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_mdp_lut_clk",
+			.parent_names = (const char *[]){ "mdp_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_extpclk_clk = {
+	.halt_reg = 0x2324,
+	.clkr = {
+		.enable_reg = 0x2324,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_extpclk_clk",
+			.parent_names = (const char *[]){ "extpclk_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_vsync_clk = {
+	.halt_reg = 0x2328,
+	.clkr = {
+		.enable_reg = 0x2328,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_vsync_clk",
+			.parent_names = (const char *[]){ "vsync_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_hdmi_clk = {
+	.halt_reg = 0x2338,
+	.clkr = {
+		.enable_reg = 0x2338,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_hdmi_clk",
+			.parent_names = (const char *[]){ "hdmi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte0_clk = {
+	.halt_reg = 0x233c,
+	.clkr = {
+		.enable_reg = 0x233c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte0_clk",
+			.parent_names = (const char *[]){ "byte0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte1_clk = {
+	.halt_reg = 0x2340,
+	.clkr = {
+		.enable_reg = 0x2340,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte1_clk",
+			.parent_names = (const char *[]){ "byte1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_esc0_clk = {
+	.halt_reg = 0x2344,
+	.clkr = {
+		.enable_reg = 0x2344,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_esc0_clk",
+			.parent_names = (const char *[]){ "esc0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_esc1_clk = {
+	.halt_reg = 0x2348,
+	.clkr = {
+		.enable_reg = 0x2348,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_esc1_clk",
+			.parent_names = (const char *[]){ "esc1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_rot_clk = {
+	.halt_reg = 0x2350,
+	.clkr = {
+		.enable_reg = 0x2350,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_rot_clk",
+			.parent_names = (const char *[]){ "rot_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_link_clk = {
+	.halt_reg = 0x2354,
+	.clkr = {
+		.enable_reg = 0x2354,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_link_clk",
+			.parent_names = (const char *[]){ "dp_link_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_link_intf_clk = {
+	.halt_reg = 0x2358,
+	.clkr = {
+		.enable_reg = 0x2358,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_link_intf_clk",
+			.parent_names = (const char *[]){ "dp_link_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_crypto_clk = {
+	.halt_reg = 0x235c,
+	.clkr = {
+		.enable_reg = 0x235c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_crypto_clk",
+			.parent_names = (const char *[]){ "dp_crypto_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_pixel_clk = {
+	.halt_reg = 0x2360,
+	.clkr = {
+		.enable_reg = 0x2360,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_pixel_clk",
+			.parent_names = (const char *[]){ "dp_pixel_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_aux_clk = {
+	.halt_reg = 0x2364,
+	.clkr = {
+		.enable_reg = 0x2364,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_aux_clk",
+			.parent_names = (const char *[]){ "dp_aux_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte0_intf_clk = {
+	.halt_reg = 0x2374,
+	.clkr = {
+		.enable_reg = 0x2374,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte0_intf_clk",
+			.parent_names = (const char *[]){ "byte0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte1_intf_clk = {
+	.halt_reg = 0x2378,
+	.clkr = {
+		.enable_reg = 0x2378,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte1_intf_clk",
+			.parent_names = (const char *[]){ "byte1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0phytimer_clk = {
+	.halt_reg = 0x3024,
+	.clkr = {
+		.enable_reg = 0x3024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0phytimer_clk",
+			.parent_names = (const char *[]){ "csi0phytimer_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1phytimer_clk = {
+	.halt_reg = 0x3054,
+	.clkr = {
+		.enable_reg = 0x3054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1phytimer_clk",
+			.parent_names = (const char *[]){ "csi1phytimer_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2phytimer_clk = {
+	.halt_reg = 0x3084,
+	.clkr = {
+		.enable_reg = 0x3084,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2phytimer_clk",
+			.parent_names = (const char *[]){ "csi2phytimer_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0_clk = {
+	.halt_reg = 0x30b4,
+	.clkr = {
+		.enable_reg = 0x30b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0_clk",
+			.parent_names = (const char *[]){ "csi0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0_ahb_clk = {
+	.halt_reg = 0x30bc,
+	.clkr = {
+		.enable_reg = 0x30bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0rdi_clk = {
+	.halt_reg = 0x30d4,
+	.clkr = {
+		.enable_reg = 0x30d4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0rdi_clk",
+			.parent_names = (const char *[]){ "csi0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0pix_clk = {
+	.halt_reg = 0x30e4,
+	.clkr = {
+		.enable_reg = 0x30e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0pix_clk",
+			.parent_names = (const char *[]){ "csi0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1_clk = {
+	.halt_reg = 0x3124,
+	.clkr = {
+		.enable_reg = 0x3124,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1_clk",
+			.parent_names = (const char *[]){ "csi1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1_ahb_clk = {
+	.halt_reg = 0x3128,
+	.clkr = {
+		.enable_reg = 0x3128,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1rdi_clk = {
+	.halt_reg = 0x3144,
+	.clkr = {
+		.enable_reg = 0x3144,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1rdi_clk",
+			.parent_names = (const char *[]){ "csi1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1pix_clk = {
+	.halt_reg = 0x3154,
+	.clkr = {
+		.enable_reg = 0x3154,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1pix_clk",
+			.parent_names = (const char *[]){ "csi1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2_clk = {
+	.halt_reg = 0x3184,
+	.clkr = {
+		.enable_reg = 0x3184,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2_clk",
+			.parent_names = (const char *[]){ "csi2_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2_ahb_clk = {
+	.halt_reg = 0x3188,
+	.clkr = {
+		.enable_reg = 0x3188,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2rdi_clk = {
+	.halt_reg = 0x31a4,
+	.clkr = {
+		.enable_reg = 0x31a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2rdi_clk",
+			.parent_names = (const char *[]){ "csi2_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2pix_clk = {
+	.halt_reg = 0x31b4,
+	.clkr = {
+		.enable_reg = 0x31b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2pix_clk",
+			.parent_names = (const char *[]){ "csi2_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3_clk = {
+	.halt_reg = 0x31e4,
+	.clkr = {
+		.enable_reg = 0x31e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3_clk",
+			.parent_names = (const char *[]){ "csi3_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3_ahb_clk = {
+	.halt_reg = 0x31e8,
+	.clkr = {
+		.enable_reg = 0x31e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3rdi_clk = {
+	.halt_reg = 0x3204,
+	.clkr = {
+		.enable_reg = 0x3204,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3rdi_clk",
+			.parent_names = (const char *[]){ "csi3_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3pix_clk = {
+	.halt_reg = 0x3214,
+	.clkr = {
+		.enable_reg = 0x3214,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3pix_clk",
+			.parent_names = (const char *[]){ "csi3_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_ispif_ahb_clk = {
+	.halt_reg = 0x3224,
+	.clkr = {
+		.enable_reg = 0x3224,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_ispif_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cci_clk = {
+	.halt_reg = 0x3344,
+	.clkr = {
+		.enable_reg = 0x3344,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cci_clk",
+			.parent_names = (const char *[]){ "cci_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cci_ahb_clk = {
+	.halt_reg = 0x3348,
+	.clkr = {
+		.enable_reg = 0x3348,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cci_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk0_clk = {
+	.halt_reg = 0x3384,
+	.clkr = {
+		.enable_reg = 0x3384,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk0_clk",
+			.parent_names = (const char *[]){ "mclk0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk1_clk = {
+	.halt_reg = 0x33b4,
+	.clkr = {
+		.enable_reg = 0x33b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk1_clk",
+			.parent_names = (const char *[]){ "mclk1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk2_clk = {
+	.halt_reg = 0x33e4,
+	.clkr = {
+		.enable_reg = 0x33e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk2_clk",
+			.parent_names = (const char *[]){ "mclk2_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk3_clk = {
+	.halt_reg = 0x3414,
+	.clkr = {
+		.enable_reg = 0x3414,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk3_clk",
+			.parent_names = (const char *[]){ "mclk3_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_top_ahb_clk = {
+	.halt_reg = 0x3484,
+	.clkr = {
+		.enable_reg = 0x3484,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_top_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_ahb_clk = {
+	.halt_reg = 0x348c,
+	.clkr = {
+		.enable_reg = 0x348c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_micro_ahb_clk = {
+	.halt_reg = 0x3494,
+	.clkr = {
+		.enable_reg = 0x3494,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_micro_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg0_clk = {
+	.halt_reg = 0x35a8,
+	.clkr = {
+		.enable_reg = 0x35a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg0_clk",
+			.parent_names = (const char *[]){ "jpeg0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg_ahb_clk = {
+	.halt_reg = 0x35b4,
+	.clkr = {
+		.enable_reg = 0x35b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg_axi_clk = {
+	.halt_reg = 0x35b8,
+	.clkr = {
+		.enable_reg = 0x35b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_ahb_clk = {
+	.halt_reg = 0x3668,
+	.clkr = {
+		.enable_reg = 0x3668,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_ahb_clk = {
+	.halt_reg = 0x3678,
+	.clkr = {
+		.enable_reg = 0x3678,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_clk = {
+	.halt_reg = 0x36a8,
+	.clkr = {
+		.enable_reg = 0x36a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_clk",
+			.parent_names = (const char *[]){ "vfe0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_clk = {
+	.halt_reg = 0x36ac,
+	.clkr = {
+		.enable_reg = 0x36ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_clk",
+			.parent_names = (const char *[]){ "vfe1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_clk = {
+	.halt_reg = 0x36b0,
+	.clkr = {
+		.enable_reg = 0x36b0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_clk",
+			.parent_names = (const char *[]){ "cpp_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_ahb_clk = {
+	.halt_reg = 0x36b4,
+	.clkr = {
+		.enable_reg = 0x36b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe_vbif_ahb_clk = {
+	.halt_reg = 0x36b8,
+	.clkr = {
+		.enable_reg = 0x36b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe_vbif_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe_vbif_axi_clk = {
+	.halt_reg = 0x36bc,
+	.clkr = {
+		.enable_reg = 0x36bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe_vbif_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_axi_clk = {
+	.halt_reg = 0x36c4,
+	.clkr = {
+		.enable_reg = 0x36c4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_vbif_ahb_clk = {
+	.halt_reg = 0x36c8,
+	.clkr = {
+		.enable_reg = 0x36c8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_vbif_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi_vfe0_clk = {
+	.halt_reg = 0x3704,
+	.clkr = {
+		.enable_reg = 0x3704,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi_vfe0_clk",
+			.parent_names = (const char *[]){ "vfe0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csi_vfe1_clk = {
+	.halt_reg = 0x3714,
+	.clkr = {
+		.enable_reg = 0x3714,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi_vfe1_clk",
+			.parent_names = (const char *[]){ "vfe1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_stream_clk = {
+	.halt_reg = 0x3720,
+	.clkr = {
+		.enable_reg = 0x3720,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_stream_clk",
+			.parent_names = (const char *[]){ "vfe0_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_stream_clk = {
+	.halt_reg = 0x3724,
+	.clkr = {
+		.enable_reg = 0x3724,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_stream_clk",
+			.parent_names = (const char *[]){ "vfe1_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid0_clk = {
+	.halt_reg = 0x3730,
+	.clkr = {
+		.enable_reg = 0x3730,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid0_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid1_clk = {
+	.halt_reg = 0x3734,
+	.clkr = {
+		.enable_reg = 0x3734,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid1_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid2_clk = {
+	.halt_reg = 0x3738,
+	.clkr = {
+		.enable_reg = 0x3738,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid2_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid3_clk = {
+	.halt_reg = 0x373c,
+	.clkr = {
+		.enable_reg = 0x373c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid3_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy0_clk = {
+	.halt_reg = 0x3740,
+	.clkr = {
+		.enable_reg = 0x3740,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy0_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy1_clk = {
+	.halt_reg = 0x3744,
+	.clkr = {
+		.enable_reg = 0x3744,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy1_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy2_clk = {
+	.halt_reg = 0x3748,
+	.clkr = {
+		.enable_reg = 0x3748,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy2_clk",
+			.parent_names = (const char *[]){ "csiphy_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch fd_core_clk = {
+	.halt_reg = 0x3b68,
+	.clkr = {
+		.enable_reg = 0x3b68,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "fd_core_clk",
+			.parent_names = (const char *[]){ "fd_core_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch fd_core_uar_clk = {
+	.halt_reg = 0x3b6c,
+	.clkr = {
+		.enable_reg = 0x3b6c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "fd_core_uar_clk",
+			.parent_names = (const char *[]){ "fd_core_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch fd_ahb_clk = {
+	.halt_reg = 0x3b74,
+	.clkr = {
+		.enable_reg = 0x3b74,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "fd_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch mnoc_ahb_clk = {
+	.halt_reg = 0x5024,
+	.clkr = {
+		.enable_reg = 0x5024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mnoc_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch bimc_smmu_ahb_clk = {
+	.halt_reg = 0xe004,
+	.clkr = {
+		.enable_reg = 0xe004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "bimc_smmu_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch bimc_smmu_axi_clk = {
+	.halt_reg = 0xe008,
+	.clkr = {
+		.enable_reg = 0xe008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "bimc_smmu_axi_clk",
+			.parent_names = (const char *[]){ "axi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mnoc_maxi_clk = {
+	.halt_reg = 0xf004,
+	.clkr = {
+		.enable_reg = 0xf004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mnoc_maxi_clk",
+			.parent_names = (const char *[]){ "maxi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch vmem_maxi_clk = {
+	.halt_reg = 0xf064,
+	.clkr = {
+		.enable_reg = 0xf064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "vmem_maxi_clk",
+			.parent_names = (const char *[]){ "maxi_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_branch vmem_ahb_clk = {
+	.halt_reg = 0xf068,
+	.clkr = {
+		.enable_reg = 0xf068,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "vmem_ahb_clk",
+			.parent_names = (const char *[]){ "ahb_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static struct clk_hw *mmcc_msm8998_hws[] = {
+	&dummy_xo.hw,
+	&dummy_gpll0.hw,
+	&gpll0_div.hw,
+};
+
+static struct gdsc video_top_gdsc = {
+	.gdscr = 0x1024,
+	.pd = {
+		.name = "video_top",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc video_subcore0_gdsc = {
+	.gdscr = 0x1040,
+	.pd = {
+		.name = "video_subcore0",
+	},
+	.parent = &video_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc video_subcore1_gdsc = {
+	.gdscr = 0x1044,
+	.pd = {
+		.name = "video_subcore1",
+	},
+	.parent = &video_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x2304,
+	.cxcs = (unsigned int []){ 0x2310, 0x2350, 0x231c, 0x2320 },
+	.cxc_count = 4,
+	.pd = {
+		.name = "mdss",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_top_gdsc = {
+	.gdscr = 0x34a0,
+	.cxcs = (unsigned int []){ 0x35b8, 0x36c4, 0x3704, 0x3714, 0x3494,
+				   0x35a8, 0x3868 },
+	.cxc_count = 7,
+	.pd = {
+		.name = "camss_top",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_vfe0_gdsc = {
+	.gdscr = 0x3664,
+	.pd = {
+		.name = "camss_vfe0",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_vfe1_gdsc = {
+	.gdscr = 0x3674,
+	.pd = {
+		.name = "camss_vfe1_gdsc",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_cpp_gdsc = {
+	.gdscr = 0x36d4,
+	.pd = {
+		.name = "camss_cpp",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc bimc_smmu_gdsc = {
+	.gdscr = 0xe020,
+	.gds_hw_ctrl = 0xe024,
+	.pd = {
+		.name = "bimc_smmu",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
+};
+
+static struct clk_regmap *mmcc_msm8998_clocks[] = {
+	[MMPLL0] = &mmpll0.clkr,
+	[MMPLL0_OUT_EVEN] = &mmpll0_out_even.clkr,
+	[MMPLL1] = &mmpll1.clkr,
+	[MMPLL1_OUT_EVEN] = &mmpll1_out_even.clkr,
+	[MMPLL3] = &mmpll3.clkr,
+	[MMPLL3_OUT_EVEN] = &mmpll3_out_even.clkr,
+	[MMPLL4] = &mmpll4.clkr,
+	[MMPLL4_OUT_EVEN] = &mmpll4_out_even.clkr,
+	[MMPLL5] = &mmpll5.clkr,
+	[MMPLL5_OUT_EVEN] = &mmpll5_out_even.clkr,
+	[MMPLL6] = &mmpll6.clkr,
+	[MMPLL6_OUT_EVEN] = &mmpll6_out_even.clkr,
+	[MMPLL7] = &mmpll7.clkr,
+	[MMPLL7_OUT_EVEN] = &mmpll7_out_even.clkr,
+	[MMPLL10] = &mmpll10.clkr,
+	[MMPLL10_OUT_EVEN] = &mmpll10_out_even.clkr,
+	[BYTE0_CLK_SRC] = &byte0_clk_src.clkr,
+	[BYTE1_CLK_SRC] = &byte1_clk_src.clkr,
+	[CCI_CLK_SRC] = &cci_clk_src.clkr,
+	[CPP_CLK_SRC] = &cpp_clk_src.clkr,
+	[CSI0_CLK_SRC] = &csi0_clk_src.clkr,
+	[CSI1_CLK_SRC] = &csi1_clk_src.clkr,
+	[CSI2_CLK_SRC] = &csi2_clk_src.clkr,
+	[CSI3_CLK_SRC] = &csi3_clk_src.clkr,
+	[CSIPHY_CLK_SRC] = &csiphy_clk_src.clkr,
+	[CSI0PHYTIMER_CLK_SRC] = &csi0phytimer_clk_src.clkr,
+	[CSI1PHYTIMER_CLK_SRC] = &csi1phytimer_clk_src.clkr,
+	[CSI2PHYTIMER_CLK_SRC] = &csi2phytimer_clk_src.clkr,
+	[DP_AUX_CLK_SRC] = &dp_aux_clk_src.clkr,
+	[DP_CRYPTO_CLK_SRC] = &dp_crypto_clk_src.clkr,
+	[DP_LINK_CLK_SRC] = &dp_link_clk_src.clkr,
+	[DP_PIXEL_CLK_SRC] = &dp_pixel_clk_src.clkr,
+	[ESC0_CLK_SRC] = &esc0_clk_src.clkr,
+	[ESC1_CLK_SRC] = &esc1_clk_src.clkr,
+	[EXTPCLK_CLK_SRC] = &extpclk_clk_src.clkr,
+	[FD_CORE_CLK_SRC] = &fd_core_clk_src.clkr,
+	[HDMI_CLK_SRC] = &hdmi_clk_src.clkr,
+	[JPEG0_CLK_SRC] = &jpeg0_clk_src.clkr,
+	[MAXI_CLK_SRC] = &maxi_clk_src.clkr,
+	[MCLK0_CLK_SRC] = &mclk0_clk_src.clkr,
+	[MCLK1_CLK_SRC] = &mclk1_clk_src.clkr,
+	[MCLK2_CLK_SRC] = &mclk2_clk_src.clkr,
+	[MCLK3_CLK_SRC] = &mclk3_clk_src.clkr,
+	[MDP_CLK_SRC] = &mdp_clk_src.clkr,
+	[VSYNC_CLK_SRC] = &vsync_clk_src.clkr,
+	[AHB_CLK_SRC] = &ahb_clk_src.clkr,
+	[AXI_CLK_SRC] = &axi_clk_src.clkr,
+	[PCLK0_CLK_SRC] = &pclk0_clk_src.clkr,
+	[PCLK1_CLK_SRC] = &pclk1_clk_src.clkr,
+	[ROT_CLK_SRC] = &rot_clk_src.clkr,
+	[VIDEO_CORE_CLK_SRC] = &video_core_clk_src.clkr,
+	[VIDEO_SUBCORE0_CLK_SRC] = &video_subcore0_clk_src.clkr,
+	[VIDEO_SUBCORE1_CLK_SRC] = &video_subcore1_clk_src.clkr,
+	[VFE0_CLK_SRC] = &vfe0_clk_src.clkr,
+	[VFE1_CLK_SRC] = &vfe1_clk_src.clkr,
+	[MISC_AHB_CLK] = &misc_ahb_clk.clkr,
+	[VIDEO_CORE_CLK] = &video_core_clk.clkr,
+	[VIDEO_AHB_CLK] = &video_ahb_clk.clkr,
+	[VIDEO_AXI_CLK] = &video_axi_clk.clkr,
+	[VIDEO_MAXI_CLK] = &video_maxi_clk.clkr,
+	[VIDEO_SUBCORE0_CLK] = &video_subcore0_clk.clkr,
+	[VIDEO_SUBCORE1_CLK] = &video_subcore1_clk.clkr,
+	[MDSS_AHB_CLK] = &mdss_ahb_clk.clkr,
+	[MDSS_HDMI_DP_AHB_CLK] = &mdss_hdmi_dp_ahb_clk.clkr,
+	[MDSS_AXI_CLK] = &mdss_axi_clk.clkr,
+	[MDSS_PCLK0_CLK] = &mdss_pclk0_clk.clkr,
+	[MDSS_PCLK1_CLK] = &mdss_pclk1_clk.clkr,
+	[MDSS_MDP_CLK] = &mdss_mdp_clk.clkr,
+	[MDSS_MDP_LUT_CLK] = &mdss_mdp_lut_clk.clkr,
+	[MDSS_EXTPCLK_CLK] = &mdss_extpclk_clk.clkr,
+	[MDSS_VSYNC_CLK] = &mdss_vsync_clk.clkr,
+	[MDSS_HDMI_CLK] = &mdss_hdmi_clk.clkr,
+	[MDSS_BYTE0_CLK] = &mdss_byte0_clk.clkr,
+	[MDSS_BYTE1_CLK] = &mdss_byte1_clk.clkr,
+	[MDSS_ESC0_CLK] = &mdss_esc0_clk.clkr,
+	[MDSS_ESC1_CLK] = &mdss_esc1_clk.clkr,
+	[MDSS_ROT_CLK] = &mdss_rot_clk.clkr,
+	[MDSS_DP_LINK_CLK] = &mdss_dp_link_clk.clkr,
+	[MDSS_DP_LINK_INTF_CLK] = &mdss_dp_link_intf_clk.clkr,
+	[MDSS_DP_CRYPTO_CLK] = &mdss_dp_crypto_clk.clkr,
+	[MDSS_DP_PIXEL_CLK] = &mdss_dp_pixel_clk.clkr,
+	[MDSS_DP_AUX_CLK] = &mdss_dp_aux_clk.clkr,
+	[MDSS_BYTE0_INTF_CLK] = &mdss_byte0_intf_clk.clkr,
+	[MDSS_BYTE1_INTF_CLK] = &mdss_byte1_intf_clk.clkr,
+	[CAMSS_CSI0PHYTIMER_CLK] = &camss_csi0phytimer_clk.clkr,
+	[CAMSS_CSI1PHYTIMER_CLK] = &camss_csi1phytimer_clk.clkr,
+	[CAMSS_CSI2PHYTIMER_CLK] = &camss_csi2phytimer_clk.clkr,
+	[CAMSS_CSI0_CLK] = &camss_csi0_clk.clkr,
+	[CAMSS_CSI0_AHB_CLK] = &camss_csi0_ahb_clk.clkr,
+	[CAMSS_CSI0RDI_CLK] = &camss_csi0rdi_clk.clkr,
+	[CAMSS_CSI0PIX_CLK] = &camss_csi0pix_clk.clkr,
+	[CAMSS_CSI1_CLK] = &camss_csi1_clk.clkr,
+	[CAMSS_CSI1_AHB_CLK] = &camss_csi1_ahb_clk.clkr,
+	[CAMSS_CSI1RDI_CLK] = &camss_csi1rdi_clk.clkr,
+	[CAMSS_CSI1PIX_CLK] = &camss_csi1pix_clk.clkr,
+	[CAMSS_CSI2_CLK] = &camss_csi2_clk.clkr,
+	[CAMSS_CSI2_AHB_CLK] = &camss_csi2_ahb_clk.clkr,
+	[CAMSS_CSI2RDI_CLK] = &camss_csi2rdi_clk.clkr,
+	[CAMSS_CSI2PIX_CLK] = &camss_csi2pix_clk.clkr,
+	[CAMSS_CSI3_CLK] = &camss_csi3_clk.clkr,
+	[CAMSS_CSI3_AHB_CLK] = &camss_csi3_ahb_clk.clkr,
+	[CAMSS_CSI3RDI_CLK] = &camss_csi3rdi_clk.clkr,
+	[CAMSS_CSI3PIX_CLK] = &camss_csi3pix_clk.clkr,
+	[CAMSS_ISPIF_AHB_CLK] = &camss_ispif_ahb_clk.clkr,
+	[CAMSS_CCI_CLK] = &camss_cci_clk.clkr,
+	[CAMSS_CCI_AHB_CLK] = &camss_cci_ahb_clk.clkr,
+	[CAMSS_MCLK0_CLK] = &camss_mclk0_clk.clkr,
+	[CAMSS_MCLK1_CLK] = &camss_mclk1_clk.clkr,
+	[CAMSS_MCLK2_CLK] = &camss_mclk2_clk.clkr,
+	[CAMSS_MCLK3_CLK] = &camss_mclk3_clk.clkr,
+	[CAMSS_TOP_AHB_CLK] = &camss_top_ahb_clk.clkr,
+	[CAMSS_AHB_CLK] = &camss_ahb_clk.clkr,
+	[CAMSS_MICRO_AHB_CLK] = &camss_micro_ahb_clk.clkr,
+	[CAMSS_JPEG0_CLK] = &camss_jpeg0_clk.clkr,
+	[CAMSS_JPEG_AHB_CLK] = &camss_jpeg_ahb_clk.clkr,
+	[CAMSS_JPEG_AXI_CLK] = &camss_jpeg_axi_clk.clkr,
+	[CAMSS_VFE0_AHB_CLK] = &camss_vfe0_ahb_clk.clkr,
+	[CAMSS_VFE1_AHB_CLK] = &camss_vfe1_ahb_clk.clkr,
+	[CAMSS_VFE0_CLK] = &camss_vfe0_clk.clkr,
+	[CAMSS_VFE1_CLK] = &camss_vfe1_clk.clkr,
+	[CAMSS_CPP_CLK] = &camss_cpp_clk.clkr,
+	[CAMSS_CPP_AHB_CLK] = &camss_cpp_ahb_clk.clkr,
+	[CAMSS_VFE_VBIF_AHB_CLK] = &camss_vfe_vbif_ahb_clk.clkr,
+	[CAMSS_VFE_VBIF_AXI_CLK] = &camss_vfe_vbif_axi_clk.clkr,
+	[CAMSS_CPP_AXI_CLK] = &camss_cpp_axi_clk.clkr,
+	[CAMSS_CPP_VBIF_AHB_CLK] = &camss_cpp_vbif_ahb_clk.clkr,
+	[CAMSS_CSI_VFE0_CLK] = &camss_csi_vfe0_clk.clkr,
+	[CAMSS_CSI_VFE1_CLK] = &camss_csi_vfe1_clk.clkr,
+	[CAMSS_VFE0_STREAM_CLK] = &camss_vfe0_stream_clk.clkr,
+	[CAMSS_VFE1_STREAM_CLK] = &camss_vfe1_stream_clk.clkr,
+	[CAMSS_CPHY_CSID0_CLK] = &camss_cphy_csid0_clk.clkr,
+	[CAMSS_CPHY_CSID1_CLK] = &camss_cphy_csid1_clk.clkr,
+	[CAMSS_CPHY_CSID2_CLK] = &camss_cphy_csid2_clk.clkr,
+	[CAMSS_CPHY_CSID3_CLK] = &camss_cphy_csid3_clk.clkr,
+	[CAMSS_CSIPHY0_CLK] = &camss_csiphy0_clk.clkr,
+	[CAMSS_CSIPHY1_CLK] = &camss_csiphy1_clk.clkr,
+	[CAMSS_CSIPHY2_CLK] = &camss_csiphy2_clk.clkr,
+	[FD_CORE_CLK] = &fd_core_clk.clkr,
+	[FD_CORE_UAR_CLK] = &fd_core_uar_clk.clkr,
+	[FD_AHB_CLK] = &fd_ahb_clk.clkr,
+	[MNOC_AHB_CLK] = &mnoc_ahb_clk.clkr,
+	[BIMC_SMMU_AHB_CLK] = &bimc_smmu_ahb_clk.clkr,
+	[BIMC_SMMU_AXI_CLK] = &bimc_smmu_axi_clk.clkr,
+	[MNOC_MAXI_CLK] = &mnoc_maxi_clk.clkr,
+	[VMEM_MAXI_CLK] = &vmem_maxi_clk.clkr,
+	[VMEM_AHB_CLK] = &vmem_ahb_clk.clkr,
+};
+
+static struct gdsc *mmcc_msm8998_gdscs[] = {
+	[VIDEO_TOP_GDSC] = &video_top_gdsc,
+	[VIDEO_SUBCORE0_GDSC] = &video_subcore0_gdsc,
+	[VIDEO_SUBCORE1_GDSC] = &video_subcore1_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[CAMSS_TOP_GDSC] = &camss_top_gdsc,
+	[CAMSS_VFE0_GDSC] = &camss_vfe0_gdsc,
+	[CAMSS_VFE1_GDSC] = &camss_vfe1_gdsc,
+	[CAMSS_CPP_GDSC] = &camss_cpp_gdsc,
+	[BIMC_SMMU_GDSC] = &bimc_smmu_gdsc,
+};
+
+static const struct qcom_reset_map mmcc_msm8998_resets[] = {
+	[SPDM_BCR] = { 0x200 },
+	[SPDM_RM_BCR] = { 0x300 },
+	[MISC_BCR] = { 0x320 },
+	[VIDEO_TOP_BCR] = { 0x1020 },
+	[THROTTLE_VIDEO_BCR] = { 0x1180 },
+	[MDSS_BCR] = { 0x2300 },
+	[THROTTLE_MDSS_BCR] = { 0x2460 },
+	[CAMSS_PHY0_BCR] = { 0x3020 },
+	[CAMSS_PHY1_BCR] = { 0x3050 },
+	[CAMSS_PHY2_BCR] = { 0x3080 },
+	[CAMSS_CSI0_BCR] = { 0x30b0 },
+	[CAMSS_CSI0RDI_BCR] = { 0x30d0 },
+	[CAMSS_CSI0PIX_BCR] = { 0x30e0 },
+	[CAMSS_CSI1_BCR] = { 0x3120 },
+	[CAMSS_CSI1RDI_BCR] = { 0x3140 },
+	[CAMSS_CSI1PIX_BCR] = { 0x3150 },
+	[CAMSS_CSI2_BCR] = { 0x3180 },
+	[CAMSS_CSI2RDI_BCR] = { 0x31a0 },
+	[CAMSS_CSI2PIX_BCR] = { 0x31b0 },
+	[CAMSS_CSI3_BCR] = { 0x31e0 },
+	[CAMSS_CSI3RDI_BCR] = { 0x3200 },
+	[CAMSS_CSI3PIX_BCR] = { 0x3210 },
+	[CAMSS_ISPIF_BCR] = { 0x3220 },
+	[CAMSS_CCI_BCR] = { 0x3340 },
+	[CAMSS_TOP_BCR] = { 0x3480 },
+	[CAMSS_AHB_BCR] = { 0x3488 },
+	[CAMSS_MICRO_BCR] = { 0x3490 },
+	[CAMSS_JPEG_BCR] = { 0x35a0 },
+	[CAMSS_VFE0_BCR] = { 0x3660 },
+	[CAMSS_VFE1_BCR] = { 0x3670 },
+	[CAMSS_VFE_VBIF_BCR] = { 0x36a0 },
+	[CAMSS_CPP_TOP_BCR] = { 0x36c0 },
+	[CAMSS_CPP_BCR] = { 0x36d0 },
+	[CAMSS_CSI_VFE0_BCR] = { 0x3700 },
+	[CAMSS_CSI_VFE1_BCR] = { 0x3710 },
+	[CAMSS_FD_BCR] = { 0x3b60 },
+	[THROTTLE_CAMSS_BCR] = { 0x3c30 },
+	[MNOCAHB_BCR] = { 0x5020 },
+	[MNOCAXI_BCR] = { 0xd020 },
+	[BMIC_SMMU_BCR] = { 0xe000 },
+	[MNOC_MAXI_BCR] = { 0xf000 },
+	[VMEM_BCR] = { 0xf060 },
+	[BTO_BCR] = { 0x10004 },
+};
+
+static const struct regmap_config mmcc_msm8998_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10004,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc mmcc_msm8998_desc = {
+	.config = &mmcc_msm8998_regmap_config,
+	.clks = mmcc_msm8998_clocks,
+	.num_clks = ARRAY_SIZE(mmcc_msm8998_clocks),
+	.resets = mmcc_msm8998_resets,
+	.num_resets = ARRAY_SIZE(mmcc_msm8998_resets),
+	.gdscs = mmcc_msm8998_gdscs,
+	.num_gdscs = ARRAY_SIZE(mmcc_msm8998_gdscs),
+};
+
+static const struct of_device_id mmcc_msm8998_match_table[] = {
+	{ .compatible = "qcom,mmcc-msm8998" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmcc_msm8998_match_table);
+
+static int mmcc_msm8998_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int i, ret;
+	struct regmap *regmap;
+	struct clk *c;
+
+	c = devm_clk_get(dev, "xo");
+	if (!IS_ERR(c))
+		dummy_xo_init.parent_names =
+					(const char *[]){__clk_get_name(c)};
+	else
+		return PTR_ERR(c);
+
+	c = devm_clk_get(dev, "gpll0");
+	if (!IS_ERR(c))
+		dummy_gpll0_init.parent_names =
+					(const char *[]){__clk_get_name(c)};
+	else
+		return PTR_ERR(c);
+
+	regmap = qcom_cc_map(pdev, &mmcc_msm8998_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	for (i = 0; i < ARRAY_SIZE(mmcc_msm8998_hws); i++) {
+		ret = devm_clk_hw_register(dev, mmcc_msm8998_hws[i]);
+		if (ret)
+			return ret;
+	}
+
+	return qcom_cc_really_probe(pdev, &mmcc_msm8998_desc, regmap);
+}
+
+static struct platform_driver mmcc_msm8998_driver = {
+	.probe		= mmcc_msm8998_probe,
+	.driver		= {
+		.name	= "mmcc-msm8998",
+		.of_match_table = mmcc_msm8998_match_table,
+	},
+};
+module_platform_driver(mmcc_msm8998_driver);
+
+MODULE_DESCRIPTION("QCOM MMCC MSM8998 Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mmcc-msm8998");
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8998.h b/include/dt-bindings/clock/qcom,mmcc-msm8998.h
new file mode 100644
index 0000000..ecbafdb
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8998.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_8998_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_8998_H
+
+#define MMPLL0						0
+#define MMPLL0_OUT_EVEN					1
+#define MMPLL1						2
+#define MMPLL1_OUT_EVEN					3
+#define MMPLL3						4
+#define MMPLL3_OUT_EVEN					5
+#define MMPLL4						6
+#define MMPLL4_OUT_EVEN					7
+#define MMPLL5						8
+#define MMPLL5_OUT_EVEN					9
+#define MMPLL6						10
+#define MMPLL6_OUT_EVEN					11
+#define MMPLL7						12
+#define MMPLL7_OUT_EVEN					13
+#define MMPLL10						14
+#define MMPLL10_OUT_EVEN				15
+#define BYTE0_CLK_SRC					16
+#define BYTE1_CLK_SRC					17
+#define CCI_CLK_SRC					18
+#define CPP_CLK_SRC					19
+#define CSI0_CLK_SRC					20
+#define CSI1_CLK_SRC					21
+#define CSI2_CLK_SRC					22
+#define CSI3_CLK_SRC					23
+#define CSIPHY_CLK_SRC					24
+#define CSI0PHYTIMER_CLK_SRC				25
+#define CSI1PHYTIMER_CLK_SRC				26
+#define CSI2PHYTIMER_CLK_SRC				27
+#define DP_AUX_CLK_SRC					28
+#define DP_CRYPTO_CLK_SRC				29
+#define DP_LINK_CLK_SRC					30
+#define DP_PIXEL_CLK_SRC				31
+#define ESC0_CLK_SRC					32
+#define ESC1_CLK_SRC					33
+#define EXTPCLK_CLK_SRC					34
+#define FD_CORE_CLK_SRC					35
+#define HDMI_CLK_SRC					36
+#define JPEG0_CLK_SRC					37
+#define MAXI_CLK_SRC					38
+#define MCLK0_CLK_SRC					39
+#define MCLK1_CLK_SRC					40
+#define MCLK2_CLK_SRC					41
+#define MCLK3_CLK_SRC					42
+#define MDP_CLK_SRC					43
+#define VSYNC_CLK_SRC					44
+#define AHB_CLK_SRC					45
+#define AXI_CLK_SRC					46
+#define PCLK0_CLK_SRC					47
+#define PCLK1_CLK_SRC					48
+#define ROT_CLK_SRC					49
+#define VIDEO_CORE_CLK_SRC				50
+#define VIDEO_SUBCORE0_CLK_SRC				51
+#define VIDEO_SUBCORE1_CLK_SRC				52
+#define VFE0_CLK_SRC					53
+#define VFE1_CLK_SRC					54
+#define MISC_AHB_CLK					55
+#define VIDEO_CORE_CLK					56
+#define VIDEO_AHB_CLK					57
+#define VIDEO_AXI_CLK					58
+#define VIDEO_MAXI_CLK					59
+#define VIDEO_SUBCORE0_CLK				60
+#define VIDEO_SUBCORE1_CLK				61
+#define MDSS_AHB_CLK					62
+#define MDSS_HDMI_DP_AHB_CLK				63
+#define MDSS_AXI_CLK					64
+#define MDSS_PCLK0_CLK					65
+#define MDSS_PCLK1_CLK					66
+#define MDSS_MDP_CLK					67
+#define MDSS_MDP_LUT_CLK				68
+#define MDSS_EXTPCLK_CLK				69
+#define MDSS_VSYNC_CLK					70
+#define MDSS_HDMI_CLK					71
+#define MDSS_BYTE0_CLK					72
+#define MDSS_BYTE1_CLK					73
+#define MDSS_ESC0_CLK					74
+#define MDSS_ESC1_CLK					75
+#define MDSS_ROT_CLK					76
+#define MDSS_DP_LINK_CLK				77
+#define MDSS_DP_LINK_INTF_CLK				78
+#define MDSS_DP_CRYPTO_CLK				79
+#define MDSS_DP_PIXEL_CLK				80
+#define MDSS_DP_AUX_CLK					81
+#define MDSS_BYTE0_INTF_CLK				82
+#define MDSS_BYTE1_INTF_CLK				83
+#define CAMSS_CSI0PHYTIMER_CLK				84
+#define CAMSS_CSI1PHYTIMER_CLK				85
+#define CAMSS_CSI2PHYTIMER_CLK				86
+#define CAMSS_CSI0_CLK					87
+#define CAMSS_CSI0_AHB_CLK				88
+#define CAMSS_CSI0RDI_CLK				89
+#define CAMSS_CSI0PIX_CLK				90
+#define CAMSS_CSI1_CLK					91
+#define CAMSS_CSI1_AHB_CLK				92
+#define CAMSS_CSI1RDI_CLK				93
+#define CAMSS_CSI1PIX_CLK				94
+#define CAMSS_CSI2_CLK					95
+#define CAMSS_CSI2_AHB_CLK				96
+#define CAMSS_CSI2RDI_CLK				97
+#define CAMSS_CSI2PIX_CLK				98
+#define CAMSS_CSI3_CLK					99
+#define CAMSS_CSI3_AHB_CLK				100
+#define CAMSS_CSI3RDI_CLK				101
+#define CAMSS_CSI3PIX_CLK				102
+#define CAMSS_ISPIF_AHB_CLK				103
+#define CAMSS_CCI_CLK					104
+#define CAMSS_CCI_AHB_CLK				105
+#define CAMSS_MCLK0_CLK					106
+#define CAMSS_MCLK1_CLK					107
+#define CAMSS_MCLK2_CLK					108
+#define CAMSS_MCLK3_CLK					109
+#define CAMSS_TOP_AHB_CLK				110
+#define CAMSS_AHB_CLK					111
+#define CAMSS_MICRO_AHB_CLK				112
+#define CAMSS_JPEG0_CLK					113
+#define CAMSS_JPEG_AHB_CLK				114
+#define CAMSS_JPEG_AXI_CLK				115
+#define CAMSS_VFE0_AHB_CLK				116
+#define CAMSS_VFE1_AHB_CLK				117
+#define CAMSS_VFE0_CLK					118
+#define CAMSS_VFE1_CLK					119
+#define CAMSS_CPP_CLK					120
+#define CAMSS_CPP_AHB_CLK				121
+#define CAMSS_VFE_VBIF_AHB_CLK				122
+#define CAMSS_VFE_VBIF_AXI_CLK				123
+#define CAMSS_CPP_AXI_CLK				124
+#define CAMSS_CPP_VBIF_AHB_CLK				125
+#define CAMSS_CSI_VFE0_CLK				126
+#define CAMSS_CSI_VFE1_CLK				127
+#define CAMSS_VFE0_STREAM_CLK				128
+#define CAMSS_VFE1_STREAM_CLK				129
+#define CAMSS_CPHY_CSID0_CLK				130
+#define CAMSS_CPHY_CSID1_CLK				131
+#define CAMSS_CPHY_CSID2_CLK				132
+#define CAMSS_CPHY_CSID3_CLK				133
+#define CAMSS_CSIPHY0_CLK				134
+#define CAMSS_CSIPHY1_CLK				135
+#define CAMSS_CSIPHY2_CLK				136
+#define FD_CORE_CLK					137
+#define FD_CORE_UAR_CLK					138
+#define FD_AHB_CLK					139
+#define MNOC_AHB_CLK					140
+#define BIMC_SMMU_AHB_CLK				141
+#define BIMC_SMMU_AXI_CLK				142
+#define MNOC_MAXI_CLK					143
+#define VMEM_MAXI_CLK					144
+#define VMEM_AHB_CLK					145
+
+#define SPDM_BCR					0
+#define SPDM_RM_BCR					1
+#define MISC_BCR					2
+#define VIDEO_TOP_BCR					3
+#define THROTTLE_VIDEO_BCR				4
+#define MDSS_BCR					5
+#define THROTTLE_MDSS_BCR				6
+#define CAMSS_PHY0_BCR					7
+#define CAMSS_PHY1_BCR					8
+#define CAMSS_PHY2_BCR					9
+#define CAMSS_CSI0_BCR					10
+#define CAMSS_CSI0RDI_BCR				11
+#define CAMSS_CSI0PIX_BCR				12
+#define CAMSS_CSI1_BCR					13
+#define CAMSS_CSI1RDI_BCR				14
+#define CAMSS_CSI1PIX_BCR				15
+#define CAMSS_CSI2_BCR					16
+#define CAMSS_CSI2RDI_BCR				17
+#define CAMSS_CSI2PIX_BCR				18
+#define CAMSS_CSI3_BCR					19
+#define CAMSS_CSI3RDI_BCR				20
+#define CAMSS_CSI3PIX_BCR				21
+#define CAMSS_ISPIF_BCR					22
+#define CAMSS_CCI_BCR					23
+#define CAMSS_TOP_BCR					24
+#define CAMSS_AHB_BCR					25
+#define CAMSS_MICRO_BCR					26
+#define CAMSS_JPEG_BCR					27
+#define CAMSS_VFE0_BCR					28
+#define CAMSS_VFE1_BCR					29
+#define CAMSS_VFE_VBIF_BCR				30
+#define CAMSS_CPP_TOP_BCR				31
+#define CAMSS_CPP_BCR					32
+#define CAMSS_CSI_VFE0_BCR				33
+#define CAMSS_CSI_VFE1_BCR				34
+#define CAMSS_FD_BCR					35
+#define THROTTLE_CAMSS_BCR				36
+#define MNOCAHB_BCR					37
+#define MNOCAXI_BCR					38
+#define BMIC_SMMU_BCR					39
+#define MNOC_MAXI_BCR					40
+#define VMEM_BCR					41
+#define BTO_BCR						42
+
+#define VIDEO_TOP_GDSC		1
+#define VIDEO_SUBCORE0_GDSC	2
+#define VIDEO_SUBCORE1_GDSC	3
+#define MDSS_GDSC		4
+#define CAMSS_TOP_GDSC		5
+#define CAMSS_VFE0_GDSC		6
+#define CAMSS_VFE1_GDSC		7
+#define CAMSS_CPP_GDSC		8
+#define BIMC_SMMU_GDSC		9
+
+#endif
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8B620883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8B620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFUE3S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:29:18 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:57354 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeFUE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:29:16 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 21 Jun 2018
 12:29:21 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: meson-axg: add clocks required by pcie driver
Date:   Thu, 21 Jun 2018 12:26:20 +0000
Message-ID: <20180621122620.13195-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding clocks for pcie driver, due to the ASIC design,
the pcie controller re-use part of the mipi clock logic,
so the mipi clock is also required.

Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/axg.c              | 145 +++++++++++++++++++++++++++
 drivers/clk/meson/axg.h              |   6 +-
 include/dt-bindings/clock/axg-clkc.h |   3 +
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index bd4dbc696b88..f1dc5433b69d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -626,6 +626,137 @@ static struct clk_regmap axg_mpll3 = {
 	},
 };
 
+static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
+	{
+		.rate	= 100000000,
+		.m	= 200,
+		.n	= 3,
+		.od	= 1,
+		.od2	= 3,
+	},
+	{ /* sentinel */ },
+};
+
+static const struct reg_sequence axg_pcie_init_regs[] = {
+	{ .reg = HHI_PCIE_PLL_CNTL,	.def = 0x400106c8 },
+	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x0084a2aa },
+	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0xb75020be },
+	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x0a47488e },
+	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0xc000004d },
+	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x00078000 },
+	{ .reg = HHI_PCIE_PLL_CNTL6,	.def = 0x002323c6 },
+};
+
+static struct clk_regmap axg_pcie_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.od2 = {
+			.reg_off = HHI_PCIE_PLL_CNTL6,
+			.shift   = 6,
+			.width   = 2,
+		},
+		.frac = {
+			.reg_off = HHI_PCIE_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = axg_pcie_pll_rate_table,
+		.init_regs = axg_pcie_init_regs,
+		.init_count = ARRAY_SIZE(axg_pcie_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap axg_pcie_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_PCIE_PLL_CNTL6,
+		.mask = 0x1,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "mpll3", "pcie_pll" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_pcie_ref = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_PCIE_PLL_CNTL6,
+		.mask = 0x1,
+		.shift = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_ref",
+		.ops = &clk_regmap_mux_ops,
+		/* do not select the first partent, debug only */
+		.parent_names = (const char *[]){ "",
+			"pcie_mux" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_pcie_cml_en0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_PCIE_PLL_CNTL6,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pcie_cml_en0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "pcie_ref" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+
+	},
+};
+
+static struct clk_regmap axg_pcie_cml_en1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_PCIE_PLL_CNTL6,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pcie_cml_en1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "pcie_ref" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
 	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
@@ -821,6 +952,7 @@ static MESON_GATE(axg_mmc_pclk, HHI_GCLK_MPEG2, 11);
 static MESON_GATE(axg_vpu_intr, HHI_GCLK_MPEG2, 25);
 static MESON_GATE(axg_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
 static MESON_GATE(axg_gic, HHI_GCLK_MPEG2, 30);
+static MESON_GATE(axg_mipi_enable, HHI_MIPI_CNTL0, 29);
 
 /* Always On (AO) domain gates */
 
@@ -910,6 +1042,13 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_FCLK_DIV4_DIV]		= &axg_fclk_div4_div.hw,
 		[CLKID_FCLK_DIV5_DIV]		= &axg_fclk_div5_div.hw,
 		[CLKID_FCLK_DIV7_DIV]		= &axg_fclk_div7_div.hw,
+		[CLKID_PCIE_PLL]		= &axg_pcie_pll.hw,
+		[CLKID_PCIE_MUX]		= &axg_pcie_mux.hw,
+		[CLKID_PCIE_REF]		= &axg_pcie_ref.hw,
+		[CLKID_PCIE_CML_EN0]		= &axg_pcie_cml_en0.hw,
+		[CLKID_PCIE_CML_EN1]		= &axg_pcie_cml_en1.hw,
+		[CLKID_MIPI_ENABLE]		= &axg_mipi_enable.hw,
+
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -988,6 +1127,12 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_fclk_div4,
 	&axg_fclk_div5,
 	&axg_fclk_div7,
+	&axg_pcie_pll,
+	&axg_pcie_mux,
+	&axg_pcie_ref,
+	&axg_pcie_cml_en0,
+	&axg_pcie_cml_en1,
+	&axg_mipi_enable,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index b421df6a7ea0..6e55ebd6c77d 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -16,6 +16,7 @@
  * Register offsets from the data sheet must be multiplied by 4 before
  * adding them to the base address to get the right value.
  */
+#define HHI_MIPI_CNTL0			0x00
 #define HHI_GP0_PLL_CNTL		0x40
 #define HHI_GP0_PLL_CNTL2		0x44
 #define HHI_GP0_PLL_CNTL3		0x48
@@ -127,8 +128,11 @@
 #define CLKID_FCLK_DIV4_DIV			73
 #define CLKID_FCLK_DIV5_DIV			74
 #define CLKID_FCLK_DIV7_DIV			75
+#define CLKID_PCIE_PLL				76
+#define CLKID_PCIE_MUX				77
+#define CLKID_PCIE_REF				78
 
-#define NR_CLKS					76
+#define NR_CLKS					82
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 555937a25504..70371228b7e0 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -68,5 +68,8 @@
 #define CLKID_SD_EMMC_B_CLK0			59
 #define CLKID_SD_EMMC_C_CLK0			60
 #define CLKID_HIFI_PLL				69
+#define CLKID_PCIE_CML_EN0			79
+#define CLKID_PCIE_CML_EN1			80
+#define CLKID_MIPI_ENABLE			81
 
 #endif /* __AXG_CLKC_H */
-- 
2.17.1


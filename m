Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBSLW1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:22:27 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32930 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBSLWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:22:03 -0500
X-Google-Smtp-Source: AH8x2265qKn1y02wrtHSNFNRQWcaxheDAxyuyS1dyRuInLlfJwNT9n6Hw4B/Umb4mCFOH5jKbvj9kg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] clk: meson: add fdiv clock gates
Date: Mon, 19 Feb 2018 12:21:45 +0100
Message-Id: <20180219112146.21746-11-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fdiv fixed dividers clocks of the fixed_pll can actually gate
independently. We never had an issue so far because these clocks
were provided 'enabled' by the bootloader.

Add these gates to enable/disable the clocks when required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  95 ++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/axg.h     |   7 +++-
 drivers/clk/meson/gxbb.c    | 100 +++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/gxbb.h    |   7 +++-
 drivers/clk/meson/meson8b.c |  95 ++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/meson8b.h |   7 +++-
 6 files changed, 278 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2989087fb52d..99b2738c204f 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -299,61 +299,126 @@ static struct clk_regmap axg_hifi_pll = {
 	},
 };
 
-static struct clk_fixed_factor axg_fclk_div2 = {
+static struct clk_fixed_factor axg_fclk_div2_div = {
 	.mult = 1,
 	.div = 2,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div2",
+		.name = "fclk_div2_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor axg_fclk_div3 = {
+static struct clk_regmap axg_fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 27,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div2_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div3_div = {
 	.mult = 1,
 	.div = 3,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div3",
+		.name = "fclk_div3_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor axg_fclk_div4 = {
+static struct clk_regmap axg_fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 28,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div3_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div4_div = {
 	.mult = 1,
 	.div = 4,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div4",
+		.name = "fclk_div4_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor axg_fclk_div5 = {
+static struct clk_regmap axg_fclk_div4 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div4_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div5_div = {
 	.mult = 1,
 	.div = 5,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div5",
+		.name = "fclk_div5_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor axg_fclk_div7 = {
+static struct clk_regmap axg_fclk_div5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div5_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div7_div = {
 	.mult = 1,
 	.div = 7,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div7",
+		.name = "fclk_div7_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap axg_fclk_div7 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div7_div" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap axg_mpll_prediv = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_MPLL_CNTL5,
@@ -836,6 +901,11 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_MPLL3_DIV]		= &axg_mpll3_div.hw,
 		[CLKID_HIFI_PLL]		= &axg_hifi_pll.hw,
 		[CLKID_MPLL_PREDIV]		= &axg_mpll_prediv.hw,
+		[CLKID_FCLK_DIV2_DIV]		= &axg_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]		= &axg_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]		= &axg_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]		= &axg_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]		= &axg_fclk_div7_div.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -909,6 +979,11 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_gp0_pll,
 	&axg_hifi_pll,
 	&axg_mpll_prediv,
+	&axg_fclk_div2,
+	&axg_fclk_div3,
+	&axg_fclk_div4,
+	&axg_fclk_div5,
+	&axg_fclk_div7,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index 6e5dc65041b5..b421df6a7ea0 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -122,8 +122,13 @@
 #define CLKID_MPLL2_DIV				67
 #define CLKID_MPLL3_DIV				68
 #define CLKID_MPLL_PREDIV			70
+#define CLKID_FCLK_DIV2_DIV			71
+#define CLKID_FCLK_DIV3_DIV			72
+#define CLKID_FCLK_DIV4_DIV			73
+#define CLKID_FCLK_DIV5_DIV			74
+#define CLKID_FCLK_DIV7_DIV			75
 
-#define NR_CLKS					71
+#define NR_CLKS					76
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index b62d181a6d33..70b4669cf7d6 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -490,61 +490,126 @@ static struct clk_regmap gxl_gp0_pll = {
 	},
 };
 
-static struct clk_fixed_factor gxbb_fclk_div2 = {
+static struct clk_fixed_factor gxbb_fclk_div2_div = {
 	.mult = 1,
 	.div = 2,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div2",
+		.name = "fclk_div2_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor gxbb_fclk_div3 = {
+static struct clk_regmap gxbb_fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 27,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div2_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_fclk_div3_div = {
 	.mult = 1,
 	.div = 3,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div3",
+		.name = "fclk_div3_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor gxbb_fclk_div4 = {
+static struct clk_regmap gxbb_fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 28,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div3_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_fclk_div4_div = {
 	.mult = 1,
 	.div = 4,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div4",
+		.name = "fclk_div4_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor gxbb_fclk_div5 = {
+static struct clk_regmap gxbb_fclk_div4 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div4_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_fclk_div5_div = {
 	.mult = 1,
 	.div = 5,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div5",
+		.name = "fclk_div5_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor gxbb_fclk_div7 = {
+static struct clk_regmap gxbb_fclk_div5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div5_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_fclk_div7_div = {
 	.mult = 1,
 	.div = 7,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div7",
+		.name = "fclk_div7_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap gxbb_fclk_div7 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div7_div" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap gxbb_mpll_prediv = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_MPLL_CNTL5,
@@ -1718,6 +1783,11 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
 		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
+		[CLKID_FCLK_DIV2_DIV]	    = &gxbb_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]	    = &gxbb_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]	    = &gxbb_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]	    = &gxbb_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]	    = &gxbb_fclk_div7_div.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -1869,6 +1939,11 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
 		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
+		[CLKID_FCLK_DIV2_DIV]	    = &gxbb_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]	    = &gxbb_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]	    = &gxbb_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]	    = &gxbb_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]	    = &gxbb_fclk_div7_div.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -2022,6 +2097,11 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_fixed_pll,
 	&gxbb_sys_pll,
 	&gxbb_mpll_prediv,
+	&gxbb_fclk_div2,
+	&gxbb_fclk_div3,
+	&gxbb_fclk_div4,
+	&gxbb_fclk_div5,
+	&gxbb_fclk_div7,
 };
 
 struct clkc_data {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index afae007ae1ec..9febf3f03739 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -199,8 +199,13 @@
 #define CLKID_MPLL1_DIV		  143
 #define CLKID_MPLL2_DIV		  144
 #define CLKID_MPLL_PREDIV	  145
+#define CLKID_FCLK_DIV2_DIV	  146
+#define CLKID_FCLK_DIV3_DIV	  147
+#define CLKID_FCLK_DIV4_DIV	  148
+#define CLKID_FCLK_DIV5_DIV	  149
+#define CLKID_FCLK_DIV7_DIV	  150
 
-#define NR_CLKS			  146
+#define NR_CLKS			  151
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index f8b2f23c49de..9c9e3d180120 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -225,61 +225,126 @@ static struct clk_regmap meson8b_sys_pll = {
 	},
 };
 
-static struct clk_fixed_factor meson8b_fclk_div2 = {
+static struct clk_fixed_factor meson8b_fclk_div2_div = {
 	.mult = 1,
 	.div = 2,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div2",
+		.name = "fclk_div2_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor meson8b_fclk_div3 = {
+static struct clk_regmap meson8b_fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 27,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div2_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_fclk_div3_div = {
 	.mult = 1,
 	.div = 3,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div3",
+		.name = "fclk_div_div3",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor meson8b_fclk_div4 = {
+static struct clk_regmap meson8b_fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 28,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div3_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_fclk_div4_div = {
 	.mult = 1,
 	.div = 4,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div4",
+		.name = "fclk_div4_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor meson8b_fclk_div5 = {
+static struct clk_regmap meson8b_fclk_div4 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div4_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_fclk_div5_div = {
 	.mult = 1,
 	.div = 5,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div5",
+		.name = "fclk_div5_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_fixed_factor meson8b_fclk_div7 = {
+static struct clk_regmap meson8b_fclk_div5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div5_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor meson8b_fclk_div7_div = {
 	.mult = 1,
 	.div = 7,
 	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div7",
+		.name = "fclk_div7_div",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap meson8b_fclk_div7 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL6,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div7_div" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap meson8b_mpll_prediv = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_MPLL_CNTL5,
@@ -766,6 +831,11 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
 		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
 		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
+		[CLKID_FCLK_DIV2_DIV]	    = &meson8b_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]	    = &meson8b_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV4_DIV]	    = &meson8b_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV5_DIV]	    = &meson8b_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]	    = &meson8b_fclk_div7_div.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -866,6 +936,11 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cpu_scale_out_sel,
 	&meson8b_cpu_clk,
 	&meson8b_mpll_prediv,
+	&meson8b_fclk_div2,
+	&meson8b_fclk_div3,
+	&meson8b_fclk_div4,
+	&meson8b_fclk_div5,
+	&meson8b_fclk_div7,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 839ffc9da5f7..6e414bd36981 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -78,8 +78,13 @@
 #define CLKID_CPU_SCALE_DIV	102
 #define CLKID_CPU_SCALE_OUT_SEL	103
 #define CLKID_MPLL_PREDIV	104
+#define CLKID_FCLK_DIV2_DIV	105
+#define CLKID_FCLK_DIV3_DIV	106
+#define CLKID_FCLK_DIV4_DIV	107
+#define CLKID_FCLK_DIV5_DIV	108
+#define CLKID_FCLK_DIV7_DIV	109
 
-#define CLK_NR_CLKS		105
+#define CLK_NR_CLKS		110
 
 /*
  * include the CLKID and RESETID that have
-- 
2.14.3

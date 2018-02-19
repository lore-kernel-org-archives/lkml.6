Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeBSLWr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:22:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53352 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbeBSLWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:22:02 -0500
X-Google-Smtp-Source: AH8x224BbXC5xJwinRL7c7IlxLBq2oK7BS/K6ATwK0vgV1GuMo81I6+x8aDd5WwlNwz8c5Dn0f/4fQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] clk: meson: add mpll pre-divider
Date: Mon, 19 Feb 2018 12:21:44 +0100
Message-Id: <20180219112146.21746-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpll clocks parent can actually be divided by 1 or 2. So far, this
divider has always been set to 1, so the calculation was correct.
Now that we know it exists, model the tree correctly. If we ever get
a platform where the divider is different, we won't get into trouble

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 24 ++++++++++++++++++++----
 drivers/clk/meson/axg.h     |  3 ++-
 drivers/clk/meson/gxbb.c    | 23 ++++++++++++++++++++---
 drivers/clk/meson/gxbb.h    |  3 ++-
 drivers/clk/meson/meson8b.c | 22 +++++++++++++++++++---
 drivers/clk/meson/meson8b.h |  3 ++-
 6 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index ed4a645753c4..2989087fb52d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -354,6 +354,20 @@ static struct clk_fixed_factor axg_fclk_div7 = {
 	},
 };
 
+static struct clk_regmap axg_mpll_prediv = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPLL_CNTL5,
+		.shift = 12,
+		.width = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_prediv",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap axg_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -386,7 +400,7 @@ static struct clk_regmap axg_mpll0_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -432,7 +446,7 @@ static struct clk_regmap axg_mpll1_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -478,7 +492,7 @@ static struct clk_regmap axg_mpll2_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -524,7 +538,7 @@ static struct clk_regmap axg_mpll3_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -821,6 +835,7 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_MPLL2_DIV]		= &axg_mpll2_div.hw,
 		[CLKID_MPLL3_DIV]		= &axg_mpll3_div.hw,
 		[CLKID_HIFI_PLL]		= &axg_hifi_pll.hw,
+		[CLKID_MPLL_PREDIV]		= &axg_mpll_prediv.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -893,6 +908,7 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_sys_pll,
 	&axg_gp0_pll,
 	&axg_hifi_pll,
+	&axg_mpll_prediv,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index 4916c7045c48..6e5dc65041b5 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -121,8 +121,9 @@
 #define CLKID_MPLL1_DIV				66
 #define CLKID_MPLL2_DIV				67
 #define CLKID_MPLL3_DIV				68
+#define CLKID_MPLL_PREDIV			70
 
-#define NR_CLKS					70
+#define NR_CLKS					71
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index fdeb372863de..b62d181a6d33 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -545,6 +545,20 @@ static struct clk_fixed_factor gxbb_fclk_div7 = {
 	},
 };
 
+static struct clk_regmap gxbb_mpll_prediv = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPLL_CNTL5,
+		.shift = 12,
+		.width = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_prediv",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap gxbb_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -572,7 +586,7 @@ static struct clk_regmap gxbb_mpll0_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -613,7 +627,7 @@ static struct clk_regmap gxbb_mpll1_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -654,7 +668,7 @@ static struct clk_regmap gxbb_mpll2_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -1703,6 +1717,7 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
+		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -1853,6 +1868,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
 		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
+		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -2005,6 +2021,7 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_cts_amclk_div,
 	&gxbb_fixed_pll,
 	&gxbb_sys_pll,
+	&gxbb_mpll_prediv,
 };
 
 struct clkc_data {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index a8e7b8884e95..afae007ae1ec 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -198,8 +198,9 @@
 #define CLKID_MPLL0_DIV		  142
 #define CLKID_MPLL1_DIV		  143
 #define CLKID_MPLL2_DIV		  144
+#define CLKID_MPLL_PREDIV	  145
 
-#define NR_CLKS			  145
+#define NR_CLKS			  146
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 62c54a75a1d2..f8b2f23c49de 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -280,6 +280,20 @@ static struct clk_fixed_factor meson8b_fclk_div7 = {
 	},
 };
 
+static struct clk_regmap meson8b_mpll_prediv = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPLL_CNTL5,
+		.shift = 12,
+		.width = 1,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_prediv",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap meson8b_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -307,7 +321,7 @@ static struct clk_regmap meson8b_mpll0_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -348,7 +362,7 @@ static struct clk_regmap meson8b_mpll1_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -389,7 +403,7 @@ static struct clk_regmap meson8b_mpll2_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_names = (const char *[]){ "mpll_prediv" },
 		.num_parents = 1,
 	},
 };
@@ -751,6 +765,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CPU_DIV3]	    = &meson8b_cpu_div3.hw,
 		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
 		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
+		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -850,6 +865,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cpu_scale_div,
 	&meson8b_cpu_scale_out_sel,
 	&meson8b_cpu_clk,
+	&meson8b_mpll_prediv,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 73dae83d9932..839ffc9da5f7 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -77,8 +77,9 @@
 #define CLKID_CPU_DIV3		101
 #define CLKID_CPU_SCALE_DIV	102
 #define CLKID_CPU_SCALE_OUT_SEL	103
+#define CLKID_MPLL_PREDIV	104
 
-#define CLK_NR_CLKS		104
+#define CLK_NR_CLKS		105
 
 /*
  * include the CLKID and RESETID that have
-- 
2.14.3

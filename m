Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeAaSLC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:11:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38218 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbeAaSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:08 -0500
X-Google-Smtp-Source: AH8x224mSMq64E6V1es+MR5Zd1WruM4LN+uFdiyHLiQwQXq+GA7d9VGPfYYiLocG34ZEOXVd1K3gBQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] clk: meson: split divider and gate part of mpll
Date: Wed, 31 Jan 2018 19:09:42 +0100
Message-Id: <20180131180945.18025-17-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mpll clock is a kind of fractional divider which can gate.
When the RW operation have been added, enable/disable ops have been
mistakenly inserted in this driver. These ops are essentially a
poor copy/paste of generic gate ops.

This change remove the gate ops from the mpll driver and insert a
generic gate clock on each mpll divider, simplifying the mpll
driver and reducing code duplication.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c      | 100 +++++++++++++++++++++++++++++++------------
 drivers/clk/meson/axg.h      |   6 ++-
 drivers/clk/meson/clk-mpll.c |  44 -------------------
 drivers/clk/meson/clkc.h     |   1 -
 drivers/clk/meson/gxbb.c     |  75 +++++++++++++++++++++++---------
 drivers/clk/meson/gxbb.h     |   5 ++-
 drivers/clk/meson/meson8b.c  |  75 +++++++++++++++++++++++---------
 drivers/clk/meson/meson8b.h  |   6 ++-
 8 files changed, 194 insertions(+), 118 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index df1f15bfd058..ae1dd35246f5 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -296,7 +296,7 @@ static struct clk_fixed_factor axg_fclk_div7 = {
 	},
 };
 
-static struct clk_regmap axg_mpll0 = {
+static struct clk_regmap axg_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL7,
@@ -313,11 +313,6 @@ static struct clk_regmap axg_mpll0 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL7,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.ssen = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 25,
@@ -331,14 +326,28 @@ static struct clk_regmap axg_mpll0 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll0",
+		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap axg_mpll1 = {
+static struct clk_regmap axg_mpll0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL7,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_mpll1_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL8,
@@ -355,11 +364,6 @@ static struct clk_regmap axg_mpll1 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL8,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 1,
@@ -368,14 +372,28 @@ static struct clk_regmap axg_mpll1 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll1",
+		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap axg_mpll2 = {
+static struct clk_regmap axg_mpll1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL8,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_mpll2_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL9,
@@ -392,11 +410,6 @@ static struct clk_regmap axg_mpll2 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL9,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 2,
@@ -405,14 +418,28 @@ static struct clk_regmap axg_mpll2 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll2",
+		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap axg_mpll3 = {
+static struct clk_regmap axg_mpll2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL9,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_mpll3_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL3_CNTL0,
@@ -429,11 +456,6 @@ static struct clk_regmap axg_mpll3 = {
 			.shift   = 2,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL3_CNTL0,
-			.shift   = 0,
-			.width	 = 1,
-		},
 		.misc = {
 			.reg_off = HHI_PLL_TOP_MISC,
 			.shift   = 3,
@@ -442,13 +464,27 @@ static struct clk_regmap axg_mpll3 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll3",
+		.name = "mpll3_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap axg_mpll3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL3_CNTL0,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll3_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
 	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
@@ -722,6 +758,10 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_SD_EMMC_C_CLK0_SEL]	= &axg_sd_emmc_c_clk0_sel.hw,
 		[CLKID_SD_EMMC_C_CLK0_DIV]	= &axg_sd_emmc_c_clk0_div.hw,
 		[CLKID_SD_EMMC_C_CLK0]		= &axg_sd_emmc_c_clk0.hw,
+		[CLKID_MPLL0_DIV]		= &axg_mpll0_div.hw,
+		[CLKID_MPLL1_DIV]		= &axg_mpll1_div.hw,
+		[CLKID_MPLL2_DIV]		= &axg_mpll2_div.hw,
+		[CLKID_MPLL3_DIV]		= &axg_mpll3_div.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -786,6 +826,10 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_mpll1,
 	&axg_mpll2,
 	&axg_mpll3,
+	&axg_mpll0_div,
+	&axg_mpll1_div,
+	&axg_mpll2_div,
+	&axg_mpll3_div,
 	&axg_fixed_pll,
 	&axg_sys_pll,
 	&axg_gp0_pll,
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index ce0bafdb6b28..4c1502a8b8c9 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -117,8 +117,12 @@
 #define CLKID_SD_EMMC_B_CLK0_DIV		62
 #define CLKID_SD_EMMC_C_CLK0_SEL		63
 #define CLKID_SD_EMMC_C_CLK0_DIV		64
+#define CLKID_MPLL0_DIV				65
+#define CLKID_MPLL1_DIV				66
+#define CLKID_MPLL2_DIV				67
+#define CLKID_MPLL3_DIV				68
 
-#define NR_CLKS					65
+#define NR_CLKS					69
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 66998ff47635..0df1227b65b3 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -170,57 +170,13 @@ static int mpll_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static void mpll_enable_core(struct clk_hw *hw, int enable)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
-	unsigned long flags = 0;
-
-	if (mpll->lock)
-		spin_lock_irqsave(mpll->lock, flags);
-	else
-		__acquire(mpll->lock);
-
-	meson_parm_write(clk->map, &mpll->en, enable ? 1 : 0);
-
-	if (mpll->lock)
-		spin_unlock_irqrestore(mpll->lock, flags);
-	else
-		__release(mpll->lock);
-}
-
-
-static int mpll_enable(struct clk_hw *hw)
-{
-	mpll_enable_core(hw, 1);
-
-	return 0;
-}
-
-static void mpll_disable(struct clk_hw *hw)
-{
-	mpll_enable_core(hw, 0);
-}
-
-static int mpll_is_enabled(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
-
-	return meson_parm_read(clk->map, &mpll->en);
-}
-
 const struct clk_ops meson_clk_mpll_ro_ops = {
 	.recalc_rate	= mpll_recalc_rate,
 	.round_rate	= mpll_round_rate,
-	.is_enabled	= mpll_is_enabled,
 };
 
 const struct clk_ops meson_clk_mpll_ops = {
 	.recalc_rate	= mpll_recalc_rate,
 	.round_rate	= mpll_round_rate,
 	.set_rate	= mpll_set_rate,
-	.enable		= mpll_enable,
-	.disable	= mpll_disable,
-	.is_enabled	= mpll_is_enabled,
 };
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index f0d70eaffcf3..cc1a964cd4d7 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -116,7 +116,6 @@ struct meson_clk_mpll_data {
 	struct parm sdm;
 	struct parm sdm_en;
 	struct parm n2;
-	struct parm en;
 	struct parm ssen;
 	struct parm misc;
 	spinlock_t *lock;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 49f5716ce8b6..92403ab2daf5 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -540,7 +540,7 @@ static struct clk_fixed_factor gxbb_fclk_div7 = {
 	},
 };
 
-static struct clk_regmap gxbb_mpll0 = {
+static struct clk_regmap gxbb_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL7,
@@ -557,11 +557,6 @@ static struct clk_regmap gxbb_mpll0 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL7,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.ssen = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 25,
@@ -570,14 +565,28 @@ static struct clk_regmap gxbb_mpll0 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll0",
+		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap gxbb_mpll1 = {
+static struct clk_regmap gxbb_mpll0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL7,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_mpll1_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL8,
@@ -594,22 +603,31 @@ static struct clk_regmap gxbb_mpll1 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL8,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll1",
+		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap gxbb_mpll2 = {
+static struct clk_regmap gxbb_mpll1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL8,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_mpll2_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL9,
@@ -626,21 +644,30 @@ static struct clk_regmap gxbb_mpll2 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL9,
-			.shift   = 14,
-			.width	 = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll2",
+		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap gxbb_mpll2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL9,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
 	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
@@ -1815,6 +1842,9 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_VAPB_1]		    = &gxbb_vapb_1.hw,
 		[CLKID_VAPB_SEL]	    = &gxbb_vapb_sel.hw,
 		[CLKID_VAPB]		    = &gxbb_vapb.hw,
+		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
+		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
+		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -1961,6 +1991,9 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_mpll0,
 	&gxbb_mpll1,
 	&gxbb_mpll2,
+	&gxbb_mpll0_div,
+	&gxbb_mpll1_div,
+	&gxbb_mpll2_div,
 	&gxbb_cts_amclk_div,
 	&gxbb_fixed_pll,
 	&gxbb_sys_pll,
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 42573b28a137..a8e7b8884e95 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -195,8 +195,11 @@
 #define CLKID_VAPB_0_DIV	  134
 #define CLKID_VAPB_1_DIV	  137
 #define CLKID_HDMI_PLL_PRE_MULT	  141
+#define CLKID_MPLL0_DIV		  142
+#define CLKID_MPLL1_DIV		  143
+#define CLKID_MPLL2_DIV		  144
 
-#define NR_CLKS			  142
+#define NR_CLKS			  145
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 4fd8253c54bb..625d953511be 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -289,7 +289,7 @@ static struct clk_fixed_factor meson8b_fclk_div7 = {
 	},
 };
 
-static struct clk_regmap meson8b_mpll0 = {
+static struct clk_regmap meson8b_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL7,
@@ -306,11 +306,6 @@ static struct clk_regmap meson8b_mpll0 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL7,
-			.shift   = 14,
-			.width   = 1,
-		},
 		.ssen = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 25,
@@ -319,14 +314,28 @@ static struct clk_regmap meson8b_mpll0 = {
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll0",
+		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap meson8b_mpll1 = {
+static struct clk_regmap meson8b_mpll0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL7,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mpll1_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL8,
@@ -343,22 +352,31 @@ static struct clk_regmap meson8b_mpll1 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL8,
-			.shift   = 14,
-			.width   = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll1",
+		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
-static struct clk_regmap meson8b_mpll2 = {
+static struct clk_regmap meson8b_mpll1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL8,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_mpll2_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
 			.reg_off = HHI_MPLL_CNTL9,
@@ -375,21 +393,30 @@ static struct clk_regmap meson8b_mpll2 = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.en = {
-			.reg_off = HHI_MPLL_CNTL9,
-			.shift   = 14,
-			.width   = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "mpll2",
+		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
 	},
 };
 
+static struct clk_regmap meson8b_mpll2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPLL_CNTL9,
+		.bit_idx = 14,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "mpll2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /*
  * FIXME cpu clocks and the legacy composite clocks (e.g. clk81) are both PLL
  * post-dividers and should be modeled with their respective PLLs via the
@@ -640,6 +667,9 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MPLL0]		    = &meson8b_mpll0.hw,
 		[CLKID_MPLL1]		    = &meson8b_mpll1.hw,
 		[CLKID_MPLL2]		    = &meson8b_mpll2.hw,
+		[CLKID_MPLL0_DIV]	    = &meson8b_mpll0_div.hw,
+		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
+		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -729,6 +759,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_mpll0,
 	&meson8b_mpll1,
 	&meson8b_mpll2,
+	&meson8b_mpll0_div,
+	&meson8b_mpll1_div,
+	&meson8b_mpll2_div,
 	&meson8b_fixed_pll,
 	&meson8b_vid_pll,
 	&meson8b_sys_pll,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 2eaf8a52e7dd..f2780508edec 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -69,7 +69,11 @@
  * will remain defined here.
  */
 
-#define CLK_NR_CLKS		96
+#define CLKID_MPLL0_DIV		96
+#define CLKID_MPLL1_DIV		97
+#define CLKID_MPLL2_DIV		98
+
+#define CLK_NR_CLKS		99
 
 /*
  * include the CLKID and RESETID that have
-- 
2.14.3

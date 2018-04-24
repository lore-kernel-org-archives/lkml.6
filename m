Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDXSvJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:51:09 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:53250 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752074AbeDXSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:50:35 -0400
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Apr 2018 20:50:34 +0200
X-ME-IP: 81.67.76.113
From: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mike Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Subject: [PATCH v2 2/2] clk: meson: gxbb: add the video decoder clocks
Date: Tue, 24 Apr 2018 20:48:38 +0200
Message-Id: <20180424184838.3406-3-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
References: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SEL/DIV/GATE for VDEC_1 and VDEC_HEVC.

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 drivers/clk/meson/gxbb.c | 114 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h |   6 ++-
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index b1e4d9557610..a893b1edda22 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1543,6 +1543,102 @@ static struct clk_regmap gxbb_vapb = {
 	},
 };
 
+/* VDEC clocks */
+
+static const char * const gxbb_vdec_parent_names[] = {
+	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
+};
+
+static struct clk_regmap gxbb_vdec_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_vdec_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_vdec_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_vdec_hevc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_vdec_hevc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap gxbb_vdec_hevc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_hevc",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
@@ -1786,6 +1882,12 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_FCLK_DIV4_DIV]	    = &gxbb_fclk_div4_div.hw,
 		[CLKID_FCLK_DIV5_DIV]	    = &gxbb_fclk_div5_div.hw,
 		[CLKID_FCLK_DIV7_DIV]	    = &gxbb_fclk_div7_div.hw,
+		[CLKID_VDEC_1_SEL]	    = &gxbb_vdec_1_sel.hw,
+		[CLKID_VDEC_1_DIV]	    = &gxbb_vdec_1_div.hw,
+		[CLKID_VDEC_1]		    = &gxbb_vdec_1.hw,
+		[CLKID_VDEC_HEVC_SEL]	    = &gxbb_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]	    = &gxbb_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC]	    = &gxbb_vdec_hevc.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -1942,6 +2044,12 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_FCLK_DIV4_DIV]	    = &gxbb_fclk_div4_div.hw,
 		[CLKID_FCLK_DIV5_DIV]	    = &gxbb_fclk_div5_div.hw,
 		[CLKID_FCLK_DIV7_DIV]	    = &gxbb_fclk_div7_div.hw,
+		[CLKID_VDEC_1_SEL]	    = &gxbb_vdec_1_sel.hw,
+		[CLKID_VDEC_1_DIV]	    = &gxbb_vdec_1_div.hw,
+		[CLKID_VDEC_1]		    = &gxbb_vdec_1.hw,
+		[CLKID_VDEC_HEVC_SEL]	    = &gxbb_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]	    = &gxbb_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC]	    = &gxbb_vdec_hevc.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -2100,6 +2208,12 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_fclk_div4,
 	&gxbb_fclk_div5,
 	&gxbb_fclk_div7,
+	&gxbb_vdec_1_sel,
+	&gxbb_vdec_1_div,
+	&gxbb_vdec_1,
+	&gxbb_vdec_hevc_sel,
+	&gxbb_vdec_hevc_div,
+	&gxbb_vdec_hevc,
 };
 
 struct clkc_data {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 9febf3f03739..b3ef54f65a9d 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -204,8 +204,12 @@
 #define CLKID_FCLK_DIV4_DIV	  148
 #define CLKID_FCLK_DIV5_DIV	  149
 #define CLKID_FCLK_DIV7_DIV	  150
+#define CLKID_VDEC_1_SEL	  151
+#define CLKID_VDEC_1_DIV	  152
+#define CLKID_VDEC_HEVC_SEL	  154
+#define CLKID_VDEC_HEVC_DIV	  155
 
-#define NR_CLKS			  151
+#define NR_CLKS			  157
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
-- 
2.17.0

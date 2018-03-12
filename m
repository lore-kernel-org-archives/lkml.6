Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeCLHEN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:04:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751950AbeCLHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:03:56 -0400
X-UUID: f308dd1dac2f40bebbdca6c53a90c3a4-20180312
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 5/5] clk: mediatek: update clock driver of MT2712
Date: Mon, 12 Mar 2018 15:03:42 +0800
Message-ID: <20180312070342.4335-7-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ECO design change,
1. add new clock mux data and change some
2. add new clock gate data and clock factor data
3. change status register offset of infra subsystem

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2712.c | 69 +++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 498d13799388..991d4093726e 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -221,6 +221,8 @@ static const struct mtk_fixed_factor top_divs[] = {
 		4),
 	FACTOR(CLK_TOP_D2A_ULCLK_6P5M, "d2a_ulclk_6p5m", "clk26m", 1,
 		4),
+	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3", "apll1_ck", 1,
+		3),
 };
 
 static const char * const axi_parents[] = {
@@ -625,7 +627,7 @@ static const char * const ether_125m_parents[] = {
 static const char * const ether_50m_parents[] = {
 	"clk26m",
 	"etherpll_50m",
-	"univpll_d26",
+	"apll1_d3",
 	"univpll3_d4"
 };
 
@@ -686,7 +688,7 @@ static const char * const i2c_parents[] = {
 
 static const char * const msdc0p_aes_parents[] = {
 	"clk26m",
-	"msdcpll_ck",
+	"syspll_d2",
 	"univpll_d3",
 	"vcodecpll_ck"
 };
@@ -719,6 +721,17 @@ static const char * const aud_apll2_parents[] = {
 	"clkaud_ext_i_2"
 };
 
+static const char * const apll1_ref_parents[] = {
+	"clkaud_ext_i_2",
+	"clkaud_ext_i_1",
+	"clki2si0_mck_i",
+	"clki2si1_mck_i",
+	"clki2si2_mck_i",
+	"clktdmin_mclk_i",
+	"clki2si2_mck_i",
+	"clktdmin_mclk_i"
+};
+
 static const char * const audull_vtx_parents[] = {
 	"d2a_ulclk_6p5m",
 	"clkaud_ext_i_0"
@@ -886,6 +899,10 @@ static struct mtk_composite top_muxes[] = {
 		aud_apll2_parents, 0x134, 1, 1),
 	MUX(CLK_TOP_DA_AUDULL_VTX_6P5M_SEL, "audull_vtx_sel",
 		audull_vtx_parents, 0x134, 31, 1),
+	MUX(CLK_TOP_APLL1_REF_SEL, "apll1_ref_sel",
+		apll1_ref_parents, 0x134, 4, 3),
+	MUX(CLK_TOP_APLL2_REF_SEL, "apll2_ref_sel",
+		apll1_ref_parents, 0x134, 7, 3),
 };
 
 static const char * const mcu_mp0_parents[] = {
@@ -932,36 +949,56 @@ static const struct mtk_clk_divider top_adj_divs[] = {
 	DIV_ADJ(CLK_TOP_APLL_DIV7, "apll_div7", "i2si3_sel", 0x128, 24, 8),
 };
 
-static const struct mtk_gate_regs top_cg_regs = {
+static const struct mtk_gate_regs top0_cg_regs = {
 	.set_ofs = 0x120,
 	.clr_ofs = 0x120,
 	.sta_ofs = 0x120,
 };
 
-#define GATE_TOP(_id, _name, _parent, _shift) {	\
+static const struct mtk_gate_regs top1_cg_regs = {
+	.set_ofs = 0x424,
+	.clr_ofs = 0x424,
+	.sta_ofs = 0x424,
+};
+
+#define GATE_TOP0(_id, _name, _parent, _shift) {	\
 		.id = _id,				\
 		.name = _name,				\
 		.parent_name = _parent,			\
-		.regs = &top_cg_regs,			\
+		.regs = &top0_cg_regs,			\
 		.shift = _shift,			\
 		.ops = &mtk_clk_gate_ops_no_setclr,	\
 	}
 
+#define GATE_TOP1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &top1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
 static const struct mtk_gate top_clks[] = {
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN0, "apll_div_pdn0", "i2so1_sel", 0),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN1, "apll_div_pdn1", "i2so2_sel", 1),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN2, "apll_div_pdn2", "i2so3_sel", 2),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN3, "apll_div_pdn3", "tdmo0_sel", 3),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN4, "apll_div_pdn4", "tdmo1_sel", 4),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN5, "apll_div_pdn5", "i2si1_sel", 5),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN6, "apll_div_pdn6", "i2si2_sel", 6),
-	GATE_TOP(CLK_TOP_APLL_DIV_PDN7, "apll_div_pdn7", "i2si3_sel", 7),
+	/* TOP0 */
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN0, "apll_div_pdn0", "i2so1_sel", 0),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN1, "apll_div_pdn1", "i2so2_sel", 1),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN2, "apll_div_pdn2", "i2so3_sel", 2),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN3, "apll_div_pdn3", "tdmo0_sel", 3),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN4, "apll_div_pdn4", "tdmo1_sel", 4),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN5, "apll_div_pdn5", "i2si1_sel", 5),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN6, "apll_div_pdn6", "i2si2_sel", 6),
+	GATE_TOP0(CLK_TOP_APLL_DIV_PDN7, "apll_div_pdn7", "i2si3_sel", 7),
+	/* TOP1 */
+	GATE_TOP1(CLK_TOP_NFI2X_EN, "nfi2x_en", "nfi2x_sel", 0),
+	GATE_TOP1(CLK_TOP_NFIECC_EN, "nfiecc_en", "nfiecc_sel", 1),
+	GATE_TOP1(CLK_TOP_NFI1X_CK_EN, "nfi1x_ck_en", "nfi2x_sel", 2),
 };
 
 static const struct mtk_gate_regs infra_cg_regs = {
 	.set_ofs = 0x40,
 	.clr_ofs = 0x44,
-	.sta_ofs = 0x40,
+	.sta_ofs = 0x48,
 };
 
 #define GATE_INFRA(_id, _name, _parent, _shift) {	\
@@ -1120,6 +1157,10 @@ static const struct mtk_gate peri_clks[] = {
 		"msdc50_0_h_sel", 4),
 	GATE_PERI2(CLK_PERI_MSDC50_3_HCLK_EN, "per_msdc50_3_h",
 		"msdc50_3_h_sel", 5),
+	GATE_PERI2(CLK_PERI_MSDC30_0_QTR_EN, "per_msdc30_0_q",
+		"axi_sel", 6),
+	GATE_PERI2(CLK_PERI_MSDC30_3_QTR_EN, "per_msdc30_3_q",
+		"mem_sel", 7),
 };
 
 #define MT2712_PLL_FMAX		(3000UL * MHZ)
-- 
2.12.5

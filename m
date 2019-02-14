Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67466C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1E7222E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550161971;
	bh=m77rE7/wMUd1pn8crd6Ug8AEy5PbTKoRD6tBjs4D088=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DaoJkwtPXxjEEUDmjhmA+QQlxMNIFNAd0Jv6EYXMM+IhJdZXJGbwn41AfkBkqqKr7
	 Ite/JQ3MVV9jfq8sErvNoQhfm5tKPn1piPPzf4gP6xqsp5drQN9nDbwFqNLT5EIrZ+
	 gynmm7tlzFLtD0/q8yxJ+/7mbhrfEd7H/o9dQv+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439689AbfBNQcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405161AbfBNQcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:32:48 -0500
Received: from ziggy.de (unknown [37.223.146.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C56222DA;
        Thu, 14 Feb 2019 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550161967;
        bh=m77rE7/wMUd1pn8crd6Ug8AEy5PbTKoRD6tBjs4D088=;
        h=From:To:Cc:Subject:Date:From;
        b=MPtecKHYHkXnHw4qVA2WnXh/V8ahPRHPR5KVs8d77X0dhofI+H6S7YWsvUFcseVHX
         Fb7tkXAfjKNNdje21jRFx4Ol/aLkOuw7ZuGASOJ0gvxOrSsaM36fJfX5nb3Pop82c3
         tDVQdpV84ssBnw4Ee816Aslgk+PVvPF9pqYDF5nI=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/3] clk: mediatek: Mark bus and DRAM related clocks as critical
Date:   Thu, 14 Feb 2019 17:32:42 +0100
Message-Id: <20190214163242.26259-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Mattsson <jasu@njomotys.info>

Currently, DRAM-related clocks are not marked with CLK_IS_CRITICAL
for MT6797. This causes memory corruption when the system is
booted without clk_ignore_unused.
This patch marks MUX ddrphycfg_sel as well as gates infra_dramc_f26m
and infra_dramc_b_f26m as CLK_IS_CRITICAL.

Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-mt6797.c | 68 +++++++++++++++++++------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc974ed9..c2b46b184b9a 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -324,6 +324,10 @@ static const char * const anc_md32_parents[] = {
 	"univpll_d5",
 };
 
+/*
+ * Clock mux ddrphycfg is needed by the DRAM controller. We mark it as
+ * critical as otherwise the system will hang after boot.
+ */
 static const struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_MUX_ULPOSC_AXI_CK_MUX_PRE, "ulposc_axi_ck_mux_pre",
 	    ulposc_axi_ck_mux_pre_parents, 0x0040, 3, 1),
@@ -331,8 +335,8 @@ static const struct mtk_composite top_muxes[] = {
 	    ulposc_axi_ck_mux_parents, 0x0040, 2, 1),
 	MUX(CLK_TOP_MUX_AXI, "axi_sel", axi_parents,
 	    0x0040, 0, 2),
-	MUX(CLK_TOP_MUX_DDRPHYCFG, "ddrphycfg_sel", ddrphycfg_parents,
-	    0x0040, 16, 2),
+	MUX_FLAGS(CLK_TOP_MUX_DDRPHYCFG, "ddrphycfg_sel", ddrphycfg_parents,
+		  0x0040, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX(CLK_TOP_MUX_MM, "mm_sel", mm_parents,
 	    0x0040, 24, 2),
 	MUX_GATE(CLK_TOP_MUX_PWM, "pwm_sel", pwm_parents, 0x0050, 0, 3, 7),
@@ -424,33 +428,45 @@ static const struct mtk_gate_regs infra2_cg_regs = {
 	.sta_ofs = 0x00b0,
 };
 
-#define GATE_ICG0(_id, _name, _parent, _shift) {	\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &infra0_cg_regs,			\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
+#define GATE_ICG0(_id, _name, _parent, _shift) {		\
+	.id = _id,						\
+	.name = _name,						\
+	.parent_name = _parent,					\
+	.regs = &infra0_cg_regs,				\
+	.shift = _shift,					\
+	.ops = &mtk_clk_gate_ops_setclr,			\
 }
 
-#define GATE_ICG1(_id, _name, _parent, _shift) {	\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &infra1_cg_regs,			\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
+#define GATE_ICG1(_id, _name, _parent, _shift)			\
+	GATE_ICG1_FLAGS(_id, _name, _parent, _shift, 0)
+
+#define GATE_ICG1_FLAGS(_id, _name, _parent, _shift, _flags) {	\
+	.id = _id,						\
+	.name = _name,						\
+	.parent_name = _parent,					\
+	.regs = &infra1_cg_regs,				\
+	.shift = _shift,					\
+	.ops = &mtk_clk_gate_ops_setclr,			\
+	.flags = _flags,					\
 }
 
-#define GATE_ICG2(_id, _name, _parent, _shift) {	\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &infra2_cg_regs,			\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
+#define GATE_ICG2(_id, _name, _parent, _shift)			\
+	GATE_ICG2_FLAGS(_id, _name, _parent, _shift, 0)
+
+#define GATE_ICG2_FLAGS(_id, _name, _parent, _shift, _flags) {	\
+	.id = _id,						\
+	.name = _name,						\
+	.parent_name = _parent,					\
+	.regs = &infra2_cg_regs,				\
+	.shift = _shift,					\
+	.ops = &mtk_clk_gate_ops_setclr,			\
+	.flags = _flags,					\
 }
 
+/*
+ * Clock gates dramc and dramc_b are needed by the DRAM controller.
+ * We mark them as critical as otherwise the system will hang after boot.
+ */
 static const struct mtk_gate infra_clks[] = {
 	GATE_ICG0(CLK_INFRA_PMIC_TMR, "infra_pmic_tmr", "ulposc", 0),
 	GATE_ICG0(CLK_INFRA_PMIC_AP, "infra_pmic_ap", "pmicspi_sel", 1),
@@ -505,7 +521,8 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_ICG1(CLK_INFRA_CCIF_AP, "infra_ccif_ap", "axi_sel", 23),
 	GATE_ICG1(CLK_INFRA_AUDIO, "infra_audio", "axi_sel", 25),
 	GATE_ICG1(CLK_INFRA_CCIF_MD, "infra_ccif_md", "axi_sel", 26),
-	GATE_ICG1(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m", "clk26m", 31),
+	GATE_ICG1_FLAGS(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m",
+			"clk26m", 31, CLK_IS_CRITICAL),
 	GATE_ICG2(CLK_INFRA_I2C4, "infra_i2c4", "axi_sel", 0),
 	GATE_ICG2(CLK_INFRA_I2C_APPM, "infra_i2c_appm", "axi_sel", 1),
 	GATE_ICG2(CLK_INFRA_I2C_GPUPM, "infra_i2c_gpupm", "axi_sel", 2),
@@ -516,7 +533,8 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_ICG2(CLK_INFRA_I2C5, "infra_i2c5", "axi_sel", 7),
 	GATE_ICG2(CLK_INFRA_SYS_CIRQ, "infra_sys_cirq", "axi_sel", 8),
 	GATE_ICG2(CLK_INFRA_SPI1, "infra_spi1", "spi_sel", 10),
-	GATE_ICG2(CLK_INFRA_DRAMC_B_F26M, "infra_dramc_b_f26m", "clk26m", 11),
+	GATE_ICG2_FLAGS(CLK_INFRA_DRAMC_B_F26M, "infra_dramc_b_f26m",
+			"clk26m", 11, CLK_IS_CRITICAL),
 	GATE_ICG2(CLK_INFRA_ANC_MD32, "infra_anc_md32", "anc_md32_sel", 12),
 	GATE_ICG2(CLK_INFRA_ANC_MD32_32K, "infra_anc_md32_32k", "clk26m", 13),
 	GATE_ICG2(CLK_INFRA_DVFS_SPM1, "infra_dvfs_spm1", "axi_sel", 15),
-- 
2.20.1


Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC1DC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC2218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545243417;
	bh=72fdjbNpxrOgaid6/wodsdGUd2NO2XEPMocUEpv/mR8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bW6TkKbTMpHJ00DTnD8CHq85Qvhkyy7dTMQotLGkTryGEdozERUCQRogRxtRXOe31
	 s207xNP1wxwsdSj/3AAaYyOwKZNQVHXc9Nz7SXGXeu7Re4tfZyEqH/9adWK5QWxXbW
	 BPkMiR6UYvw9TFl8u7BhMPX/zTY69W3MJG2pQR1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeLSSQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeLSSQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:16:56 -0500
Received: from ziggy.de (unknown [37.223.145.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0345217D9;
        Wed, 19 Dec 2018 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545243415;
        bh=72fdjbNpxrOgaid6/wodsdGUd2NO2XEPMocUEpv/mR8=;
        h=From:To:Cc:Subject:Date:From;
        b=sGWRAJ2SndK7M/Ziwv0aivWhCtYKU3w3GNUo2Y2tJDkwbknoc0GVfB1MTLl8wB1Ev
         Y2u6zmf7AfzPJuuk+LYiiKnsmYE/52YASLeeVZX6xLnNeiMAbRu2F+1o0Bo7rNSrJA
         zYrr2wBnAqN0591OM6b9aB9IMwSdCIGotA3+C0/4=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: Mark bus and DRAM related clocks as critical
Date:   Wed, 19 Dec 2018 19:16:50 +0100
Message-Id: <20181219181650.27105-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.2
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
changes since v2 [1]:
- first two patches of series are in clk-next, drop them
- axi_sel is not needed, drop CLK_IS_CRITICAL for it.
- update commit message

[1] https://patchwork.kernel.org/patch/10686759/ 

 drivers/clk/mediatek/clk-mt6797.c | 60 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc974ed9..a6e5408e0388 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -331,8 +331,8 @@ static const struct mtk_composite top_muxes[] = {
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
@@ -424,31 +424,39 @@ static const struct mtk_gate_regs infra2_cg_regs = {
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
 
 static const struct mtk_gate infra_clks[] = {
@@ -505,7 +513,8 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_ICG1(CLK_INFRA_CCIF_AP, "infra_ccif_ap", "axi_sel", 23),
 	GATE_ICG1(CLK_INFRA_AUDIO, "infra_audio", "axi_sel", 25),
 	GATE_ICG1(CLK_INFRA_CCIF_MD, "infra_ccif_md", "axi_sel", 26),
-	GATE_ICG1(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m", "clk26m", 31),
+	GATE_ICG1_FLAGS(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m",
+			"clk26m", 31, CLK_IS_CRITICAL),
 	GATE_ICG2(CLK_INFRA_I2C4, "infra_i2c4", "axi_sel", 0),
 	GATE_ICG2(CLK_INFRA_I2C_APPM, "infra_i2c_appm", "axi_sel", 1),
 	GATE_ICG2(CLK_INFRA_I2C_GPUPM, "infra_i2c_gpupm", "axi_sel", 2),
@@ -516,7 +525,8 @@ static const struct mtk_gate infra_clks[] = {
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
2.19.2


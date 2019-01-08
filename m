Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77687C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949548;
	bh=OzgpK4rvn1UmkXsAxAA2XXllzzALu/U6bBbow7VBJpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0R7O3qf12NK7Vo42UV6zmUBqF8ql2EpU1o3diK4+mUoU9iMMZZyNrLz+y8f07c9/R
	 gbFH24t/3tPBrrDY/cdpa/tcAyCFKY952vYL9DeS/APDSyRTLXvC2tDk25USGlM0nl
	 4AFRfNhvoKZ9St5FONhMRiheI53gBiUZDQnTQ3X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAHMMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfAHMMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:12:24 -0500
Received: from localhost.localdomain (unknown [37.223.143.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA912087F;
        Tue,  8 Jan 2019 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949543;
        bh=OzgpK4rvn1UmkXsAxAA2XXllzzALu/U6bBbow7VBJpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W//lyRUc9It7SpaiXeZA+ZXyyaXoiV9mWIrMDf06Z9NGTe/vddoXQqvJVTZQ4frHi
         n8sEWZbb5MsVHTqsh5ivjjaiV3HA8/nTaQKhYcVE45UzQuM8vTwcUrQTRu0HI0gnRH
         7b046D9WhQ+1V0YQRZeggJ6zfdQcTo34wWs68ltM=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/3] clk: mediatek: Mark bus and DRAM related clocks as critical
Date:   Tue,  8 Jan 2019 13:12:08 +0100
Message-Id: <20190108121208.2473-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190108121208.2473-1-matthias.bgg@kernel.org>
References: <20190108121208.2473-1-matthias.bgg@kernel.org>
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
2.20.1


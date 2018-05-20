Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeETQcT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32864 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeETQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:13 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/6] clk: ingenic: jz4770: Enable power of AHB1 bus after ungating VPU clock
Date: Sun, 20 May 2018 16:31:16 +0000
Message-Id: <20180520163117.14125-5-paul@crapouillou.net>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was broken before, because the AHB1 bus was enabled before the VPU
clock was ungated, while it must be done afterwards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4770-cgu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 2a4209a9f53f..f83852db1e27 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -154,7 +154,7 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		"h1clk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = { CGU_REG_CPCCR, 24, 1, 4, 22, -1, -1 },
-		.gate = { CGU_REG_LCR, 30 },
+		.gate = { CGU_REG_CLKGR1, 7 },
 	},
 	[JZ4770_CLK_H2CLK] = {
 		"h2clk", CGU_CLK_DIV,
@@ -362,7 +362,7 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 	[JZ4770_CLK_VPU] = {
 		"vpu", CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_H1CLK, },
-		.gate = { CGU_REG_CLKGR1, 7 },
+		.gate = { CGU_REG_LCR, 30 },
 	},
 	[JZ4770_CLK_MMC0] = {
 		"mmc0", CGU_CLK_GATE,
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeETQcd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33026 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeETQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:16 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/6] clk: ingenic: jz4770: Modify C1CLK clock to disable CPU clock stop on idle
Date: Sun, 20 May 2018 16:31:15 +0000
Message-Id: <20180520163117.14125-4-paul@crapouillou.net>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the main processor goes idle, by default its clock is stopped.
However, this also stops the clock of the co-processor.

Here, if the C1CLK clock is enabled, we disable this functionality.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4770-cgu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 226c8016f6b0..2a4209a9f53f 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -162,9 +162,10 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 		.div = { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
 	},
 	[JZ4770_CLK_C1CLK] = {
-		"c1clk", CGU_CLK_DIV,
+		"c1clk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+		.gate = { CGU_REG_OPCR, 31, true }, // disable CCLK stop on idle
 	},
 	[JZ4770_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV,
-- 
2.17.0

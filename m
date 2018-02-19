Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeBSLYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:24:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBSLVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:55 -0500
X-Google-Smtp-Source: AH8x226i5lco3FLHPbjACS5Vd3SKQCtDWr6VX5LlAH3qMSgxGbzYaXxKuJ6tOK6wgJB9gvN+EWH+0g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] clk: meson: remove special gp0 lock loop
Date: Mon, 19 Feb 2018 12:21:38 +0100
Message-Id: <20180219112146.21746-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After testing, it appears that the gxl (and axg) does not require the
special locking/reset loop which was initially added for it.

All the values present in the gxl table can locked with the simple lock
checking loop.

The change switches the gxl and axg gp0 back to the simple lock checking
loop and removes the code no longer required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  1 -
 drivers/clk/meson/clk-pll.c | 12 +-----------
 drivers/clk/meson/clkc.h    |  2 --
 drivers/clk/meson/gxbb.c    |  1 -
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 8226b82c67fd..4f13929cd594 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -231,7 +231,6 @@ static struct clk_regmap axg_gp0_pll = {
 		.table = axg_gp0_pll_rate_table,
 		.init_regs = axg_gp0_init_regs,
 		.init_count = ARRAY_SIZE(axg_gp0_init_regs),
-		.flags = CLK_MESON_PLL_LOCK_LOOP_RST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f3d909719111..0b9b4422c968 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -121,19 +121,9 @@ static int meson_clk_pll_wait_lock(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	int delay = pll->flags & CLK_MESON_PLL_LOCK_LOOP_RST ?
-		100 : 24000000;
+	int delay = 24000000;
 
 	do {
-		/* Specific wait loop for GXL/GXM GP0 PLL */
-		if (pll->flags & CLK_MESON_PLL_LOCK_LOOP_RST) {
-			/* Procedure taken from the vendor kernel */
-			meson_parm_write(clk->map, &pll->rst, 1);
-			udelay(10);
-			meson_parm_write(clk->map, &pll->rst, 0);
-			mdelay(1);
-		}
-
 		/* Is the clock locked now ? */
 		if (meson_parm_read(clk->map, &pll->l))
 			return 0;
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 8d8fe608cff4..ebd88afe1eb5 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -82,8 +82,6 @@ struct pll_rate_table {
 		.frac		= (_frac),				\
 	}								\
 
-#define CLK_MESON_PLL_LOCK_LOOP_RST	BIT(0)
-
 struct meson_clk_pll_data {
 	struct parm m;
 	struct parm n;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 3cd07f960489..ac48eef0f490 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -475,7 +475,6 @@ static struct clk_regmap gxl_gp0_pll = {
 		.table = gxl_gp0_pll_rate_table,
 		.init_regs = gxl_gp0_init_regs,
 		.init_count = ARRAY_SIZE(gxl_gp0_init_regs),
-		.flags = CLK_MESON_PLL_LOCK_LOOP_RST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
-- 
2.14.3

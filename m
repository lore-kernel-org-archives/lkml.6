Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeDJNFK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:05:10 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:45480 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753540AbeDJNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:05:07 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: renesas: rcar-gen2: Centralize quirks handling
Date: Tue, 10 Apr 2018 15:04:58 +0200
Message-Id: <1523365498-16789-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce centralized quirks handling like on R-Car Gen3, and convert
the RZ/G1C SD clock table handling over to it.

This makes it easier to add more quirks later, if/when needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in clk-renesas-for-v4.18.

 drivers/clk/renesas/rcar-gen2-cpg.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen2-cpg.c b/drivers/clk/renesas/rcar-gen2-cpg.c
index 0c49f59d5074b1c4..daf88bc2cdae177b 100644
--- a/drivers/clk/renesas/rcar-gen2-cpg.c
+++ b/drivers/clk/renesas/rcar-gen2-cpg.c
@@ -261,9 +261,15 @@ static const struct clk_div_table cpg_sd01_div_table[] = {
 static const struct rcar_gen2_cpg_pll_config *cpg_pll_config __initdata;
 static unsigned int cpg_pll0_div __initdata;
 static u32 cpg_mode __initdata;
+static u32 cpg_quirks __initdata;
 
-static const struct soc_device_attribute soc_r8a77470[] = {
-	{ .soc_id = "r8a77470" },
+#define SD_SKIP_FIRST	BIT(0)		/* Skip first clock in SD table */
+
+static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
+	{
+		.soc_id = "r8a77470",
+		.data = (void *)SD_SKIP_FIRST,
+	},
 	{ /* sentinel */ }
 };
 
@@ -333,7 +339,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN2_SD0:
 		table = cpg_sd01_div_table;
-		if (soc_device_match(soc_r8a77470))
+		if (cpg_quirks & SD_SKIP_FIRST)
 			table++;
 
 		shift = 4;
@@ -341,7 +347,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN2_SD1:
 		table = cpg_sd01_div_table;
-		if (soc_device_match(soc_r8a77470))
+		if (cpg_quirks & SD_SKIP_FIRST)
 			table++;
 
 		shift = 0;
@@ -372,9 +378,15 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
 int __init rcar_gen2_cpg_init(const struct rcar_gen2_cpg_pll_config *config,
 			      unsigned int pll0_div, u32 mode)
 {
+	const struct soc_device_attribute *attr;
+
 	cpg_pll_config = config;
 	cpg_pll0_div = pll0_div;
 	cpg_mode = mode;
+	attr = soc_device_match(cpg_quirks_match);
+	if (attr)
+		cpg_quirks = (uintptr_t)attr->data;
+	pr_debug("%s: mode = 0x%x quirks = 0x%x\n", __func__, mode, cpg_quirks);
 
 	spin_lock_init(&cpg_lock);
 
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeESSck (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:32:40 -0400
Received: from mailout6.siol.net ([213.250.19.133]:34646 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752534AbeESSc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:29 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 01/15] clk: sunxi-ng: r40: Add minimal rate for video PLLs
Date: Sat, 19 May 2018 20:31:13 +0200
Message-Id: <20180519183127.2718-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation and experience with other similar SoCs, video
PLLs don't work stable if their output frequency is set below 192 MHz.

Because of that, set minimal rate to both R40 video PLLs to 192 MHz.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 46 +++++++++++++++-------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 933f2e68f42a..c16a62a7bdbd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -65,17 +65,18 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   CLK_SET_RATE_UNGATE);
 
 /* TODO: The result of N/M is required to be in [8, 25] range. */
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
-					"osc24M", 0x0010,
-					8, 7,		/* N */
-					0, 4,		/* M */
-					BIT(24),	/* frac enable */
-					BIT(25),	/* frac select */
-					270000000,	/* frac rate 0 */
-					297000000,	/* frac rate 1 */
-					BIT(31),	/* gate */
-					BIT(28),	/* lock */
-					CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video0_clk, "pll-video0",
+					    "osc24M", 0x0010,
+					    192000000,	/* Minimum rate */
+					    8, 7,	/* N */
+					    0, 4,	/* M */
+					    BIT(24),	/* frac enable */
+					    BIT(25),	/* frac select */
+					    270000000,	/* frac rate 0 */
+					    297000000,	/* frac rate 1 */
+					    BIT(31),	/* gate */
+					    BIT(28),	/* lock */
+					    CLK_SET_RATE_UNGATE);
 
 /* TODO: The result of N/M is required to be in [8, 25] range. */
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
@@ -151,17 +152,18 @@ static struct ccu_nk pll_periph1_clk = {
 };
 
 /* TODO: The result of N/M is required to be in [8, 25] range. */
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
-					"osc24M", 0x030,
-					8, 7,		/* N */
-					0, 4,		/* M */
-					BIT(24),	/* frac enable */
-					BIT(25),	/* frac select */
-					270000000,	/* frac rate 0 */
-					297000000,	/* frac rate 1 */
-					BIT(31),	/* gate */
-					BIT(28),	/* lock */
-					CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video1_clk, "pll-video1",
+					    "osc24M", 0x030,
+					    192000000,	/* Minimum rate */
+					    8, 7,	/* N */
+					    0, 4,	/* M */
+					    BIT(24),	/* frac enable */
+					    BIT(25),	/* frac select */
+					    270000000,	/* frac rate 0 */
+					    297000000,	/* frac rate 1 */
+					    BIT(31),	/* gate */
+					    BIT(28),	/* lock */
+					    CLK_SET_RATE_UNGATE);
 
 static struct ccu_nkm pll_sata_clk = {
 	.enable		= BIT(31),
-- 
2.17.0

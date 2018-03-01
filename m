Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162543AbeCAWLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:11:25 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:42612 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162480AbeCAWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:11:22 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 02/16] clk: sunxi-ng: h3: h5: Add minimal rate for video PLL
Date: Thu,  1 Mar 2018 22:34:28 +0100
Message-Id: <20180301213442.16677-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although user manuals for H3 and H5 SoCs state that minimal rate
supported by video PLL is around 30 MHz, it seems that in reality
minimal rate is around 192 MHz.

Experiments showed that any rate below 96 MHz doesn't produce any video
output at all. Even at this frequency, stable output depends on right
factors. For example, when N = 4 and M = 1, output is stable and when N
= 8 and M = 2, it's not.

BSP clock driver suggest that minimum stable frequency is 192 MHz. That
would also be in line with A64 SoC, which has similar periphery.

Set minimal video PLL rate for H3/H5 to 192 MHz.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 29bc0566b776..b9f39078c0b2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -69,17 +69,18 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				       BIT(28),	/* lock */
 				       CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
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
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video_clk, "pll-video",
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
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x0018,
-- 
2.16.2

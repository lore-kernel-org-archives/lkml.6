Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C74C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DAB20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DAB20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394289AbeKVVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:40 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:48376 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394193AbeKVVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:39 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5AD975FCB2; Thu, 22 Nov 2018 18:23:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v9 5/8] clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation for audio PLL
Date:   Thu, 22 Nov 2018 18:23:22 +0800
Message-Id: <20181122102325.29495-6-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio blocks require specific clock rates. Until now we were using
the closest clock rate possible with integer N-M factors. This resulted
in audio playback being slightly slower than it should be.

The vendor kernel gets around this (for some SoCs) by using sigma-delta
modulation to generate a fractional-N factor. As the PLL hardware is
identical in most chips, we can port the settings for H3 onto the A64.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 37 +++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 1f45b20ad752..181b599dc163 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -51,18 +51,29 @@ static struct ccu_nkmp pll_cpux_clk = {
  * the base (2x, 4x and 8x), and one variable divider (the one true
  * pll audio).
  *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names
+ * With sigma-delta modulation for fractional-N on the audio PLL,
+ * we have to use specific dividers. This means the variable divider
+ * can no longer be used, as the audio codec requests the exact clock
+ * rates we support through this mechanism. So we now hard code the
+ * variable divider to 1. This means the clock rates will no longer
+ * match the clock names.
  */
 #define SUN50I_A64_PLL_AUDIO_REG	0x008
 
-static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
-				   "osc24M", 0x008,
-				   8, 7,	/* N */
-				   0, 5,	/* M */
-				   BIT(31),	/* gate */
-				   BIT(28),	/* lock */
-				   CLK_SET_RATE_UNGATE);
+static struct ccu_sdm_setting pll_audio_sdm_table[] = {
+	{ .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
+	{ .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
+};
+
+static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
+				       "osc24M", 0x008,
+				       8, 7,	/* N */
+				       0, 5,	/* M */
+				       pll_audio_sdm_table, BIT(24),
+				       0x284, BIT(31),
+				       BIT(31),	/* gate */
+				       BIT(28),	/* lock */
+				       CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
 						"osc24M", 0x010,
@@ -594,9 +605,9 @@ static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 /* Fixed Factor clocks */
 static CLK_FIXED_FACTOR(osc12M_clk, "osc12M", "osc24M", 2, 1, 0);
 
-/* We hardcode the divider to 4 for now */
+/* We hardcode the divider to 1 for now */
 static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
+			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
 			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
@@ -916,10 +927,10 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	/* Force the PLL-Audio-1x divider to 4 */
+	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN50I_A64_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
-	writel(val | (3 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
+	writel(val | (0 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
-- 
2.19.1


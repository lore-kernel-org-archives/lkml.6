Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeCLP6H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:58:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37071 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeCLP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:58:02 -0400
X-Google-Smtp-Source: AG47ELvhMeQ7OZuPwZ3r8xhXVwc39ETg4JpeTdZLtF6aDvleuTc2vP1YcwefKfkMTsHddgyH8zNU2w==
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v2 3/6] ASoC: sun4i-i2s: Correct divider calculations
Date: Mon, 12 Mar 2018 16:57:50 +0100
Message-Id: <20180312155753.9478-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312155753.9478-1-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The clock division circuitry is different on the H3 and later SoCs.
The division of bclk is now based on pll2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 76 +++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 396b11346361..2bd0befa02a8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -129,10 +129,10 @@
  * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
- * @mclk_offset: Value by which mclkdiv needs to be adjusted.
- * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
+ * @field_clkdiv_mclk: regmap field for mclkdiv.
+ * @field_clkdiv_bclk: regmap field for bclkdiv.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
  * @field_fmt_bclk: regmap field to set clk polarity.
@@ -153,8 +153,6 @@ struct sun4i_i2s_quirks {
 	bool				has_chsel_offset;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
-	unsigned int			mclk_offset;
-	unsigned int			bclk_offset;
 	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
@@ -212,7 +210,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 8, .val = 3 },
 	{ .div = 12, .val = 4 },
 	{ .div = 16, .val = 5 },
-	/* TODO - extend divide ratio supported by newer SoCs */
+};
+
+static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
+	{ .div = 0, .val = 0 },
+	{ .div = 1, .val = 1 },
+	{ .div = 2, .val = 2 },
+	{ .div = 4, .val = 3 },
+	{ .div = 6, .val = 4 },
+	{ .div = 8, .val = 5 },
+	{ .div = 12, .val = 6 },
+	{ .div = 16, .val = 7 },
+	{ .div = 24, .val = 8 },
+	{ .div = 32, .val = 9 },
+	{ .div = 48, .val = 10 },
+	{ .div = 64, .val = 11 },
+	{ .div = 96, .val = 12 },
+	{ .div = 128, .val = 13 },
+	{ .div = 176, .val = 14 },
+	{ .div = 192, .val = 15 },
 };
 
 static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
@@ -224,21 +240,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	{ .div = 12, .val = 5 },
 	{ .div = 16, .val = 6 },
 	{ .div = 24, .val = 7 },
-	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
-				  unsigned int word_size)
+				  unsigned int word_size,
+				  const struct sun4i_i2s_clk_div *bdiv,
+				  unsigned int size)
 {
 	int div = oversample_rate / word_size / 2;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
-		const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (bdiv->div == div)
 			return bdiv->val;
+		bdiv++;
 	}
 
 	return -EINVAL;
@@ -247,16 +263,17 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
 				  unsigned int module_rate,
-				  unsigned int sampling_rate)
+				  unsigned int sampling_rate,
+				  const struct sun4i_i2s_clk_div *mdiv,
+				  unsigned int size)
 {
 	int div = module_rate / sampling_rate / oversample_rate;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
-		const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (mdiv->div == div)
 			return mdiv->val;
+		mdiv++;
 	}
 
 	return -EINVAL;
@@ -321,24 +338,37 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
+	if (i2s->variant->has_fmt_set_lrck_period)
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+						  word_size,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+						  word_size,
+						  sun4i_i2s_bclk_div,
+						  ARRAY_SIZE(sun4i_i2s_bclk_div));
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
 	}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
+
+	if (i2s->variant->has_fmt_set_lrck_period)
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun4i_i2s_mclk_div,
+						  ARRAY_SIZE(sun4i_i2s_mclk_div));
 	if (mclk_div < 0) {
 		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
 		return -EINVAL;
 	}
 
-	/* Adjust the clock division values if needed */
-	bclk_div += i2s->variant->bclk_offset;
-	mclk_div += i2s->variant->mclk_offset;
-
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
 		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
@@ -953,8 +983,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
-	.mclk_offset		= 1,
-	.bclk_offset		= 2,
 	.fmt_offset		= 3,
 	.has_fmt_set_lrck_period = true,
 	.has_chcfg		= true,
-- 
2.16.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeCLP6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:58:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35099 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeCLP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:57:59 -0400
X-Google-Smtp-Source: AG47ELudKO3tSVBPwXD49P63zNRbRx4HbK1xYdkuTKhiteGQQNthDoqTNL+kHBG1Be/OtMDs/lcPvQ==
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v2 1/6] ASoC: sun4i-i2s: Add slot width override
Date: Mon, 12 Mar 2018 16:57:48 +0100
Message-Id: <20180312155753.9478-2-codekipper@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312155753.9478-1-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Some codecs require a different amount of a bit clocks per frame
than what is calculated by using the sample width. Use a slot
width override property to provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt |  5 +++++
 sound/soc/sunxi/sun4i-i2s.c                           | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index b9d50d6cdef3..48addef65b8f 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -28,6 +28,11 @@ Required properties for the following compatibles:
 	- "allwinner,sun8i-h3-i2s"
 - resets: phandle to the reset line for this codec
 
+Optional properties:
+- allwinner,slot-width-override:if this property is present then the dai is
+				configured to extend the slot width to the
+				value specified. Min 8, Max 32.
+
 Example:
 
 i2s0: i2s@1c22400 {
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a4aa931ebfae..873054a6c3be 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -193,6 +193,8 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -344,7 +346,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	return 0;
 }
@@ -418,7 +420,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->slot_width ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -1029,7 +1032,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	struct sun4i_i2s *i2s;
 	struct resource *res;
 	void __iomem *regs;
-	int irq, ret;
+	int irq, ret, val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1096,6 +1099,12 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 8;
 
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "allwinner,slot-width-override", &val)) {
+		if (val >= 8 && val <= 32)
+			i2s->slot_width = val;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.16.2

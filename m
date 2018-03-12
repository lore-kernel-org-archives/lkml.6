Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeCLP6h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:58:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45577 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeCLP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:58:03 -0400
X-Google-Smtp-Source: AG47ELtsBpDSpGR+6aRIJoDlj+/6rnCaX8eDIzzpILl4h/kcpIJweTMwaulsB9E0DtbqTn7CTSvBVg==
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Mon, 12 Mar 2018 16:57:51 +0100
Message-Id: <20180312155753.9478-5-codekipper@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312155753.9478-1-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The i2s block supports multi-lane i2s output however this functionality
is only possible in earlier SoCs where the pins are exposed and for
the i2s block used for HDMI audio on the later SoCs.

To enable this functionality, an optional property has been added to
the bindings.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
 sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++++++-----
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 48addef65b8f..3f966ac61b9e 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -33,6 +33,9 @@ Optional properties:
 				configured to extend the slot width to the
 				value specified. Min 8, Max 32.
 
+- allwinner,playback-channels:  if this property is present then the number
+				of available channels is extended and the
+				outputs enabled.
 Example:
 
 i2s0: i2s@1c22400 {
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 2bd0befa02a8..436480df1844 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -27,7 +27,7 @@
 
 #define SUN4I_I2S_CTRL_REG		0x00
 #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
-#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
+#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) << 8)
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
@@ -394,14 +394,23 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int sr, wss, channels;
 	u32 width;
+	int lines;
 
 	channels = params_channels(params);
-	if (channels != 2) {
+	if ((channels > dai->driver->playback.channels_max) ||
+		(channels < dai->driver->playback.channels_min)) {
 		dev_err(dai->dev, "Unsupported number of channels: %d\n",
 			channels);
 		return -EINVAL;
 	}
 
+	lines = (channels + 1) / 2;
+
+	/* Enable the required output lines */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK,
+			   SUN4I_I2S_CTRL_SDO_EN(lines));
+
 	if (i2s->variant->has_chcfg) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
@@ -412,8 +421,19 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_txchanmap, 0x76543210);
 	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+	regmap_field_write(i2s->field_txchanmap, 0x10);
+	if (i2s->variant->has_chsel_tx_chen) {
+		if (channels > 2)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
+		if (channels > 4)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
+		if (channels > 6)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+	}
 
 	/* Configure the channels */
 	regmap_field_write(i2s->field_txchansel,
@@ -692,12 +712,6 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 			   SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
 
-	/* Enable the first output line */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(0));
-
-
 	return clk_prepare_enable(i2s->mod_clk);
 }
 
@@ -1073,6 +1087,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret, val;
@@ -1148,6 +1163,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			i2s->slot_width = val;
 	}
 
+	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "allwinner,playback-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			soc_dai->playback.channels_max = val;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
@@ -1157,7 +1185,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+					      soc_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
-- 
2.16.2

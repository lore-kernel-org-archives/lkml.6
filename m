Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeBZDOS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:14:18 -0500
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:37615 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeBZDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:14:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.260804|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.B5B-1F2_1519614839;
From: Yong Deng <yong.deng@magewell.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Yong Deng <yong.deng@magewell.com>
Subject: [PATCH] ASoC: sun4i-i2s: Fix offset tune for SUN8I
Date: Mon, 26 Feb 2018 11:12:18 +0800
Message-Id: <1519614738-10959-1-git-send-email-yong.deng@magewell.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SUN8I_I2S_TX_CHAN_OFFSET_MASK should be GENMASK(13, 12).
And offset tune of RX should also be updated.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a4aa931ebfae..797cafffaac8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,12 +110,15 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
 
 #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
+#define SUN8I_I2S_RX_CHAN_OFFSET_MASK		GENMASK(13, 12)
+#define SUN8I_I2S_RX_CHAN_OFFSET(offset)	(offset << 12)
+
 #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
 
 /**
@@ -460,6 +463,9 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_RX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_RX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
1.8.3.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeBLWE3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:04:29 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38428 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeBLWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:56 -0500
X-Google-Smtp-Source: AH8x225flWQfFXlcwrMW2dg+Fvi14ijw8al/m+9Ztv3zeawCuD9ZyyKnJTZhTMfOmFoFKhYS+GaSRQ==
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org, timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 14/17] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
Date: Mon, 12 Feb 2018 14:03:22 -0800
Message-Id: <1518473005-14090-15-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _fsl_ssi_set_dai_fmt() is a helper function being called from
fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
mainly for AC97 format initialization.

This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
* Removing *dev pointer in the parameters as it's included in the
  *ssi pointer of struct fsl_ssi.
* Using regmap_update_bits() instead of regmap_read() with masking
  the value manually.
* Moving baudclk check to the switch-case routine to skip the I2S
  master check. And moving SxCCR.DC settings after baudclk check.
* Adding format settings for SND_SOC_DAIFMT_AC97 like others.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 74 +++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dfb0da3..ed9102d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -860,42 +860,31 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int _fsl_ssi_set_dai_fmt(struct device *dev,
-				struct fsl_ssi *ssi, unsigned int fmt)
+static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 {
-	struct regmap *regs = ssi->regs;
-	u32 strcr = 0, stcr, srcr, scr, mask;
+	u32 strcr = 0, scr = 0, stcr, srcr, mask;
 
 	ssi->dai_fmt = fmt;
 
-	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
-		dev_err(dev, "missing baudclk for master mode\n");
-		return -EINVAL;
-	}
-
-	regmap_read(regs, REG_SSI_SCR, &scr);
-	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
 	scr |= SSI_SCR_SYNC_TX_FS;
 
-	mask = SSI_STCR_TXBIT0 | SSI_STCR_TFDIR | SSI_STCR_TXDIR |
-	       SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL | SSI_STCR_TEFS;
-	regmap_read(regs, REG_SSI_STCR, &stcr);
-	regmap_read(regs, REG_SSI_SRCR, &srcr);
-	stcr &= ~mask;
-	srcr &= ~mask;
+	/* Set to default shifting settings: LSB_ALIGNED */
+	strcr |= SSI_STCR_TXBIT0;
 
 	/* Use Network mode as default */
 	ssi->i2s_net = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		regmap_update_bits(regs, REG_SSI_STCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
-		regmap_update_bits(regs, REG_SSI_SRCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
+			if (IS_ERR(ssi->baudclk)) {
+				dev_err(ssi->dev,
+					"missing baudclk for master mode\n");
+				return -EINVAL;
+			}
+			/* fall through */
+		case SND_SOC_DAIFMT_CBM_CFS:
 			ssi->i2s_net |= SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
@@ -905,30 +894,34 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 			return -EINVAL;
 		}
 
+		regmap_update_bits(ssi->regs, REG_SSI_STCCR,
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+		regmap_update_bits(ssi->regs, REG_SSI_SRCCR,
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+
 		/* Data on rising edge of bclk, frame low, 1clk before data */
-		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP |
-			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP;
+		strcr |= SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
-			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP | SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_AC97:
 		/* Data on falling edge of bclk, frame high, 1clk before data */
-		ssi->i2s_net |= SSI_SCR_I2S_MODE_NORMAL;
+		strcr |= SSI_STCR_TEFS;
 		break;
 	default:
 		return -EINVAL;
 	}
+
 	scr |= ssi->i2s_net;
 
 	/* DAI clock inversion */
@@ -962,20 +955,17 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* Input bit or frame sync clocks */
-		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* Input bit clock but output frame sync clock */
-		strcr &= ~SSI_STCR_TXDIR;
 		strcr |= SSI_STCR_TFDIR;
-		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	stcr |= strcr;
-	srcr |= strcr;
+	stcr = strcr;
+	srcr = strcr;
 
 	/* Set SYN mode and clear RXDIR bit when using SYN or AC97 mode */
 	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
@@ -983,9 +973,15 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr |= SSI_SCR_SYN;
 	}
 
-	regmap_write(regs, REG_SSI_STCR, stcr);
-	regmap_write(regs, REG_SSI_SRCR, srcr);
-	regmap_write(regs, REG_SSI_SCR, scr);
+	mask = SSI_STCR_TFDIR | SSI_STCR_TXDIR | SSI_STCR_TSCKP |
+	       SSI_STCR_TFSL | SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
+
+	regmap_update_bits(ssi->regs, REG_SSI_STCR, mask, stcr);
+	regmap_update_bits(ssi->regs, REG_SSI_SRCR, mask, srcr);
+
+	mask = SSI_SCR_SYNC_TX_FS | SSI_SCR_I2S_MODE_MASK |
+	       SSI_SCR_SYS_CLK_EN | SSI_SCR_SYN;
+	regmap_update_bits(ssi->regs, REG_SSI_SCR, mask, scr);
 
 	return 0;
 }
@@ -1001,7 +997,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(dai->dev, ssi, fmt);
+	return _fsl_ssi_set_dai_fmt(ssi, fmt);
 }
 
 /**
@@ -1254,7 +1250,7 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 
 	/* AC97 should start earlier to communicate with CODECs */
 	if (fsl_ssi_is_ac97(ssi)) {
-		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		_fsl_ssi_set_dai_fmt(ssi, ssi->dai_fmt);
 		fsl_ssi_setup_ac97(ssi);
 	}
 
-- 
2.1.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbeBLWFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:05:13 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46420 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeBLWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:51 -0500
X-Google-Smtp-Source: AH8x2278Zeg73kKh/B9ogkT54fLb4MH7YfFb1mFxbApOaocu4k9AaDfODPXRNJA/cStRuOY8D+Jh1Q==
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org, timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 10/17] ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
Date: Mon, 12 Feb 2018 14:03:18 -0800
Message-Id: <1518473005-14090-11-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'd be safer to enable both FIFOs for TX or RX at the same time.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 156f5132..00dfdc7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -591,6 +591,11 @@ static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 	if (fsl_ssi_is_ac97(ssi))
 		vals[RX].scr = vals[TX].scr = 0;
 
+	if (ssi->use_dual_fifo) {
+		vals[RX].srcr |= SSI_SRCR_RFEN1;
+		vals[TX].stcr |= SSI_STCR_TFEN1;
+	}
+
 	if (ssi->use_dma) {
 		vals[RX].sier |= SSI_SIER_RDMAE;
 		vals[TX].sier |= SSI_SIER_TDMAE;
@@ -991,14 +996,9 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
 		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
 
-	if (ssi->use_dual_fifo) {
-		regmap_update_bits(regs, REG_SSI_SRCR,
-				   SSI_SRCR_RFEN1, SSI_SRCR_RFEN1);
-		regmap_update_bits(regs, REG_SSI_STCR,
-				   SSI_STCR_TFEN1, SSI_STCR_TFEN1);
+	if (ssi->use_dual_fifo)
 		regmap_update_bits(regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
-	}
 
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi);
-- 
2.1.4

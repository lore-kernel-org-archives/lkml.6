Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E6FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937725167
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A937725167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933836AbeGAQYe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:24:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbeGAQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:24:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3280AEF;
        Sun,  1 Jul 2018 16:24:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 013/101] ASoC: cirrus: i2s: Fix LRCLK configuration
Date:   Sun,  1 Jul 2018 18:20:59 +0200
Message-Id: <20180701160757.668291028@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

commit 2d534113be9a2aa532a1ae127a57e83558aed358 upstream.

The bit responsible for LRCLK polarity is i2s_tlrs (0), not i2s_trel (2)
(refer to "EP93xx User's Guide").

Previously card drivers which specified SND_SOC_DAIFMT_NB_IF actually got
SND_SOC_DAIFMT_NB_NF, an adaptation is necessary to retain the old
behavior.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/cirrus/edb93xx.c     |    2 +-
 sound/soc/cirrus/ep93xx-i2s.c  |    8 ++++----
 sound/soc/cirrus/snappercl15.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link edb93xx_d
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_name	= "spi0.0",
 	.codec_dai_name	= "cs4271-hifi",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &edb93xx_ops,
 };
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -213,24 +213,24 @@ static int ep93xx_i2s_set_dai_fmt(struct
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/* Negative bit clock, lrclk low on left word */
-		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL);
+		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS);
 		break;
 
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Negative bit clock, lrclk low on right word */
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Positive bit clock, lrclk low on left word */
 		clk_cfg |= EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Positive bit clock, lrclk low on right word */
-		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS;
 		break;
 	}
 
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -72,7 +72,7 @@ static struct snd_soc_dai_link snappercl
 	.codec_dai_name	= "tlv320aic23-hifi",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	= "ep93xx-i2s",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
 };



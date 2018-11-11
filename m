Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C12EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeKLGa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:30:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49388 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729849AbeKLFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000lM-GO; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001OM-6p; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Mark Brown" <broonie@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.778371948@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 029/366] ASoC: cirrus: i2s: Fix LRCLK configuration
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/cirrus/edb93xx.c     | 2 +-
 sound/soc/cirrus/ep93xx-i2s.c  | 8 ++++----
 sound/soc/cirrus/snappercl15.c | 2 +-
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


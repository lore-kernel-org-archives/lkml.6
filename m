Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F1C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DEC21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OylEizMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAYUaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:30:25 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39458 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548448221; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nU4nsC16XwU32AgrNaULkRhA19eZpel/HCT5A8SWe08=;
        b=OylEizMGiL5YRP90sN3JQebYz/Vmw8HxsMTwgTxTpinKVlaS1wJR+0b9YR/hcy+3hG/FPF
        k2U4GUQWSX07AGufgC71QM5ShYIUZDov1LNTVhLZmAqYgdAJg7tRYTS1akjEGfQGl8FWLS
        W2R5uyexFzmsPSOSdYlxreCdhqfDd/s=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] sound: soc: jz4740: Add support for multichannel audio on JZ4780
Date:   Fri, 25 Jan 2019 17:30:09 -0300
Message-Id: <20190125203009.24301-2-paul@crapouillou.net>
In-Reply-To: <20190125203009.24301-1-paul@crapouillou.net>
References: <20190125203009.24301-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4780 SoC offers the possibility to configure the number of
channels used for playback. Right now, the corresponding bits in the
configuration register are always zero, which means that the hardware is
only configured for monaural sound.

With this commit, the hardware is now correctly configured for the
number of channels requested by ALSA.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index e099c0505b76..05a9d7c20fb0 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -65,6 +65,7 @@
 #define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_MASK \
 			(0x1f <<  JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET)
 
+#define JZ_AIC_CTRL_CHANNELS_MASK (0x7 << 24)
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
@@ -81,6 +82,7 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
+#define JZ_AIC_CTRL_CHANNELS_OFFSET 24
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
@@ -287,6 +289,12 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
 
+		if (i2s->version >= JZ_I2S_JZ4780) {
+			ctrl &= ~JZ_AIC_CTRL_CHANNELS_MASK;
+			ctrl |= (params_channels(params) - 1) <<
+				JZ_AIC_CTRL_CHANNELS_OFFSET;
+		}
+
 		div_reg &= ~I2SDIV_DV_MASK;
 		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
 	} else {
-- 
2.11.0


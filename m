Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1936BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C8C24FA3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSxi6tZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C8C24FA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeGBVUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36133 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeGBVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:17 -0400
Received: by mail-it0-f67.google.com with SMTP id h19-v6so288835itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLEJflwbyrgEVsNYggmO2put4RpiCH6W7s/wUZagWVM=;
        b=LSxi6tZ8kTdoXjRRDFemln3HTfCo8YcVgPZM6143x5ktmDfbncC8J0qRPRFAXxQJz4
         WyKAsFjVIOsYUH/UK6LfI12r2M/wxVL2NyWSCeeg2vuJzmG29tUKousOBo/1TIM+WVLq
         dEKCEjzdECk0gBAs+nA1BxkWX7892g7VBevQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLEJflwbyrgEVsNYggmO2put4RpiCH6W7s/wUZagWVM=;
        b=Lz7onkwH4usP7gmwWUEiynEU3pftFfxL0NEvSkeHFyQMAAHELswhvZ1J76U5ct8M6a
         f97r4CZHv0ca8xszzjXVpLcTxrvQ3+43+PppaZIRH9Obz9BvOCEZdX4v5K8Ax04A4htK
         WEoWYywMg3vnlzADC/5neOXv4UeLrW1RKbSsScLS1xUDPFJd4EOkTU1HLSRtEfM6UVBv
         nBR3dI74C6CZp7z+oiIXQBUEMqsyZiPPS9O93TgFzC2NrzeRNREk74ic+97yogH+/6yw
         fBLMTTzUL6XMxMw4Cyku+mH/0loQPynGlbGpO2An82kPFFDY0nQqJ8Xpl/i9Nz/nAfVp
         N/rA==
X-Gm-Message-State: APt69E3LqqJp7JUmwsznyA9BLH5dhKjVEycSBoPrg4kRIRGqrOpHN1nr
        QLu7oC+3mqr3tRgyXqczQG/wXg==
X-Google-Smtp-Source: AAOMgpchR2/dMsrkodqf5X2wWgRCrgXssqFy+/kGr0Lo4Jf2MMJT26X3t5GwtWHrgH89lOnSNTu6Dg==
X-Received: by 2002:a02:8ac6:: with SMTP id i6-v6mr22209952jal.122.1530566417027;
        Mon, 02 Jul 2018 14:20:17 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:16 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/6] ASoC: AMD: Simplify trigger handler
Date:   Mon,  2 Jul 2018 15:19:55 -0600
Message-Id: <20180702211956.149355-6-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the I2S channel names are fixed, and DMA data flow order is
consistent (ch1 then ch2), we can simplify channel start order:
start the upstream channel and then the downstream channel for both
playback and capture cases.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ab60129f4f266..65c1033bd51cc 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1024,10 +1024,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		rtd->bytescount = acp_get_byte_count(rtd);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-		} else {
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 			if (rtd->capture_channel == CAP_CHANNEL0) {
 				acp_dma_cap_channel_disable(rtd->acp_mmio,
 							    CAP_CHANNEL1);
@@ -1040,9 +1037,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				acp_dma_cap_channel_enable(rtd->acp_mmio,
 							   CAP_CHANNEL1);
 			}
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch1);
+		acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.18.0.399.gad0ab374a1-goog


Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C6BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687A20873
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+7yRg4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeGBVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38266 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:02 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so3710516iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IWWtBjDKuFz5K+q4kYQrEThAzIr/apsuB4OV6JwZFqU=;
        b=N+7yRg4hMB8Vbj3gpblCrMXCqUNR/5MJ3G0b2Vd6vUMyiONBdrFdP0QRg6TpLp4+C5
         LFYNJlDYFFWv5qc5LJDq3O1HKdpOus9usHKi8EHeVwsIj3JMktUVxxrvt0AR4kneuWu7
         QgzKorhx1/xRqx0l/RRbE4aoHnWzdzGIHQyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWWtBjDKuFz5K+q4kYQrEThAzIr/apsuB4OV6JwZFqU=;
        b=kTN1CgiAZqwBQ2ug32ehNWOgMzcSX6CY/oh3XYtBczmEroBplSpVZBkK1vHbiadjNY
         PPpmKxOOrSQKUIzZodxvmQaX0fki6QoH/JfPLhGvDGMOebT4Qtf9wCvgVJPplCIeWkC+
         85UUC0PJUD3faG3x9jO0YViKUuS/5qV7iyRjVzgHleYNV7CTTXA066mIPJdNgKJQ76sV
         ybJFK7uyWipDNyQYLBTUXxAWh0SxvLRpgyAeshOg/8tV0Qfn2Pdh+7v+A7VBlV9V0UEw
         BqgRyRccH1Fdw1UJ0c2/cMgjAs7zVVrDhEnk6CO/f0XR31iHeVFEsBd36mWE0ZQyb3cS
         0fJQ==
X-Gm-Message-State: APt69E0++wHSKpBCdQvn78Bz0uLKnNt0qOFqr+DLrXifB+3ARb/8JiN3
        B9SvLIi8R3+aJl4MucmKEK/d9w==
X-Google-Smtp-Source: AAOMgpeEfBoFZes3Oi1hioEwV4qAbrFP+eoO2x7b1bK/dwgNs/Xg7KwXnszDa/XFRtD8Dhrm2hWBPg==
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr23374431iob.60.1530566401960;
        Mon, 02 Jul 2018 14:20:01 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:01 -0700 (PDT)
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
Subject: [PATCH 1/6] ASoC: AMD: Always stop ch2 first
Date:   Mon,  2 Jul 2018 15:19:50 -0600
Message-Id: <20180702211956.149355-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6b116dfb4633a ("ASoC: AMD: make channel 1 dma as circular") made
both channels circular, so this comment and logic no longer applies.  Always
stop ch2 (the channel closest to the output) before ch1.  This ensures
that the downstream circular DMA channel does not continue to play/capture
repeated samples after the upstream circular DMA channel has already
stopped.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3c3d398d0d0b1..4665ae12e74e4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1067,21 +1067,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* For playback, non circular dma should be stopped first
-		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
-		 * stopped before stopping cirular dma which is acp sram to i2s
-		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
-		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
-		 * first before stopping acp sram to sysram which is circular
-		 * dma(rtd->ch1).
-		 */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-		} else {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		}
+		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		rtd->bytescount = 0;
 		break;
 	default:
-- 
2.18.0.399.gad0ab374a1-goog


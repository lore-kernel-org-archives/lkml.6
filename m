Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C253124FBA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I35IGKIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C253124FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbeGBVUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37738 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:05 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so280178itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PeMF3h1zt/7gvJf2rnjuYTUHx/E4hf5cyZB1BDHpYr0=;
        b=I35IGKIvRHk4wOwC3CrfzWWHQ+PFxwyYxyfyIZwugDljNLWF/xUGuwANhjoRLXlLyd
         qsF9/JouQt0pPSD1jxg90ZYvSU+ZzOgXSk+6dfsbZn8nVZGRtS7YKRrVgeUBCcPcdn+Z
         HuPDGoIoBodEfL0C7wz7rxB3VDKYdsPYwZQ9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PeMF3h1zt/7gvJf2rnjuYTUHx/E4hf5cyZB1BDHpYr0=;
        b=X5c2ri+p6TwcujXVXeGbdkFe4BlsSuXZzrw9lsIaI+gMZ9S+yG9jkkK/UuNaQ3AfS+
         9Q0nUudD3ldEU21EyxNOwfs7fKXwcmkqIzdVQrhHPiZzeW6/5yZTiHCnrtWIAaCpA43j
         xyfUPnAkikmRVwrneQKLeiab5CbLEEvnhgdTPl/AuowwheKmBIEAoiE/labuuH12imCq
         WmQs7uErhD3WEd5NQFuUaHJBOcTqgxQEVP6U10gZw/TOLLDIeHrN3AoQw53aWND04NL1
         9eWAPf27Gv4YxW8eG/CsmyT4ZpnFVdb2fVn4u2xZR/Po6tK6lZaVKkBseEZPIuPo31EU
         D5fw==
X-Gm-Message-State: APt69E18O9pWumZCPRi54yO0gvS1h9cIU6uz1XbskpnaXrdUQKma0J3S
        5PtxzIxeZ6opgQVJfPx4Hk/JCA==
X-Google-Smtp-Source: AAOMgpfd+6pqMpipBtTPgptGRY9MFuRuwC4RiQ0hThH8EeLlgi3aUEzmqsYXwpnJ8nuLZTr5tOs/eA==
X-Received: by 2002:a24:6788:: with SMTP id u130-v6mr7164117itc.47.1530566404636;
        Mon, 02 Jul 2018 14:20:04 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:04 -0700 (PDT)
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
Subject: [PATCH 2/6] ASoC: AMD: Reset bytescount when starting transaction
Date:   Mon,  2 Jul 2018 15:19:51 -0600
Message-Id: <20180702211956.149355-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer() callback gets its value by reading the I2S BYTE_COUNT
register.  This is a 64-bit runnning transaction counter. If a
transaction was aborted in the middle of a sample buffer, the counter will
stop counting on a number divisible by the buffer size.  Since we actually
use it as a pointer into an aligned buffer, however, we do want to ensure
that it always starts at a number divisible by the buffer size when
starting a transaction, hence we reset it whenever starting a transaction.

To accomplish this, it wasn't necessary to zero bytescount at the
termination of each transaction, so remove this unnecessary code.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 4665ae12e74e4..e6f85f2e5ac2a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1029,7 +1029,6 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1040,9 +1039,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
+		rtd->bytescount = acp_get_byte_count(rtd);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
@@ -1069,7 +1066,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.18.0.399.gad0ab374a1-goog


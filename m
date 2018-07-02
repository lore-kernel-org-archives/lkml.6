Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE8124222
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ocLWewXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE8124222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeGBVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46379 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGBVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:08 -0400
Received: by mail-io0-f195.google.com with SMTP id p7-v6so3568960ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dX9pP/dh5n477QsEVY5f6zeNdJXdS406ea9F9OtRySo=;
        b=ocLWewXH1FUa0J+jePdoJA8yu0+MG3C6DIwhwj8byaUcjsOiLvHUJOiU/CjJXJc/1r
         +AI4cNtmpBYCmPKNVE/OqugGfZLpmT97H1bV7QbW5vxNON5NGdT2fmXHAugO4wlp+Wyu
         gscxm/YOfiAwt9exfePToXjWtxdnnR82QnUF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dX9pP/dh5n477QsEVY5f6zeNdJXdS406ea9F9OtRySo=;
        b=d1QiToE8Eie6iF39DTqtGBJC+fhThfnAdO2l58O+uyUKyeLqZ0kKsh9oVsjhu8NCLh
         O6kfKr4qGSLLBwueWJG3WZgalpcorROJfOoGiYauVCRwEkwsfPHPK1hlr02BAthQbNWy
         29YR0awlUgnp+ypAr+KTW36x5EVXS+jdq+ztwnl/dj1qeaOpKrQrlEgmiB7TDLQ9C9nA
         hnYaN7jZ+03Yv9MIRa+ENS7O/8a91qY6fjVhVDMZgJ59rlPYKP8ym7MPqcBoWFfmIp1r
         r73q22IH2b4vwkunqGzt8xSLmnsFEa0AZFPJiXSFYafXaoRX7feyMhzBnnHi9Rbkea4i
         /wqw==
X-Gm-Message-State: APt69E2yxcQ9wxmMqN8QFOyteYxhTL3omFpzpOynj7W7c3Gi5P+TydJD
        kOmGc9RP7LPviZ06t0GE6cuRng==
X-Google-Smtp-Source: AAOMgpdwqnNtLpHUfUHBQGNc55kHh6kr0NaR0VxQHNzfX+LfyR5eXgDDaYGVXW8znqhdIj/m6i3s4g==
X-Received: by 2002:a6b:28c6:: with SMTP id o189-v6mr22006296ioo.149.1530566407366;
        Mon, 02 Jul 2018 14:20:07 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:06 -0700 (PDT)
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
Subject: [PATCH 3/6] ASoC: AMD: Always subtract bytescount
Date:   Mon,  2 Jul 2018 15:19:52 -0600
Message-Id: <20180702211956.149355-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is always correct to subtract out the starting bytescount value.  Even
in the case of 2^64 byte rollover (292 Million Years in the future
@ 48000 Hz) the math still works out.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e6f85f2e5ac2a..224383fef0c3a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -995,8 +995,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
+	bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
-- 
2.18.0.399.gad0ab374a1-goog


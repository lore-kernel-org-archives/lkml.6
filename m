Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDBAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F7420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4DEGG3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F7420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeK1UBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:01:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35528 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1UBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:01:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so9211859pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgtufxcsUbbhvbpoGvQbrCYqqvfC+nhS1gPzSq1nZsg=;
        b=R4DEGG3WzGXLxE/Xr3i1Bk9w7aN4nUT5Yx4BHnfpp+Tr09GeZMVqcUrlK4INlQDWAL
         Tr93wBMuIYPYXQUzNahuS2AUMKhiY3gf5mio86V4aP4BQlK/hZPMxpyjQ3XQxCupBnfa
         Eg1+Sj4egf5N3e/GL7iehXVY5hgSUhsbLDBl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgtufxcsUbbhvbpoGvQbrCYqqvfC+nhS1gPzSq1nZsg=;
        b=KqfcGUgXdcX7QcbPsJXXL9lJk0evgVANikpySHzdIoSUYxDprhysbSdNmexhZAqjnd
         o9GVj18nEnLfbmLBTqJxhnU6EhSYONWlqloM/CqIrmSVUdB06ukG4EYLlJbmTvqryhhj
         0O4p8e8HYv/nuLmqkLe1rxtwtuKA6LtpinTZ499OPfPMnIJDRt2oiLTKlaGSRrBJFKwX
         Gfr8wOyVSjlNRdEiK+3jxNYOy3v7O7oHEGE58HJPArBakBWRt/6o2xDGBhPVcchC6zqy
         BW6mLshpFbak+ylPnSzOdjIc4cPC4USKuSc8D6tGv9MZ8OLqn4yM9ppHTlKaWvMGp53E
         N26Q==
X-Gm-Message-State: AA+aEWbTgmuoAcXbtr3OC2p9du+rJ6ZRQxU6C1gY8xD/IBM5rthcoYn5
        wWVWXyCoKQkCKUEobTT8Tw1y3EsvpBU=
X-Google-Smtp-Source: AFSGD/URYEiUsNt6OrAueQ5JPY4lPwDluFC7i/TPvfJ1ZOmUojls5Pfb5WKWRf1g7UyoVjd1epy0ew==
X-Received: by 2002:a62:c3:: with SMTP id 186mr19911725pfa.24.1543395658927;
        Wed, 28 Nov 2018 01:00:58 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id i72sm11568607pfe.181.2018.11.28.01.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:00:58 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 3/5] ASoC: sdm845: Add TDM configuration for speaker
Date:   Wed, 28 Nov 2018 17:00:35 +0800
Message-Id: <20181128090037.257359-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set TDM time slots and DAI format for speaker codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 43c03f8e8cdc2..d0df7ec6042e2 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -6,9 +6,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
+#include <sound/soc.h>
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
@@ -17,6 +19,10 @@
 #define DEFAULT_MCLK_RATE		24576000
 #define TDM_BCLK_RATE		6144000
 #define MI2S_BCLK_RATE		1536000
+#define LEFT_SPK_TDM_TX_MASK    0x30
+#define RIGHT_SPK_TDM_TX_MASK   0xC0
+#define SPK_TDM_RX_MASK         0x03
+#define NUM_TDM_SLOTS           8
 
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
@@ -34,7 +40,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
+	int ret = 0, j;
 	int channels, slot_width;
 
 	switch (params_format(params)) {
@@ -81,6 +87,35 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 			goto end;
 		}
 	}
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, LEFT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, RIGHT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV1 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+
 end:
 	return ret;
 }
@@ -155,10 +190,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int j;
+	int ret;
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
@@ -190,6 +229,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
 				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
+
+		codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			codec_dai = rtd->codec_dais[j];
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Left")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Left TDM fmt err:%d\n", ret);
+					return ret;
+				}
+			}
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Right")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Right TDM slot err:%d\n", ret);
+					return ret;
+				}
+			}
+		}
 		break;
 
 	default:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog


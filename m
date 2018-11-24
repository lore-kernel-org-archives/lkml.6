Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABA1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70FE2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXDR/av+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70FE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeKXV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:58:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42195 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKXV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:58:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so11677642pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 03:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+oHEdKMDpuxzwVk64tZIxSsbb8yNe8+IDFvuSSfRD8=;
        b=nXDR/av+SQiZ1+gwoqkq/RVZ93mhWZVEBbciOefSoUVJlhXlFFLmiYXoCUIb4pDgjA
         CXYyFeJPY3O0r98qup97ze7vH151qM7HkFGgM8t4a3zjfd/bkw1jsrPhIsd9fWrS75KO
         iU1z/v/n0oyHDJ1C6Vf/honptjR41TsFmqafA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+oHEdKMDpuxzwVk64tZIxSsbb8yNe8+IDFvuSSfRD8=;
        b=Qz48anbe4bq+m6G66hSVDRGM7IMGFARGSoPQIAUDk1UN5bjPapMEYG9vfY2OA6o7ba
         bBJsst+z+L2j4z7hO2SrbfUW+9uSnO/ONuctINRecZ9PnG6H1CGR5tHgawEUCPM6q9Kq
         KIaoKsxgdALlccWLGREt0cHkBSr5oofN6HzvTXXTYtlmXB+ggwt+6TF6COyyE9ymxeIC
         InwVogTUyapQ6ltRYl6AJXTs+gYlBr/LERLWTNQ3LmEELPl5H6se9WVMm56+jn5MBq4z
         nWFGa4tLOFRPiw8ryfXwadFa356KG1r9ClWLmxHzaGxpO5W02ZvLQ3TWKDetjrk/jCXS
         aV0g==
X-Gm-Message-State: AA+aEWa4ZcvlUNEgO3lFsg4SFRB8jVzx6Lrzei5UEJ3MO0OROH9g+PrI
        59vuglYwf3jd0oZiCIjamuKOZjf8GZY=
X-Google-Smtp-Source: AFSGD/VJ5pA0iSjWZrU0R2pZoLZanG+4lruFeYAQ4o8JLhBrSmx5SoJt4wfWok41GEfNdVxXKjUq9A==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr19191099plq.95.1543057821327;
        Sat, 24 Nov 2018 03:10:21 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id v124-v6sm25098580pfb.182.2018.11.24.03.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 03:10:20 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 3/4] ASoC: qcom: sdm845: Add codec related configuration for sdm845
Date:   Sat, 24 Nov 2018 19:09:47 +0800
Message-Id: <20181124110948.209019-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181124110948.209019-1-cychiang@chromium.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set TDM time slots and DAI format for speaker codec.
Set DAI format and clock for headset.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 82 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 43c03f8e8cdc2..d815040e98dc9 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -6,12 +6,15 @@
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
+#include "../codecs/rt5663.h"
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
@@ -34,7 +37,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
+	int ret = 0, j;
 	int channels, slot_width;
 
 	switch (params_format(params)) {
@@ -81,6 +84,31 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 			goto end;
 		}
 	}
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, 0x30, 0x3, 8, slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, 0xC0, 0x3, 8, slot_width);
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
@@ -90,9 +118,26 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		/*
+		 * Use ASRC for internal clocks, as PLL rate isn't multiple
+		 * of BCLK.
+		 */
+		rt5663_sel_asrc_clk_src(
+			codec_dai->component,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+				RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"snd_soc_dai_set_sysclk err = %d\n", ret);
+		break;
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		ret = sdm845_tdm_snd_hw_params(substream, params);
@@ -155,14 +200,20 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	int j;
+	int ret;
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
 	case PRIMARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
 		if (++(data->pri_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_MCLK_1,
@@ -172,6 +223,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case SECONDARY_MI2S_TX:
@@ -190,6 +242,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
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


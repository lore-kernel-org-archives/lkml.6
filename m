Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6269FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F5C20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ghGMyByn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F5C20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeK1UB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:01:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38771 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1UB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:01:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so9220106pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obgcqLBzBg5HoHtorS/BUD2AZfJqzHsvR5ZV3gqGHws=;
        b=ghGMyBynlKFud8ocDfv99UI3c5MTXcF2I9SOwXZYkF7H54p4bY/t47igImDn1X37G/
         uusi9ciVrliX9he9q8WzR+JkpENNclyaMN+eKGI41yqxdYBJ3ffi+ssGOJetmHSSboaO
         Fjwqs7rhh94o2Wn+4trZUkq7HTDlwYkmrvLA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obgcqLBzBg5HoHtorS/BUD2AZfJqzHsvR5ZV3gqGHws=;
        b=s+G1hDWjx/rc/BEePv9jE3fIZ3sSftAYF6l6fmr1NXWU0TSn8ypHUp+sypx2uoAzqZ
         7tX4ctHUusQoXOcQ+L9d5ve07WbNmvtUfZjTjcBSC0Ugatv9aGZDSj7+nr8SM9DUvVh3
         4pt6pXcf2kmyvmP504pz88S0+Rqn9RSX8+beQmURWcKH1gOu3Cz+ws5VQDl9q0nld9Nk
         YXnCS/QbRLgw1pT4uSUze4cyAOa1LcZpV5OtyuC7pUfpMNdFYbV0rHFu+JPgv7rQJkxa
         vfuWHSwRmVhCamhX43+FT18jP/rz8ypZ2rvUdP/A7unX4dmaM7k52nenDzDlVxrVKYaF
         MvAA==
X-Gm-Message-State: AA+aEWbpX4iXYB0vrRaZtBOT3CFQuWJAgLddRp0KDq970sczBQpklh6S
        H4BAnZ/MYC0oF1zUSuwGNmjGGJwKsbs=
X-Google-Smtp-Source: AFSGD/VFOViiiurkCTAn3Dac8oDCy0FXKdT95jI0RD+wPdsm3WK/oRiCCfZAr+1/U4utuH/VaJwJcw==
X-Received: by 2002:a62:c42:: with SMTP id u63mr4826704pfi.73.1543395662430;
        Wed, 28 Nov 2018 01:01:02 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id i72sm11568607pfe.181.2018.11.28.01.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:01:01 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 4/5] ASoC: sdm845: Add configuration for headset codec
Date:   Wed, 28 Nov 2018 17:00:36 +0800
Message-Id: <20181128090037.257359-4-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set DAI format and sysclk for headset codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index d0df7ec6042e2..1db8ef6682233 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
+#include "../codecs/rt5663.h"
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
@@ -125,9 +126,27 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
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
+		ret = snd_soc_dai_set_sysclk(
+			codec_dai, RT5663_SCLK_S_MCLK, DEFAULT_MCLK_RATE,
+			SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"snd_soc_dai_set_sysclk err = %d\n", ret);
+		break;
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		ret = sdm845_tdm_snd_hw_params(substream, params);
@@ -202,6 +221,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
 	case PRIMARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
 		if (++(data->pri_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_MCLK_1,
@@ -211,6 +231,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case SECONDARY_MI2S_TX:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog


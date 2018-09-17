Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BCFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9CB2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2pYCTr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9CB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeIQGXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:23:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52590 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbeIQGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:23:13 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so9079286ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IA3NssNVI2Q9RVwkXpQaJ3ttyxnrxpJbsIkQeijt2Ss=;
        b=Z2pYCTr+Y/yxuuilUK/mg+MDzsVEnq5rsFz/kAZsIDZykVc179SM+xFUeVkKEiT+jv
         0cmtGq80u9EFhJ8dX2/8nZGY0CQF6ZSmB6aBu/TdNWCZESwWL+I62W6m+2Y/CGeY+3UI
         eAcmXhDbaJ83TY+QuLMHYze8svWIB5+BXRI2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IA3NssNVI2Q9RVwkXpQaJ3ttyxnrxpJbsIkQeijt2Ss=;
        b=q87fw/UsCbQTUHarcEhm2tMM0nslSVRINHdmMRN7OFeXwk26CLuSVeUBOL97Ip5hLu
         hq4z+OdrZTxaGzkpkZ3pDay1jjRhhJj93pv9I/vq72s4+HSyZ6AoS7cqUwCyT04WTiYS
         nbXfS58e+Jc6CCs5ePEzYUD+5fs5LvDfpl8BFCZaFtnNgiMz/svnOCoAnTQMWryyMl8k
         blwYBRz5dYvPD/eOVnqynHpOtXW3awXmJZ4jYADkyUWjro2LS88nwParF2BCwB+rvsj8
         M3fvcPVlE9WeD+vaHBCV4x5oxKr6wiZuI6XgzS7nIvTm855loADmya1SQ5GgKzlMx1Y3
         StYw==
X-Gm-Message-State: APzg51BixiKcoHsRZEzWJ/tVFUY9bjbHlv6YwbcaX2c37PC8vthobSrq
        LyQPHR76OKPmfK7Sjqs06mscoQ==
X-Google-Smtp-Source: ANB0VdbfsDXVl7Owl/BfMbkrOrg58YWGLqF1DDptBLvFuebojrkXqmldp1COty2dWmBSXXuFeN/v5Q==
X-Received: by 2002:a02:9a10:: with SMTP id b16-v6mr20810874jal.4.1537145900260;
        Sun, 16 Sep 2018 17:58:20 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:58:19 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 14/14] ASoC: qcom: common: move be_hw_fixup to common
Date:   Sun, 16 Sep 2018 17:57:27 -0700
Message-Id: <20180917005727.32728-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

be_hw_fixup for qdsp is common across mutiple qcom machine drivers,
so move it to common file and remove the redundant code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 15 ---------------
 sound/soc/qcom/common.c  | 17 +++++++++++++++++
 sound/soc/qcom/sdm845.c  | 22 ++--------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index daad43f..9cb26aee 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -20,20 +20,6 @@ struct apq8096_card_data {
 	bool jack_setup;
 };
 
-static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				      struct snd_pcm_hw_params *params)
-{
-	struct snd_interval *rate = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-
-	rate->min = rate->max = 48000;
-	channels->min = channels->max = 2;
-
-	return 0;
-}
-
 static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -139,7 +125,6 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 
 	for (i = 0; i < num_links; i++) {
 		if (link->no_pcm == 1) {
-			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
 			link->init = apq8096_init;
 			link->ops = &apq8096_ops;
 		}
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index eb1b9da..ce8e759 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -3,8 +3,24 @@
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
 #include <linux/module.h>
+#include <sound/pcm_params.h>
 #include "common.h"
 
+static int qcom_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
+
+	return 0;
+}
+
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
 	struct device_node *np;
@@ -79,6 +95,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			}
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = qcom_snd_be_hw_params_fixup;
 		} else {
 			link->platform_of_node = link->cpu_of_node;
 			link->codec_dai_name = "snd-soc-dummy-dai";
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 2a781d8..87e150c 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -11,7 +11,6 @@
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
-#define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
 #define DEFAULT_BCLK_RATE		12288000
 
@@ -177,32 +176,15 @@ static struct snd_soc_ops sdm845_be_ops = {
 	.shutdown = sdm845_snd_shutdown,
 };
 
-static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_interval *rate = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-
-	rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
-	channels->min = channels->max = 2;
-	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
-
-	return 0;
-}
-
 static void sdm845_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link = card->dai_link;
 	int i, num_links = card->num_links;
 
 	for (i = 0; i < num_links; i++) {
-		if (link->no_pcm == 1) {
+		if (link->no_pcm == 1)
 			link->ops = &sdm845_be_ops;
-			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
-		}
+
 		link++;
 	}
 }
-- 
2.9.3


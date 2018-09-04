Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73BC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ABA206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cN0YocF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ABA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIDOwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36614 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeIDOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so3761359wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDTb19RTWifFuLfVBk7DXBD9s0ll9MuJJWXgCHepOhA=;
        b=cN0YocF1mczPl6T85Z2jLVC4dfnPo63mU0ibDJE5hgsO97J42fCAolUQ/6dDWN50Ch
         h4hwPZFyi3+V+s62YfbVOkwnRGlVmhWn+dq5NP68XYv4L7k3Iisj85yxzo/B3p3Selj+
         HJo5dhmS7ff+DEJhM6H7zaaM5KsbtCKKyoCPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDTb19RTWifFuLfVBk7DXBD9s0ll9MuJJWXgCHepOhA=;
        b=ozEK1np5swCbyCLNc0jXn8Ss4ASyg6KJdl4Kd1aqUQ6tDwDEESQlZGE9hjKcW4H7P1
         9TJMjmSyLNSlMtqgF4+F98uwS8Sg6LD7JyvrUVzmFE/PgSzk1kWc6dPAdWrAKyuSepaG
         f1ONNgDV41qVOTTKDQGP9VAJiUzkYuYmq+S5tEpshpgyc2hTZL0KUJaJeXf+LlzyJ/L1
         q2NyfEYxIo2aXbSzx/Ag9cdk+E299XHHNydGay0fEZ7+kIybwRIlU9QDFnaTlCGtjmam
         +jCZXR3yNalqTZ/jOoEOUt+OLwqzRcM++RmD48HQLoYyV5FchgGYNQmJl5ucVCpHb7Rk
         Q4zw==
X-Gm-Message-State: APzg51DKRC9fvrI6iEeLq7uuwGklIr3b44VouqW19kgYPw/iGYZgoQl5
        FsVHuWG8ZA9407o4J8jVeKpBsg==
X-Google-Smtp-Source: ANB0VdbHER0gHLXRvnVqz/tuEFPWE8g9KcZ7ECVeVAFndTzOur4kaKUeGZy6cTitgqJCUR8OGFzQ8w==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr2081581wmh.22.1536056867016;
        Tue, 04 Sep 2018 03:27:47 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 13/13] ASoC: apq8096: add headset JACK support
Date:   Tue,  4 Sep 2018 11:25:00 +0100
Message-Id: <20180904102500.30318-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index db07e9b62daf..78b245261477 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -5,14 +5,21 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <uapi/linux/input-event-codes.h>
 #include "common.h"
 
 #define SLIM_MAX_TX_PORTS 16
 #define SLIM_MAX_RX_PORTS 16
 #define WCD9335_DEFAULT_MCLK_RATE	9600000
 
+struct apq8096_card_data {
+	struct snd_soc_jack jack;
+	bool jack_setup;
+};
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -65,6 +72,7 @@ static struct snd_soc_ops apq8096_ops = {
 static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct apq8096_card_data *data = snd_soc_card_get_drvdata(rtd->card);
 
 	/*
 	 * Codec SLIMBUS configuration
@@ -77,6 +85,8 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
 					    134, 135, 136, 137, 138, 139,
 					    140, 141, 142, 143};
+	struct snd_soc_card *card = rtd->card;
+	int rval;
 
 	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
 					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
@@ -84,6 +94,38 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dai_set_sysclk(codec_dai, 0, WCD9335_DEFAULT_MCLK_RATE,
 				SNDRV_PCM_STREAM_PLAYBACK);
 
+	if (!data->jack_setup) {
+		struct snd_jack *jack;
+
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+					     SND_JACK_HEADSET |
+					     SND_JACK_HEADPHONE |
+					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+					     SND_JACK_BTN_4,
+					     &data->jack, NULL, 0);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		jack = data->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+		data->jack_setup = true;
+	}
+
+	rval = snd_soc_component_set_jack(codec_dai->component,
+					 &data->jack, NULL);
+	if (rval != 0 && rval != -ENOTSUPP) {
+		dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+		return rval;
+	}
+
 	return 0;
 }
 
@@ -104,6 +146,7 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 
 static int apq8096_platform_probe(struct platform_device *pdev)
 {
+	struct apq8096_card_data *data;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -112,8 +155,15 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		kfree(card);
+		return -ENOMEM;
+	}
+
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
@@ -131,16 +181,19 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	kfree(card->dai_link);
 err:
 	kfree(card);
+	kfree(data);
 	return ret;
 }
 
 static int apq8096_platform_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
+	struct apq8096_card_data *data = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(card);
+	kfree(data);
 
 	return 0;
 }
-- 
2.18.0


Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0AECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C46214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvmAE2K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C46214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIQGXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:23:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52587 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbeIQGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:23:12 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so9079248ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJH11aBb5GlguuXS0xBxC+fzG4Kc/S3a2ZBQ9aPxUZQ=;
        b=KvmAE2K1QPiVuM0vacAsHLFyQN0Yg3RlgWSBKLvPjztxElR5VxAbIyg96z2S6a9zNM
         QsOsvLhGc9v0dguuCHLkUiiT6RbniOu0NPl56r94CnhrzwD92zDdqNKLUJFUUABcvNac
         rYe5EpXv69pnU5yMECXbjyoLaKlc/Uniq8j4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJH11aBb5GlguuXS0xBxC+fzG4Kc/S3a2ZBQ9aPxUZQ=;
        b=Dn1sabPXUa6rykGO3RscbuR6556Xc7JgkujftQcIVzMpfoa68ogIhDm9TkGvscNZIo
         0XSkBI6G+oJqvq4l/DfmMdOmI9OFe7dyaXr8N6u7hUMuiai2kA/aNPOPFBmcf2Bo3WTb
         vsmKbXAxoi1V/FulKLfyH0PJXvpcq2op/vLn1grP6GnFIIRJwVFqYw0C9upnFwomJeWl
         vGISFaIvIdP2NsF/yMbKBY6wVmpnWlVU9sE9zmBzbWr+w3cStxB/k4tJZJnSnwbnCmdl
         DulSVbVnCeqzVh3aU4L4SiS6G3gRBNfGDwLJtinbo6HjveJ5FuOwtZryLKS4MpMcKGXO
         BNmQ==
X-Gm-Message-State: APzg51BXPQu+84AIC17tYBW3jD5YT6ee2rXdiDza40PN93bTpYlLD8Mv
        vt56NE3tMkgxt3z+XjOtCkuleA==
X-Google-Smtp-Source: ANB0VdY3Ug7+qHV9HRxeHemw1MsUahz7XN0r0zw1Kzw6eD8ZEEn3EEmKwZsj+pxfo4GkJNUcsX78Ww==
X-Received: by 2002:a24:1d52:: with SMTP id 79-v6mr10305796itj.142.1537145898993;
        Sun, 16 Sep 2018 17:58:18 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:58:18 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 13/14] ASoC: apq8096: add headset JACK support
Date:   Sun, 16 Sep 2018 17:57:26 -0700
Message-Id: <20180917005727.32728-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 66a28c2..daad43f 100644
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
@@ -68,6 +75,7 @@ static struct snd_soc_ops apq8096_ops = {
 static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct apq8096_card_data *data = snd_soc_card_get_drvdata(rtd->card);
 
 	/*
 	 * Codec SLIMBUS configuration
@@ -80,6 +88,8 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
 					    134, 135, 136, 137, 138, 139,
 					    140, 141, 142, 143};
+	struct snd_soc_card *card = rtd->card;
+	int rval;
 
 	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
 					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
@@ -87,6 +97,38 @@ static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
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
 
@@ -107,6 +149,7 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 
 static int apq8096_platform_probe(struct platform_device *pdev)
 {
+	struct apq8096_card_data *data;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -115,8 +158,15 @@ static int apq8096_platform_probe(struct platform_device *pdev)
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
@@ -134,16 +184,19 @@ static int apq8096_platform_probe(struct platform_device *pdev)
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
2.9.3


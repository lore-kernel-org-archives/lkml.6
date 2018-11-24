Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12702086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TunuNmpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12702086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKXV6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:58:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46662 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKXV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:58:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so11672018ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/yiL8MSzU0TPG6wYpvLbVxtNR5gac1eR3sg1WCS69w=;
        b=TunuNmpQxBki+ZFLPPWVDAYUffRWneeZP7KQnxXnCxQZRy7c8CdHwDTG8S33iJNMGa
         3XNpRdcZ6EpfPkhN58ZGobr4qHWC9evH3xYI3MYg56qiuqK4yqJFZId31G5yNYqjJoXj
         sZC6QkwzdWBmytZBL8esBucfuMhC+h8XiTXkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/yiL8MSzU0TPG6wYpvLbVxtNR5gac1eR3sg1WCS69w=;
        b=btTLk6fRH4SBw2MFUfC2HXQncnl1jDEQR58oQV8bTQP42auDSGiYdgszbP6A72JtAX
         dEH9wZJCRw921UsjTsF9SPTtC+HhLIeMGXADgGe0zoCsutbRk85CFJIC9aOsdhhfyIf7
         XUUtXYAWJhb1YmmAHEAVApvinqMPy4p1iQv+eLRgj2iWgR09zerO4xcaR87Q37nTz7+e
         JyAqMp107ATcCvugmXDs273XicDLq185GxKDsxM/gioUxfvdzH9PfyqFiOd2IOp+cJUj
         AG7icoYc51EVUsCBfv4m1GM+NqyvlK7ssv8mb9QkCWuKh/s9jlbUMUledpGortJuMpWR
         dwIQ==
X-Gm-Message-State: AA+aEWZgHSdlmtu1Hq8VPjcByzZf/B4nKtGZ2HqnBvC5WCNfyJPeh675
        ej67v1b5jfqibCNqXBpXvlrE3G49Ai4=
X-Google-Smtp-Source: AFSGD/WDhQtoCFmc1vAJmHWZvcxL7q29764rWg9RvpQj4zBA3uTrG5HW+BFsGhLiQheZiGVITZsveg==
X-Received: by 2002:a17:902:9f89:: with SMTP id g9mr19642103plq.214.1543057812209;
        Sat, 24 Nov 2018 03:10:12 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id v124-v6sm25098580pfb.182.2018.11.24.03.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 03:10:11 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/4] ASoC: qcom: sdm845: Create and setup jack in init callback
Date:   Sat, 24 Nov 2018 19:09:46 +0800
Message-Id: <20181124110948.209019-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181124110948.209019-1-cychiang@chromium.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a callback for init ops on dai_link to create and setup jack.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 57 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 95d8d4422dae0..43c03f8e8cdc2 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -8,6 +8,8 @@
 #include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
+#include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
@@ -17,6 +19,8 @@
 #define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
+	struct snd_soc_jack jack;
+	bool jack_setup;
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
 	uint32_t sec_mi2s_clk_count;
@@ -100,6 +104,54 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
+	int i, rval;
+
+	if (!pdata->jack_setup) {
+		struct snd_jack *jack;
+
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+				SND_JACK_HEADSET |
+				SND_JACK_HEADPHONE |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				&pdata->jack, NULL, 0);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		jack = pdata->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+		pdata->jack_setup = true;
+	}
+
+	for (i = 0 ; i < dai_link->num_codecs; i++) {
+		struct snd_soc_dai *dai = rtd->codec_dais[i];
+
+		component = dai->component;
+		rval = snd_soc_component_set_jack(
+				component, &pdata->jack, NULL);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+			return rval;
+		}
+	}
+
+	return 0;
+}
+
+
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
@@ -220,7 +272,7 @@ static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 };
 
-static void sdm845_add_be_ops(struct snd_soc_card *card)
+static void sdm845_add_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
 	int i;
@@ -230,6 +282,7 @@ static void sdm845_add_be_ops(struct snd_soc_card *card)
 			link->ops = &sdm845_be_ops;
 			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
 		}
+		link->init = sdm845_dai_init;
 	}
 }
 
@@ -264,7 +317,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	data->card = card;
 	snd_soc_card_set_drvdata(card, data);
 
-	sdm845_add_be_ops(card);
+	sdm845_add_ops(card);
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(dev, "Sound card registration failed\n");
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog


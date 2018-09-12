Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C09C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BB020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxtIHy6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BB020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeILOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:20:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50289 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeILOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:20:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1555420wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SB79lkiy2mkjOk/PhulCuOIkKcLOy2JwBPtWR76d3Lg=;
        b=CxtIHy6qRVjdsWVtOBn7AK9GXYvR0SJzjFVt4TL/mcjhW2QN5ZfSWZV6MxmVqQkxW6
         pbW7WlqZF/Gl4DMYhjkFiHUUkJw0keKsaDT80EeQGxSAJOAHSGPMpl6mRXSykyeO9FjL
         IX5TykSHtNs0ZKk9bxkHiwjuJnes43BcQzX3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SB79lkiy2mkjOk/PhulCuOIkKcLOy2JwBPtWR76d3Lg=;
        b=P4vf3ulS3+HTdUHIKAckzPQrzhMwnmIOWYZ5YleZGRcjH5gffm0xyJwZE2C80PiUBA
         uvb0yVWSZdOKEqFifiELsUr+123Y5jDJm/oYtqR24cDeMPIyI8f3mfU4mlwsCt5XN7un
         064fPxzjN/G7cEZdoUP8soEn12CZuaY5+1Hkh/jTq0lbfgL8oyNcRC1sVm/ekdfvXuB0
         Nq6IGfVYOqTcgxNKSKO+xEH6V31NmBb9tLwM3xp8ruhpVKrnQNFFHfHiN9jz6rnC0Lrk
         gJApPvUQ9Ye4YzdWOG+VVS3KCmNiT11oxKpQ0LPxZGXPzVGM02vfn2LcyyCfyajtCCqj
         B9sQ==
X-Gm-Message-State: APzg51BEwdp5BWL7thXml82l9bIE7zh8UaMJOtuNgpCRBDOE2U88PoJ/
        w2kfdbkfT9UoSvqLLI5d4pUlrg==
X-Google-Smtp-Source: ANB0VdYIMReRVWia12H+fyMif1Z6qWIpbUFl6Ql5xhFNsOHnSQIAZ5eUXYa3N/QCRuKPNbiIPSV+8w==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr978506wmf.89.1536743829037;
        Wed, 12 Sep 2018 02:17:09 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 142-v6sm1060557wme.35.2018.09.12.02.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 02:17:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: core: add support to card rebind
Date:   Wed, 12 Sep 2018 10:15:00 +0100
Message-Id: <20180912091500.21126-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current behaviour of ASoC core w.r.t to component removal is that it
unregisters dependent sound card totally. There is no support to
rebind the card if the component comes back.
Typical use case is DSP restart or kernel modules itself.

With this patch, core now maintains list of cards that are unbind due to
any of its depended components are removed and card not unregistered yet.
This list is cleared when the card is rebind successfully or when the
card is unregistered from machine driver.

This list of unbind cards are tried to bind once again after every new
component is successfully added, giving a fair chance for card bind
to be successful.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- None, just rebased on top of 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/?h=for-next

 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 85 ++++++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 821bf99992b8..46521b416aa1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1098,6 +1098,7 @@ struct snd_soc_card {
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
+	struct list_head list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1374,6 +1375,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_list);
 	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
+	INIT_LIST_HEAD(&card->list);
 }
 
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4e9367aacc0c..bc99bd5b2065 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -52,6 +52,7 @@ EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(component_list);
+static LIST_HEAD(unbind_card_list);
 
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
@@ -2681,6 +2682,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
+static int snd_soc_bind_card(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	int ret;
+
+	ret = snd_soc_instantiate_card(card);
+	if (ret != 0)
+		return ret;
+
+	/* deactivate pins to sleep state */
+	list_for_each_entry(rtd, &card->rtd_list, list)  {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		struct snd_soc_dai *codec_dai;
+		int j;
+
+		for_each_rtd_codec_dai(rtd, j, codec_dai) {
+			if (!codec_dai->active)
+				pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
+
+		if (!cpu_dai->active)
+			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
+	return ret;
+}
+
 /**
  * snd_soc_register_card - Register a card with the ASoC core
  *
@@ -2690,7 +2718,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, ret;
-	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -2722,28 +2749,23 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 
-	ret = snd_soc_instantiate_card(card);
-	if (ret != 0)
-		return ret;
-
-	/* deactivate pins to sleep state */
-	list_for_each_entry(rtd, &card->rtd_list, list)  {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		struct snd_soc_dai *codec_dai;
-		int j;
-
-		for_each_rtd_codec_dai(rtd, j, codec_dai) {
-			if (!codec_dai->active)
-				pinctrl_pm_select_sleep_state(codec_dai->dev);
-		}
+	return snd_soc_bind_card(card);
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
-		if (!cpu_dai->active)
-			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
+{
+	if (card->instantiated) {
+		card->instantiated = false;
+		snd_soc_dapm_shutdown(card);
+		soc_cleanup_card_resources(card);
+		if (!unregister)
+			list_add(&card->list, &unbind_card_list);
+	} else {
+		if (unregister)
+			list_del(&card->list);
 	}
-
-	return ret;
 }
-EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
 /**
  * snd_soc_unregister_card - Unregister a card with the ASoC core
@@ -2753,12 +2775,8 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
  */
 int snd_soc_unregister_card(struct snd_soc_card *card)
 {
-	if (card->instantiated) {
-		card->instantiated = false;
-		snd_soc_dapm_shutdown(card);
-		soc_cleanup_card_resources(card);
-		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
-	}
+	snd_soc_unbind_card(card, true);
+	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
 }
@@ -3102,7 +3120,7 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 	struct snd_soc_card *card = component->card;
 
 	if (card)
-		snd_soc_unregister_card(card);
+		snd_soc_unbind_card(card, false);
 
 	list_del(&component->list);
 }
@@ -3142,6 +3160,18 @@ static void convert_endianness_formats(struct snd_soc_pcm_stream *stream)
 			stream->formats |= endianness_format_map[i];
 }
 
+static void snd_soc_try_rebind_card(void)
+{
+	struct snd_soc_card *card, *c;
+
+	if (!list_empty(&unbind_card_list)) {
+		list_for_each_entry_safe(card, c, &unbind_card_list, list) {
+			if (!snd_soc_bind_card(card))
+				list_del(&card->list);
+		}
+	}
+}
+
 int snd_soc_add_component(struct device *dev,
 			struct snd_soc_component *component,
 			const struct snd_soc_component_driver *component_driver,
@@ -3169,6 +3199,7 @@ int snd_soc_add_component(struct device *dev,
 	}
 
 	snd_soc_component_add(component);
+	snd_soc_try_rebind_card();
 
 	return 0;
 
-- 
2.18.0


Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD7C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D720833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WVbp0UwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40D720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIMQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:48:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeIMQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MC7rym0MxKSbCOMsLp5yaIUwDO3ZqFhlf6jYZhQkgJE=; b=WVbp0UwXDOb8
        oyt0u3YXTMGSP5Vt5vSd6QkQWcK2pO4GfG9I12wLo1iynMnl8r9V9rAK/s60mFParUr7VF/3u2ak+
        FffRK7ra/6w/LOG70TQ18CcNbW0synzsOkGQVEBNTmeFowGJaqNeChZxFLwIw4Ve0n4SJ1AU6WqbL
        atLuE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g0Py8-0000JS-SP; Thu, 13 Sep 2018 11:39:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A00211121CA5; Thu, 13 Sep 2018 12:39:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: add support to card rebind" to the asoc tree
In-Reply-To:  <20180912091500.21126-1-srinivas.kandagatla@linaro.org>
Message-Id: <20180913113932.A00211121CA5@debutante.sirena.org.uk>
Date:   Thu, 13 Sep 2018 12:39:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: add support to card rebind

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e894efef9ac7c10b7727798dcc711cccf07569f9 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 12 Sep 2018 10:15:00 +0100
Subject: [PATCH] ASoC: core: add support to card rebind

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 85 ++++++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e17a7ae9a155..1e093b399bc0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1097,6 +1097,7 @@ struct snd_soc_card {
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
+	struct list_head list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1373,6 +1374,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_list);
 	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
+	INIT_LIST_HEAD(&card->list);
 }
 
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7e18937c2214..807f112fad80 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -52,6 +52,7 @@ EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(component_list);
+static LIST_HEAD(unbind_card_list);
 
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
@@ -2679,6 +2680,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
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
@@ -2688,7 +2716,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, ret;
-	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -2719,28 +2746,23 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
@@ -2750,12 +2772,8 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
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
@@ -3099,7 +3117,7 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 	struct snd_soc_card *card = component->card;
 
 	if (card)
-		snd_soc_unregister_card(card);
+		snd_soc_unbind_card(card, false);
 
 	list_del(&component->list);
 }
@@ -3139,6 +3157,18 @@ static void convert_endianness_formats(struct snd_soc_pcm_stream *stream)
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
@@ -3166,6 +3196,7 @@ int snd_soc_add_component(struct device *dev,
 	}
 
 	snd_soc_component_add(component);
+	snd_soc_try_rebind_card();
 
 	return 0;
 
-- 
2.19.0.rc2


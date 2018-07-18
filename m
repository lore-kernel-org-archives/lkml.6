Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA76ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1250206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="g6JRn5rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1250206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGRNHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:07:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbeGRNHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FnYH4yos/Vict/4H2NDy2a/GUo17Dm7D88UOjYaIsSE=; b=g6JRn5rvA4wx
        YTCjFGA25zJrDbrlD7GXE0ByI1ycnW420wyE2WjieVVK0OXy51iNYB+i66851GbIyRO5s+IV10GmZ
        FQjKGIUAMFTb9HNaWLR/3zjvzLzcYVpwXwS0bB8pBtidVypxhh/21RD99A5eNTXNmWLOwFhJWI61f
        C6WRs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaF-0003WD-Nm; Wed, 18 Jul 2018 12:29:32 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaE-0007QK-NJ; Wed, 18 Jul 2018 13:29:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: add support to card re-bind using component framework" to the asoc tree
In-Reply-To:  <20180713153632.32511-2-srinivas.kandagatla@linaro.org>
Message-Id: <E1fflaE-0007QK-NJ@debutante>
Date:   Wed, 18 Jul 2018 13:29:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: add support to card re-bind using component framework

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

From bb4b894addb09a069c072a0a032f644cc470d17f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 13 Jul 2018 16:36:28 +0100
Subject: [PATCH] ASoC: core: add support to card re-bind using component
 framework

This patch aims at achieving dynamic behaviour of audio card when
the dependent components disappear and reappear.

With this patch the card is removed if any of the dependent component
is removed and card is added back if the dependent component comes back.
All this is done using component framework and matching based on
component name.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 +++++
 sound/soc/soc-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..a23ecdf3eff1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/component.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
@@ -1090,6 +1091,12 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
+	/* component framework related */
+	bool components_added;
+	/* set in machine driver to enable/disable auto re-binding */
+	bool auto_bind;
+	struct component_match *match;
+
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3be0310d5c81..08e189485009 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,11 +279,28 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
+static int snd_soc_card_comp_compare(struct device *dev, void *data)
+{
+	struct snd_soc_component *component;
+
+	lockdep_assert_held(&client_mutex);
+	list_for_each_entry(component, &component_list, list) {
+		if (dev == component->dev) {
+			if (!strcmp(component->name, data))
+				return 1;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_rtdcom_list *new_rtdcom;
+	char *cname;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -300,6 +317,13 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
+	if (rtd->card->auto_bind && !rtd->card->components_added) {
+		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
+				       "%s", component->name);
+		component_match_add(rtd->card->dev, &rtd->card->match,
+				    snd_soc_card_comp_compare, cname);
+	}
+
 	return 0;
 }
 
@@ -835,6 +859,25 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 	return false;
 }
 
+static int snd_soc_card_comp_bind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	if (card->instantiated)
+		return 0;
+
+	return snd_soc_register_card(card);
+}
+
+static void snd_soc_card_comp_unbind(struct device *dev)
+{
+}
+
+static const struct component_master_ops snd_soc_card_comp_ops = {
+	.bind = snd_soc_card_comp_bind,
+	.unbind = snd_soc_card_comp_unbind,
+};
+
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -2126,6 +2169,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
+	if (card->auto_bind && !card->components_added) {
+		component_master_add_with_match(card->dev,
+						&snd_soc_card_comp_ops,
+						card->match);
+		card->components_added = true;
+	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2749,6 +2798,9 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 	}
 
+	if (!card->auto_bind && card->components_added)
+		component_master_del(card->dev, &snd_soc_card_comp_ops);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
@@ -3161,8 +3213,17 @@ int snd_soc_add_component(struct device *dev,
 
 	snd_soc_component_add(component);
 
+	ret = component_add(dev, NULL);
+	if (ret < 0) {
+		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
+		goto err_comp;
+	}
+
 	return 0;
 
+err_comp:
+	soc_remove_component(component);
+	snd_soc_unregister_dais(component);
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
@@ -3210,6 +3271,7 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
+		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.18.0


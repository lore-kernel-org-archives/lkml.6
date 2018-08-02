Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0994C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE921525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvZUFENR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDE921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeHBQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:57:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40674 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbeHBQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:57:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so2956253wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ibQFJG3ZrMvqqlB6/pzr09QcDU/5Fh8SilsQgMz4Vqc=;
        b=fvZUFENRpFEdBSBRcFajd5iliwCGG0G9jYp3Tj54PFWZ6sObpcMPqfg6jQNQ8YZqNj
         HfbC3OfyHngQ9osrySLJ/zhFsL5gOIVZouEq+W+BfKkH/bQ2iivf+0yAB7vKXm2jDoik
         NDpfaLGe3p2+DNGEE5xgw/c4gkKgDFh1rjqPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ibQFJG3ZrMvqqlB6/pzr09QcDU/5Fh8SilsQgMz4Vqc=;
        b=sHHmzPHRz4mHEdQrtg/Mg59OORewPjle79IFH7l8YtrfIatAyMFT1ym7OAbpGTCg4W
         ROxPhimdbUz19E8ddE9fcnGIb6Oy9/sw2bY9fOBB+pl5TN/ngUDiYkRxGrm3FkVIPnWI
         UaguoAj/w07qiz9b8t7COQlEHnqZDYYddKqy5DsVa8NfgjM3beluZzgE52aDeu3wgALU
         sISeD+BdL5NfrUAKqspvu9a1TGbTlGb15C5d4c74XGzHGkjqUBjUgRys3NgegtbRIMnZ
         kiM6yhIjD0vwYt3zv2/2DHGK1bgsCq3P4HNa+mD6druBN7/kCJMtvddN+BZmCRCd7ZWm
         fVFw==
X-Gm-Message-State: AOUpUlEsRkkshiTyTz1KaFXV3yHwTFnwQ6s0AdOE1C23457v77bSzZY/
        O3gYVCmj0SfAiohA/BoeX+6M/A==
X-Google-Smtp-Source: AAOMgpezRFsOxE1kEupiEYxtxOb6e1Xb4V+sEt2wmIKtKgcXGpKxBwx1Ux6XNtlJm5RknAl5SFhtAQ==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr2156993wmd.18.1533222355860;
        Thu, 02 Aug 2018 08:05:55 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm2497517wmf.41.2018.08.02.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 08:05:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org, stefan.wahren@i2se.com,
        guillaume.tucker@collabora.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] ASoC: core: remove support for card rebind using component framework
Date:   Thu,  2 Aug 2018 16:03:38 +0100
Message-Id: <20180802150338.24538-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
References: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM based audio components get registered inside the component framework
bind callback. However component framework has a big mutex lock taken for
every call to component_add, component_del and bind, unbind callbacks.

This can lead to deadlock situation if we are trying to add new/remove
component within a bind/unbind callbacks. Which is what was happening
with bcm2837 rpi 3.

Revert this change till we sort out the mutex issue.

Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc.h  |  7 ------
 sound/soc/soc-core.c | 62 ----------------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ace474e8649e..41cec42fb456 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/component.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
@@ -1091,12 +1090,6 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
-	/* component framework related */
-	bool components_added;
-	/* set in machine driver to enable/disable auto re-binding */
-	bool auto_bind;
-	struct component_match *match;
-
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b27923303d..82eb3868be67 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,28 +279,11 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
-static int snd_soc_card_comp_compare(struct device *dev, void *data)
-{
-	struct snd_soc_component *component;
-
-	lockdep_assert_held(&client_mutex);
-	list_for_each_entry(component, &component_list, list) {
-		if (dev == component->dev) {
-			if (!strcmp(component->name, data))
-				return 1;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_rtdcom_list *new_rtdcom;
-	char *cname;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -317,13 +300,6 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
-	if (rtd->card->auto_bind && !rtd->card->components_added) {
-		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
-				       "%s", component->name);
-		component_match_add(rtd->card->dev, &rtd->card->match,
-				    snd_soc_card_comp_compare, cname);
-	}
-
 	return 0;
 }
 
@@ -859,25 +835,6 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 	return false;
 }
 
-static int snd_soc_card_comp_bind(struct device *dev)
-{
-	struct snd_soc_card *card = dev_get_drvdata(dev);
-
-	if (card->instantiated)
-		return 0;
-
-	return snd_soc_register_card(card);
-}
-
-static void snd_soc_card_comp_unbind(struct device *dev)
-{
-}
-
-static const struct component_master_ops snd_soc_card_comp_ops = {
-	.bind = snd_soc_card_comp_bind,
-	.unbind = snd_soc_card_comp_unbind,
-};
-
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -2169,12 +2126,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
-	if (card->auto_bind && !card->components_added) {
-		component_master_add_with_match(card->dev,
-						&snd_soc_card_comp_ops,
-						card->match);
-		card->components_added = true;
-	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2820,9 +2771,6 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 	}
 
-	if (!card->auto_bind && card->components_added)
-		component_master_del(card->dev, &snd_soc_card_comp_ops);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
@@ -3235,17 +3183,8 @@ int snd_soc_add_component(struct device *dev,
 
 	snd_soc_component_add(component);
 
-	ret = component_add(dev, NULL);
-	if (ret < 0) {
-		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
-		goto err_comp;
-	}
-
 	return 0;
 
-err_comp:
-	soc_remove_component(component);
-	snd_soc_unregister_dais(component);
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
@@ -3293,7 +3232,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
-		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.16.2


Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C807208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWQqMqor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C807208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGKIsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:48:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeGKIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:48:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so17267941wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ue7Xm7o7EibOLxsIq/QdsSGqCKgJ4rq3ZDtqtZx8sAk=;
        b=MWQqMqorm9DER3Ng2bz069xCnQsok9BeikORLXTdYAED27i7sjzxQPx5mHEtvFbFno
         3BDgznODbls7TWlZtunt5OykT8CIvFW1rSm6lXOgqTCBexnSx0HLSo9xEcbv3zZs9W+V
         +QHvpMr0Hui98cl4pGHhGrUO3sn4s+w/iQGsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ue7Xm7o7EibOLxsIq/QdsSGqCKgJ4rq3ZDtqtZx8sAk=;
        b=R5rr5fZ8XPB1gvRRSm7pxxLRx5B35n40R3KpbpcFbBREJaTnvsrfFdP43he34rFfHY
         hiM0fQnhP2ZU11D7yMfHzKWfAWJuFK4TY/c+aWOdmKnrStrp4lF9qjVyNARIFWllpWGq
         jY4txhcy6h4TIrBrHqd2+niy1Qygyn0vOHuFcZwdh5J7WHXFQrKhNyDICCUAHGwl6ZyF
         pWEMWTG8HPDdYI8EwmSKoqkY50CChiEf6/MHEloex7RlFUEOP1thUyhvnF7opWGKoD98
         ZiC1b+9DpAbnkc5cO3K/sYS7wewSC5cP5lb9G2FOQ0JZd3mno/aQIj9vWF5Qj1jaW2ht
         aQbQ==
X-Gm-Message-State: AOUpUlHvDGAEcNHPi1nec9s34GOIPZTFlk2lFbiVHeFO06zciLtTejqV
        KEJEEFdSrVLCn+oSlwM96TGhM2j4Wuo=
X-Google-Smtp-Source: AAOMgpc8NdPq+PZkEGVlNSilkxI6juaBIXDiVRv+pPtyUJtddtSAK/0XMBJ84XoM9DPUKls9yKbgqw==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr5394101wro.195.1531298724658;
        Wed, 11 Jul 2018 01:45:24 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id h12-v6sm17120349wmb.3.2018.07.11.01.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 01:45:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: core: add support to card re-bind/unbind using component framework
Date:   Wed, 11 Jul 2018 09:43:18 +0100
Message-Id: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims at add achieving dynamic behaviour of audio card when
the dependent components disappear and reappear.

With this patch the card is removed if any of the dependent component
is removed and card is added back if the dependent component comes back.
All this is done using component framework and matching based on
component name.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

During discussion regarding card re-binding when components unregister
and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
that component framework can be added into core to provide this feature.

With this new changes the card will re-bind once the dependent component
re-registers after unregistering. This works based on the match done
from component name using component framework.

I have tested this patch with qdsp start-stop usecase for more than 10000
times in loop on Qcom platforms.

I will send qdsp side cleanup patches once I get some feedback on this patch.


 include/sound/soc.h  |  5 ++++
 sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 870ba6b64817..b94149d29c0d 100644
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
@@ -1088,6 +1089,10 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
+	/* component framework related */
+	bool components_added;
+	struct component_match *match;
+
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6d33634b934b..377ed8e67686 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
+static int snd_soc_card_comp_compare(struct device *dev, void *data)
+{
+	struct snd_soc_component *component = NULL;
+	struct snd_soc_component *t;
+
+	lockdep_assert_held(&client_mutex);
+	list_for_each_entry(t, &component_list, list) {
+		if (dev == t->dev) {
+			component = t;
+			break;
+		}
+	}
+
+	if (component && !strcmp(component->name, data))
+		return 1;
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
@@ -300,6 +320,13 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
+	if (!rtd->card->components_added) {
+		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
+				       "%s", component->name);
+		component_match_add(rtd->card->dev, &rtd->card->match,
+				    snd_soc_card_comp_compare, cname);
+	}
+
 	return 0;
 }
 
@@ -835,6 +862,28 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
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
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	snd_soc_unregister_card(card);
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
@@ -2108,6 +2157,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
+	if (!card->components_added) {
+		component_master_add_with_match(card->dev,
+						&snd_soc_card_comp_ops,
+						card->match);
+		card->components_added = true;
+	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -3098,11 +3153,6 @@ static void snd_soc_component_cleanup(struct snd_soc_component *component)
 
 static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 {
-	struct snd_soc_card *card = component->card;
-
-	if (card)
-		snd_soc_unregister_card(card);
-
 	list_del(&component->list);
 }
 
@@ -3169,8 +3219,17 @@ int snd_soc_add_component(struct device *dev,
 
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
@@ -3218,6 +3277,7 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
+		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.16.2


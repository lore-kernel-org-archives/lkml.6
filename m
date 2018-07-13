Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781B4208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVpbE/Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781B4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeGMPyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38096 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbeGMPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id m1-v6so12824168wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DT8uzieULApLhHCk+Za0usRqnEVnd2LGlbLtpiw7yc=;
        b=iVpbE/TgrkJoRyeje16gkO+sU9aqmenWuGH0919eKPGHaoEscwsU3SFcuMyQ/PJC5T
         Y6nZNTirGAj9nN9BoGSpVEaCPHHHHXkyYfdS1UuqIvck1NZn2ovGYGVRxOVFg6gVjJVS
         euxd++oPh2aAjkh0z50H55mwCI89bKvtMhTcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DT8uzieULApLhHCk+Za0usRqnEVnd2LGlbLtpiw7yc=;
        b=PHNpib2EhUlRtzwu2dJgjR3DuP+P3RWQjWKEmow8i22hx7853je3IAggOGAwnXb5uS
         pIMdIhQTrhgBFpA8jHZJJTcQZcNm0TgkisbZpajkf/a4CnqMLKB1gmORJ3LwdPOsdqfY
         5n2mBH1sPXziYuIfmNcuuE8etsz11wKQEwvvJbLQaSuAQXj6A+hkCcAr6dGg7S2hc3qD
         iIlKf5BVEVrPh5UtkRghKnoBFRlEPupSRY4/Tuav8FDryc8RJEUR9gP3RSVBf7/Pihrk
         wOh9RY91g1HXA6eIHeCuDh3+ltaJ0ZK9K5m1b5xIQoXj0qgsZWxjIjICW0Gix2iNy8X9
         Ci1g==
X-Gm-Message-State: AOUpUlFSXuDue07ttmliLRJ9QPAKn5NXnc+v6T7Y6q1mr2xGArNYjXZb
        WoKJ1uYEUwTv4zPs9ZEI0Pwlhg==
X-Google-Smtp-Source: AAOMgpezxF3qrpWQ+AVPjz9I6wS2GilLlvBIXE0lDm/DVadFpWTibBZdI3Vneqfz0Ce1sJwRWZr+Gw==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr5142953wrp.202.1531496365156;
        Fri, 13 Jul 2018 08:39:25 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: qdsp6: q6routing: remove component framework related code
Date:   Fri, 13 Jul 2018 16:36:31 +0100
Message-Id: <20180713153632.32511-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 35269b492761..1d33b00e5b44 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -8,7 +8,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/bitops.h>
-#include <linux/component.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -977,9 +976,10 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
-static int q6routing_dai_bind(struct device *dev, struct device *master,
-			      void *data)
+static int q6pcm_routing_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+
 	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
 	if (!routing_data)
 		return -ENOMEM;
@@ -989,35 +989,15 @@ static int q6routing_dai_bind(struct device *dev, struct device *master,
 	mutex_init(&routing_data->lock);
 	dev_set_drvdata(dev, routing_data);
 
-	return snd_soc_register_component(dev, &msm_soc_routing_component,
+	return devm_snd_soc_register_component(dev, &msm_soc_routing_component,
 					  NULL, 0);
 }
 
-static void q6routing_dai_unbind(struct device *dev, struct device *master,
-				 void *d)
+static int q6pcm_routing_remove(struct platform_device *pdev)
 {
-	struct msm_routing_data *data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-
-	kfree(data);
-
+	kfree(routing_data);
 	routing_data = NULL;
-}
 
-static const struct component_ops q6routing_dai_comp_ops = {
-	.bind   = q6routing_dai_bind,
-	.unbind = q6routing_dai_unbind,
-};
-
-static int q6pcm_routing_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6routing_dai_comp_ops);
-}
-
-static int q6pcm_routing_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6routing_dai_comp_ops);
 	return 0;
 }
 
-- 
2.16.2


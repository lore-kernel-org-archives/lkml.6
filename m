Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF82ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492EE208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJuoBeqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492EE208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGMPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54160 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbeGMPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1904749wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TqQmdbUc76Zh3AKXyulvqz/9XxR8S85UTq3b7WXey3s=;
        b=fJuoBeqKTg7nosmoZ7eFaF9rkHo+pyOcwXuqN9bBmcpUAAPRJwli9LxUi2SHxw9cdy
         RdzhQvdgyJ+dXhCRn43X2XO3PwUmpkxz1y45PWifn+pg4NlW08SzXWWWF0K28kabLTXf
         yeiL25dBR/R1anE1WZBBOd0C5vm4KtIHYhvyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TqQmdbUc76Zh3AKXyulvqz/9XxR8S85UTq3b7WXey3s=;
        b=Lag0VadZ73jmbNpV7MGhq6DV5t1lqQSpyXEXWAjBD450eBelYmDDaYdS3VYXlGMPHC
         S1EbOLIKq3HhHgPd3yRuCjFkyau9hjlMFQsEEx9cZRhVNwn96Wia5Xk8MDh2CJXTiAh6
         ioA1b9EcW6be+adChmQgbcFBTydUAUdkHBdWeKC0ULgjjdgFx0FqGplMhitPX7H5AD0k
         T3/OSYfWrzi1ecMWiEioag4zZPPWbx4jJivySOU7Fxwz1RuwAtnc5xir8hKzPp6N8xpN
         gITSwoa6hnJj94lv6MqaLhTdprouS9ek9CrKxWeSyMadHvGacKfK2rYvRyJxiUH4Nmag
         ii8g==
X-Gm-Message-State: AOUpUlFcbiYh32xaS50wvtNszHAhTe31YFi4xyLuxKaulKwITVL/TduC
        ur9F+J/Pz/m5O+SSG50LCpQAOA==
X-Google-Smtp-Source: AAOMgpcPsJm8UKC4rVIW3Rg9N+88sLPVLfh/Eqh8BZPu4Jny1qxTX7a0smJeQ3URkHKn+lEs6TZdaA==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11-v6mr4200050wme.148.1531496364158;
        Fri, 13 Jul 2018 08:39:24 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] ASoC: qdsp6: q6asm-dai: remove component framework related code
Date:   Fri, 13 Jul 2018 16:36:30 +0100
Message-Id: <20180713153632.32511-4-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6asm-dai.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 199d0fb6f90a..9db9a2944ef2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/component.h>
 #include <sound/soc.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -563,14 +562,15 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 	Q6ASM_FEDAI_DRIVER(8),
 };
 
-static int q6asm_dai_bind(struct device *dev, struct device *master, void *data)
+static int q6asm_dai_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	struct q6asm_dai_data *pdata;
 	int rc;
 
-	pdata = kzalloc(sizeof(struct q6asm_dai_data), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
@@ -582,36 +582,10 @@ static int q6asm_dai_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, pdata);
 
-	return snd_soc_register_component(dev, &q6asm_fe_dai_component,
+	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
 					q6asm_fe_dais,
 					ARRAY_SIZE(q6asm_fe_dais));
 }
-static void q6asm_dai_unbind(struct device *dev, struct device *master,
-			     void *data)
-{
-	struct q6asm_dai_data *pdata = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-
-	kfree(pdata);
-
-}
-
-static const struct component_ops q6asm_dai_comp_ops = {
-	.bind   = q6asm_dai_bind,
-	.unbind = q6asm_dai_unbind,
-};
-
-static int q6asm_dai_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6asm_dai_comp_ops);
-}
-
-static int q6asm_dai_dev_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6asm_dai_comp_ops);
-	return 0;
-}
 
 static const struct of_device_id q6asm_dai_device_id[] = {
 	{ .compatible = "qcom,q6asm-dais" },
@@ -625,7 +599,6 @@ static struct platform_driver q6asm_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6asm_dai_device_id),
 	},
 	.probe = q6asm_dai_probe,
-	.remove = q6asm_dai_dev_remove,
 };
 module_platform_driver(q6asm_dai_platform_driver);
 
-- 
2.16.2


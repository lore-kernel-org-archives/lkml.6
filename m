Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC82ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72921208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSKiJVUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72921208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbeGMPyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34617 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id s13-v6so4816063wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OqHiQ49cJea9/GlixOkx9jZTRTO42wXjtFFZOu5frC0=;
        b=aSKiJVUbuxEvbXOGrAWXuWpfKaLJAG1kAao4f25dIoU2iJksAcSws4PXT+QL7b8PAI
         j0O8/dHDeSGQMRt+aItpumyYPw8wlayDV0glajjgO7Fnw8nUp4TWVnYnEljjCodDC4zw
         7jzXN0EyOhBgzCwZcbO2baUUqWQYgVN5v3Xbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OqHiQ49cJea9/GlixOkx9jZTRTO42wXjtFFZOu5frC0=;
        b=iybYxesW9g4Ssejslb5NK2+3E8rfYHKHYtB8JmJ20JahcoH03qvUWeqjCexp728Ngj
         BoI/KJ35909HskavXo6rFyK1/0f4t4Yctvp/hGsPaTtxw14orrsqBlFYtlBdrBvOoxEk
         2737bYogy0HyXYpB6RRzjmVyvw+eL1aeZj8F4TdBuXeCqJL7M20iq/rJjPbC9mF0Yl+3
         a658B0dDkJcdFnC5a5sFzTV9b7OVe2cLYzHXnflDXvm6ha1K71z+3yf1AUCLmC87gIST
         WfMrfGZSHY+Ao6qR0IwR+lSQhp1cXWM04ZnbH+Dl13dDDk2Wf1uxpHnJbNlaJ3JyAfTE
         SRAw==
X-Gm-Message-State: AOUpUlGuzoXGZkG0xJ3jbZ1CQSopS9m/h7Jj3R7ZZq7BAyLWmY45+MOR
        3tOFPeiCtbsS97SJb8FQMAwfmg==
X-Google-Smtp-Source: AAOMgpf3H2k8f19rJNXIZm/z4Kw0WPwOPRg3IzxwiFWBpyQnEt4Qy8CJVcj+c+/I1Y/6DMZThIovrg==
X-Received: by 2002:a1c:3e50:: with SMTP id l77-v6mr4037736wma.45.1531496363172;
        Fri, 13 Jul 2018 08:39:23 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] ASoC: qdsp6: q6afe-dai: remove component fw related code
Date:   Fri, 13 Jul 2018 16:36:29 +0100
Message-Id: <20180713153632.32511-3-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6afe-dai.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 24d1ffc3e5db..3081464befc7 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -4,7 +4,6 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/component.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -1405,11 +1404,12 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 	}
 }
 
-static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
+static int q6afe_dai_dev_probe(struct platform_device *pdev)
 {
 	struct q6afe_dai_data *dai_data;
+	struct device *dev = &pdev->dev;
 
-	dai_data = kzalloc(sizeof(*dai_data), GFP_KERNEL);
+	dai_data = devm_kzalloc(dev, sizeof(*dai_data), GFP_KERNEL);
 	if (!dai_data)
 		return -ENOMEM;
 
@@ -1417,35 +1417,10 @@ static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
 
 	of_q6afe_parse_dai_data(dev, dai_data);
 
-	return snd_soc_register_component(dev, &q6afe_dai_component,
+	return devm_snd_soc_register_component(dev, &q6afe_dai_component,
 					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
 }
 
-static void q6afe_dai_unbind(struct device *dev, struct device *master,
-			     void *data)
-{
-	struct q6afe_dai_data *dai_data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-	kfree(dai_data);
-}
-
-static const struct component_ops q6afe_dai_comp_ops = {
-	.bind   = q6afe_dai_bind,
-	.unbind = q6afe_dai_unbind,
-};
-
-static int q6afe_dai_dev_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6afe_dai_comp_ops);
-}
-
-static int q6afe_dai_dev_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6afe_dai_comp_ops);
-	return 0;
-}
-
 static const struct of_device_id q6afe_dai_device_id[] = {
 	{ .compatible = "qcom,q6afe-dais" },
 	{},
@@ -1458,7 +1433,6 @@ static struct platform_driver q6afe_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6afe_dai_device_id),
 	},
 	.probe = q6afe_dai_dev_probe,
-	.remove = q6afe_dai_dev_remove,
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-- 
2.16.2


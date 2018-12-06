Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C353C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE67920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jErdw6p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE67920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeLFMoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35133 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFMoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so305847ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJvN9Rzv+0xPXleQeFq/pULseUhFiIrJUg0MsYbkIQQ=;
        b=jErdw6p7lQSVYfE6FJqDsTaFKkD2INS1kz7U5/VH+Oe1DtxgVxoQejsEyhJn8aa/Uj
         rnhKSwjdozbLDI7C96cU2XyAuQJmIVq0+NbZVqX1KV41SRUxoreovVGDZZlFSeJ1IZ+I
         3ycGk3aT/73Q+ed3Lv17SxV0u4yq/4lRq4T9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJvN9Rzv+0xPXleQeFq/pULseUhFiIrJUg0MsYbkIQQ=;
        b=AmSD562DStkg2B8W4/bIPe6Zs0IaByyGkwfG/+pK6Y8ujTymwKnMH4nZ7mdInRJMGq
         iba1ExPM3IYpWsG1uk1uJz87R6srp35hpypr6tYXdQJ3nwxHGbQG5pjnHSElHH64uIf7
         Nwq44jylqnQMGZXus1WeHHxM7I52rdzKDpe7jpTERCrOHWuM4LsiNDjaadUs97khT8nB
         m2GD11jssrhOTWSlKk+OQCcjvQzSFi/blwj+CfzDddONbAYJzzGraamBwLmRnKszG3Zb
         Ydmjo+T1pTaL6Sag1AvgzC2KwMCFWGKNSYeieQJb4EMMdyazxHRNLN5gR7PdqFNMEndb
         2g6Q==
X-Gm-Message-State: AA+aEWbaGstLTRRc5IwHP91EOMhjp689u7wD0GEg3K8mS/b54jC0UPFO
        mcmHNmUp/oVtl6bzZgtVSOhVHg==
X-Google-Smtp-Source: AFSGD/XgGq8iSLLDEy4C/SzT1+JI1rAlGiPpUYTp9665S5CjQGXXEawxKorPww4MkNZFP6b/UOcziw==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr18222992ljk.128.1544100246324;
        Thu, 06 Dec 2018 04:44:06 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/15 v4] regulator: lm363x: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:39 +0100
Message-Id: <20181206124351.10155-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: b2d751b7f69b ("regulator: lm363x: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/lm363x-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index bbedb08d257b..8c0e8419c43f 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -224,13 +224,15 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	/*
 	 * Check LCM_EN1/2_GPIO is configured.
 	 * Those pins are used for enabling VPOS/VNEG LDOs.
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return devm_gpiod_get_index_optional(dev, "enable", 0,
+		return gpiod_get_index_optional(dev, "enable", 0,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
-		return devm_gpiod_get_index_optional(dev, "enable", 1,
+		return gpiod_get_index_optional(dev, "enable", 1,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
 		return NULL;
@@ -263,6 +265,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 					 LM3632_EXT_EN_MASK,
 					 LM3632_EXT_EN_MASK);
 		if (ret) {
+			if (gpiod)
+				gpiod_put(gpiod);
 			dev_err(dev, "External pin err: %d\n", ret);
 			return ret;
 		}
-- 
2.19.2


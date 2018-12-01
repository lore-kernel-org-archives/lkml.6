Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC27C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BBE2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgnOSiwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BBE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeLBDGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35363 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeLBDGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so6229085lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoT+Ndj5Ei0kF2uLiPdGvTf6lS/9r/F3o57+S1DbskE=;
        b=XgnOSiwjI4z9wgN+Zk3ZjjQlIhLlyC1NH653lGFo2zo2zTOJb1CuYW47Ex7XY1Ab/V
         r2cRc8S2nTecGtBUiwgmZJxpbH3QMYlTJhiFswmzR/RmtExPjcLKF+15fd0JI5xJKUx5
         Dh6P3LP1mM7tBP85vFusmxS+LR60x+ZNJ0tm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoT+Ndj5Ei0kF2uLiPdGvTf6lS/9r/F3o57+S1DbskE=;
        b=VKomQvHMmOb3Vigv1y4GFPNVl4PQ2DOv2t/bo64P7ipYNgRVolqCRdAipvrwolHuDW
         yClsru2f9M1EXeQNiUjeXV41WOJpjSxb6uKEDeUlKqfoa1XPaAIfdTjuXRDyHMPLCt5l
         sH2wvTvx2zMMGzjnuBCI6vvqzc7mOmnP4nE6fyotHRaMIfDv397cJC2Y6z8bC8w2MlUj
         Jqsu51ee8TOlmOPCCs+LI/bBQAlSjAF53+Lgha3GH25h9VWkuxSWIiyR0cGbgBWTdWe9
         F4rOBgS5RGHtAHNYaX3uuCZoHoyK9+1SV+5Rbbn7Euqrv59siRLNwji0Vj1nTCxiqQCh
         YVeg==
X-Gm-Message-State: AA+aEWabScmJnpHIyxYI/vsmWC2lKpmlvTH0+MbfQD1MINXsQ5+UTIsv
        A0dVkXxgf3NZ4bZFUs+gdKLPpg==
X-Google-Smtp-Source: AFSGD/WEktpGoiekdHHvVxMw4bMhk1tzpFRiwZpi75XmoGhluTXsEm+FLOS1pNEh7k/h/uVRMkesJw==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr6073306lfi.19.1543679598621;
        Sat, 01 Dec 2018 07:53:18 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/13 v2] regulator: max77686: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:46 +0100
Message-Id: <20181201154151.14890-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

Fix up the errorpath so that we free this descriptor if
an error occurs in the callback. Rely on the regulator
core to deal with it after this point: a previous patch
fixed up the regulator core to properly dispose any
GPIO descriptors once you call regulator_register().

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Handle the errorpath (hopefully) correct, back out of
  regulator registration by freeing the descriptors of all
  not yet registered regulators.
---
 drivers/regulator/max77686-regulator.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index f5cee1775905..8020eb57374a 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -250,13 +250,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 		struct regulator_config *config)
 {
 	struct max77686_data *max77686 = config->driver_data;
+	int ret;
 
 	switch (desc->id) {
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
-				np,
+		config->ena_gpiod = gpiod_get_from_of_node(np,
 				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
@@ -271,9 +271,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
-		return regmap_update_bits(config->regmap, desc->enable_reg,
-					  desc->enable_mask,
-					  MAX77686_GPIO_CONTROL);
+		ret = regmap_update_bits(config->regmap, desc->enable_reg,
+					 desc->enable_mask,
+					 MAX77686_GPIO_CONTROL);
+		if (ret) {
+			gpiod_put(config->ena_gpiod);
+			config->ena_gpiod = NULL;
+		}
 	}
 
 	return 0;
-- 
2.19.1


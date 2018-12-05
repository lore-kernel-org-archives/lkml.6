Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDCA20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScvXDerd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDCA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbeLEMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:47:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35150 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbeLEMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so18213586ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTwEgaJuHML2/WugrEbTAW9s/jIgwlSTFOzt/GYbDJk=;
        b=ScvXDerd9AjqpSTtybMjmLDBmrN/dJTK4LZtUTVLDI8K/hsBSik/8My7fIAhAB0JpM
         CY2z6RfbQsonquJTdfMp7uO+zPewcW1EaZrYBjm4XvcdIkurSp1KKLQrZ9iAcQmP6KJi
         H7xa3mbRBhl1eCYurlEPEGzjRcBl00fKqTI4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTwEgaJuHML2/WugrEbTAW9s/jIgwlSTFOzt/GYbDJk=;
        b=BGBhNdJ82CbohbNfizrYni/Tcn0qPdpDOoiz2B5+7wItiWRTMK+jWgPeW2VM4PK5mf
         y0MiS+9Qkkq0dn+BL0Di9R518W+8Zj6iMVNdnkCqg9Bg72Aqxglx+16F5TpqCcurhD3A
         5yYzWORyhbxOFsxeua5IZGVXt0gfuVOLqXSDwHYDliFMWUllI44bCLYVEzyaXfY0sDjC
         NiIUZmHGctk4O1CGITQjxQbFY+fP7EiznJWvd/31dfmjZ4NIDbsFufNj7S6dJoKYGerv
         JtusmuaXV5eU9nbRoVW7TF8qzmyynp/LUDjMIfZeqhDKwQbTKerh/9jU9DA9NMVW1ht4
         mpLw==
X-Gm-Message-State: AA+aEWbXVFqZsAsUoPbwmiR74QpFKOCJxl6UxabWP6BVtEyWhF6Qrc0L
        mCQ8aWTERxO43NsO8U4apTciJg==
X-Google-Smtp-Source: AFSGD/Ua1YLt4MiMZnMbT5Xv42wTyNmGJf1qpdDkNhBoPYJ8JZb9nqxRa3iQt9pMT8inlhSdVDVGEg==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr17299442ljj.158.1544014066335;
        Wed, 05 Dec 2018 04:47:46 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/15 v3] regulator: max77686: Let core handle GPIO descriptor
Date:   Wed,  5 Dec 2018 13:47:14 +0100
Message-Id: <20181205124721.26624-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resending.
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
2.19.2


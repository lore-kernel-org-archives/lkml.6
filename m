Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75295C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E131205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfmHo1KO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E131205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeLEMsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34801 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeLEMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so18207050ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XQGPplmAxsoD4Fqk/HW1LiiDkGUJY5wCq//IJHDs0c=;
        b=kfmHo1KOzEnmzFEOh7qMnVB3y5geh2cSYRas9Pmgq/F00yi299pjmRKr4F0hBms4JA
         UJmId8NqwaV9zdbaPckLglKvZwfumXUP79dA6WfrmpXkWJS0Xks06+//Y8aEzDdeouRP
         d9UkzZdjHGQ7YyuLSc0EMKcEussauxs+s1YmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XQGPplmAxsoD4Fqk/HW1LiiDkGUJY5wCq//IJHDs0c=;
        b=qVQrgwIeEjyCbnuzBZJA5BvybJy8kWKzINwB9boAN3zGNxf1DM+mkhma1T8rjvOyba
         DkUdLmWfIpYRp2AS8Yl1SFKkdQ7EFecPnhEOkzCRB8aWS8xPdV1E8sVbKQNMQoSn0bg8
         xORbKhliQBO6kIiUnZhP1XaNvxn+jh7EI8GAMjOYsJY0lUrTyn2sT2aMevasjchnS6Kp
         MAFp/C970cuOHjm8KFEs1kcGHRNB2tuPaFle60GA9Rk7uAsVXWBFR+MsPSAGL5MgCBT/
         l4GEPHpeqf2YTFNWWtyU9qE1TgRjZJ/B+tPO4raZZL9TmiGbLEjwmHApgliqM0QFLqMM
         P5qA==
X-Gm-Message-State: AA+aEWaa64lHxLs0fAu+3GVFBsSChlZl/pjjAzuWOLNjfl5zAXpcEVkf
        3HWlfT5dkNdc2/UsoOcBo6ADmw==
X-Google-Smtp-Source: AFSGD/XGyld5esnrsIJ78n7oSV4z9Aoxb6oHRLQYRLttu6DApni3NjZyJ2YEIfwraWhLelpFOPUrfA==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr15235740ljj.146.1544014062231;
        Wed, 05 Dec 2018 04:47:42 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/15 v3] regulator: max8973: Let core handle GPIO descriptor
Date:   Wed,  5 Dec 2018 13:47:12 +0100
Message-Id: <20181205124721.26624-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: e7d2be696faa ("regulator: max8973: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Fix the second case of devm_gpiod_get()
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/max8973-regulator.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e7a58b509032..ef8f4789a517 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -632,7 +632,7 @@ static int max8973_probe(struct i2c_client *client,
 	struct max8973_chip *max;
 	bool pdata_from_dt = false;
 	unsigned int chip_id;
-	struct gpio_desc *gpiod;
+	struct gpio_desc *gpiod = NULL;
 	enum gpiod_flags gflags;
 	int ret;
 
@@ -759,9 +759,13 @@ static int max8973_probe(struct i2c_client *client,
 		else
 			gflags = GPIOD_OUT_LOW;
 		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
-		gpiod = devm_gpiod_get_optional(&client->dev,
-						"maxim,enable",
-						gflags);
+		/*
+		 * Do not use devm* here: the regulator core takes over the
+		 * lifecycle management of the GPIO descriptor.
+		 */
+		gpiod = gpiod_get_optional(&client->dev,
+					   "maxim,enable",
+					   gflags);
 		if (IS_ERR(gpiod))
 			return PTR_ERR(gpiod);
 		if (gpiod) {
@@ -775,10 +779,13 @@ static int max8973_probe(struct i2c_client *client,
 		/*
 		 * We do not let the core switch this regulator on/off,
 		 * we just leave it on.
+		 *
+		 * Do not use devm* here: the regulator core takes over the
+		 * lifecycle management of the GPIO descriptor.
 		 */
-		gpiod = devm_gpiod_get_optional(&client->dev,
-						"maxim,enable",
-						GPIOD_OUT_HIGH);
+		gpiod = gpiod_get_optional(&client->dev,
+					   "maxim,enable",
+					   GPIOD_OUT_HIGH);
 		if (IS_ERR(gpiod))
 			return PTR_ERR(gpiod);
 		if (gpiod)
@@ -798,6 +805,8 @@ static int max8973_probe(struct i2c_client *client,
 
 	ret = max8973_init_dcdc(max, pdata);
 	if (ret < 0) {
+		if (gpiod)
+			gpiod_put(gpiod);
 		dev_err(max->dev, "Max8973 Init failed, err = %d\n", ret);
 		return ret;
 	}
-- 
2.19.2


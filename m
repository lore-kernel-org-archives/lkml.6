Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110AEC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC202146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgrekM/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC202146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLBDGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33815 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeLBDGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so7649839ljd.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjCRleG8di9Pc2Z7GsEkzTD2w0QLemG0losOcCHuzcc=;
        b=cgrekM/QsorFtbcUaVHMmtDLtCS1sWSFypoqEELuUVtiCLgK3yXWHP2AACh+0+eaRN
         cY40+f0uc107IPDbonPK8eAXiTxQ7escPATii4qaLB5RXljzRmBI/xHKfhdnwxC1ROfV
         t1ipStUXE+8RupmAynDtcqzPzynWEiv9D6rfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjCRleG8di9Pc2Z7GsEkzTD2w0QLemG0losOcCHuzcc=;
        b=e4PBqhqAAo+Fl8PSfebpMXqVKrHKAJ8PDyko1EDE/otEB34bQg2VRlz5IBNcHPoMA0
         RneUXg8RGklO43g1JL8IVbYDbFld71eePlU5SriMt5jp7uMc5iO8ckAsXwLUgMXik9oM
         KAQFtxw7AlTu87h1sjeVkBCxGj3wRkCkbDLo4K0IMENoehnyvRo1zBAQFUCm+C+E4kwH
         +4RALzdOk+14K+L2zmjSTgfJ3d6eytzDMGOjjJv4bcMGomkLer9b79g2GPwh8kWki5hz
         a/LARQeZg13yiTgYWSFtHFLT3zFME5zTVA2i2ROrP84gFutYn00k0s0Tw6amPDcKULNO
         p54A==
X-Gm-Message-State: AA+aEWYdMe+QriDdAM5VBccHWiqaYIAAO58vf7351DyIa85k38VTT7dP
        B5NHGPHnA9Wy1HhJbcxeXJBpYA==
X-Google-Smtp-Source: AFSGD/VhWpGaark7XRvdgdkKGg8jxc6ovOd6yf72L+/+6/4GPK+OpBvbiceZ3TibF7S3QD/GxJrJ6g==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr6038978ljj.1.1543679594169;
        Sat, 01 Dec 2018 07:53:14 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/13 v2] regulator: max8973: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:44 +0100
Message-Id: <20181201154151.14890-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
2.19.1


Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A0C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763C2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxGxj0Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0763C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeJOQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:47:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33854 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:47:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so13526032lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UCDDkhaY6HizuGQM6vGCKMWYjZl2QZuB37pX/99sSM0=;
        b=kxGxj0Tb/3+sRNcUCDkYdQ+Bc5OZ6MNO/OpGiGyVVuC+HpbD8cCdJqZdzaKW8sxOl7
         pdZJLYcGAbJt5FWdA6Ysw7GNt4HxDmMOGG0ZLBGqM4EseJ291ul07vDhJihRhSZxTgjc
         EDuyXD1YVWIgt7a10BGPk328J9+L0Ty30uGSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UCDDkhaY6HizuGQM6vGCKMWYjZl2QZuB37pX/99sSM0=;
        b=A2UxngnQ7GaYAFgluESK4gyzU0BM+CxI37v5PokIsuxaE7Vr7tm3k58+vUp+3xSR3s
         /U5EaiqSKffWUh5MEsDvLorOzFnQjVntOtfat2rxxM5W/ewxKVvoq0rjs0OngFY3PH6Z
         7N8wguwHVpwOpKGkgmXiRH5XuPCGxNOBqIff2aKKNCkTzf0DYr4mnd/Qv0WZmxki6dGC
         Gs3LeWfkRy+ynpZBpV9hYcOka0FZaUaJ/ZEM2E8vHgnO2A6eDuYro7nGpBHCdUYQAFve
         Yqw2glnRar/oy/8mAI79r05SqnRjep6n+JGyEie2hF4DyYgbU+Okv44aQeU6fLPzDD+c
         VO2g==
X-Gm-Message-State: ABuFfojjYfwsmqxPu79AnXKr3HtWRxxsesg9bqe4LbTeWoAsSx9vVBDl
        LeBld+OHN2R2TaV5v07QSXvtpQ==
X-Google-Smtp-Source: ACcGV61XjbHQVCALVMxSYitMPbGNI6tpMAudqJkTPjBkcTxg9SL5WWH/pG+Xouc9rMGV3/iVjFd45g==
X-Received: by 2002:a19:9497:: with SMTP id o23-v6mr9180481lfk.61.1539594164291;
        Mon, 15 Oct 2018 02:02:44 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id n195-v6sm2036349lfb.26.2018.10.15.02.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 02:02:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] regulator: Fetch enable gpiods nonexclusive
Date:   Mon, 15 Oct 2018 11:02:40 +0200
Message-Id: <20181015090240.8039-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the core regulator code is treating GPIO descriptors as
nonexclusive, i.e. it assumes that the enable GPIO line may be
shared with several regulators, let's add the flag introduced
for fixing this problem on fixed regulators to all drivers
fetching GPIO descriptors to avoid possible regressions.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/arizona-ldo1.c       |  2 +-
 drivers/regulator/da9211-regulator.c   | 10 +++++-----
 drivers/regulator/lm363x-regulator.c   |  6 ++++--
 drivers/regulator/lp8788-ldo.c         |  7 ++++---
 drivers/regulator/max8952.c            |  1 +
 drivers/regulator/max8973-regulator.c  |  1 +
 drivers/regulator/s5m8767.c            | 13 +++++++------
 drivers/regulator/tps65090-regulator.c |  1 +
 8 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index e976d073f28d..9a72eae4926d 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -260,7 +260,7 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	 * so clean up would happen at the wrong time
 	 */
 	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
-					      GPIOD_OUT_LOW);
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 6c122b3df5d0..8f68c7a05d27 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -294,11 +294,11 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
 		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
-								  da9211_matches[i].of_node,
-								  "enable",
-								  0,
-								  GPIOD_OUT_HIGH,
-								  "da9211-enable");
+				  da9211_matches[i].of_node,
+				  "enable",
+				  0,
+				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+				  "da9211-enable");
 		n++;
 	}
 
diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index b615a413ca9f..bbedb08d257b 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -227,9 +227,11 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return devm_gpiod_get_index_optional(dev, "enable", 0, GPIOD_OUT_LOW);
+		return devm_gpiod_get_index_optional(dev, "enable", 0,
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
-		return devm_gpiod_get_index_optional(dev, "enable", 1, GPIOD_OUT_LOW);
+		return devm_gpiod_get_index_optional(dev, "enable", 1,
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
 		return NULL;
 	}
diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index f2347474a106..553b4790050f 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -503,9 +503,10 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 
 	/* FIXME: check default mode for GPIO here: high or low? */
 	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
-						       "enable",
-						       enable_id,
-						       GPIOD_OUT_HIGH);
+					       "enable",
+					       enable_id,
+					       GPIOD_OUT_HIGH |
+					       GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(ldo->ena_gpiod))
 		return PTR_ERR(ldo->ena_gpiod);
 
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index f1e77ed5dfec..6c39fff73b8a 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -230,6 +230,7 @@ static int max8952_pmic_probe(struct i2c_client *client,
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_LOW;
+	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 	gpiod = devm_gpiod_get_optional(&client->dev,
 					"max8952,en",
 					gflags);
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 7cd493ec6315..e7a58b509032 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -758,6 +758,7 @@ static int max8973_probe(struct i2c_client *client,
 			gflags = GPIOD_OUT_HIGH;
 		else
 			gflags = GPIOD_OUT_LOW;
+		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 		gpiod = devm_gpiod_get_optional(&client->dev,
 						"maxim,enable",
 						gflags);
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 09a97a7093e8..219b9afda0cb 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -571,12 +571,13 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			continue;
 		}
 
-		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
-								       reg_np,
-								       "s5m8767,pmic-ext-control-gpios",
-								       0,
-								       GPIOD_OUT_HIGH,
-								       "s5m8767");
+		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(
+			&pdev->dev,
+			reg_np,
+			"s5m8767,pmic-ext-control-gpios",
+			0,
+			GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+			"s5m8767");
 		if (IS_ERR(rdata->ext_control_gpiod))
 			return PTR_ERR(rdata->ext_control_gpiod);
 
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index edaef9e4dc74..db714d5edafc 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -374,6 +374,7 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				gflags = GPIOD_OUT_HIGH;
 			else
 				gflags = GPIOD_OUT_LOW;
+			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
 			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
 								    tps65090_matches[idx].of_node,
-- 
2.17.2


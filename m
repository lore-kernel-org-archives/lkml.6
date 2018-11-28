Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18709C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMVgeJmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D336D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeK1VpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42337 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeK1VpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so18961948lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdQV+TtwR7nUQa2nhbCkXbp692jip7xowWS6qqziPL4=;
        b=ZMVgeJmnzdhwXVO/Tc+cwfs1zPRRsyfkEXSjNq4CJulE1Y7IB3f1RF6O/Yf+Pa26eP
         BF4JOzEd3Q/nZc8CM+XXlATF8nZc1RYpsvTA4sxn41UAdlqkofMDwRG+vVJaWIYmeQgb
         vXVCIAVp+/wg7h7t/JKe222qjV155CYc9ou08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdQV+TtwR7nUQa2nhbCkXbp692jip7xowWS6qqziPL4=;
        b=IlYT8t4ohT/M66KERBZJTBcUS2b2f6itEa3mQKmIvh9AQN4JoxcuJpIH9n18yMOJpg
         tTyLEpn7JxqXCFfM6UsXYtDQ/L8PLLmEgpOBXzq/9VeWJtMqL7rdUBm4bU3wp6yjvrd6
         JRMWgHged3dLKLmbVYj1RYkcavcc6h354Cvy93xK+ijv+iIASf8uR9MjLOnJBTYOowd8
         d6azyVNWHEwKLTIriVSxoR7eh/wJAfhqCHCzpYAwYOFcqYkwxRJCPY0mklsCy9gATmCa
         3HIxMbZtfhjtHELdDJ5Hc3OiPNLyl75HKdPCsOqYFmRvddHCMG3qHYuMl1B9s2ARpgOv
         70gQ==
X-Gm-Message-State: AGRZ1gLsuMX0tO8mHxturHQlJfSRlUcDWgE/xQbjMoclTId0MSYOPBtD
        8N3XrprBCgoSu7non+z3j4fnfQ==
X-Google-Smtp-Source: AJdET5eM4ujn95aHXYyyIMN4nRlc292ojuuvushxi6naj/AtTT8O9EkFozrY85GdFIY7pwne4MhxoQ==
X-Received: by 2002:a19:5e5d:: with SMTP id z29mr20746732lfi.105.1543401846138;
        Wed, 28 Nov 2018 02:44:06 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:05 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/10] regulator: max8973: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:45 +0100
Message-Id: <20181128104350.31902-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
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
 drivers/regulator/max8973-regulator.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e7a58b509032..6e11324cb9cf 100644
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
 
@@ -759,9 +759,9 @@ static int max8973_probe(struct i2c_client *client,
 		else
 			gflags = GPIOD_OUT_LOW;
 		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
-		gpiod = devm_gpiod_get_optional(&client->dev,
-						"maxim,enable",
-						gflags);
+		gpiod = gpiod_get_optional(&client->dev,
+					   "maxim,enable",
+					   gflags);
 		if (IS_ERR(gpiod))
 			return PTR_ERR(gpiod);
 		if (gpiod) {
@@ -798,6 +798,8 @@ static int max8973_probe(struct i2c_client *client,
 
 	ret = max8973_init_dcdc(max, pdata);
 	if (ret < 0) {
+		if (gpiod)
+			gpiod_put(gpiod);
 		dev_err(max->dev, "Max8973 Init failed, err = %d\n", ret);
 		return ret;
 	}
@@ -811,6 +813,8 @@ static int max8973_probe(struct i2c_client *client,
 	/* Register the regulators */
 	rdev = devm_regulator_register(&client->dev, &max->desc, &config);
 	if (IS_ERR(rdev)) {
+		if (gpiod)
+			gpiod_put(gpiod);
 		ret = PTR_ERR(rdev);
 		dev_err(max->dev, "regulator register failed, err %d\n", ret);
 		return ret;
-- 
2.19.1


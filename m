Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE76C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBAF20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nz0VKdjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBAF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeK1VpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34897 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeK1VpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so22982008ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFUKjxTT9vhRdoORnKcL1go1+WQ1lrKrvE6sIAkGI9I=;
        b=Nz0VKdjCMqLGPbYKRJYOxaVnpQh1k58x0DVVOkjpY1BI3lwBX4HROZeN1QPA8vhlwp
         Xjg2dlpHd+vr6o2tPZT4t1T9ZjTOcMsmCdDC+dmQX/6YjAMaAqmlYtFYfvfBRtNo3bdZ
         D7pR+uGNDF41vynPtMgm0C+Z3M58qyv7tSPQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFUKjxTT9vhRdoORnKcL1go1+WQ1lrKrvE6sIAkGI9I=;
        b=jhg1CJj/XtFu9RKpjhAjkUZFS7Nb1uHqu/NeP8hW7X7aJRFBdPzFNBEBjUg8NVMR48
         aDdzm7NHA8v3+ECuTmR4jRDVU5kqfvl7p0KbK38OPFn8I7ArT7E1kyCLkdTI5tqjRFpO
         GIn9zYDWZVLb1Tzr/Myw0KKQYgiGaXp8FtjutT1eQ1DjZWwI7R2utfLYpXXnzDSmW7W9
         lkfACSHL56it/xd4kEnfm9TixYM7P7aeGyycBdVb0D2qhWQbmUyhBPISQ6Kgjeeh64J1
         dleXLdb1m7S8d2lDr4lsW+feOpmPQQfuiQXbSz+kZP671uCkT9WbSM0aF94dYBiA6rJx
         /TeA==
X-Gm-Message-State: AA+aEWYIfMFD86aIRgW1xHqDzSzYFPGM3qoyOXCewdvIlJghV+khJLui
        2jq/ihAMQDFbDqZruQqfvEeqYnzKi4IDmA==
X-Google-Smtp-Source: AFSGD/VkjgfG60Lmh23capoW6HY10ztUylfK/4vuPQxBzNpa9IUJSh5sJQ4ii1ck1uivK4zoMU0UWQ==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr22072216ljd.45.1543401844472;
        Wed, 28 Nov 2018 02:44:04 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] regulator: max8952: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:44 +0100
Message-Id: <20181128104350.31902-5-linus.walleij@linaro.org>
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

Fixes: d7a261c2d1f2 ("regulator: max8952: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max8952.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 6c39fff73b8a..baa8b771a6e4 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -231,9 +231,9 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	else
 		gflags = GPIOD_OUT_LOW;
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
-	gpiod = devm_gpiod_get_optional(&client->dev,
-					"max8952,en",
-					gflags);
+	gpiod = gpiod_get_optional(&client->dev,
+				   "max8952,en",
+				   gflags);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	if (gpiod)
@@ -241,6 +241,8 @@ static int max8952_pmic_probe(struct i2c_client *client,
 
 	rdev = devm_regulator_register(&client->dev, &regulator, &config);
 	if (IS_ERR(rdev)) {
+		if (gpiod)
+			gpiod_put(gpiod);
 		ret = PTR_ERR(rdev);
 		dev_err(&client->dev, "regulator init failed (%d)\n", ret);
 		return ret;
-- 
2.19.1


Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946BAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FC22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9VamWUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FC22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLKJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:53:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39098 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:53:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so10284704lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6ItMC8Daj1okFQsaf/UZWIovBp6EzsjnZ7CGkAZOD8=;
        b=S9VamWUwSd59nVvevQ/hG3Wg4Mjm+YocI2xbfu/GMRGsRyPcsyjFqVBwLtCo1uuM+y
         yLc2WF5P1JUdiCMzGZf2k7Cj2ypX0UJgTUcyz/I3nk2mtlfyfqQ5uBCG87C3O3Fk2PHS
         WoHnn6r/YKqiGuHwXwoq7duEeNvWmQS+IeTvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6ItMC8Daj1okFQsaf/UZWIovBp6EzsjnZ7CGkAZOD8=;
        b=YzHJs4a5IqzoeUiUdS87PWbtaqiJlN644unteU4bU/s4V/vUbWQiOdctAJShqy6/SR
         irIYenepKgid7Jd8v8GB6aG+GFBMb/sGj8kxfc8Ko5yYlby4sz+qr8wl6TQYv4ZpmV5F
         oYlymGfjBe6wlmQotJaZeN5/R5FJGigNJIK0cyWb2ZDcuDniPFQH8AO1N7NFYe5MFmAG
         vTIBAe2qK15/MMHSvj5bwxqQMplF1oT0UY5YPMmkCCzq3SCVbovjq2z//lst9N/+781u
         Z+2Phx9LuJRsMqm0i5c9l0UZTfNoAd9z1/6LdC0NuC/c51sEVkKakYDea8avqTyJPM9s
         b07g==
X-Gm-Message-State: AA+aEWY96UAunb6805w643yvDUuV3c+h6+D4APQY/apUXe1Rpa6KK6Nq
        tJm6myMQUL6+NfA8R4KywGV56QJNh6kQpA==
X-Google-Smtp-Source: AFSGD/UyW7hEqMeVcowKo9C7AoW3uPBOwUb2o0w7Y5G1BEGcIsjpHFNni5YiEhceBsSCIK58b+Dcsg==
X-Received: by 2002:a19:1019:: with SMTP id f25mr8691342lfi.54.1544522004224;
        Tue, 11 Dec 2018 01:53:24 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u30sm2740505lfc.90.2018.12.11.01.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 01:53:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] regulator: wm8994: Rely on core to handle GPIO descriptor
Date:   Tue, 11 Dec 2018 10:53:18 +0100
Message-Id: <20181211095319.11393-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After making sure that the regulator core always take over
handling of the GPIO descriptors, the gpiod_put()
on the errorpath of the wm8994 driver becomes redundant.

Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/wm8994-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 46e6b4ee1491..38928cdcb6e6 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -172,6 +172,11 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 		ldo->init_data = *pdata->ldo[id].init_data;
 	}
 
+	/*
+	 * At this point the GPIO descriptor is handled over to the
+	 * regulator core and we need not worry about it on the
+	 * error path.
+	 */
 	ldo->regulator = devm_regulator_register(&pdev->dev,
 						 &wm8994_ldo_desc[id],
 						 &config);
@@ -179,16 +184,12 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 		ret = PTR_ERR(ldo->regulator);
 		dev_err(wm8994->dev, "Failed to register LDO%d: %d\n",
 			id + 1, ret);
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, ldo);
 
 	return 0;
-
-err:
-	gpiod_put(gpiod);
-	return ret;
 }
 
 static struct platform_driver wm8994_ldo_driver = {
-- 
2.19.2


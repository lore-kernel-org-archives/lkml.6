Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C34520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="INbC4BzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C34520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeLFMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34505 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeLFMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so262885lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4y2b8gfjVdDJn6awlRT6qg9t1Md297IZ+m34M/dErEA=;
        b=INbC4BzPSiBO1R9J+pKLcyUU3/vHy0yg3IarqReUW6CnBPkVWAujz8muLjx44C3Hb5
         fYQa/g7RQ9A+C0JGdv0fS84V2zG72nmF6Bp1bTJZzELcq/GqtoY2qRMwT0pOF21EJ1GY
         vwXOy/b7874WUOMW3jep1wUr77MhxaB3nWdxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4y2b8gfjVdDJn6awlRT6qg9t1Md297IZ+m34M/dErEA=;
        b=WzWSFR3te0KfWUhUOG9prw9RWgoJQTR3Z1w36DVuse2ZBkQk03FzYfCCtAcnvjbx/2
         gHFHnAXsTwkbMEppn8FSuuucBQkg8PDQnW1b/7isd/MZzEfS4OfojLlrUIk3139sGWwQ
         abRZ/bA5brfKZ4fxIaayuSsiWlv05AKNQoj82A9Yb0KWES3l1Dk6doC1iHOxTors1oTC
         zNFTBwQtnUNvoJU3Mgybos3ncyhRCUKoCoc6iiEHq3mCt+tc4AewxWLM2EYZ+hdqra0/
         GJp05MWNfj2lScm9RF8VOy/vAnVWTLzxlGFmJ2REklhQ0TsOskSzckKTIbP1o3d5WOF6
         fHIw==
X-Gm-Message-State: AA+aEWaegiI54oeOgL9OVa4fdjI/2TIJKICpYXM5yU9lRu4D1v0VgA6d
        3s5Q660e6gWsHLxh0SYA6WzhKw==
X-Google-Smtp-Source: AFSGD/WmxLAA6I/ghn2bnJvkfjKFzxzAP1tcIUf0ZfReY6i2Z2NAIOL9x1n06PK79DbjeSXJ//jK3g==
X-Received: by 2002:a19:641d:: with SMTP id y29mr15632212lfb.14.1544100263304;
        Thu, 06 Dec 2018 04:44:23 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/15 v4] regulator: max8973: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:47 +0100
Message-Id: <20181206124351.10155-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe path of this driver is a bit complex: sometimes the
GPIO descriptor is passed to the regulator core, sometimes
it is not.

To handle it in a simple way: stick with the devm_* resource
management and unhinge the GPIO descriptor devres handling
right before passing it to the regulator core, if we pass it
to the regulator core.

Fixes: e7d2be696faa ("regulator: max8973: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Stick with devm_*, use devm_gpiod_unhinge() to handle the
  descriptor for lifecycling in the regulator core as suggested
  by Charles.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Fix the second case of devm_gpiod_get()
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/max8973-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e7a58b509032..9aee1444181d 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -808,7 +808,13 @@ static int max8973_probe(struct i2c_client *client,
 	config.of_node = client->dev.of_node;
 	config.regmap = max->regmap;
 
-	/* Register the regulators */
+	/*
+	 * Register the regulators
+	 * Turn the GPIO descriptor over to the regulator core for
+	 * lifecycle management if we pass an ena_gpiod.
+	 */
+	if (config.ena_gpiod)
+		devm_gpiod_unhinge(&client->dev, config.ena_gpiod);
 	rdev = devm_regulator_register(&client->dev, &max->desc, &config);
 	if (IS_ERR(rdev)) {
 		ret = PTR_ERR(rdev);
-- 
2.19.2


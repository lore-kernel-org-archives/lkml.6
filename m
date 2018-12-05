Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD92082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7K27khP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CD92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeLEMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34068 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbeLEMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so14619947lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kaSioRZMdN3SegrcZ9FLbUcYPNWPye8wQmfXmSzf3g=;
        b=B7K27khPwEWSmKMr04bv9k4h3qpmIbyBbsn16ZRdZtsUWsIvKWNLq85f4OgSdCPa7K
         n5MF/4HYh+d9uY6MykHFLPGoL00CDbtGig+TNkPL7+vDiI8RDG4G8w/9sHfWhe1hrhI2
         PWtZbdR4U6gz9aJHxJ9/IORImw1dYcXrJipCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kaSioRZMdN3SegrcZ9FLbUcYPNWPye8wQmfXmSzf3g=;
        b=UVx3YJzcXqiyAAKiBspexun57yLNIgbE0IqvVNLvHLenGBNDyd0/QPBNNDJuTgH2oF
         kb7g5d8vu6Ns7mFJOOliNo1p9VMtiqyCYgapSKHEVoUIKaPcZY4dgmINECAyzg2kBxC9
         +gLOLhfQd0Y2/t6cB9BCV4snqY1T/QlfE2RRVb5JQU4TqVi2G/NspkPxP8V6tSSPwade
         jKqXm6sUSwo/AWSG2MyMFHj4J8efhHv8XtjVojSl+w0+aE4hB8g5yiKEKiKdqDGzNkgF
         Ssy/TyJgMJ8tiqjd1kJFejL+VP6ERo6TQAwiwraO8CMirzwoZJVq293nxJ+sUzpPF+dt
         P3yw==
X-Gm-Message-State: AA+aEWaVnmgjgs/vr+qQf7nNCXqQp4Keujj0+yrkXhdauZhsL/NG5cui
        W5j/6oGv7z4HjBJOLMsWau0a/A==
X-Google-Smtp-Source: AFSGD/VwCrldnI5b/xKqyrJJZDUmczJxEm1R+eoYqrkdAphWVanmcReTMKSr7J95Uq0u0jLmE0uOqg==
X-Received: by 2002:a19:2906:: with SMTP id p6mr13910692lfp.17.1544014074729;
        Wed, 05 Dec 2018 04:47:54 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:53 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/15 v3] regulator: da9211: Hand over GPIO to regulator core
Date:   Wed,  5 Dec 2018 13:47:18 +0100
Message-Id: <20181205124721.26624-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the DA9211 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- New patch handling this drivers GPIO descriptors properly.
---
 drivers/regulator/da9211-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 8f68c7a05d27..109ee12d4362 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -389,6 +389,12 @@ static int da9211_regulator_init(struct da9211 *chip)
 		else
 			config.ena_gpiod = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from GPIO devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(chip->dev, config.ena_gpiod);
 		chip->rdev[i] = devm_regulator_register(chip->dev,
 			&da9211_regulators[i], &config);
 		if (IS_ERR(chip->rdev[i])) {
-- 
2.19.2


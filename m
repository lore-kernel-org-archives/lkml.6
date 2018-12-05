Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A524AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681A2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVl/6G5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeLEMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41430 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so733769ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDXJn4r2s+zy7VrlG4cSBIGqxAHZiQ7TczOaY5V2Rm8=;
        b=XVl/6G5S49/iWZPpOwxE5k94KUzcEZDoQVae5FXyOYLmyvWIpfcP98MVEKl3BWCwcr
         7J28orekYDmunAVYBsEVT/Xcfvb6EnC+oOB9pwRY7e6/CfSfJORwhdpW6tu42e3cQukr
         tyPNQR9r80hmaaor9rRmUMXRISMJt6UAgZqHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDXJn4r2s+zy7VrlG4cSBIGqxAHZiQ7TczOaY5V2Rm8=;
        b=jT5o51TkB1S7uFrCV90c+xTTrJMAf6/4d8cJZW0RbBicePfYD7PSyXIbf+yl5B+mdI
         oSpTGpaamnRscIliS3hFmZ/dcZr6MlC1w224U+SnLEn7bL9I571aNsb9OOeWs+A9xJe6
         CT/07pAbWXyRemr3OwOe595DnPEQOU/ACyeLpNgGp4Z6tCliArJ0AyjIE5MwnCCBvOQD
         eRECqMBoPiuvtkeIWdZkNKPYHsAo+7Kr0hPNOAB+E2djvwK64SbWN6fI5Kyhm4S5NO8V
         Ig6Nzrtcyj/xSHVgEaYfFGEV2SEmW/h8nwxJMTr9QhzPAFVwPFfULzRca8ivfG0ohWeg
         L99g==
X-Gm-Message-State: AA+aEWa2Ggwv2XDZ79NhGvu6tFv7sV8YCB7VjKI/1+iD4AKcXpkuAlpJ
        QxvPfOdr6e8h2V+379GBLPYg/A==
X-Google-Smtp-Source: AFSGD/WGHVy5I5rxK0gikwzdKoN9xh8/0PJrCVpNpq25qplamJ7mz109qPzSJc6wC5kbLKfgfMHCuA==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr16955090ljb.51.1544014076783;
        Wed, 05 Dec 2018 04:47:56 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 13/15 v3] regulator: s5m8767: Hand over GPIO to regulator core
Date:   Wed,  5 Dec 2018 13:47:19 +0100
Message-Id: <20181205124721.26624-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the S5M8767 driver are retrieved
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
 drivers/regulator/s5m8767.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 219b9afda0cb..d1edd8c2bcec 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -956,10 +956,17 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		config.regmap = iodev->regmap_pmic;
 		config.of_node = pdata->regulators[i].reg_node;
 		config.ena_gpiod = NULL;
-		if (pdata->regulators[i].ext_control_gpiod)
+		if (pdata->regulators[i].ext_control_gpiod) {
+			/* Assigns config.ena_gpiod */
 			s5m8767_regulator_config_ext_control(s5m8767,
 					&pdata->regulators[i], &config);
 
+			/*
+			 * Hand the GPIO descriptor management over to the
+			 * regulator core, remove it from devres management.
+			 */
+			devm_gpiod_unhinge(s5m8767->dev, config.ena_gpiod);
+		}
 		rdev = devm_regulator_register(&pdev->dev, &regulators[id],
 						  &config);
 		if (IS_ERR(rdev)) {
-- 
2.19.2


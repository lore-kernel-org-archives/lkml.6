Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3EB20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK6zz3sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3EB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeLBDGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36432 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeLBDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so7641404ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44SPP0BIPcyJprau3J/HnN7hoNM3OEVwqSrrtldr13E=;
        b=LK6zz3sXhQ6zMfd6xPVCcwV+AB03r2QF/4TreQ7SOnGwmct1GuZSJvvfH8UzvCEAu5
         YyVU3YXxCGpbPzh5z82lpCiD0SBw/7fXw7ykD6zf2KNC6x4/5bm52PYIp38Ko+PzuDKw
         VYLVz8MrsciLV6eQc2WPKfwwagY0/gikp9GGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44SPP0BIPcyJprau3J/HnN7hoNM3OEVwqSrrtldr13E=;
        b=YPt766hz5wno4z1Z01Sob4Qsp+5jSPcfRhCtXTC8iwYJeA+f2fUgl7aekp11lkzS0s
         22mBRBpTlKVSlqap/fbkQ4YjJlyy+JyxTsnXzIb+Z4nK0u4PfGp3X7xYVG9kjo4FHK0q
         xcK/HrAa7Ff4PAcBozK7N2oYx3m5KYZJyVwqOcAjmqPtUZy2RYrOm2ndr7TcYYk9+Ap1
         +sO8/+G4ijqhgvIR3/b1akeSzDrq2eoOiMS/9WzsTR8wo91samyy2qe2ANM1z8jE+f6/
         tmj6P8chKCPiGrUDuvRWjlWY7FzKiIiNaUyokv6aeXs7XcFsbBvqfYT0032yBeHzzBlw
         +5hQ==
X-Gm-Message-State: AA+aEWYTLpIQj69rnQmcRHBEIh7JgSkOIUtXfyhaY7BRa2DsyeEbPMqv
        3He40nUeZQ8rx8lI24cJpvzb4A==
X-Google-Smtp-Source: AFSGD/X07gsfu9yJFE8BUI1Kx+J1cOaoru/8A7AtS3jMWmfMU4SO+j1rr/wFNv8FnjQWQvo2HYm2ug==
X-Received: by 2002:a2e:9a56:: with SMTP id k22-v6mr1977164ljj.17.1543679605045;
        Sat, 01 Dec 2018 07:53:25 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/13 v2] regulator: s5m8767: Hand over GPIO to regulator core
Date:   Sat,  1 Dec 2018 16:41:49 +0100
Message-Id: <20181201154151.14890-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
2.19.1


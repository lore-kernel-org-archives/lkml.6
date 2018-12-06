Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B47820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEoEamDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B47820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeLFMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34490 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeLFMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so262513lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGdG41X/n1r/5ZJbvZ7uuuwkxYAx3vmZpL8IIUge2Cg=;
        b=cEoEamDOJyLyhIXSAcJMkITLJvl5A4GFRyZHi/JsUzQla3+KgMqYSyqfzX0hrBgqca
         cV+C1eb9qjhERcqSeXkyU6Fau6T3+SOAT2j4qOKDlpdI6VjdjeKYqeh4N8BSgAORz7hu
         IGDMdfNWDNt+A+0O/vWMWTYZE20pRK8s4fNtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGdG41X/n1r/5ZJbvZ7uuuwkxYAx3vmZpL8IIUge2Cg=;
        b=Gx4c8QEEbUW9ev4uQ9ZnMZxvH8GbFsi1H+8lgvOSqmEPz/p2v0CdYLCwKKGOT6U7B1
         fcsugL/i6opX+LhOm6e02CPLWX3zE4azHHEfTOzcs4vIZK+3P4K+xNHVbYETZL1IbJja
         mR6dMzFkiddk32lTpSn8wCimzuoYEH5KpXXgKl+rF1cs0Iv/bG/Q+YLQw8n6S0Bz3M2z
         8X93pvTIngnBs4H64vZuf4zMlV5joJJlk1phYKZk8HyvTMSNcwsjWCVXY/r+iPhF9cbL
         fCEIqiqWAEdupX9rpp7N/8YcjuDxMsJ9FNlnj7kNJPSzxzIVt3tijsN5wpk4pOWUF0Iv
         QjIQ==
X-Gm-Message-State: AA+aEWbOwEfwkutZCjSXPH1MSj744wUeU/JsJKd5Ahry/6F/hCupaVYQ
        /ud6WkVJ3e9Wr4P0s9DRYMd7Qw==
X-Google-Smtp-Source: AFSGD/Wd2Tc5bXvFMifkL3qq8vhkP8ceAPySEDtNJzZyXegftPRrY6C09g2zKPgkixViyxG5ICUYCA==
X-Received: by 2002:a19:4345:: with SMTP id m5mr16370319lfj.142.1544100254402;
        Thu, 06 Dec 2018 04:44:14 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/15 v4] regulator: max77686: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:43 +0100
Message-Id: <20181206124351.10155-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

Fix up the errorpath so that we free this descriptor if
an error occurs in the callback. Rely on the regulator
core to deal with it after this point: a previous patch
fixed up the regulator core to properly dispose any
GPIO descriptors once you call regulator_register().

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Handle the errorpath (hopefully) correct, back out of
  regulator registration by freeing the descriptors of all
  not yet registered regulators.
---
 drivers/regulator/max77686-regulator.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index f5cee1775905..8020eb57374a 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -250,13 +250,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 		struct regulator_config *config)
 {
 	struct max77686_data *max77686 = config->driver_data;
+	int ret;
 
 	switch (desc->id) {
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
-				np,
+		config->ena_gpiod = gpiod_get_from_of_node(np,
 				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
@@ -271,9 +271,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
-		return regmap_update_bits(config->regmap, desc->enable_reg,
-					  desc->enable_mask,
-					  MAX77686_GPIO_CONTROL);
+		ret = regmap_update_bits(config->regmap, desc->enable_reg,
+					 desc->enable_mask,
+					 MAX77686_GPIO_CONTROL);
+		if (ret) {
+			gpiod_put(config->ena_gpiod);
+			config->ena_gpiod = NULL;
+		}
 	}
 
 	return 0;
-- 
2.19.2


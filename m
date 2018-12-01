Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017FDC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCCC21479
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtUGzzrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCCC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeLBDF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:05:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33807 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeLBDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:05:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so7649671ljd.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw5DmJYSpDmuJznmwAMRHQCtGgWe5nKFfzGdrXYI1X4=;
        b=KtUGzzrtlk2DxLtkU0GSvQOAnNzIWPXRRGKfQe2yVbwdXt7ofrw5D7dZ8ce12OaLCS
         unXZVIEy3vPQ16kqH5pI9yPTK5v/QOf7A0D/cUQQmPmHNSyWQnpzvMT+Mg6n5OHACWKu
         Mu+sU2Hzi82ZRIhvlvRDcvy6bW5MtXlNd00RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw5DmJYSpDmuJznmwAMRHQCtGgWe5nKFfzGdrXYI1X4=;
        b=KHvq9rfhICsOYHnL1U75pI36oQ55/oxT07883cNxA7trj9/Am69nZCEfB1xz41YsCa
         CoxLXei9OOc4KoSBz4SrmNNE6nxDf2QTeVw40WKYtqZtNZ2kkMGYx+7HlAC8qgfMcVPY
         L7wYGF/wU2YAz/FyG9MLusSKz/t7Zq4tYxdH2Pg0Joqay7mzezF8fVpK+y/GY4NEHbv0
         51d+E5ldFknBjwMVNvmHgrmEXpCPw1+L+GOa2L8DHOaytVek4Vzm3T9DPbZyW/MqkbBG
         PUCJ12XjgrnhASQZkxdHh9b5Qco0H1BRH8vor/KsPoh2xTxplWFYkBLIDOO6Eh7zMBAu
         klBg==
X-Gm-Message-State: AA+aEWYa4CNTMs355+4jd8qrYVgWP/ZEqrFyT+9uYHJvu6zqUlDXuLmc
        y4OhKAKParS9acerRhnLSha1qw==
X-Google-Smtp-Source: AFSGD/U3MK86JakjWAsGIAPOydF4Fu1ZuFebohW+lO98c3aYHQuBhpACEc2ZaU+lRM0KzWxfWxfRZA==
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr6836862ljf.123.1543679587802;
        Sat, 01 Dec 2018 07:53:07 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:06 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/13 v2] regulator: lm363x: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:41 +0100
Message-Id: <20181201154151.14890-4-linus.walleij@linaro.org>
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

Fixes: b2d751b7f69b ("regulator: lm363x: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/lm363x-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index bbedb08d257b..8c0e8419c43f 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -224,13 +224,15 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	/*
 	 * Check LCM_EN1/2_GPIO is configured.
 	 * Those pins are used for enabling VPOS/VNEG LDOs.
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return devm_gpiod_get_index_optional(dev, "enable", 0,
+		return gpiod_get_index_optional(dev, "enable", 0,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
-		return devm_gpiod_get_index_optional(dev, "enable", 1,
+		return gpiod_get_index_optional(dev, "enable", 1,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
 		return NULL;
@@ -263,6 +265,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 					 LM3632_EXT_EN_MASK,
 					 LM3632_EXT_EN_MASK);
 		if (ret) {
+			if (gpiod)
+				gpiod_put(gpiod);
 			dev_err(dev, "External pin err: %d\n", ret);
 			return ret;
 		}
-- 
2.19.1


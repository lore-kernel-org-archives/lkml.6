Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90D92082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ma63Pt9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90D92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLEMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:47:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46134 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so18174964ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYp3S/IRQJmcBgWx8RZhYl171BsROIDwACkCZb3Iuv8=;
        b=Ma63Pt9BEM9ip4CwNsk4DDecTc7sh8LyWBa5bjzjs/mLmRXXUlgqSkEp97IEyzAot5
         XZyC0cwZol6hziuA6SHd3eElxXMpxsmT7qrt9YedFlkuFLx04PXkR/N79jCbDrnwF/wJ
         uCybcGNUAI4X7Asurbz/OLrTaIFKHkiHhFxLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYp3S/IRQJmcBgWx8RZhYl171BsROIDwACkCZb3Iuv8=;
        b=M+7Bn+vVKrHqjGTRsHqWkk2l2BvmgnJCeNQ2PK1DWvf1EwAJl9k198a0Mvul52ZB6j
         EAqOhzjlagt0HVepkL6jKpsoOyxSney+NfB/jJ+QB9ax4YXytJV7pWXPJCAD3Y+7pgH3
         2ydDSHOh+ZNVpj/F9RsxtsqBsARQderdUDfkDB78Namx6nKXXoChYtivCA6ayRwC0wCz
         k+Okf9FFQuGi+5Sx4KqpHXKyGWLk2LyX6ikz6+oZX9t/6zvzzZdCNFUWSy7bc9WRuBu2
         dLyyRHjfHYKvPaq6SReAInl55+GpI8NyxQLWLUK9Kz6eTRaQAop3h8BxqL69HRDEP7rm
         iVbA==
X-Gm-Message-State: AA+aEWbTx9YSh3eZj8ayD5EhPWVFKQS4m5U0UqG6aTV1S3FwYtXXPGyM
        WzgYwE8mAXy8pdQkKUaOMU44Kg==
X-Google-Smtp-Source: AFSGD/XVraC03scd1noWHVeyg80f5kVjt3kUtrp3xhxyE72qbnaGlrspBuZM/sJcQie01xEJOtPPig==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr4227555ljb.52.1544014055704;
        Wed, 05 Dec 2018 04:47:35 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/15 v3] regulator: lm363x: Let core handle GPIO descriptor
Date:   Wed,  5 Dec 2018 13:47:09 +0100
Message-Id: <20181205124721.26624-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Resending.
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
2.19.2


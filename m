Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A52C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFFC2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kk2RKmpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFFC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeLEMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:47:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36129 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so18205769ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OGUaW4HLWctMtQHrwOTqPJRU9A2u+9w8AwyRoL6A9Q=;
        b=kk2RKmpxsDFy9cCP5k5caiGO9Qhtr1lHPXPRw8dCeOcUUm62UcM3SP3Bl6qtbvzZKP
         cVwO+w7JMLMh+HJSUznc+UBCbw6P+TIF5x4K52zB/XmvK2mbok1Xq+lGWlXx4/fc/j1a
         Z/Z0W8QfRHJx0H7XnqxEH8BAsRA/QF3+OuBLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OGUaW4HLWctMtQHrwOTqPJRU9A2u+9w8AwyRoL6A9Q=;
        b=eKusSEeU1i2K04/IgyRD1s/BhUKd4f2PtuwnFSCDdcIrpsrDiw9MtGpaZCBuEdOImJ
         SmbzEZ92GkvAY6LCfxiXK9zJ/b1ijf+H3+eG1NWoH1vXmFNhEzBfF08+bkRKacAC70ru
         9r5y0nKCn/70C8wCXSSQ9E1PxB37fd31suW2YG6y/1DcyF1jCyYqF3P7eGmKWa6SbAUf
         rdJt7xAjW26oFAf0P2Guku2dPZwR2g5Xy7fronxopZLSqjrxhb9jRY5YaCNj01GLx4IO
         U8lYSMHHLmTHjHDWFb7haCJF+7o90HP7E+y4FUyfb6Okh2PwgHgjAl7DRhtMPTMfppv4
         UgSQ==
X-Gm-Message-State: AA+aEWaz/pNGs+U08quwUUVXO3NcLC2809qGnsoj/5+TlXvtcS7GX5if
        2e6VIPd6OPk/qe8wI23+ygri8+KgpQNs1w==
X-Google-Smtp-Source: AFSGD/VsmSjYh9qKV7sx74yVwdgVEpDmEbqamrCqo5Wb039INRYHxyQaELGbKYxe8GOYtR4Vt3wV6Q==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr15122517ljg.164.1544014068137;
        Wed, 05 Dec 2018 04:47:48 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/15 v3] gpio: Enable nonexclusive gpiods from DT nodes
Date:   Wed,  5 Dec 2018 13:47:15 +0100
Message-Id: <20181205124721.26624-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes gpiod_get_from_of_node() respect the
GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which is especially
nice when getting regulator GPIOs right out of device
tree nodes.

Cc: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: b0ce7b29bfcd ("regulator/gpio: Allow nonexclusive GPIO access")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v3:
- New patch after Marek's review.
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 230e41562462..a7e3fd512e2d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4204,6 +4204,8 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 	transitory = flags & OF_GPIO_TRANSITORY;
 
 	ret = gpiod_request(desc, label);
+	if (ret == -EBUSY && (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
+		return desc;
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.19.2


Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F81C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B698420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwUeMEPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B698420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeLFMpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:45:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41151 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbeLFMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so231216lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UCfXd8FomOG2PyW0T35K10v1EsE1DAdxPlQYdOdXf0=;
        b=AwUeMEPsVL8O86NQN8PsH4kGpM4py+TWzmkDBMtuAcU1F5sAcjIlVPvSbvyteBn817
         xrYEvA0ELxHei6jvJB5vhlZ2VrjkXFLTkYKLE0s8jUBTL/MtSwuTITyplP+PLUIP0OAL
         2ZIQpZGdq0SioQ9GsY3XrX2ohrebkA3+ns5Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UCfXd8FomOG2PyW0T35K10v1EsE1DAdxPlQYdOdXf0=;
        b=VW3UDWzyKW+m7y9wvsWbLu5UsCRUW85uTvUxxCc6BS2XPZENSrNtIJlX7bsTF5JtEW
         0dvoN7GWittQ5kW4jINWD18jFJJ7u9b/HaCHr5SggWtKF8NevG8/AZxW9tDA8jiLiWwp
         1gy3TR1w3Sp4RKIbYfWi3gaXpl6dM831wNvWtsgw2WuMWS4XB0+mRMnXsvqjEmcEKTxh
         8T/MeA00rlNCwo/nqdLgBs5ZGFMeJzC62Z25iist8cpLr2Fk8m80L6bX60W8//vclm87
         /hHs1zNq7SzbKFLESFxiY5IMvPiPQIqLR4g3yzYF2+Q9RUcv1buq/dCG9oT9gdiLfNNN
         9JTw==
X-Gm-Message-State: AA+aEWbrc3Ke8Zpq8vwvc06rDuoFxwN4QodsWykmhs7EONKVSUJaLjKg
        lNVgvYAeE1Pgu4PUCdTLyD/DuQ==
X-Google-Smtp-Source: AFSGD/WFvjkg5t0dl5XIVC7nr6N9rQLePXfIyQVrbLGzqhwL7uqNej+XcY9IfzZgzPhLBe9lCmE9DA==
X-Received: by 2002:a19:1019:: with SMTP id f25mr16368839lfi.54.1544100256624;
        Thu, 06 Dec 2018 04:44:16 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/15 v4] gpio: Enable nonexclusive gpiods from DT nodes
Date:   Thu,  6 Dec 2018 13:43:44 +0100
Message-Id: <20181206124351.10155-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Resending.
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


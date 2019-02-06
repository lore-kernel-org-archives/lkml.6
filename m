Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C221C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485F2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfBFJjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:39:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35108 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfBFJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:39:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id 132-v6so2834925ljf.2;
        Wed, 06 Feb 2019 01:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhIIaawKxXGdGw9tURA71dsUwy7rC8b83r901j6v9IA=;
        b=sY4zS4DgS7WtkRJ5glee772Uf7aTQzkBFAmt1qTjmGM6w2lQ+tWr7lbXtqcreNYkVc
         qhBPBDvic25bDMM+nEWIo6LGGtjY8M8cDsgEgUMWtGgmmFHMxTl3BBw5EiEDeYVb23rP
         aH6qpz4nMPebbVo7Mr0RJlMfgt/fFQi7H0f2gnEw+81L6bIcFoDIZShKsSfpx4VKUxjS
         HoooAEKqSnRnfKN98mWshEkmLTQTwuW2+fNLpOQJecUQbARXRBDnKl2Y7IaraJi7EVWe
         GqlK51+RIxWY2zxzRZaTNrRVR2hLk8l4zckZuIVehnKZ4UrZOPoL4uitTqEJmCIGuMKN
         bRkg==
X-Gm-Message-State: AHQUAuZ2XNa4N+p9f0yXXn87TYDdFHtIoH69dnempBAd/C266egUL6gK
        UISeqAQfpkh1oWSxe882L5A=
X-Google-Smtp-Source: AHgI3Ib4RLP8hXHJfmYxlSQdJoD51oLFdkZFao2l9Nijfb5ff1kWxxItEwUgOv/YCk3fdAUtB5ZOjQ==
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr5728758ljd.156.1549445947312;
        Wed, 06 Feb 2019 01:39:07 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l124sm1412032lfb.2.2019.02.06.01.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 01:39:06 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:38:54 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v7 03/10] clk: bd718x7: use chip specific and generic data
 structs
Message-ID: <d30e869929638cb4907e52222124df8250b0980c.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the clk driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-bd718x7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 60422c72d142..461228ebf703 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -17,7 +17,7 @@ struct bd718xx_clk {
 	u8 reg;
 	u8 mask;
 	struct platform_device *pdev;
-	struct bd718xx *mfd;
+	struct rohm_regmap_dev *mfd;
 };
 
 static int bd71837_clk_set(struct clk_hw *hw, int status)
@@ -68,7 +68,7 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	int rval = -ENOMEM;
 	const char *parent_clk;
 	struct device *parent = pdev->dev.parent;
-	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct rohm_regmap_dev *mfd = dev_get_drvdata(parent);
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
@@ -119,5 +119,5 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_DESCRIPTION("BD71837/BD71847 chip clk driver");
 MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

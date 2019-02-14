Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA14DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10FD222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394871AbfBNNHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:07:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47080 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNNHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:07:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so4455049lfc.13;
        Thu, 14 Feb 2019 05:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7+XyUqAv6WuIJCnBF6kKgkrqT5xeDOdkGMyr/5jkjY=;
        b=O0o8PCgcdTg4Ch8lXlD2QCFQRvLXc0b3ydkBzbusN7rhko5lWcSQh77cY8V78st7NK
         8NyMpbRmqq0SuP1fUd/kzmTgj3i1LafNVa21ZKDgjk4D1s3XKiiwzuedweOT7MuuDXmL
         VWI9DNgkADSSt6ITHJi6hvtkU6YPgBS7I/sdjpokK54FKZdbjNkJ/27FUJJxb7GLLvSZ
         4aVIogjDqnebfXF3Q1oIwyBIsLJSIkDOrk66hFxNDdAfJ077aFFgrRug5PC+tBZdeQii
         jITquanMcyQeDK3XqfwXHGIjjXIN2u4PRW41vF2GWF2HYU+jiV0V3ynFT6yI2tlwPSFE
         hZMQ==
X-Gm-Message-State: AHQUAub+rI1yZDckvsVp1QwjMGPwP5mHhS/+d3mi4OHpcmCedZbgy98M
        EXMwQm/ZPohD36o/FHQJbd8=
X-Google-Smtp-Source: AHgI3IZmjtUhIUdu5mGH9AS6pelLkAWTmgCjN3ZNz3bnguiXIa+lIkBQbbmqwTNToTgfG3jR3BRqhw==
X-Received: by 2002:ac2:54a5:: with SMTP id w5mr2447819lfk.147.1550149662392;
        Thu, 14 Feb 2019 05:07:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g85-v6sm436721lji.17.2019.02.14.05.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:07:41 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:07:34 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
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
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: [PATCH v10 3/9] clk: bd718x7: Support ROHM BD70528 clk block
Message-ID: <b4bcc5e4c2c35bd4f71f5e96c02922aabba6d013.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD70528 is an ultra low power PMIC with similar 32K clk as
bd718x7. Only difference (from clk perspective) is register address.
Add support for controlling BD70528 clk using bd718x7 driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig       |  6 +++---
 drivers/clk/clk-bd718x7.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d2f0bb5ba47e..87f61a46cd5f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -285,10 +285,10 @@ config COMMON_CLK_STM32H7
 
 config COMMON_CLK_BD718XX
 	tristate "Clock driver for ROHM BD718x7 PMIC"
-	depends on MFD_ROHM_BD718XX
+	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD70528
 	help
-	  This driver supports ROHM BD71837 and ROHM BD71847
-	  PMICs clock gates.
+	  This driver supports ROHM BD71837, ROHM BD71847 and
+	  ROHM BD70528 PMICs clock gates.
 
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 461228ebf703..ae6e5baee330 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mfd/rohm-bd718x7.h>
+#include <linux/mfd/rohm-bd70528.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/regmap.h>
@@ -86,9 +87,20 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No parent clk found\n");
 		return -EINVAL;
 	}
-
-	c->reg = BD718XX_REG_OUT32K;
-	c->mask = BD718XX_OUT32K_EN;
+	switch (mfd->chip_type) {
+	case ROHM_CHIP_TYPE_BD71837:
+	case ROHM_CHIP_TYPE_BD71847:
+		c->reg = BD718XX_REG_OUT32K;
+		c->mask = BD718XX_OUT32K_EN;
+		break;
+	case ROHM_CHIP_TYPE_BD70528:
+		c->reg = BD70528_REG_CLK_OUT;
+		c->mask = BD70528_CLK_OUT_EN_MASK;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown clk chip\n");
+		return -EINVAL;
+	}
 	c->mfd = mfd;
 	c->pdev = pdev;
 	c->hw.init = &init;
@@ -119,5 +131,5 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837/BD71847 chip clk driver");
+MODULE_DESCRIPTION("BD71837/BD71847/BD70528 chip clk driver");
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

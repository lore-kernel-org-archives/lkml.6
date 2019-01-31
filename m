Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17EE2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfAaME0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:04:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37667 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaMEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:04:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so2462550ljd.4;
        Thu, 31 Jan 2019 04:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjntFQCQBO8gCvZ1THC9JCAeRH6+57daYb7m1z5r9+k=;
        b=LAlxBZuuO9jgt3j4ZEnZJ/jgEMGwGSA3iK1f+tszatEJi/jZptbx92s4Fw7JzyNirB
         ix+IJ5Yrdn1D65vlBLd5mpt7lNd/X11J0QOw6Loo0hnPt1mDhc+UuE1jfC8ZDIeCW9dh
         y6HJs76EEymFrqEazSJvTws55OhQCQea1gqO2cZLKgNjIcrDYPoaJ+QEpJ1uq0mQ+cfR
         8wQhzL8P/0E00/in0da01bwAhzfrLDgzsAPJzQRmvHP8FFsIFZDbbxCT3LNuD1qH3TPg
         LZbbFTssGSvv0MxGqkhF7NRr+xG3AZYOhBrpLxZLeiO6ldHqd7g4jgCfwJmd/NvxmGZ2
         tUEA==
X-Gm-Message-State: AJcUuke+Qq98cm23k35tyleZIDIlMgTUv6S/8aTKH1VIayOuczjYe9xP
        1kEizpUvLqP5pCqgw2cLcwo=
X-Google-Smtp-Source: ALg8bN4rNa0jrV1QzABL8ymASqgwTREkzLCIVJ8aXWBL+DQOOzzHYv+TrXTNKmbsAuRRR+wMUfLI8Q==
X-Received: by 2002:a2e:5cc8:: with SMTP id q191-v6mr27688273ljb.192.1548936262579;
        Thu, 31 Jan 2019 04:04:22 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l7sm228428lfc.55.2019.01.31.04.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:04:21 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:04:09 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v4 05/10] clk: bd718x7: Support ROHM BD70528 clk block
Message-ID: <b72bdb7c851496834d66d6f69221788d70a43990.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD70528 is an ultra low power PMIC with similar 32K clk as
bd718x7. Only difference (from clk perspective) is register address.
Add support for controlling BD70528 clk using bd718x7 driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig       |  6 +++---
 drivers/clk/clk-bd718x7.c | 21 +++++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e5b2fe80eab4..992cfb86f2ca 100644
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
index 461228ebf703..41c1374f4217 100644
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
@@ -86,9 +87,21 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No parent clk found\n");
 		return -EINVAL;
 	}
-
-	c->reg = BD718XX_REG_OUT32K;
-	c->mask = BD718XX_OUT32K_EN;
+	switch (mfd->chip_type) {
+	case ROHM_CHIP_TYPE_BD71837:
+	case ROHM_CHIP_TYPE_BD71847:
+
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
@@ -119,5 +132,5 @@ static struct platform_driver bd71837_clk = {
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

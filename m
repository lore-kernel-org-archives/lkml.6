Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD4DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AD620879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfAVJpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:45:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37451 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfAVJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:45:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so17587504lfj.4;
        Tue, 22 Jan 2019 01:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U5ofuj/SpJN91nWjSU2HBWbgMkgJhLDUcWpcM5DC2Og=;
        b=lgysYIDPEPawDCtdoX/h3A5SuYX3unVtkcsf5i3LzxADmuQXGSO1qfmprWglwj/5O3
         PO25lVWOhOpSvpYgcfhsnaEOhJs+0NHqAjaP13cRvG5XUZ/3qG0Qc5AmXc2p1jeG+/SQ
         6DOYcDzGixDK5FUIJEty5zH3UhuMTpdx/lnTNl3unB+urWHd379IUiV9B6W1JrvBE9pN
         UPULmZVbTuW2N12Q1tU0caR2pVMhFVK1Oe9/MKrPTZuJElooYAnIuoKGymPiNq5TRus2
         AUPko89K+ajTgCO/wdS7MbG2GNiKaXm7Mnfkg2xONnTDbxHZkJMrmLAhovJ4G1Zku0pD
         RXXg==
X-Gm-Message-State: AJcUukd4RkPIhNjuyimgDsgx+HtU5FAXkR+6hRvHXoah2HbSk1cFaAj7
        AmI2i3VQL5r3UFM7y5U6K6Q=
X-Google-Smtp-Source: ALg8bN6tyr0CRsu7M/eQ7tYO3m0gsOxSapwOwr372+cySC2Ai91s4H9Bu5fe2nV4a3t/N8+xbepaMw==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr19033740lfk.155.1548150321131;
        Tue, 22 Jan 2019 01:45:21 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q23sm2679067lfm.82.2019.01.22.01.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:45:20 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:45:07 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 06/13] clk: bd718x7: Support ROHM BD70528 clk block
Message-ID: <ea98303c81c2637bfc023c02e89547ee2028140c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
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
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

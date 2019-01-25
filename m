Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3331AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F4218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAYLDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:03:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38788 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:03:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so8013969lja.5;
        Fri, 25 Jan 2019 03:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yCgchzQtuH0OVZG2DmuNzUVZhYI6DJEDxJMBY6NGg9Q=;
        b=ORNgMsC5HvlSQaJL0/k8LlwEok2KQixD79hhyhzjIjYuBtBv+sn07qBxZYdPtRKv1+
         vPLKkA24AUKgHP/INakWh5g1uVKX08r7JYUhAogH4gANSzUNxHj8e4hU1/Zn+bGrQjfr
         GIgSz/Uq5wgamQ4h7bmIxxGumlgnk0RiuKI2wURaLs/lun1fVhZYHkc2N53EwWLhwKV3
         0bbqIAvVAPfFwqYSTJiiBvFXctbRLTXYUGFn7wOAQGcwBKUY6tOzmQwTq9TKXiene2Xn
         8+da/GHKySy9FrD4ZzH0vj6/E+1C1feK6KycDAQI/ddS1h3jhGRz0+cSIxRFx6lR35UT
         ntHA==
X-Gm-Message-State: AHQUAuZDPNvzdj4vY+7ye99mry+VgXqRAUOtc8XcQt4DEetUt6xgUsOj
        /IA/UXCKqq92noJpuCOjGJlfhsuvX1E=
X-Google-Smtp-Source: AHgI3IZN8zY+v9zOZERNaJMeVC56163lGQUBsvkIE/kNkaUQU9IEUgc2lKPTV04G7pkjufOe8VmL9A==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr164096ljj.18.1548414190214;
        Fri, 25 Jan 2019 03:03:10 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1476416ljg.21.2019.01.25.03.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:03:09 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:02:57 +0200
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
Subject: [RFC PATCH v2 03/10] clk: bd718x7: use chip specific and generic
 data structs
Message-ID: <20190125110256.GA29254@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

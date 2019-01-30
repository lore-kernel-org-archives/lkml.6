Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58FC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B498A20870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfA3JIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:08:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41614 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfA3JIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:08:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so20015570ljc.8;
        Wed, 30 Jan 2019 01:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlHTxQKBQ2m9TDsnEy1wDJ2As4QYwsor9CJjkiG+Uek=;
        b=LECFaAtWb3y+wPXpy5eOTlD25Hii2GXS/e8N0Bu1fnhSA640H72HJksejAItDLaRCB
         ipIli/OhcAwCKBR697Z4R3RHV7hJeFCk87d9doqS5QPcDl5sw+R81f1zxHTAfle+JKlO
         94lx2DUIcmAguMnq9yrr/eBA/h5rL/fITaattoDGxVkPgeYXJDu7snZtqrY/FE16SWjf
         7r6VYtlPqhb02GA9BsCIWAmXtjnJI20/ba/Zo9/Rz2IMr+WoM8BwDGzqe1Q+frJg7gPP
         38dCqoqLpAc2Gto7YZPlOvkoytXY8GDwXBqUUz64N72xhc6xjzailAvGYfnixOeCo87C
         6u1g==
X-Gm-Message-State: AJcUukeGhOe6JiSC5ZPl8ce11m+o9eN3vNMSjBh+HedLaO2RqH2IixQk
        PmohrGFSWyOtft8UqZcX2dI=
X-Google-Smtp-Source: ALg8bN5Wvnkd7z+fXUk+IbPAmss0P2mrS0XNkad6mMIzQk3gWgzATdoZ087fUNcrinrzSmvRyR/y3Q==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr23644820ljj.13.1548839308238;
        Wed, 30 Jan 2019 01:08:28 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b21sm187734lfi.7.2019.01.30.01.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 01:08:27 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:08:15 +0200
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
Subject: [RFC PATCH v3 03/10] clk: bd718x7: use chip specific and generic
 data structs
Message-ID: <6003ef36e7aa8a55c58a3328af106d2955280a95.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
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
ROHM Semiconductors Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

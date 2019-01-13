Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87901C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9820675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfAMUB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:26 -0500
Received: from mail.windriver.com ([147.11.1.11]:65258 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfAMUAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:04 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIdhjk029132
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:39:43 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:39:42 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 13/18] mfd: wm831x-spi: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:44 -0500
Message-ID: <1547404609-14161-14-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_WM831X_SPI
drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM831x/2x PMICs with SPI"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/wm831x-spi.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 018ce652ae57..dd4dab419940 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm.h>
@@ -67,15 +67,6 @@ static int wm831x_spi_probe(struct spi_device *spi)
 	return wm831x_device_init(wm831x, spi->irq);
 }
 
-static int wm831x_spi_remove(struct spi_device *spi)
-{
-	struct wm831x *wm831x = spi_get_drvdata(spi);
-
-	wm831x_device_exit(wm831x);
-
-	return 0;
-}
-
 static int wm831x_spi_suspend(struct device *dev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(dev);
@@ -108,17 +99,16 @@ static const struct spi_device_id wm831x_spi_ids[] = {
 	{ "wm8326", WM8326 },
 	{ },
 };
-MODULE_DEVICE_TABLE(spi, wm831x_spi_ids);
 
 static struct spi_driver wm831x_spi_driver = {
 	.driver = {
 		.name	= "wm831x",
 		.pm	= &wm831x_spi_pm,
 		.of_match_table = of_match_ptr(wm831x_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.id_table	= wm831x_spi_ids,
 	.probe		= wm831x_spi_probe,
-	.remove		= wm831x_spi_remove,
 };
 
 static int __init wm831x_spi_init(void)
@@ -132,13 +122,3 @@ static int __init wm831x_spi_init(void)
 	return 0;
 }
 subsys_initcall(wm831x_spi_init);
-
-static void __exit wm831x_spi_exit(void)
-{
-	spi_unregister_driver(&wm831x_spi_driver);
-}
-module_exit(wm831x_spi_exit);
-
-MODULE_DESCRIPTION("SPI support for WM831x/2x AudioPlus PMICs");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Mark Brown");
-- 
2.7.4


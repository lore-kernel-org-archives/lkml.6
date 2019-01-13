Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4520675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAMUBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:25 -0500
Received: from mail1.windriver.com ([147.11.146.13]:50247 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfAMUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:05 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIditq026191
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:39:44 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:39:44 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 14/18] mfd: wm831x-i2c: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:45 -0500
Message-ID: <1547404609-14161-15-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_WM831X_I2C
drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM831x/2x PMICs with I2C"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm831x-i2c.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
index 22f7054d1b28..0f3af42f7268 100644
--- a/drivers/mfd/wm831x-i2c.c
+++ b/drivers/mfd/wm831x-i2c.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/mfd/core.h>
@@ -68,15 +68,6 @@ static int wm831x_i2c_probe(struct i2c_client *i2c,
 	return wm831x_device_init(wm831x, i2c->irq);
 }
 
-static int wm831x_i2c_remove(struct i2c_client *i2c)
-{
-	struct wm831x *wm831x = i2c_get_clientdata(i2c);
-
-	wm831x_device_exit(wm831x);
-
-	return 0;
-}
-
 static int wm831x_i2c_suspend(struct device *dev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(dev);
@@ -103,7 +94,6 @@ static const struct i2c_device_id wm831x_i2c_id[] = {
 	{ "wm8326", WM8326 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, wm831x_i2c_id);
 
 static const struct dev_pm_ops wm831x_pm_ops = {
 	.suspend = wm831x_i2c_suspend,
@@ -115,9 +105,9 @@ static struct i2c_driver wm831x_i2c_driver = {
 		.name = "wm831x",
 		.pm = &wm831x_pm_ops,
 		.of_match_table = of_match_ptr(wm831x_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe = wm831x_i2c_probe,
-	.remove = wm831x_i2c_remove,
 	.id_table = wm831x_i2c_id,
 };
 
@@ -132,9 +122,3 @@ static int __init wm831x_i2c_init(void)
 	return ret;
 }
 subsys_initcall(wm831x_i2c_init);
-
-static void __exit wm831x_i2c_exit(void)
-{
-	i2c_del_driver(&wm831x_i2c_driver);
-}
-module_exit(wm831x_i2c_exit);
-- 
2.7.4


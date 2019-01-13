Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CAC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0D20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfAMUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:45 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfAMUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:43 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DIdtvS025176
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:40:41 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:40:20 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 16/18] mfd: wm8350-i2c: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:47 -0500
Message-ID: <1547404609-14161-17-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_WM8350_I2C
drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM8350 with I2C"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.
But we do delete an unused moduleparam.h

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm8350-i2c.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index 9358f03b7938..b4194e068e1b 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -13,8 +13,6 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
@@ -48,30 +46,19 @@ static int wm8350_i2c_probe(struct i2c_client *i2c,
 	return wm8350_device_init(wm8350, i2c->irq, pdata);
 }
 
-static int wm8350_i2c_remove(struct i2c_client *i2c)
-{
-	struct wm8350 *wm8350 = i2c_get_clientdata(i2c);
-
-	wm8350_device_exit(wm8350);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8350_i2c_id[] = {
 	{ "wm8350", 0 },
 	{ "wm8351", 0 },
 	{ "wm8352", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, wm8350_i2c_id);
-
 
 static struct i2c_driver wm8350_i2c_driver = {
 	.driver = {
 		   .name = "wm8350",
+		   .suppress_bind_attrs = true,
 	},
 	.probe = wm8350_i2c_probe,
-	.remove = wm8350_i2c_remove,
 	.id_table = wm8350_i2c_id,
 };
 
@@ -81,12 +68,3 @@ static int __init wm8350_i2c_init(void)
 }
 /* init early so consumer devices can complete system boot */
 subsys_initcall(wm8350_i2c_init);
-
-static void __exit wm8350_i2c_exit(void)
-{
-	i2c_del_driver(&wm8350_i2c_driver);
-}
-module_exit(wm8350_i2c_exit);
-
-MODULE_DESCRIPTION("I2C support for the WM8350 AudioPlus PMIC");
-MODULE_LICENSE("GPL");
-- 
2.7.4


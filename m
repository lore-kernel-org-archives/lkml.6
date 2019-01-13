Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD1FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7920850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfAMUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:18 -0500
Received: from mail1.windriver.com ([147.11.146.13]:50247 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfAMUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:07 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIei7d026207
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:40:44 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:40:43 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:49 -0500
Message-ID: <1547404609-14161-19-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_WM8400
drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM8400"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

A trivial function rename from wm8400_module_init to the name
wm8400_driver_init is also done to reduce possible confusion.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm8400-core.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 8a98a2fc74e1..79756c83f5f0 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -12,7 +12,7 @@
  *
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/bug.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -150,7 +150,6 @@ static const struct i2c_device_id wm8400_i2c_id[] = {
        { "wm8400", 0 },
        { }
 };
-MODULE_DEVICE_TABLE(i2c, wm8400_i2c_id);
 
 static struct i2c_driver wm8400_i2c_driver = {
 	.driver = {
@@ -161,7 +160,7 @@ static struct i2c_driver wm8400_i2c_driver = {
 };
 #endif
 
-static int __init wm8400_module_init(void)
+static int __init wm8400_driver_init(void)
 {
 	int ret = -ENODEV;
 
@@ -173,15 +172,4 @@ static int __init wm8400_module_init(void)
 
 	return ret;
 }
-subsys_initcall(wm8400_module_init);
-
-static void __exit wm8400_module_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&wm8400_i2c_driver);
-#endif
-}
-module_exit(wm8400_module_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+subsys_initcall(wm8400_driver_init);
-- 
2.7.4


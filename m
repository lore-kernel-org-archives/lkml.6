Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F50620675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfAMUBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:09 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfAMUBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:01:07 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DId6T6025166
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:39:16 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:38:56 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Tony Lindgren <tony@atomide.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH 11/18] mfd: tps65910: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:42 -0500
Message-ID: <1547404609-14161-12-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_TPS65910
drivers/mfd/Kconfig-    bool "TI TPS65910 Power Management chip"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.
We do delete an unused moduleparam.h include though.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/tps65910.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index bf16cbe6fd88..aa3d472a10ff 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -1,5 +1,5 @@
 /*
- * tps65910.c  --  TI TPS6591x
+ * tps65910.c  --  TI TPS6591x chip family multi-function driver
  *
  * Copyright 2010 Texas Instruments Inc.
  *
@@ -13,8 +13,6 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -374,7 +372,6 @@ static const struct of_device_id tps65910_of_match[] = {
 	{ .compatible = "ti,tps65911", .data = (void *)TPS65911},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, tps65910_of_match);
 
 static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 						unsigned long *chip_id)
@@ -527,8 +524,6 @@ static const struct i2c_device_id tps65910_i2c_id[] = {
        { "tps65911", TPS65911 },
        { }
 };
-MODULE_DEVICE_TABLE(i2c, tps65910_i2c_id);
-
 
 static struct i2c_driver tps65910_i2c_driver = {
 	.driver = {
@@ -545,14 +540,3 @@ static int __init tps65910_i2c_init(void)
 }
 /* init early so consumer devices can complete system boot */
 subsys_initcall(tps65910_i2c_init);
-
-static void __exit tps65910_i2c_exit(void)
-{
-	i2c_del_driver(&tps65910_i2c_driver);
-}
-module_exit(tps65910_i2c_exit);
-
-MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
-MODULE_AUTHOR("Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>");
-MODULE_DESCRIPTION("TPS6591x chip family multi-function driver");
-MODULE_LICENSE("GPL");
-- 
2.7.4


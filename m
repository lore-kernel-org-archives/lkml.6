Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68903C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4459C20850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfAMUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:32 -0500
Received: from mail1.windriver.com ([147.11.146.13]:50247 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfAMUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:06 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIctO2026188
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:38:55 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:38:54 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: [PATCH 10/18] mfd: tps65090: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:41 -0500
Message-ID: <1547404609-14161-11-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_TPS65090
drivers/mfd/Kconfig:    bool "TI TPS65090 Power Management chips"

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
was (or is now) contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/tps65090.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index f13e4cd06e89..6968df4d7828 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -2,7 +2,9 @@
  * Core driver for TI TPS65090 PMIC family
  *
  * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
-
+ *
+ * Author: Venu Byravarasu <vbyravarasu@nvidia.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -19,7 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
@@ -171,7 +173,6 @@ static const struct of_device_id tps65090_of_match[] = {
 	{ .compatible = "ti,tps65090",},
 	{},
 };
-MODULE_DEVICE_TABLE(of, tps65090_of_match);
 #endif
 
 static int tps65090_i2c_probe(struct i2c_client *client,
@@ -236,30 +237,19 @@ static int tps65090_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int tps65090_i2c_remove(struct i2c_client *client)
-{
-	struct tps65090 *tps65090 = i2c_get_clientdata(client);
-
-	mfd_remove_devices(tps65090->dev);
-	if (client->irq)
-		regmap_del_irq_chip(client->irq, tps65090->irq_data);
-
-	return 0;
-}
 
 static const struct i2c_device_id tps65090_id_table[] = {
 	{ "tps65090", 0 },
 	{ },
 };
-MODULE_DEVICE_TABLE(i2c, tps65090_id_table);
 
 static struct i2c_driver tps65090_driver = {
 	.driver	= {
 		.name	= "tps65090",
+		.suppress_bind_attrs = true,
 		.of_match_table = of_match_ptr(tps65090_of_match),
 	},
 	.probe		= tps65090_i2c_probe,
-	.remove		= tps65090_i2c_remove,
 	.id_table	= tps65090_id_table,
 };
 
@@ -268,13 +258,3 @@ static int __init tps65090_init(void)
 	return i2c_add_driver(&tps65090_driver);
 }
 subsys_initcall(tps65090_init);
-
-static void __exit tps65090_exit(void)
-{
-	i2c_del_driver(&tps65090_driver);
-}
-module_exit(tps65090_exit);
-
-MODULE_DESCRIPTION("TPS65090 core driver");
-MODULE_AUTHOR("Venu Byravarasu <vbyravarasu@nvidia.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


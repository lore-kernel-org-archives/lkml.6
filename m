Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A40C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1420675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfAMUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:09 -0500
Received: from mail.windriver.com ([147.11.1.11]:65258 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfAMUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:06 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0DIbZPw029070
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:37:35 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:37:35 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 02/18] mfd: adp5520: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:33 -0500
Message-ID: <1547404609-14161-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile/Kconfig currently controlling compilation of this code is:

drivers/mfd/Makefile:obj-$(CONFIG_PMIC_ADP5520) += adp5520.o
drivers/mfd/Kconfig:config PMIC_ADP5520
drivers/mfd/Kconfig:    bool "Analog Devices ADP5520/01 MFD PMIC Core Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_i2c_driver() uses the same init level priority as
builtin_i2c_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/mfd/adp5520.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index be0497b96720..2cdd39cb8a18 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -7,6 +7,8 @@
  *
  * Copyright 2009 Analog Devices Inc.
  *
+ * Author: Michael Hennerich <michael.hennerich@analog.com>
+ *
  * Derived from da903x:
  * Copyright (C) 2008 Compulab, Ltd.
  *	Mike Rapoport <mike@compulab.co.il>
@@ -18,7 +20,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -304,18 +306,6 @@ static int adp5520_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int adp5520_remove(struct i2c_client *client)
-{
-	struct adp5520_chip *chip = dev_get_drvdata(&client->dev);
-
-	if (chip->irq)
-		free_irq(chip->irq, chip);
-
-	adp5520_remove_subdevs(chip);
-	adp5520_write(chip->dev, ADP5520_MODE_STATUS, 0);
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int adp5520_suspend(struct device *dev)
 {
@@ -346,20 +336,14 @@ static const struct i2c_device_id adp5520_id[] = {
 	{ "pmic-adp5501", ID_ADP5501 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, adp5520_id);
 
 static struct i2c_driver adp5520_driver = {
 	.driver = {
-		.name	= "adp5520",
-		.pm	= &adp5520_pm,
+		.name			= "adp5520",
+		.pm			= &adp5520_pm,
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= adp5520_probe,
-	.remove		= adp5520_remove,
 	.id_table	= adp5520_id,
 };
-
-module_i2c_driver(adp5520_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("ADP5520(01) PMIC-MFD Driver");
-MODULE_LICENSE("GPL");
+builtin_i2c_driver(adp5520_driver);
-- 
2.7.4


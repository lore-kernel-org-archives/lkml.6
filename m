Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F882C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F45E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLCEZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:25:45 -0500
Received: from mail5.windriver.com ([192.103.53.11]:55212 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeLCEZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:25:45 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB34OUG7018204
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 2 Dec 2018 20:25:05 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 2 Dec 2018
 20:24:52 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Support Opensource <support.opensource@diasemi.com>,
        David Dajun Chen <dchen@diasemi.com>
Subject: [PATCH 06/22] mfd: da9055-i2c: Make it explicitly non-modular
Date:   Sun, 2 Dec 2018 23:23:13 -0500
Message-ID: <1543811009-15112-7-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile/Kconfig currently controlling compilation of this code is:

drivers/mfd/Makefile:da9055-objs := da9055-core.o da9055-i2c.o
drivers/mfd/Makefile:obj-$(CONFIG_MFD_DA9055)   += da9055.o

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

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/da9055-i2c.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 8169a5c2fa20..f4573feb9f8c 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -11,7 +11,7 @@
  *
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -46,15 +46,6 @@ static int da9055_i2c_probe(struct i2c_client *i2c,
 	return da9055_device_init(da9055);
 }
 
-static int da9055_i2c_remove(struct i2c_client *i2c)
-{
-	struct da9055 *da9055 = i2c_get_clientdata(i2c);
-
-	da9055_device_exit(da9055);
-
-	return 0;
-}
-
 /*
  * DO NOT change the device Ids. The naming is intentionally specific as both
  * the PMIC and CODEC parts of this chip are instantiated separately as I2C
@@ -66,7 +57,6 @@ static const struct i2c_device_id da9055_i2c_id[] = {
 	{"da9055-pmic", 0},
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
 
 static const struct of_device_id da9055_of_match[] = {
 	{ .compatible = "dlg,da9055-pmic", },
@@ -75,11 +65,11 @@ static const struct of_device_id da9055_of_match[] = {
 
 static struct i2c_driver da9055_i2c_driver = {
 	.probe = da9055_i2c_probe,
-	.remove = da9055_i2c_remove,
 	.id_table = da9055_i2c_id,
 	.driver = {
 		.name = "da9055-pmic",
 		.of_match_table = of_match_ptr(da9055_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -96,13 +86,3 @@ static int __init da9055_i2c_init(void)
 	return 0;
 }
 subsys_initcall(da9055_i2c_init);
-
-static void __exit da9055_i2c_exit(void)
-{
-	i2c_del_driver(&da9055_i2c_driver);
-}
-module_exit(da9055_i2c_exit);
-
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.7.4


Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC75BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4420848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A4420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLCEZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:25:38 -0500
Received: from mail5.windriver.com ([192.103.53.11]:55208 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeLCEZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:25:38 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB34OUG5018204
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 2 Dec 2018 20:24:45 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 2 Dec 2018
 20:24:19 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Support Opensource <support.opensource@diasemi.com>,
        David Dajun Chen <dchen@diasemi.com>
Subject: [PATCH 05/22] mfd: da9052-*: Make it explicitly non-modular
Date:   Sun, 2 Dec 2018 23:23:12 -0500
Message-ID: <1543811009-15112-6-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfigis currently controlling compilation of this code are:

mfd/Kconfig:config MFD_DA9052_SPI
mfd/Kconfig:    bool "Dialog Semiconductor DA9052/53 PMIC variants with SPI"

mfd/Kconfig:config MFD_DA9052_I2C
mfd/Kconfig:    bool "Dialog Semiconductor DA9052/53 PMIC variants with I2C"

drivers/mfd/Kconfig:config PMIC_DA9052
drivers/mfd/Kconfig:    bool

...meaning that this code is currently not being built as a module.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.
In doing so, da9052_device_exit() becomes orphaned, so it gets
removed as well.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We replace module.h with init.h where required, i.e. if the the file
did not include that already.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the files in the comments.

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/da9052-core.c         | 11 -----------
 drivers/mfd/da9052-i2c.c          | 22 ++--------------------
 drivers/mfd/da9052-irq.c          |  1 -
 drivers/mfd/da9052-spi.c          | 22 ++--------------------
 include/linux/mfd/da9052/da9052.h |  1 -
 5 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 433add43a0a9..96da73ce5ae4 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/property.h>
 
 #include <linux/mfd/da9052/da9052.h>
@@ -648,13 +647,3 @@ int da9052_device_init(struct da9052 *da9052, u8 chip_id)
 
 	return ret;
 }
-
-void da9052_device_exit(struct da9052 *da9052)
-{
-	mfd_remove_devices(da9052->dev);
-	da9052_irq_exit(da9052);
-}
-
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("DA9052 MFD Core");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 578e881067a5..cf881907b4b3 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/input.h>
 #include <linux/mfd/core.h>
 #include <linux/i2c.h>
@@ -177,20 +177,12 @@ static int da9052_i2c_probe(struct i2c_client *client,
 	return da9052_device_init(da9052, id->driver_data);
 }
 
-static int da9052_i2c_remove(struct i2c_client *client)
-{
-	struct da9052 *da9052 = i2c_get_clientdata(client);
-
-	da9052_device_exit(da9052);
-	return 0;
-}
-
 static struct i2c_driver da9052_i2c_driver = {
 	.probe = da9052_i2c_probe,
-	.remove = da9052_i2c_remove,
 	.id_table = da9052_i2c_id,
 	.driver = {
 		.name = "da9052",
+		.suppress_bind_attrs = true,
 #ifdef CONFIG_OF
 		.of_match_table = dialog_dt_ids,
 #endif
@@ -210,13 +202,3 @@ static int __init da9052_i2c_init(void)
 	return 0;
 }
 subsys_initcall(da9052_i2c_init);
-
-static void __exit da9052_i2c_exit(void)
-{
-	i2c_del_driver(&da9052_i2c_driver);
-}
-module_exit(da9052_i2c_exit);
-
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
index cd4ca849ca44..6e0db46f71a9 100644
--- a/drivers/mfd/da9052-irq.c
+++ b/drivers/mfd/da9052-irq.c
@@ -20,7 +20,6 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 
 #include <linux/mfd/da9052/da9052.h>
 #include <linux/mfd/da9052/reg.h>
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index fdae1288bc6d..8532afa567a1 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/input.h>
 #include <linux/mfd/core.h>
 #include <linux/spi/spi.h>
@@ -60,14 +60,6 @@ static int da9052_spi_probe(struct spi_device *spi)
 	return da9052_device_init(da9052, id->driver_data);
 }
 
-static int da9052_spi_remove(struct spi_device *spi)
-{
-	struct da9052 *da9052 = spi_get_drvdata(spi);
-
-	da9052_device_exit(da9052);
-	return 0;
-}
-
 static const struct spi_device_id da9052_spi_id[] = {
 	{"da9052", DA9052},
 	{"da9053-aa", DA9053_AA},
@@ -79,10 +71,10 @@ static const struct spi_device_id da9052_spi_id[] = {
 
 static struct spi_driver da9052_spi_driver = {
 	.probe = da9052_spi_probe,
-	.remove = da9052_spi_remove,
 	.id_table = da9052_spi_id,
 	.driver = {
 		.name = "da9052",
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -99,13 +91,3 @@ static int __init da9052_spi_init(void)
 	return 0;
 }
 subsys_initcall(da9052_spi_init);
-
-static void __exit da9052_spi_exit(void)
-{
-	spi_unregister_driver(&da9052_spi_driver);
-}
-module_exit(da9052_spi_exit);
-
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
index ae5b663836d0..7951642e2ba0 100644
--- a/include/linux/mfd/da9052/da9052.h
+++ b/include/linux/mfd/da9052/da9052.h
@@ -215,7 +215,6 @@ static inline int da9052_reg_update(struct da9052 *da9052, unsigned char reg,
 }
 
 int da9052_device_init(struct da9052 *da9052, u8 chip_id);
-void da9052_device_exit(struct da9052 *da9052);
 
 extern const struct regmap_config da9052_regmap_config;
 
-- 
2.7.4


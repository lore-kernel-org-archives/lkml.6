Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F82C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5520848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F5520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLCEZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:25:08 -0500
Received: from mail1.windriver.com ([147.11.146.13]:60533 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeLCEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:25:08 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB34OIGj015514
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 2 Dec 2018 20:24:19 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 2 Dec 2018
 20:24:18 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Eric Miao <eric.miao@marvell.com>,
        Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 04/22] mfd: da903x: Make it explicitly non-modular
Date:   Sun, 2 Dec 2018 23:23:11 -0500
Message-ID: <1543811009-15112-5-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config PMIC_DA903X
drivers/mfd/Kconfig-    bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We replace module.h with init.h and export.h ; the latter since this
file does export some syms.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/da903x.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 09f367571c58..78edb0558a0f 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
@@ -446,7 +446,6 @@ static const struct i2c_device_id da903x_id_table[] = {
 	{ "da9034", 1 },
 	{ },
 };
-MODULE_DEVICE_TABLE(i2c, da903x_id_table);
 
 static int __remove_subdev(struct device *dev, void *unused)
 {
@@ -535,20 +534,12 @@ static int da903x_probe(struct i2c_client *client,
 	return da903x_add_subdevs(chip, pdata);
 }
 
-static int da903x_remove(struct i2c_client *client)
-{
-	struct da903x_chip *chip = i2c_get_clientdata(client);
-
-	da903x_remove_subdevs(chip);
-	return 0;
-}
-
 static struct i2c_driver da903x_driver = {
 	.driver	= {
-		.name	= "da903x",
+		.name			= "da903x",
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= da903x_probe,
-	.remove		= da903x_remove,
 	.id_table	= da903x_id_table,
 };
 
@@ -557,14 +548,3 @@ static int __init da903x_init(void)
 	return i2c_add_driver(&da903x_driver);
 }
 subsys_initcall(da903x_init);
-
-static void __exit da903x_exit(void)
-{
-	i2c_del_driver(&da903x_driver);
-}
-module_exit(da903x_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


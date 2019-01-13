Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C181820675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfAMUBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:17 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfAMUAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:44 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DIbEFR025097
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:37:24 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:37:04 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jin Park <jinyoungp@nvidia.com>
Subject: [PATCH 01/18] mfd: aat2870-core: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:32 -0500
Message-ID: <1547404609-14161-2-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_AAT2870_CORE
drivers/mfd/Kconfig:    bool "AnalogicTech AAT2870"

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
Cc: Jin Park <jinyoungp@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jin Park <jinyoungp@nvidia.com>
---
 drivers/mfd/aat2870-core.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 3ba19a45f199..9d3d90d386c2 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
@@ -349,18 +348,10 @@ static void aat2870_init_debugfs(struct aat2870_data *aat2870)
 			 "Failed to create debugfs register file\n");
 }
 
-static void aat2870_uninit_debugfs(struct aat2870_data *aat2870)
-{
-	debugfs_remove_recursive(aat2870->dentry_root);
-}
 #else
 static inline void aat2870_init_debugfs(struct aat2870_data *aat2870)
 {
 }
-
-static inline void aat2870_uninit_debugfs(struct aat2870_data *aat2870)
-{
-}
 #endif /* CONFIG_DEBUG_FS */
 
 static int aat2870_i2c_probe(struct i2c_client *client,
@@ -440,20 +431,6 @@ static int aat2870_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int aat2870_i2c_remove(struct i2c_client *client)
-{
-	struct aat2870_data *aat2870 = i2c_get_clientdata(client);
-
-	aat2870_uninit_debugfs(aat2870);
-
-	mfd_remove_devices(aat2870->dev);
-	aat2870_disable(aat2870);
-	if (aat2870->uninit)
-		aat2870->uninit(aat2870);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int aat2870_i2c_suspend(struct device *dev)
 {
@@ -492,15 +469,14 @@ static const struct i2c_device_id aat2870_i2c_id_table[] = {
 	{ "aat2870", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, aat2870_i2c_id_table);
 
 static struct i2c_driver aat2870_i2c_driver = {
 	.driver = {
-		.name	= "aat2870",
-		.pm	= &aat2870_pm_ops,
+		.name			= "aat2870",
+		.pm			= &aat2870_pm_ops,
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= aat2870_i2c_probe,
-	.remove		= aat2870_i2c_remove,
 	.id_table	= aat2870_i2c_id_table,
 };
 
@@ -509,13 +485,3 @@ static int __init aat2870_init(void)
 	return i2c_add_driver(&aat2870_i2c_driver);
 }
 subsys_initcall(aat2870_init);
-
-static void __exit aat2870_exit(void)
-{
-	i2c_del_driver(&aat2870_i2c_driver);
-}
-module_exit(aat2870_exit);
-
-MODULE_DESCRIPTION("Core support for the AnalogicTech AAT2870");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jin Park <jinyoungp@nvidia.com>");
-- 
2.7.4


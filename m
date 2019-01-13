Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E911C20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfAMUAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:47 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfAMUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:43 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DId6T7025166
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:39:37 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:39:30 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 12/18] mfd: tps80031: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:43 -0500
Message-ID: <1547404609-14161-13-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_TPS80031
drivers/mfd/Kconfig:    bool "TI TPS80031/TPS80032 Power Management chips"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/mfd/tps80031.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index 608c7f77830e..865257ade8ac 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -30,7 +30,6 @@
 #include <linux/irq.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps80031.h>
-#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -516,40 +515,18 @@ static int tps80031_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int tps80031_remove(struct i2c_client *client)
-{
-	struct tps80031 *tps80031 = i2c_get_clientdata(client);
-	int i;
-
-	if (tps80031_power_off_dev == tps80031) {
-		tps80031_power_off_dev = NULL;
-		pm_power_off = NULL;
-	}
-
-	mfd_remove_devices(tps80031->dev);
-
-	regmap_del_irq_chip(client->irq, tps80031->irq_data);
-
-	for (i = 0; i < TPS80031_NUM_SLAVES; i++) {
-		if (tps80031->clients[i] != client)
-			i2c_unregister_device(tps80031->clients[i]);
-	}
-	return 0;
-}
-
 static const struct i2c_device_id tps80031_id_table[] = {
 	{ "tps80031", TPS80031 },
 	{ "tps80032", TPS80032 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, tps80031_id_table);
 
 static struct i2c_driver tps80031_driver = {
 	.driver	= {
-		.name	= "tps80031",
+		.name			= "tps80031",
+		.suppress_bind_attrs	= true,
 	},
 	.probe		= tps80031_probe,
-	.remove		= tps80031_remove,
 	.id_table	= tps80031_id_table,
 };
 
@@ -558,13 +535,3 @@ static int __init tps80031_init(void)
 	return i2c_add_driver(&tps80031_driver);
 }
 subsys_initcall(tps80031_init);
-
-static void __exit tps80031_exit(void)
-{
-	i2c_del_driver(&tps80031_driver);
-}
-module_exit(tps80031_exit);
-
-MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_DESCRIPTION("TPS80031 core driver");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


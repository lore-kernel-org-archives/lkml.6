Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8306C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B784D20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfAMUAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:00:35 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfAMUAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:33 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DIcLKJ025110
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:38:31 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:38:11 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 07/18] mfd: rc5t583: Make it explicitly non-modular
Date:   Sun, 13 Jan 2019 13:36:38 -0500
Message-ID: <1547404609-14161-8-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_RC5T583
drivers/mfd/Kconfig:    bool "Ricoh RC5T583 Power Management system device"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/mfd/rc5t583.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index fd46de02b715..c5cc5cb3dde7 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -298,8 +297,6 @@ static const struct i2c_device_id rc5t583_i2c_id[] = {
 	{}
 };
 
-MODULE_DEVICE_TABLE(i2c, rc5t583_i2c_id);
-
 static struct i2c_driver rc5t583_i2c_driver = {
 	.driver = {
 		   .name = "rc5t583",
@@ -313,14 +310,3 @@ static int __init rc5t583_i2c_init(void)
 	return i2c_add_driver(&rc5t583_i2c_driver);
 }
 subsys_initcall(rc5t583_i2c_init);
-
-static void __exit rc5t583_i2c_exit(void)
-{
-	i2c_del_driver(&rc5t583_i2c_driver);
-}
-
-module_exit(rc5t583_i2c_exit);
-
-MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_DESCRIPTION("RICOH RC5T583 power management system device driver");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


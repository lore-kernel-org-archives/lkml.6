Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F8FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB120820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BB120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391718AbeKVPNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:13:21 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53064 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbeKVPNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:13:21 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAM4XWFd012233
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 21 Nov 2018 20:35:01 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 20:33:53 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/11] mfd: as3711: Make it explicitly non-modular
Date:   Wed, 21 Nov 2018 23:32:49 -0500
Message-ID: <1542861179-8941-2-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_AS3711
drivers/mfd/Kconfig:    bool "AMS AS3711"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/as3711.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 67b12417585d..7a74a874b93c 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/mfd/as3711.h>
 #include <linux/mfd/core.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -118,7 +117,6 @@ static const struct of_device_id as3711_of_match[] = {
 	{.compatible = "ams,as3711",},
 	{}
 };
-MODULE_DEVICE_TABLE(of, as3711_of_match);
 #endif
 
 static int as3711_i2c_probe(struct i2c_client *client,
@@ -202,8 +200,6 @@ static const struct i2c_device_id as3711_i2c_id[] = {
 	{}
 };
 
-MODULE_DEVICE_TABLE(i2c, as3711_i2c_id);
-
 static struct i2c_driver as3711_i2c_driver = {
 	.driver = {
 		   .name = "as3711",
@@ -219,13 +215,3 @@ static int __init as3711_i2c_init(void)
 }
 /* Initialise early */
 subsys_initcall(as3711_i2c_init);
-
-static void __exit as3711_i2c_exit(void)
-{
-	i2c_del_driver(&as3711_i2c_driver);
-}
-module_exit(as3711_i2c_exit);
-
-MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
-MODULE_DESCRIPTION("AS3711 PMIC driver");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


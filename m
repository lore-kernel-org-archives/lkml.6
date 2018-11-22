Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97620820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED97620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeKVPMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:12:39 -0500
Received: from mail.windriver.com ([147.11.1.11]:59478 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732270AbeKVPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:12:39 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wAM4Z22R020122
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 21 Nov 2018 20:35:02 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 20:35:02 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 04/11] mfd: htc-i2cpld: Make it explicitly non-modular
Date:   Wed, 21 Nov 2018 23:32:52 -0500
Message-ID: <1542861179-8941-5-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig for this option is currently:

config HTC_I2CPLD
        bool "HTC I2C PLD chip support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/htc-i2cpld.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 01572b5e79e8..af3c66355270 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -27,7 +27,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
@@ -614,8 +613,6 @@ static const struct i2c_device_id htcpld_chip_id[] = {
 	{ "htcpld-chip", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, htcpld_chip_id);
-
 
 static struct i2c_driver htcpld_chip_driver = {
 	.driver = {
@@ -643,17 +640,4 @@ static int __init htcpld_core_init(void)
 	/* Probe for our chips */
 	return platform_driver_probe(&htcpld_core_driver, htcpld_core_probe);
 }
-
-static void __exit htcpld_core_exit(void)
-{
-	i2c_del_driver(&htcpld_chip_driver);
-	platform_driver_unregister(&htcpld_core_driver);
-}
-
-module_init(htcpld_core_init);
-module_exit(htcpld_core_exit);
-
-MODULE_AUTHOR("Cory Maccarrone <darkstar6262@gmail.com>");
-MODULE_DESCRIPTION("I2C HTC PLD Driver");
-MODULE_LICENSE("GPL");
-
+device_initcall(htcpld_core_init);
-- 
2.7.4


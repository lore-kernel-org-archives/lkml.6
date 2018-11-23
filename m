Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC89C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7F20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE7F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440124AbeKXB2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:28:06 -0500
Received: from mail.windriver.com ([147.11.1.11]:48290 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKXB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:28:06 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wANEhUXL027044
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 23 Nov 2018 06:43:30 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Fri, 23 Nov 2018 06:43:29 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 5572C2E06D4; Fri, 23 Nov 2018 09:43:29 -0500 (EST)
Date:   Fri, 23 Nov 2018 09:43:29 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     kbuild test robot <lkp@intel.com>, Lee Jones <lee.jones@linaro.org>
CC:     <kbuild-all@01.org>, <linux-kernel@vger.kernel.org>,
        David Dajun Chen <dchen@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular
Message-ID: <20181123144328.GE14659@windriver.com>
References: <1542861179-8941-3-git-send-email-paul.gortmaker@windriver.com>
 <201811231036.wIjm7GBh%fengguang.wu@intel.com>
 <20181123031456.GD14659@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181123031456.GD14659@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 22/11/2018 (Thu 22:14) Paul Gortmaker wrote:

> [Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 23/11/2018 (Fri 10:21) kbuild test robot wrote:
> 

[...]

> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/mfd/da9055-i2c.o: In function `da9055_i2c_remove':
> > >> drivers/mfd/da9055-i2c.c:53: undefined reference to `da9055_device_exit'
> 
> Thanks for the report -- I'll look into what causes it, why my testing
> didn't see it, and get an update to Lee as soon as possible.

OK, mystery solved.  I chose this smaller subset of MFD "simple" patches
from my pending queue of MFD patches - to create a reasonable sized
maintainer-friendly send, based on patches with zero runtime changes.

My other pending MFD patches have a trivial runtime behavior change;
deleting a ".remove" field/function - that will never be used for a
non-module case, but in theory could be (pointlessly) triggered by
forcing a driver unbind.  (see mainline 98b72b94def9 as an example)
Patches like this were left behind for a future send batch.

Unfortunately that allowed me to overlook the fact that patch #2 link
depended on the below ".remove" patch (not sent) to be applied 1st.

Lee, what would you like to have happen?  I can resend the queue with
this patch, or I can resend with #2 being temporarily deferred until
a future patch batch that has the below da9055-i2c in it, or ...

Whatever is easiest for you - let me know.

Paul.
--

From da28030dbcdcd5cb4807ad18dfa6fd4773719ad0 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 6 Sep 2015 22:10:34 -0400
Subject: [PATCH] mfd: da9055-i2c: Make it explicitly non-modular

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

diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index b53e100f577c..7c66f82522f0 100644
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
@@ -66,7 +57,6 @@ static struct i2c_device_id da9055_i2c_id[] = {
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
2.8.0


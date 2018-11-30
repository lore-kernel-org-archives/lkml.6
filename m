Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215320834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zk2eRmbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeLADkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:40:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeLADkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bISYykJ8GQF+lqz1Nx0gVqzQoJiuaqQY4QXSqWfAKkQ=; b=Zk2eRmbSIk2XWg+gW0poHEBdxB
        Qx8s9l1/9p3yPJW1l9MOFTcPF72iTjWRwXa3d6znyv2DeQVpUbEZivGw0rc54but3901C88b9RjD4
        qhlvvrqwivgRDEjSbo6/VzyBPl7pPsaWGvvojaRxcrtlu10oJ5fblKMzMTVPQ6Zx/eV3Sue7x9x1B
        QyJCh0/xsskOZ96qvmrOg88OzeIkIoF9ED/mC33m1XV9KvaWwvZOZMX8XSZ8xQ5r5fcANUvNpozkA
        dDBYCS3k21ZNw0fb586ueM+938hhL8/Cqnq9egAWQg5XVpBQRkNHY3RBk11MsK7jUDqFh9EUWQ+Te
        bWutNFAQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSlgN-00052w-Lb; Fri, 30 Nov 2018 16:30:23 +0000
To:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ettore Chimenti <ek5.chimenti@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] media: seco-cec: add missing header file to fix build
Message-ID: <3e9c29d3-5e34-751d-134e-b2a0599aeb10@infradead.org>
Date:   Fri, 30 Nov 2018 08:30:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors due to missing <linux/module.h> header file.
The header file is inserted first because module-related errors
begin showing up in <linux/acpi.h> (when CONFIG_ACPI is not set).

Sample of build errors:

In file included from ../include/linux/acpi.h:27:0,
                 from ../drivers/media/platform/seco-cec/seco-cec.c:10:
../include/linux/device.h:1620:1: warning: data definition has no type or storage class [enabled by default]
 module_exit(__driver##_exit);
 ^
../include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^
../drivers/media/platform/seco-cec/seco-cec.c:791:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(secocec_driver);
 ^
../include/linux/device.h:1620:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
 module_exit(__driver##_exit);
 ^
../include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^
../drivers/media/platform/seco-cec/seco-cec.c:791:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(secocec_driver);
 ^
In file included from ../include/linux/linkage.h:7:0,
                 from ../include/linux/kernel.h:7,
                 from ../include/linux/list.h:9,
                 from ../include/linux/resource_ext.h:17,
                 from ../include/linux/acpi.h:26,
                 from ../drivers/media/platform/seco-cec/seco-cec.c:10:
../include/linux/export.h:18:30: warning: parameter names (without types) in function declaration [enabled by default]
 #define THIS_MODULE ((struct module *)0)
                              ^
../include/linux/platform_device.h:199:34: note: in expansion of macro 'THIS_MODULE'
  __platform_driver_register(drv, THIS_MODULE)
                                  ^
../include/linux/device.h:1613:9: note: in expansion of macro 'platform_driver_register'
  return __register(&(__driver) , ##__VA_ARGS__); \
         ^
../include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
  module_driver(__platform_driver, platform_driver_register, \
  ^
../drivers/media/platform/seco-cec/seco-cec.c:791:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(secocec_driver);
 ^
../drivers/media/platform/seco-cec/seco-cec.c:793:20: error: expected declaration specifiers or '...' before string constant
 MODULE_DESCRIPTION("SECO CEC X86 Driver");
                    ^
../drivers/media/platform/seco-cec/seco-cec.c:794:15: error: expected declaration specifiers or '...' before string constant
 MODULE_AUTHOR("Ettore Chimenti <ek5.chimenti@gmail.com>");
               ^
../drivers/media/platform/seco-cec/seco-cec.c:795:16: error: expected declaration specifiers or '...' before string constant
 MODULE_LICENSE("Dual BSD/GPL");
                ^
In file included from ../include/linux/acpi.h:27:0,
                 from ../drivers/media/platform/seco-cec/seco-cec.c:10:
../drivers/media/platform/seco-cec/seco-cec.c:791:24: warning: 'secocec_driver_init' defined but not used [-Wunused-function]
 module_platform_driver(secocec_driver);
                        ^
../include/linux/device.h:1611:19: note: in definition of macro 'module_driver'
 static int __init __driver##_init(void) \
                   ^
../drivers/media/platform/seco-cec/seco-cec.c:791:1: note: in expansion of macro 'module_platform_driver'
 module_platform_driver(secocec_driver);


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ettore Chimenti <ek5.chimenti@gmail.com>
---
 drivers/media/platform/seco-cec/seco-cec.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181130.orig/drivers/media/platform/seco-cec/seco-cec.c
+++ linux-next-20181130/drivers/media/platform/seco-cec/seco-cec.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2018, Aidilab Srl.
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>



Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E36C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF72081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAF72081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbeKFQL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:11:29 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:47348 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387813AbeKFQL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:11:29 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 1754F1A7B1780B2E74FF;
        Tue,  6 Nov 2018 14:47:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA66l6U2044621;
        Tue, 6 Nov 2018 14:47:06 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110614472018-8886587 ;
          Tue, 6 Nov 2018 14:47:20 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V8 03/11]  misc/pvpanic: add MMIO support
Date:   Tue, 6 Nov 2018 22:57:14 +0800
Message-Id: <1541516242-98568-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541516242-98568-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541516242-98568-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-06 14:47:20,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-06 14:47:02,
        Serialize complete at 2018-11-06 14:47:02
X-MAIL: mse01.zte.com.cn wA66l6U2044621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (e.g. arm64), it's preferable to use MMIO, since
this can be used standalone. Add MMIO support to the pvpanic driver.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
[Use acpi_dev_resource_memory API. - Andy]
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 49c59e1..e923dac 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -26,6 +26,8 @@
 #include <linux/types.h>
 #include <linux/acpi.h>
 
+static void __iomem *base;
+
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
@@ -41,8 +43,6 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 
-static u16 port;
-
 static struct acpi_driver pvpanic_driver = {
 	.name =		"pvpanic",
 	.class =	"QEMU",
@@ -57,7 +57,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	outb(event, port);
+	iowrite8(event, base);
 }
 
 static int
@@ -80,7 +80,10 @@
 	struct resource r;
 
 	if (acpi_dev_resource_io(res, &r)) {
-		port = r.start;
+		base = ioport_map(r.start, resource_size(&r));
+		return AE_OK;
+	} else if (acpi_dev_resource_memory(res, &r)) {
+		base = ioremap(r.start, resource_size(&r));
 		return AE_OK;
 	}
 
@@ -101,7 +104,7 @@ static int pvpanic_add(struct acpi_device *device)
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    pvpanic_walk_resources, NULL);
 
-	if (!port)
+	if (!base)
 		return -ENODEV;
 
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -115,6 +118,8 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+	iounmap(base);
+
 	return 0;
 }
 
-- 
1.8.3.1


Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE19ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A78A2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A78A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeKELsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:48:15 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:60008 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbeKELr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:47:59 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 6A8C1C84C3ADDEF22DE6;
        Mon,  5 Nov 2018 10:30:38 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA52UIfv028373;
        Mon, 5 Nov 2018 10:30:18 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110510302169-8593004 ;
          Mon, 5 Nov 2018 10:30:21 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V7 6/9]  misc/pvpanic : break dependency on ACPI
Date:   Mon, 5 Nov 2018 18:40:28 +0800
Message-Id: <1541414431-84128-6-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-05 10:30:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-05 10:30:18,
        Serialize complete at 2018-11-05 10:30:18
X-MAIL: mse01.zte.com.cn wA52UIfv028373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvpanic driver is available for architectures that do not
support ACPI.So break the dependency.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/Kconfig   |  2 +-
 drivers/misc/pvpanic.c | 32 ++++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 642626a..52642a9 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,7 +515,7 @@ config MISC_RTSX
 
 config PVPANIC
 	tristate "pvpanic device support"
-	depends on ACPI
+	depends on ACPI || OF
 	help
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 0c987d7..fbb4d1f 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -34,6 +34,10 @@
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
+#define PVPANIC_PANICKED        (1 << 0)
+
+static void __iomem *base;
+#ifdef CONFIG_ACPI
 static int pvpanic_add(struct acpi_device *device);
 static int pvpanic_remove(struct acpi_device *device);
 
@@ -43,10 +47,6 @@
 };
 MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
 
-#define PVPANIC_PANICKED	(1 << 0)
-
-static void __iomem *base;
-
 static struct acpi_driver pvpanic_driver = {
 	.name =		"pvpanic",
 	.class =	"QEMU",
@@ -58,6 +58,24 @@
 	.owner =	THIS_MODULE,
 };
 
+static int pvpanic_register_acpi_driver(void)
+{
+	return acpi_bus_register_driver(&pvpanic_driver);
+}
+
+static void pvpanic_unregister_acpi_driver(void)
+{
+	acpi_bus_unregister_driver(&pvpanic_driver);
+}
+#else
+static int pvpanic_register_acpi_driver(void)
+{
+	return -ENODEV;
+}
+
+static void pvpanic_unregister_acpi_driver(void) {}
+#endif
+
 static void
 pvpanic_send_event(unsigned int event)
 {
@@ -104,6 +122,7 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static acpi_status
 pvpanic_walk_resources(struct acpi_resource *res, void *context)
 {
@@ -153,6 +172,7 @@ static int pvpanic_remove(struct acpi_device *device)
 
 	return 0;
 }
+#endif
 
 static const struct of_device_id pvpanic_mmio_match[] = {
 	{ .compatible = "qemu,pvpanic-mmio", },
@@ -173,7 +193,7 @@ static int __init pvpanic_mmio_init(void)
 	if (acpi_disabled)
 		return platform_driver_register(&pvpanic_mmio_driver);
         else
-		return acpi_bus_register_driver(&pvpanic_driver);
+		return pvpanic_register_acpi_driver();
 }
 
 static void __exit pvpanic_mmio_exit(void)
@@ -181,7 +201,7 @@ static void __exit pvpanic_mmio_exit(void)
 	if (acpi_disabled)
 		platform_driver_unregister(&pvpanic_mmio_driver);
 	else
-		acpi_bus_unregister_driver(&pvpanic_driver);
+		pvpanic_unregister_acpi_driver();
 }
 
 module_init(pvpanic_mmio_init);
-- 
1.8.3.1


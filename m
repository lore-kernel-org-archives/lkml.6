Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E60ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721C320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721C320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeJaOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:23:29 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:26236 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeJaOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:23:28 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E4BAA8EF76413111040A;
        Wed, 31 Oct 2018 13:26:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9V5Qk2T037555;
        Wed, 31 Oct 2018 13:26:46 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018103113270743-7767263 ;
          Wed, 31 Oct 2018 13:27:07 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V4 4/5]  misc/pvpanic: add support to get pvpanic device info by FDT
Date:   Wed, 31 Oct 2018 21:37:20 +0800
Message-Id: <1540993041-25611-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-31 13:27:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-31 13:26:38,
        Serialize complete at 2018-10-31 13:26:38
X-MAIL: mse01.zte.com.cn w9V5Qk2T037555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, when ACPI tables and FDT coexist for ARM64,
current kernel takes precedence over FDT to get device information.
Virt machine in qemu provides both FDT and ACPI table. This patch
increases the way to get information through FDT.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index d0e28b2..861a0eb 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -3,15 +3,18 @@
  *  Pvpanic Device Support
  *
  *  Copyright (C) 2013 Fujitsu.
+ *  Copyright (C) 2018 ZTE.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/acpi.h>
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -22,7 +25,7 @@
 
 static const struct acpi_device_id pvpanic_device_ids[] = {
 	{ "QEMU0001", 0 },
-	{ "", 0 },
+	{ "", 0 }
 };
 MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
 
@@ -60,6 +63,32 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&pdev->dev, mem);
+	if (base == NULL)
+		return -EFAULT;
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+
+	return 0;
+}
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+
+	return 0;
+}
 
 static acpi_status
 pvpanic_walk_resources(struct acpi_resource *res, void *context)
@@ -120,4 +149,35 @@ static int pvpanic_remove(struct acpi_device *device)
 	return 0;
 }
 
-module_acpi_driver(pvpanic_driver);
+static const struct of_device_id pvpanic_mmio_match[] = {
+	{ .compatible = "qemu,pvpanic-mmio", },
+	{}
+};
+
+static struct platform_driver pvpanic_mmio_driver = {
+	.driver = {
+		.name = "pvpanic-mmio",
+		.of_match_table = pvpanic_mmio_match,
+	},
+	.probe = pvpanic_mmio_probe,
+	.remove = pvpanic_mmio_remove,
+};
+
+static int __init pvpanic_mmio_init(void)
+{
+	if (acpi_disabled)
+		return platform_driver_register(&pvpanic_mmio_driver);
+	else
+		return acpi_bus_register_driver(&pvpanic_driver);
+}
+
+static void __exit pvpanic_mmio_exit(void)
+{
+	if (acpi_disabled)
+		platform_driver_unregister(&pvpanic_mmio_driver);
+	else
+		acpi_bus_unregister_driver(&pvpanic_driver);
+}
+
+module_init(pvpanic_mmio_init);
+module_exit(pvpanic_mmio_exit);
-- 
1.8.3.1


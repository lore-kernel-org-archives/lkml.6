Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DCC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F392085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAWDO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:14:56 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:6346 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfAWDOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:14:52 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2D5B92C4B80C18923D00;
        Wed, 23 Jan 2019 11:14:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N3EkPD000703;
        Wed, 23 Jan 2019 11:14:46 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012311150573-23654300 ;
          Wed, 23 Jan 2019 11:15:05 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V2 2/6]  misc/pvpanic: Add pvpanic driver framework
Date:   Wed, 23 Jan 2019 19:37:53 +0800
Message-Id: <1548243477-60654-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 11:15:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 11:14:38,
        Serialize complete at 2019-01-23 11:14:38
X-MAIL: mse01.zte.com.cn x0N3EkPD000703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic driver framework. Split the original pvpanic acpi/of
driver as the two seperate files and modify code for adaptation framework
in follow-up patches.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/pvpanic.c | 171 ++++++++++-------------------------------
 1 file changed, 39 insertions(+), 132 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 595ac06..6380540 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -8,15 +8,20 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-static void __iomem *base;
+static struct {
+	struct platform_device *pdev;
+	void __iomem *base;
+	bool is_ioport;
+} pvpanic_data = {
+	.pdev = NULL,
+	.is_ioport = false,
+};
 
 #define PVPANIC_PANICKED        (1 << 0)
 
@@ -27,7 +32,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	iowrite8(event, pvpanic_data.base);
 }
 
 static int
@@ -43,150 +48,52 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-#ifdef CONFIG_ACPI
-static int pvpanic_add(struct acpi_device *device);
-static int pvpanic_remove(struct acpi_device *device);
-
-static const struct acpi_device_id pvpanic_device_ids[] = {
-	{ "QEMU0001", 0 },
-	{ "", 0 }
-};
-MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
-
-static struct acpi_driver pvpanic_driver = {
-	.name =		"pvpanic",
-	.class =	"QEMU",
-	.ids =		pvpanic_device_ids,
-	.ops =		{
-				.add =		pvpanic_add,
-				.remove =	pvpanic_remove,
-			},
-	.owner =	THIS_MODULE,
-};
-
-static acpi_status
-pvpanic_walk_resources(struct acpi_resource *res, void *context)
+static int pvpanic_platform_probe(struct platform_device *pdev)
 {
-	struct resource r;
-
-	if (acpi_dev_resource_io(res, &r)) {
-		base = ioport_map(r.start, resource_size(&r));
-		return AE_OK;
-	} else if (acpi_dev_resource_memory(res, &r)) {
-		base = ioremap(r.start, resource_size(&r));
-		return AE_OK;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return -ENODEV;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (!res)
+			return -ENODEV;
+
+		base = ioport_map(res->start, resource_size(res));
+		if (!base)
+			return -ENODEV;
+		pvpanic_data.is_ioport = true;
 	}
 
-	return AE_ERROR;
-}
-
-static int pvpanic_add(struct acpi_device *device)
-{
-	int ret;
-
-	ret = acpi_bus_get_status(device);
-	if (ret < 0)
-		return ret;
-
-	if (!device->status.enabled || !device->status.functional)
-		return -ENODEV;
-
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    pvpanic_walk_resources, NULL);
-
-	if (!base)
-		return -ENODEV;
-
+	pvpanic_data.base = base;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
 
 	return 0;
 }
 
-static int pvpanic_remove(struct acpi_device *device)
+static int pvpanic_platform_remove(struct platform_device *pdev)
 {
-
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
-	iounmap(base);
-
-	return 0;
-}
-
-static int pvpanic_register_acpi_driver(void)
-{
-	return acpi_bus_register_driver(&pvpanic_driver);
-}
-
-static void pvpanic_unregister_acpi_driver(void)
-{
-	acpi_bus_unregister_driver(&pvpanic_driver);
-}
-#else
-static int pvpanic_register_acpi_driver(void)
-{
-	return -ENODEV;
-}
 
-static void pvpanic_unregister_acpi_driver(void) {}
-#endif
-
-static int pvpanic_mmio_probe(struct platform_device *pdev)
-{
-	struct resource *mem;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-
-	base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static int pvpanic_mmio_remove(struct platform_device *pdev)
-{
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	if (pvpanic_data.is_ioport)
+		iounmap(pvpanic_data.base);
 
 	return 0;
 }
 
-static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
-};
-
-static struct platform_driver pvpanic_mmio_driver = {
+static struct platform_driver pvpanic_driver = {
+	.probe = pvpanic_platform_probe,
+	.remove = pvpanic_platform_remove,
 	.driver = {
-		.name = "pvpanic-mmio",
-		.of_match_table = pvpanic_mmio_match,
-	},
-	.probe = pvpanic_mmio_probe,
-	.remove = pvpanic_mmio_remove,
+		.name = "pvpanic",
+	}
 };
 
-static int __init pvpanic_mmio_init(void)
-{
-	if (acpi_disabled)
-		return platform_driver_register(&pvpanic_mmio_driver);
-	else
-		return pvpanic_register_acpi_driver();
-}
-
-static void __exit pvpanic_mmio_exit(void)
-{
-	if (acpi_disabled)
-		platform_driver_unregister(&pvpanic_mmio_driver);
-	else
-		pvpanic_unregister_acpi_driver();
-}
-
-module_init(pvpanic_mmio_init);
-module_exit(pvpanic_mmio_exit);
+module_platform_driver(pvpanic_driver);
-- 
1.8.3.1


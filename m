Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C442216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CIsTcD5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C442216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeHHTpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:45:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39696 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeHHTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:44:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so1467134pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAE3I19+1ZIuHW8YD7P2SKhYO7os9Ip5iQEbDY/0jJU=;
        b=CIsTcD5aP/HjAzpLlWfoPwsoA98Zyh9/2dlFkag+Ti+s53ggeuqpynTKcNA1w9u1Jx
         guM7JVNh3k1cK2ePpMaj7T3nApLpuaXCuCqURv0ZLKfgWrSyXduooZGlQh1bUgYjZPvB
         oRq1IrPvdR/oBWwDU46TfTnJaJiH2hi2aEu2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAE3I19+1ZIuHW8YD7P2SKhYO7os9Ip5iQEbDY/0jJU=;
        b=htN1KUSCn1wt8mtZthBgDEhoMbxWTSMYX90AP8MwSxlaiPx1LejyjmBqI5A1nxty+Y
         +JsYowjpxGPY8jzyKid4wWSBZhy8ZD/DNA99A52s5SZ44mAWZCoHi7o77zrquqHCJ3KS
         9sXJg3eY6vh7an38c3yeqv2/izLyu7cy4TP1JMJxCvg2JbehRIi+7kHIXZVy/9M5QXEm
         fdziXdlRqBEJH9qqO69o4hDYScK4bT4LYFMFnasSj6OmLSJ8d8/iHqRlhJ8a/82ilppV
         f5Ztx8p44BsRkSxQeN8Tpu7nBBaeNcGIQcroRKUeo+nGnFqXGcsvnyWAx2uOw9C5Gyrz
         4oZA==
X-Gm-Message-State: AOUpUlH8YOmgCjYSo0jHkjOi5n66zmUbNDYR/jaxSuXe8mPAJLXgmuXl
        lSCek7gNG84xzfPmJz/jhWghkg==
X-Google-Smtp-Source: AA+uWPyuvtQLTLA1bgalVke+mVyO1mWjupilh6FoxjBFfzFnzGqDSmR58SChZog4hUBuNUOI74EtdQ==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr3406708pgv.245.1533749058056;
        Wed, 08 Aug 2018 10:24:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9679503pfm.145.2018.08.08.10.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 10:24:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [PATCH v2 2/2] firmware: coreboot: Collapse platform drivers into bus core
Date:   Wed,  8 Aug 2018 10:24:14 -0700
Message-Id: <20180808172414.29983-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180808172414.29983-1-swboyd@chromium.org>
References: <20180808172414.29983-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT based and ACPI based platform drivers here do the same thing; map
some memory and hand it over to the coreboot bus to populate devices.
The only major difference is that the DT based driver doesn't map the
coreboot table header to figure out how large of a region to map for the
whole coreboot table and it uses of_iomap() instead of ioremap_cache().
A cached or non-cached mapping shouldn't matter here and mapping some
smaller region first before mapping the whole table is just more work
but should be OK. In the end, we can remove two files and combine the
code all in one place making it easier to reason about things.

We leave the old Kconfigs in place for a little while longer but make
them hidden and default to the previously hidden config option. This way
users can upgrade without having to know to reselect this config in the
future. Later on we can remove the old hidden configs.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/Kconfig               | 28 +++---
 drivers/firmware/google/Makefile              |  2 -
 drivers/firmware/google/coreboot_table-acpi.c | 88 -----------------
 drivers/firmware/google/coreboot_table-of.c   | 60 ------------
 drivers/firmware/google/coreboot_table.c      | 96 ++++++++++++++++---
 drivers/firmware/google/coreboot_table.h      |  6 --
 6 files changed, 96 insertions(+), 184 deletions(-)
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a456a000048b..42bea4dfdc4b 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -19,28 +19,22 @@ config GOOGLE_SMI
 	  variables.
 
 config GOOGLE_COREBOOT_TABLE
-	tristate
-	depends on GOOGLE_COREBOOT_TABLE_ACPI || GOOGLE_COREBOOT_TABLE_OF
-
-config GOOGLE_COREBOOT_TABLE_ACPI
-	tristate "Coreboot Table Access - ACPI"
-	depends on ACPI
-	select GOOGLE_COREBOOT_TABLE
+	tristate "Coreboot Table Access"
+	depends on ACPI || OF
 	help
 	  This option enables the coreboot_table module, which provides other
-	  firmware modules to access to the coreboot table. The coreboot table
-	  pointer is accessed through the ACPI "GOOGCB00" object.
+	  firmware modules access to the coreboot table. The coreboot table
+	  pointer is accessed through the ACPI "GOOGCB00" object or the
+	  device tree node /firmware/coreboot.
 	  If unsure say N.
 
+config GOOGLE_COREBOOT_TABLE_ACPI
+	tristate
+	default GOOGLE_COREBOOT_TABLE
+
 config GOOGLE_COREBOOT_TABLE_OF
-	tristate "Coreboot Table Access - Device Tree"
-	depends on OF
-	select GOOGLE_COREBOOT_TABLE
-	help
-	  This option enable the coreboot_table module, which provide other
-	  firmware modules to access coreboot table. The coreboot table pointer
-	  is accessed through the device tree node /firmware/coreboot.
-	  If unsure say N.
+	tristate
+	default GOOGLE_COREBOOT_TABLE
 
 config GOOGLE_MEMCONSOLE
 	tristate
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d0b3fba96194..d17caded5d88 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -2,8 +2,6 @@
 
 obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
 obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
-obj-$(CONFIG_GOOGLE_COREBOOT_TABLE_ACPI)   += coreboot_table-acpi.o
-obj-$(CONFIG_GOOGLE_COREBOOT_TABLE_OF)     += coreboot_table-of.o
 obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
diff --git a/drivers/firmware/google/coreboot_table-acpi.c b/drivers/firmware/google/coreboot_table-acpi.c
deleted file mode 100644
index 77197fe3d42f..000000000000
--- a/drivers/firmware/google/coreboot_table-acpi.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * coreboot_table-acpi.c
- *
- * Using ACPI to locate Coreboot table and provide coreboot table access.
- *
- * Copyright 2017 Google Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/acpi.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include "coreboot_table.h"
-
-static int coreboot_table_acpi_probe(struct platform_device *pdev)
-{
-	phys_addr_t phyaddr;
-	resource_size_t len;
-	struct coreboot_table_header __iomem *header = NULL;
-	struct resource *res;
-	void __iomem *ptr = NULL;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	len = resource_size(res);
-	if (!res->start || !len)
-		return -EINVAL;
-
-	phyaddr = res->start;
-	header = ioremap_cache(phyaddr, sizeof(*header));
-	if (header == NULL)
-		return -ENOMEM;
-
-	ptr = ioremap_cache(phyaddr,
-			    header->header_bytes + header->table_bytes);
-	iounmap(header);
-	if (!ptr)
-		return -ENOMEM;
-
-	return coreboot_table_init(&pdev->dev, ptr);
-}
-
-static int coreboot_table_acpi_remove(struct platform_device *pdev)
-{
-	return coreboot_table_exit();
-}
-
-static const struct acpi_device_id cros_coreboot_acpi_match[] = {
-	{ "GOOGCB00", 0 },
-	{ "BOOT0000", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, cros_coreboot_acpi_match);
-
-static struct platform_driver coreboot_table_acpi_driver = {
-	.probe = coreboot_table_acpi_probe,
-	.remove = coreboot_table_acpi_remove,
-	.driver = {
-		.name = "coreboot_table_acpi",
-		.acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
-	},
-};
-
-static int __init coreboot_table_acpi_init(void)
-{
-	return platform_driver_register(&coreboot_table_acpi_driver);
-}
-
-module_init(coreboot_table_acpi_init);
-
-MODULE_AUTHOR("Google, Inc.");
-MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
deleted file mode 100644
index 9b90c0fa4a0b..000000000000
--- a/drivers/firmware/google/coreboot_table-of.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * coreboot_table-of.c
- *
- * Coreboot table access through open firmware.
- *
- * Copyright 2017 Google Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-
-#include "coreboot_table.h"
-
-static int coreboot_table_of_probe(struct platform_device *pdev)
-{
-	struct device_node *fw_dn = pdev->dev.of_node;
-	void __iomem *ptr;
-
-	ptr = of_iomap(fw_dn, 0);
-	if (!ptr)
-		return -ENOMEM;
-
-	return coreboot_table_init(&pdev->dev, ptr);
-}
-
-static int coreboot_table_of_remove(struct platform_device *pdev)
-{
-	return coreboot_table_exit();
-}
-
-static const struct of_device_id coreboot_of_match[] = {
-	{ .compatible = "coreboot" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, coreboot_of_match);
-
-static struct platform_driver coreboot_table_of_driver = {
-	.probe = coreboot_table_of_probe,
-	.remove = coreboot_table_of_remove,
-	.driver = {
-		.name = "coreboot_table_of",
-		.of_match_table = coreboot_of_match,
-	},
-};
-module_platform_driver(coreboot_table_of_driver);
-
-MODULE_AUTHOR("Google, Inc.");
-MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 19db5709ae28..9a1d066ec9ad 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -16,12 +16,15 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "coreboot_table.h"
@@ -70,12 +73,6 @@ static struct bus_type coreboot_bus_type = {
 	.remove		= coreboot_bus_remove,
 };
 
-static int __init coreboot_bus_init(void)
-{
-	return bus_register(&coreboot_bus_type);
-}
-module_init(coreboot_bus_init);
-
 static void coreboot_device_release(struct device *dev)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -97,7 +94,7 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
-int coreboot_table_init(struct device *dev, void __iomem *ptr)
+static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 {
 	int i, ret;
 	void *ptr_entry;
@@ -140,19 +137,96 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 	return ret;
 }
-EXPORT_SYMBOL(coreboot_table_init);
 
-int coreboot_table_exit(void)
+static int coreboot_table_probe(struct platform_device *pdev)
+{
+	phys_addr_t phyaddr;
+	resource_size_t len;
+	struct coreboot_table_header __iomem *header = NULL;
+	struct resource *res;
+	void __iomem *ptr = NULL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	len = resource_size(res);
+	if (!res->start || !len)
+		return -EINVAL;
+
+	phyaddr = res->start;
+	header = ioremap_cache(phyaddr, sizeof(*header));
+	if (header == NULL)
+		return -ENOMEM;
+
+	ptr = ioremap_cache(phyaddr,
+			    header->header_bytes + header->table_bytes);
+	iounmap(header);
+	if (!ptr)
+		return -ENOMEM;
+
+	return coreboot_table_init(&pdev->dev, ptr);
+}
+
+static int coreboot_table_remove(struct platform_device *pdev)
 {
 	if (ptr_header) {
 		bus_unregister(&coreboot_bus_type);
 		iounmap(ptr_header);
 		ptr_header = NULL;
 	}
-
 	return 0;
 }
-EXPORT_SYMBOL(coreboot_table_exit);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_coreboot_acpi_match[] = {
+	{ "GOOGCB00", 0 },
+	{ "BOOT0000", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_coreboot_acpi_match);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id coreboot_of_match[] = {
+	{ .compatible = "coreboot" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, coreboot_of_match);
+#endif
+
+static struct platform_driver coreboot_table_driver = {
+	.probe = coreboot_table_probe,
+	.remove = coreboot_table_remove,
+	.driver = {
+		.name = "coreboot_table",
+		.acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
+		.of_match_table = of_match_ptr(coreboot_of_match),
+	},
+};
+
+static int __init coreboot_init(void)
+{
+	int ret;
+
+	ret = bus_register(&coreboot_bus_type);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&coreboot_table_driver);
+	if (ret)
+		bus_unregister(&coreboot_bus_type);
+
+	return ret;
+}
+module_init(coreboot_init);
+
+static void __exit coreboot_exit(void)
+{
+	platform_driver_unregister(&coreboot_table_driver);
+	bus_unregister(&coreboot_bus_type);
+}
+module_exit(coreboot_exit);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 8ad95a94481b..71a9de6b15fa 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -91,10 +91,4 @@ int coreboot_driver_register(struct coreboot_driver *driver);
 /* Unregister a driver that uses the data from a coreboot table. */
 void coreboot_driver_unregister(struct coreboot_driver *driver);
 
-/* Initialize coreboot table module given a pointer to iomem */
-int coreboot_table_init(struct device *dev, void __iomem *ptr);
-
-/* Cleanup coreboot table module */
-int coreboot_table_exit(void);
-
 #endif /* __COREBOOT_TABLE_H */
-- 
Sent by a computer through tubes


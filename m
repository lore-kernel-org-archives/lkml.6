Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E767C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2AD21EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ye3KFHKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2AD21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeHITnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37874 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbeHITnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so3053684pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qAEHBVzpuJCzdx9uesoYBHL9K4/BNoFgSXeBy69WSQ=;
        b=Ye3KFHKbxSLY9FbHUxshfXQw82S8TwRuAigvqilvlVxs0CUbfoK61HBBegvIExUO0M
         e2E95X28xcUzxxbwBW/gAWTovDdNWeXO/7+F+v/hsHqjmsnfKBHAeIu3mwHxhoPZe3p6
         ewkJ12l8T6A3V2/d1m19WXHq83Es0TgCLiSlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qAEHBVzpuJCzdx9uesoYBHL9K4/BNoFgSXeBy69WSQ=;
        b=sOpF6R2N9rPBTSKQt/+p0oHgCqIhaZdpZr3QT0i3M+1S9YUpf9T6iX+CkMHwCZvlif
         XRIo48D/WK/0Ew/O/fmuo23zEbBq6YwqWPZ+SCqKK1+e7dRQrE375+m4m7ZzNjJwAOLr
         GbhPRAv95S1ZLspUm8tVhYx7m0kPELzz8FEwQWJnGhyib1n81Mk1sZPbE6EtMh4ROfHh
         WJreJsV5gw/Zqp+027VVyEKWnD+dW8LmLXTmpuZXlQf6Pziie+tTPhIcs4COfLroa3/x
         wsq1+lsMycErPhp6HbKF7QENH7MeyjzA/5LPQArRyy61amrh1+xlmSRKWTYPHdsoWyp2
         RMnQ==
X-Gm-Message-State: AOUpUlFYFXFPO1lhGOVkPG5620XhmLnChOJ4HD/fQYFb0vxz62bpPeaK
        uAURy+BFvETD/DsfqZL+RCvS3w==
X-Google-Smtp-Source: AA+uWPzIz9GcOfLpAaQooDjMRLZFEDJjy3Fcbbj9R8RAzFYYn52wcUbU2flImpNLeDwk31Sdl4TqaA==
X-Received: by 2002:a63:1063:: with SMTP id 35-v6mr2986665pgq.249.1533835047065;
        Thu, 09 Aug 2018 10:17:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/7] firmware: coreboot: Collapse platform drivers into bus core
Date:   Thu,  9 Aug 2018 10:17:19 -0700
Message-Id: <20180809171722.144325-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
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
them hidden and select the previously hidden config option. This way
users can upgrade without having to know to reselect this config in the
future. Later on we can remove the old hidden configs.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/Kconfig               | 26 +++---
 drivers/firmware/google/Makefile              |  2 -
 drivers/firmware/google/coreboot_table-acpi.c | 88 -------------------
 drivers/firmware/google/coreboot_table-of.c   | 60 -------------
 drivers/firmware/google/coreboot_table.c      | 66 +++++++++++++-
 drivers/firmware/google/coreboot_table.h      |  6 --
 6 files changed, 72 insertions(+), 176 deletions(-)
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a456a000048b..16564cfa47ef 100644
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
+	select GOOGLE_COREBOOT_TABLE
+
 config GOOGLE_COREBOOT_TABLE_OF
-	tristate "Coreboot Table Access - Device Tree"
-	depends on OF
+	tristate
 	select GOOGLE_COREBOOT_TABLE
-	help
-	  This option enable the coreboot_table module, which provide other
-	  firmware modules to access coreboot table. The coreboot table pointer
-	  is accessed through the device tree node /firmware/coreboot.
-	  If unsure say N.
 
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
index 0e461d776ce6..feb31502f64b 100644
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
@@ -91,7 +94,7 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
-int coreboot_table_init(struct device *dev, void __iomem *ptr)
+static int coreboot_table_init(struct device *dev, void __iomem *ptr)
 {
 	int i, ret;
 	void *ptr_entry;
@@ -143,9 +146,38 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
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
@@ -155,7 +187,33 @@ int coreboot_table_exit(void)
 
 	return 0;
 }
-EXPORT_SYMBOL(coreboot_table_exit);
 
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
+module_platform_driver(coreboot_table_driver);
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


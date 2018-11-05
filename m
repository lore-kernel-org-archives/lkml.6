Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD9C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7584B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7584B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeKFATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:19:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:50023 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKFATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:19:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="105410059"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 06:59:37 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 3/6] ACPI / glue: Add acpi_platform_notify() function
Date:   Mon,  5 Nov 2018 17:59:25 +0300
Message-Id: <20181105145928.46819-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
References: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on the "platform_notify" callback hook,
introducing separate notification function
acpi_platform_notify() and calling that directly from
drivers core when device entries are added and removed.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/bus.c      |  1 -
 drivers/acpi/glue.c     | 21 +++++++++++++--------
 drivers/acpi/internal.h |  1 -
 drivers/base/core.c     |  7 +++++++
 include/linux/acpi.h    | 10 ++++++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bb3d96dea6db..99d820a693a8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1237,7 +1237,6 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
-	init_acpi_device_notify();
 	result = acpi_bus_init();
 	if (result) {
 		disable_acpi();
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 12ba2bee8789..edd10b3c7ec8 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -296,7 +296,7 @@ int acpi_unbind_one(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
-static int acpi_platform_notify(struct device *dev)
+static int acpi_device_notify(struct device *dev)
 {
 	struct acpi_bus_type *type = acpi_get_bus_type(dev);
 	struct acpi_device *adev;
@@ -343,7 +343,7 @@ static int acpi_platform_notify(struct device *dev)
 	return ret;
 }
 
-static int acpi_platform_notify_remove(struct device *dev)
+static int acpi_device_notify_remove(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_bus_type *type;
@@ -361,12 +361,17 @@ static int acpi_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-void __init init_acpi_device_notify(void)
+int acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
-	if (platform_notify || platform_notify_remove) {
-		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
-		return;
+	switch (action) {
+	case KOBJ_ADD:
+		acpi_device_notify(dev);
+		break;
+	case KOBJ_REMOVE:
+		acpi_device_notify_remove(dev);
+		break;
+	default:
+		break;
 	}
-	platform_notify = acpi_platform_notify;
-	platform_notify_remove = acpi_platform_notify_remove;
+	return 0;
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 530a3f675490..83a7dfb7d1cf 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,7 +23,6 @@
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
-void init_acpi_device_notify(void);
 int acpi_scan_init(void);
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3972ef3f080b..260cbdf44f1d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2006 Novell, Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
@@ -731,6 +732,12 @@ static inline int device_is_not_partition(struct device *dev)
 static int
 device_platform_notify(struct device *dev, enum kobject_action action)
 {
+	int ret;
+
+	ret = acpi_platform_notify(dev, action);
+	if (ret)
+		return ret;
+
 	if (platform_notify && action == KOBJ_ADD)
 		platform_notify(dev);
 	else if (platform_notify_remove && action == KOBJ_REMOVE)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed80f147bd50..4ba2e2d24676 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1313,4 +1313,14 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+#else
+static inline int
+acpi_platform_notify(struct device *dev, enum kobject_action action)
+{
+	return 0;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.19.1


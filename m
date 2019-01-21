Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261AC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E05320870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfAULCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:02:15 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:25060 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfAULCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:02:07 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 39A6B70DCC5E6733BFCD;
        Mon, 21 Jan 2019 19:02:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0LB1tYr011566;
        Mon, 21 Jan 2019 19:01:55 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012119020324-23367746 ;
          Mon, 21 Jan 2019 19:02:03 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH 4/6]  misc/pvpanic : add pvpanic acpi driver
Date:   Tue, 22 Jan 2019 03:25:09 +0800
Message-Id: <1548098711-52497-4-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-21 19:02:03,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-21 19:01:55,
        Serialize complete at 2019-01-21 19:01:55
X-MAIL: mse01.zte.com.cn x0LB1tYr011566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic acpi driver in pvpanic driver framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/Kconfig        |  9 +++++
 drivers/misc/pvpanic/Makefile       |  1 +
 drivers/misc/pvpanic/pvpanic-acpi.c | 77 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 3e612c6..d274130 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -5,3 +5,12 @@ config PVPANIC
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
+
+if PVPANIC
+
+config PVPANIC_ACPI
+	tristate "pvpanic acpi driver"
+	depends on ACPI
+	default PVPANIC
+
+endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 6394224..c5b73ca 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -3,3 +3,4 @@
 # Copyright (c) 2018 ZTE Ltd.
 
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
+obj-$(CONFIG_PVPANIC_ACPI)	 += pvpanic-acpi.o
diff --git a/drivers/misc/pvpanic/pvpanic-acpi.c b/drivers/misc/pvpanic/pvpanic-acpi.c
new file mode 100644
index 0000000..a6153fa
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-acpi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  pvpanic acpi driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao
+ */
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_add(struct acpi_device *device);
+static int pvpanic_remove(struct acpi_device *device);
+
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 }
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
+static struct acpi_driver pvpanic_driver = {
+	.name =         "pvpanic",
+	.class =        "QEMU",
+	.ids =          pvpanic_device_ids,
+	.ops =          {
+				.add =          pvpanic_add,
+				.remove =       pvpanic_remove,
+			},
+	.owner =        THIS_MODULE,
+};
+
+static acpi_status
+pvpanic_walk_resources(struct acpi_resource *res, void *context)
+{
+	struct resource r;
+	int ret = 0;
+	struct device *dev = context;
+
+	memset(&r, 0, sizeof(r));
+	if (acpi_dev_resource_io(res, &r) || acpi_dev_resource_memory(res, &r))
+		ret = pvpanic_add_device(dev, &r);
+
+	if (!ret)
+		return AE_OK;
+
+	return AE_ERROR;
+}
+static int pvpanic_add(struct acpi_device *device)
+{
+	int ret;
+	acpi_status status;
+
+	ret = acpi_bus_get_status(device);
+	if (ret < 0)
+		return ret;
+
+	if (!device->status.enabled || !device->status.functional)
+		return -ENODEV;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     pvpanic_walk_resources, &device->dev);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_remove(struct acpi_device *device)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
+module_acpi_driver(pvpanic_driver);
-- 
1.8.3.1


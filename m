Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfAWHYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:24:42 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:42226 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfAWHYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:24:41 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 936896A0B134EDB509BF;
        Wed, 23 Jan 2019 15:24:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N7OSIv027534;
        Wed, 23 Jan 2019 15:24:29 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012315245051-23701707 ;
          Wed, 23 Jan 2019 15:24:50 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 6/6]  misc/pvpanic: add new pvpanic pci driver
Date:   Wed, 23 Jan 2019 23:47:28 +0800
Message-Id: <1548258448-62013-7-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 15:24:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 15:24:21,
        Serialize complete at 2019-01-23 15:24:21
X-MAIL: mse01.zte.com.cn x0N7OSIv027534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new pvpanic pci driver to pvpanic driver framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/Kconfig       |  5 ++++
 drivers/misc/pvpanic/Makefile      |  1 +
 drivers/misc/pvpanic/pvpanic-pci.c | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 47f8709..46b6e05 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -17,4 +17,9 @@ config PVPANIC_OF
 	tristate "pvpanic mmio driver"
 	depends on OF
 
+config PVPANIC_PCI
+	tristate "pvpanic pci driver"
+	depends on PCI
+	default PVPANIC
+
 endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 63ef0db..7c71f85 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
 obj-$(CONFIG_PVPANIC_ACPI)	 += pvpanic-acpi.o
 obj-$(CONFIG_PVPANIC_OF)	 += pvpanic-of.o
+obj-$(CONFIG_PVPANIC_PCI)	 += pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 0000000..b4f453b
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic acpi driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
+
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int ret;
+	struct resource res;
+
+	ret = pcim_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	memset(&res, 0, sizeof(res));
+	res.start = pci_resource_start(pdev, 0);
+	res.end = pci_resource_end(pdev, 0);
+	res.flags = IORESOURCE_MEM;
+	ret = pvpanic_add_device(&pdev->dev, &res);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	pvpanic_remove_device();
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1


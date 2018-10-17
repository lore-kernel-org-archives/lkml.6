Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF11C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BA5214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BA5214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJQJuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:50:25 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:60494 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeJQJuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:50:25 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E41A9B93F04058216E81;
        Wed, 17 Oct 2018 09:57:06 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9H1urjX094830;
        Wed, 17 Oct 2018 09:56:53 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101709571324-4977172 ;
          Wed, 17 Oct 2018 09:57:13 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm64/pvpanic-mmio : add pvpanic mmio device
Date:   Wed, 17 Oct 2018 18:08:23 +0800
Message-Id: <1539770903-18531-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-17 09:57:13,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-17 09:56:45,
        Serialize complete at 2018-10-17 09:56:45
X-MAIL: mse01.zte.com.cn w9H1urjX094830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a platform device driver, pvpanic-mmio that is similar
to x86's pvpanic device.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/platform/Kconfig            |   3 +
 drivers/platform/Makefile           |   1 +
 drivers/platform/arm/Kconfig        |   6 ++
 drivers/platform/arm/Makefile       |   6 ++
 drivers/platform/arm/pvpanic-mmio.c | 123 ++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 drivers/platform/arm/Kconfig
 create mode 100644 drivers/platform/arm/Makefile
 create mode 100644 drivers/platform/arm/pvpanic-mmio.c

diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index d4c2e42..8b64b78 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,3 +1,6 @@
+if ARM64
+source "drivers/platform/arm/Kconfig"
+endif
 if X86
 source "drivers/platform/x86/Kconfig"
 endif
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 4b2ce58..232231c 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -3,6 +3,7 @@
 # Makefile for linux/drivers/platform
 #
 
+obj-$(CONFIG_ARM64)               += arm/
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
 obj-$(CONFIG_MIPS)		+= mips/
diff --git a/drivers/platform/arm/Kconfig b/drivers/platform/arm/Kconfig
new file mode 100644
index 0000000..89fd694
--- /dev/null
+++ b/drivers/platform/arm/Kconfig
@@ -0,0 +1,6 @@
+config PVPANIC_MMIO
+        tristate "pvpanic mmio device support"
+        help
+          This driver provides support for the pvpanic mmio device. pvpanic mmio
+          is a paravirtualized device provided by QEMU; it lets a virtual machine
+          (guest) communicate panic events to the host.
diff --git a/drivers/platform/arm/Makefile b/drivers/platform/arm/Makefile
new file mode 100644
index 0000000..a68af01
--- /dev/null
+++ b/drivers/platform/arm/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/arm
+# arm Platform-Specific Drivers
+#
+obj-$(CONFIG_PVPANIC_MMIO) = pvpanic-mmio.o
diff --git a/drivers/platform/arm/pvpanic-mmio.c b/drivers/platform/arm/pvpanic-mmio.c
new file mode 100644
index 0000000..6a06d24
--- /dev/null
+++ b/drivers/platform/arm/pvpanic-mmio.c
@@ -0,0 +1,123 @@
+/*
+ * pvpanic mmio device driver
+ *
+ * Copyright (C) 2018 ZTE Ltd.
+ * Author: Peng Hao <peng.hao2@zte.com.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/virt.h>
+#include <linux/platform_device.h>
+
+#define PVPANIC_MMIO_CRASHED	(1 << 0)
+
+struct pvpanic_mmio_device {
+	void __iomem *base;
+};
+
+static struct pvpanic_mmio_device pvpanic_mmio_dev;
+
+static void
+pvpanic_mmio_trigger_event(unsigned int event)
+{
+	writeb(event, pvpanic_mmio_dev.base);
+}
+
+static int
+pvpanic_mmio_crash_notify(struct notifier_block *nb, unsigned long code,
+			void *unused)
+{
+	pvpanic_mmio_trigger_event(PVPANIC_MMIO_CRASHED);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pvpanic_mmio_crash_nb = {
+	.notifier_call = pvpanic_mmio_crash_notify,
+	.priority = 1,
+};
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -EINVAL;
+
+	if (!devm_request_mem_region(&pdev->dev, mem->start,
+				resource_size(mem), pdev->name))
+		return -EBUSY;
+
+	pvpanic_mmio_dev.base = devm_ioremap(&pdev->dev, mem->start,
+										resource_size(mem));
+	if (pvpanic_mmio_dev.base == NULL)
+		return -EFAULT;
+
+	platform_set_drvdata(pdev, &pvpanic_mmio_dev);
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+								  &pvpanic_mmio_crash_nb);
+
+	return 0;
+}
+
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					&pvpanic_mmio_crash_nb);
+	devm_kfree(&pdev->dev, &pvpanic_mmio_dev);
+	return 0;
+}
+
+static const struct of_device_id pvpanic_mmio_match[] = {
+	{ .compatible = "pvpanic,mmio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
+
+static struct platform_driver pvpanic_mmio_driver = {
+	.probe =        pvpanic_mmio_probe,
+	.remove =       pvpanic_mmio_remove,
+	.driver = {
+		.name =	"pvpanic-mmio",
+		.of_match_table = pvpanic_mmio_match,
+	},
+};
+
+static int __init pvpanic_mmio_init(void)
+{
+	return platform_driver_register(&pvpanic_mmio_driver);
+}
+
+static void __exit pvpanic_mmio_exit(void)
+{
+	platform_driver_unregister(&pvpanic_mmio_driver);
+}
+
+module_init(pvpanic_mmio_init);
+module_exit(pvpanic_mmio_exit);
+
+MODULE_AUTHOR("Peng Hao<peng.hao2@zte.com.cn>");
+MODULE_DESCRIPTION("pvpanic mmio device driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1


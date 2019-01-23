Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCBDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E221019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAWHYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:24:39 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:16536 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfAWHYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:24:37 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BB522D430BFDCCC2A050;
        Wed, 23 Jan 2019 15:24:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N7OROg027511;
        Wed, 23 Jan 2019 15:24:27 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012315244960-23701706 ;
          Wed, 23 Jan 2019 15:24:49 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 5/6]  misc/pvpanic: add pvpanic mmio driver
Date:   Wed, 23 Jan 2019 23:47:27 +0800
Message-Id: <1548258448-62013-6-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 15:24:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 15:24:20,
        Serialize complete at 2019-01-23 15:24:20
X-MAIL: mse01.zte.com.cn x0N7OROg027511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make pvpanic mmio driver as seperate file and modify code
in order to adapt the framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/Kconfig      |  4 +++
 drivers/misc/pvpanic/Makefile     |  1 +
 drivers/misc/pvpanic/pvpanic-of.c | 53 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic-of.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index d274130..47f8709 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -13,4 +13,8 @@ config PVPANIC_ACPI
 	depends on ACPI
 	default PVPANIC
 
+config PVPANIC_OF
+	tristate "pvpanic mmio driver"
+	depends on OF
+
 endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index c5b73ca..63ef0db 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
 obj-$(CONFIG_PVPANIC_ACPI)	 += pvpanic-acpi.o
+obj-$(CONFIG_PVPANIC_OF)	 += pvpanic-of.o
diff --git a/drivers/misc/pvpanic/pvpanic-of.c b/drivers/misc/pvpanic/pvpanic-of.c
new file mode 100644
index 0000000..73ca5f3
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-of.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic of driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	ret = pvpanic_add_device(&pdev->dev, res);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
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
+module_platform_driver(pvpanic_mmio_driver);
-- 
1.8.3.1


Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9AFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92121564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwUDw2X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C92121564
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeI0FSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:18:41 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46582 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:18:41 -0400
Received: by mail-yb1-f202.google.com with SMTP id m16-v6so387252ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XdBK4IqMncCkLn3j7ma3uKS/dMETW5LEp//ayj5o1FY=;
        b=jwUDw2X+j2EHCRoHNlPhKm1GBIL3/q5zE+GWxIqtOLHUQWg8EA++kpqblmiWEPxjPp
         PbR4adQFU+tmg4w6jhEvInXISaYvYwX2MNlU+aeayM6NkmfuVVLNXiTn+ee0ndg1ZsiB
         mXXbNx8hnI/icddzuUlsND5ypEOwG6eRJcppIYdVnqK9g+1FDHJ2xXT2WDa1U3/TE1AT
         5dlvCw8rIFDR6i3LnSVlzpLM3CHuonSqAi2a6RHNkZpCstpw8tjaHVlHmSHtHOlBzcel
         nUR6zgPd1V0/JxHqBFpJrtlfwq3bjgyT+khTLX3YSDeI/a/WCY+Z20b/hu+vn5X5+cPG
         OBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XdBK4IqMncCkLn3j7ma3uKS/dMETW5LEp//ayj5o1FY=;
        b=krkMUYySfyBDHYw8RKMkSsha1Gv09DOiEuVREKSaGOXfTnrZqEvt89L04rxOeIvNi6
         c8+HE7UCOaWhoTfmiage49OiIveISzjDoM063YPYBWOauE8g33Nzimb+2cPhh9irWkfN
         82K4a89ETVbmWqBmCiz958YZwINNn0vskZ0krShtbADUz0Hz7rxvHY1UNHnr9x6MqiJV
         qm75rnGMMPUnI7/e/M4iQ/5jouM+P2c9Y7PI1GkaLW/AeRnnLldtpnKrwFi6haJNxGlJ
         FvtJ79aaVVPj9c7JjY6vV8Do9PTWIg47qScqnFuim7Eh0TTnO2oJ7UwVkunX5FWKvB/e
         bxTw==
X-Gm-Message-State: ABuFfoi4isDC3CSCRKU+onyNDsvbrcvH5e4lI6vn/rytM4d44MDjXmtV
        UK107jCcQeKB+m6o/Z5qKplr/d6L
X-Google-Smtp-Source: ACcGV6252dBjXA0ZvpEGTj3ZwxT1DbF+UNokz6AvkHEpX2tnYjYv3+07CEy/ah8ZwK9+qhXChFvyJRsh
X-Received: by 2002:a25:3b8c:: with SMTP id i134-v6mr1238943yba.33.1538003005169;
 Wed, 26 Sep 2018 16:03:25 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:02:21 -0700
In-Reply-To: <20180926230222.126513-1-rkir@google.com>
Message-Id: <20180926230222.126513-3-rkir@google.com>
Mime-Version: 1.0
References: <20180926230222.126513-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 13/21] platform: goldfish: pipe: Split the driver to v2
 specific and the rest
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Move probe/remove and other driver stuff to a separate file
to plug v1 there later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Removed breakage of allmodconfig.

 drivers/platform/goldfish/Makefile           |   3 +-
 drivers/platform/goldfish/goldfish_pipe.c    | 145 +++++++++++++++++++
 drivers/platform/goldfish/goldfish_pipe.h    |  24 +++
 drivers/platform/goldfish/goldfish_pipe_v2.c | 102 ++-----------
 drivers/platform/goldfish/goldfish_pipe_v2.h |  24 +++
 5 files changed, 210 insertions(+), 88 deletions(-)
 create mode 100644 drivers/platform/goldfish/goldfish_pipe.c
 create mode 100644 drivers/platform/goldfish/goldfish_pipe.h
 create mode 100644 drivers/platform/goldfish/goldfish_pipe_v2.h

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index 81f899a987a2..016769e003d8 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,4 +1,5 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_v2.o
+obj-$(CONFIG_GOLDFISH_PIPE)    += goldfish_pipe_all.o
+goldfish_pipe_all-objs := goldfish_pipe.o goldfish_pipe_v2.o
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
new file mode 100644
index 000000000000..802bbf0d6d23
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Intel, Inc.
+ * Copyright (C) 2013 Intel, Inc.
+ * Copyright (C) 2014 Linaro Limited
+ * Copyright (C) 2011-2016 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/* This source file contains the implementation of a special device driver
+ * that intends to provide a *very* fast communication channel between the
+ * guest system and the QEMU emulator.
+ *
+ * Usage from the guest is simply the following (error handling simplified):
+ *
+ *    int  fd = open("/dev/qemu_pipe",O_RDWR);
+ *    .... write() or read() through the pipe.
+ *
+ * This driver doesn't deal with the exact protocol used during the session.
+ * It is intended to be as simple as something like:
+ *
+ *    // do this _just_ after opening the fd to connect to a specific
+ *    // emulator service.
+ *    const char*  msg = "<pipename>";
+ *    if (write(fd, msg, strlen(msg)+1) < 0) {
+ *       ... could not connect to <pipename> service
+ *       close(fd);
+ *    }
+ *
+ *    // after this, simply read() and write() to communicate with the
+ *    // service. Exact protocol details left as an exercise to the reader.
+ *
+ * This driver is very fast because it doesn't copy any data through
+ * intermediate buffers, since the emulator is capable of translating
+ * guest user addresses into host ones.
+ *
+ * Note that we must however ensure that each user page involved in the
+ * exchange is properly mapped during a transfer.
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+#include "goldfish_pipe_qemu.h"
+#include "goldfish_pipe.h"
+#include "goldfish_pipe_v2.h"
+
+/*
+ * Update this when something changes in the driver's behavior so the host
+ * can benefit from knowing it
+ * Notes:
+ *	version 2 was an intermediate release and isn't supported anymore.
+ *	version 3 is goldfish_pipe_v2 without DMA support.
+ *	version 4 (current) is goldfish_pipe_v2 with DMA support.
+ */
+enum {
+	PIPE_DRIVER_VERSION = 4,
+	PIPE_CURRENT_DEVICE_VERSION = 2
+};
+
+static int goldfish_pipe_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	char __iomem *base;
+	int irq;
+	int version;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r || resource_size(r) < PAGE_SIZE) {
+		dev_err(&pdev->dev, "can't allocate i/o page\n");
+		return -EINVAL;
+	}
+	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		return -EINVAL;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!r)
+		return -EINVAL;
+
+	irq = r->start;
+
+	/*
+	 * Exchange the versions with the host device
+	 *
+	 * Note: v1 driver used to not report its version, so we write it before
+	 *  reading device version back: this allows the host implementation to
+	 *  detect the old driver (if there was no version write before read).
+	 */
+	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
+	version = readl(base + PIPE_REG_VERSION);
+
+	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
+		return -EINVAL;
+
+	return goldfish_pipe_device_init(pdev, base, irq);
+}
+
+static int goldfish_pipe_remove(struct platform_device *pdev)
+{
+	struct goldfish_pipe_dev_base *dev = platform_get_drvdata(pdev);
+
+	return dev->deinit(dev, pdev);
+}
+
+static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
+	{ "GFSH0003", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
+
+static const struct of_device_id goldfish_pipe_of_match[] = {
+	{ .compatible = "google,android-pipe", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_pipe_of_match);
+
+static struct platform_driver goldfish_pipe_driver = {
+	.probe = goldfish_pipe_probe,
+	.remove = goldfish_pipe_remove,
+	.driver = {
+		.name = "goldfish_pipe",
+		.of_match_table = goldfish_pipe_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
+	}
+};
+
+module_platform_driver(goldfish_pipe_driver);
+MODULE_AUTHOR("David Turner <digit@google.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/goldfish/goldfish_pipe.h b/drivers/platform/goldfish/goldfish_pipe.h
new file mode 100644
index 000000000000..41e831f59eff
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef GOLDFISH_PIPE_H
+#define GOLDFISH_PIPE_H
+
+struct goldfish_pipe_dev_base {
+	/* the destructor, the pointer is set in init */
+	int (*deinit)(void *pipe_dev, struct platform_device *pdev);
+};
+
+#endif /* GOLDFISH_PIPE_H */
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 7187b2e603d4..d653e5a2ffcc 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -47,8 +47,6 @@
  * exchange is properly mapped during a transfer.
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -61,10 +59,10 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
-#include <linux/acpi.h>
 #include <linux/bug.h>
 #include <uapi/linux/goldfish/goldfish_dma.h>
 #include "goldfish_pipe_qemu.h"
+#include "goldfish_pipe.h"
 
 /*
  * Update this when something changes in the driver's behavior so the host
@@ -89,6 +87,9 @@ enum {
 
 struct goldfish_pipe_dev;
 
+static int goldfish_pipe_device_deinit(void *raw_dev,
+				       struct platform_device *pdev);
+
 /* A per-pipe command structure, shared with the host */
 struct goldfish_pipe_command {
 	s32 cmd;	/* PipeCmdCode, guest -> host */
@@ -202,8 +203,8 @@ struct goldfish_pipe {
  * waiting to be awoken.
  */
 struct goldfish_pipe_dev {
-	/* A magic number to check if this is an instance of this struct */
-	void *magic;
+	/* Needed for 'remove' */
+	struct goldfish_pipe_dev_base super;
 
 	/*
 	 * Global device spinlock. Protects the following members:
@@ -646,9 +647,6 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 	}
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev,
-					struct goldfish_pipe_dev *dev);
-
 /*
  * The general idea of the interrupt handling:
  *
@@ -669,7 +667,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev->magic != &goldfish_pipe_device_deinit)
+	if (dev->super.deinit != &goldfish_pipe_device_deinit)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -1122,9 +1120,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-static int goldfish_pipe_device_init(struct platform_device *pdev,
-				     char __iomem *base,
-				     int irq)
+int goldfish_pipe_device_init(struct platform_device *pdev,
+			      char __iomem *base,
+			      int irq)
 {
 	struct goldfish_pipe_dev *dev;
 	int err;
@@ -1133,7 +1131,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	if (!dev)
 		return -ENOMEM;
 
-	dev->magic = &goldfish_pipe_device_deinit;
+	dev->super.deinit = &goldfish_pipe_device_deinit;
 	spin_lock_init(&dev->lock);
 
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
@@ -1193,9 +1191,11 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	return 0;
 }
 
-static int goldfish_pipe_device_deinit(struct platform_device *pdev,
-				       struct goldfish_pipe_dev *dev)
+static int goldfish_pipe_device_deinit(void *raw_dev,
+				       struct platform_device *pdev)
 {
+	struct goldfish_pipe_dev *dev = raw_dev;
+
 	misc_deregister(&dev->miscdev);
 	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
@@ -1203,75 +1203,3 @@ static int goldfish_pipe_device_deinit(struct platform_device *pdev,
 
 	return 0;
 }
-
-static int goldfish_pipe_probe(struct platform_device *pdev)
-{
-	struct resource *r;
-	char __iomem *base;
-	int irq;
-	int version;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r || resource_size(r) < PAGE_SIZE) {
-		dev_err(&pdev->dev, "can't allocate i/o page\n");
-		return -EINVAL;
-	}
-	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
-	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -EINVAL;
-	}
-
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r)
-		return -EINVAL;
-
-	irq = r->start;
-
-	/*
-	 * Exchange the versions with the host device
-	 *
-	 * Note: v1 driver used to not report its version, so we write it before
-	 *  reading device version back: this allows the host implementation to
-	 *  detect the old driver (if there was no version write before read).
-	 */
-	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
-	version = readl(base + PIPE_REG_VERSION);
-	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
-		return -EINVAL;
-
-	return goldfish_pipe_device_init(pdev, base, irq);
-}
-
-static int goldfish_pipe_remove(struct platform_device *pdev)
-{
-	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
-
-	return goldfish_pipe_device_deinit(pdev, dev);
-}
-
-static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
-	{ "GFSH0003", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
-
-static const struct of_device_id goldfish_pipe_of_match[] = {
-	{ .compatible = "google,android-pipe", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, goldfish_pipe_of_match);
-
-static struct platform_driver goldfish_pipe_driver = {
-	.probe = goldfish_pipe_probe,
-	.remove = goldfish_pipe_remove,
-	.driver = {
-		.name = "goldfish_pipe",
-		.of_match_table = goldfish_pipe_of_match,
-		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
-	}
-};
-
-module_platform_driver(goldfish_pipe_driver);
-MODULE_AUTHOR("David Turner <digit@google.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.h b/drivers/platform/goldfish/goldfish_pipe_v2.h
new file mode 100644
index 000000000000..679d863774a8
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef GOLDFISH_PIPE_V2_H
+#define GOLDFISH_PIPE_V2_H
+
+/* The entry point to the pipe v2 driver */
+int goldfish_pipe_device_init(struct platform_device *pdev,
+			      char __iomem *base,
+			      int irq);
+
+#endif /* #define GOLDFISH_PIPE_V2_H */
-- 
2.19.0.605.g01d371f741-goog


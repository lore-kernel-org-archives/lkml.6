Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BBC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385FF20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/R/18PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385FF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbeHACVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:21:50 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:48455 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbeHACVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:21:50 -0400
Received: by mail-io0-f201.google.com with SMTP id t11-v6so12576852iog.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZzOnaBTkwDj+NGTEeEMrQCVnhrUfq9KmDdHQenlOi3o=;
        b=Y/R/18PQ6qbX80IjUPmi9In8TwpgwhaOpM8WXaE5MUDDv31xVdo/5YNYsadoS6Y6yN
         Nbly/Da/SA5Kxshnk2jCQ6Rtum5GzfhiMratjWZEFH3fIRKprVNKEWp/BBLdlV9hZSu3
         Mk1xLSqCs6Fces+4BCuIYf/erucO5g84WZzIFG1PqjIGsTVsI/0uZIRB3YE4QglnGF50
         38NxA0an566MX9nL0VgNs3IXMlaBVpPMIRqQj2VPqCf9pvWNznOJx9C8lwvxItqkBkOM
         2i9wcANC5DeUOE/V7dgZnY3vUKkwxpybUfcF8kdaPwK53BLyli9mtsddOMTsF9YwSksn
         GiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZzOnaBTkwDj+NGTEeEMrQCVnhrUfq9KmDdHQenlOi3o=;
        b=iwQD/JYfjLSWCHm2yjN+02FRu6AY/Rrv6W4B7D6hdPwuyDpmy99OmbBHCPSTx+NbGM
         1FW3iwEI8HydQ0dLEt+4FfL6fxutB2Q6WAVcR6vpQ/gTi4n5IOuFXef1lErxOtul/+z7
         JPje9RWWVzr99QrmtH0/mjJqia1Ei+6Vo49E8tkSPmotNCSE3bx3orJ6LPgKIWzsfW+/
         wL6zpQUTTsBGVDB4NYH9aHfVEpSHWhC9DtXu4T17eGfpEERPfVNcmNXMJOMzXOvArgN3
         A8JDGhLvvMKXH3GW0/pm3kSEDyK0Y1T67ZxSDr8S5PPH7DMvFTaIHGFF9NyQij4iOfYB
         YQqA==
X-Gm-Message-State: AOUpUlF20EFgb0bwky3a0YyezBOSAuBdHHFoup9yoyXP7zcy8agXg+Y2
        NqVxJRqMoF/OFdavaLVkaDl0CgpW
X-Google-Smtp-Source: AAOMgpfZIxdijdscZEIVCftFQ6jGRo4bb4dw4MvhZIxbYhGpON9SLUvvAotoy4X6tE6uAshpyr/C47mQ
X-Received: by 2002:a24:56ce:: with SMTP id o197-v6mr2606823itb.32.1533083937027;
 Tue, 31 Jul 2018 17:38:57 -0700 (PDT)
Date:   Tue, 31 Jul 2018 17:38:50 -0700
Message-Id: <20180801003850.181947-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] platform: goldfish: Retire pdev_bus
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

Not used by goldfish.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/Kconfig    |   5 -
 drivers/platform/goldfish/Makefile   |   1 -
 drivers/platform/goldfish/pdev_bus.c | 232 ---------------------------
 3 files changed, 238 deletions(-)
 delete mode 100644 drivers/platform/goldfish/pdev_bus.c

diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index fefbb8370da0..479031aa4f88 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -10,11 +10,6 @@ menuconfig GOLDFISH
 
 if GOLDFISH
 
-config GOLDFISH_BUS
-	bool "Goldfish platform bus"
-	---help---
-	  This is a virtual bus to host Goldfish Android Virtual Devices.
-
 config GOLDFISH_PIPE
 	tristate "Goldfish virtual device for QEMU pipes"
 	---help---
diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index d3487125838c..e0c202df9674 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,5 +1,4 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_BUS)	+= pdev_bus.o
 obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
diff --git a/drivers/platform/goldfish/pdev_bus.c b/drivers/platform/goldfish/pdev_bus.c
deleted file mode 100644
index dd9ea463c2a4..000000000000
--- a/drivers/platform/goldfish/pdev_bus.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (C) 2011 Intel, Inc.
- * Copyright (C) 2013 Intel, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-
-#define PDEV_BUS_OP_DONE        (0x00)
-#define PDEV_BUS_OP_REMOVE_DEV  (0x04)
-#define PDEV_BUS_OP_ADD_DEV     (0x08)
-
-#define PDEV_BUS_OP_INIT        (0x00)
-
-#define PDEV_BUS_OP             (0x00)
-#define PDEV_BUS_GET_NAME       (0x04)
-#define PDEV_BUS_NAME_LEN       (0x08)
-#define PDEV_BUS_ID             (0x0c)
-#define PDEV_BUS_IO_BASE        (0x10)
-#define PDEV_BUS_IO_SIZE        (0x14)
-#define PDEV_BUS_IRQ            (0x18)
-#define PDEV_BUS_IRQ_COUNT      (0x1c)
-#define PDEV_BUS_GET_NAME_HIGH  (0x20)
-
-struct pdev_bus_dev {
-	struct list_head list;
-	struct platform_device pdev;
-	struct resource resources[0];
-};
-
-static void goldfish_pdev_worker(struct work_struct *work);
-
-static void __iomem *pdev_bus_base;
-static unsigned long pdev_bus_addr;
-static unsigned long pdev_bus_len;
-static u32 pdev_bus_irq;
-static LIST_HEAD(pdev_bus_new_devices);
-static LIST_HEAD(pdev_bus_registered_devices);
-static LIST_HEAD(pdev_bus_removed_devices);
-static DECLARE_WORK(pdev_bus_worker, goldfish_pdev_worker);
-
-
-static void goldfish_pdev_worker(struct work_struct *work)
-{
-	int ret;
-	struct pdev_bus_dev *pos, *n;
-
-	list_for_each_entry_safe(pos, n, &pdev_bus_removed_devices, list) {
-		list_del(&pos->list);
-		platform_device_unregister(&pos->pdev);
-		kfree(pos);
-	}
-	list_for_each_entry_safe(pos, n, &pdev_bus_new_devices, list) {
-		list_del(&pos->list);
-		ret = platform_device_register(&pos->pdev);
-		if (ret)
-			pr_err("goldfish_pdev_worker failed to register device, %s\n",
-								pos->pdev.name);
-		list_add_tail(&pos->list, &pdev_bus_registered_devices);
-	}
-}
-
-static void goldfish_pdev_remove(void)
-{
-	struct pdev_bus_dev *pos, *n;
-	u32 base;
-
-	base = readl(pdev_bus_base + PDEV_BUS_IO_BASE);
-
-	list_for_each_entry_safe(pos, n, &pdev_bus_new_devices, list) {
-		if (pos->resources[0].start == base) {
-			list_del(&pos->list);
-			kfree(pos);
-			return;
-		}
-	}
-	list_for_each_entry_safe(pos, n, &pdev_bus_registered_devices, list) {
-		if (pos->resources[0].start == base) {
-			list_del(&pos->list);
-			list_add_tail(&pos->list, &pdev_bus_removed_devices);
-			schedule_work(&pdev_bus_worker);
-			return;
-		}
-	};
-	pr_err("goldfish_pdev_remove could not find device at %x\n", base);
-}
-
-static int goldfish_new_pdev(void)
-{
-	struct pdev_bus_dev *dev;
-	u32 name_len;
-	u32 irq = -1, irq_count;
-	int resource_count = 2;
-	u32 base;
-	char *name;
-
-	base = readl(pdev_bus_base + PDEV_BUS_IO_BASE);
-
-	irq_count = readl(pdev_bus_base + PDEV_BUS_IRQ_COUNT);
-	name_len = readl(pdev_bus_base + PDEV_BUS_NAME_LEN);
-	if (irq_count)
-		resource_count++;
-
-	dev = kzalloc(sizeof(*dev) +
-		sizeof(struct resource) * resource_count +
-		name_len + 1 + sizeof(*dev->pdev.dev.dma_mask), GFP_ATOMIC);
-	if (dev == NULL)
-		return -ENOMEM;
-
-	dev->pdev.num_resources = resource_count;
-	dev->pdev.resource = (struct resource *)(dev + 1);
-	dev->pdev.name = name = (char *)(dev->pdev.resource + resource_count);
-	dev->pdev.dev.coherent_dma_mask = ~0;
-	dev->pdev.dev.dma_mask = (void *)(dev->pdev.name + name_len + 1);
-	*dev->pdev.dev.dma_mask = ~0;
-
-#ifdef CONFIG_64BIT
-	writel((u32)((u64)name>>32), pdev_bus_base + PDEV_BUS_GET_NAME_HIGH);
-#endif
-	writel((u32)(unsigned long)name, pdev_bus_base + PDEV_BUS_GET_NAME);
-	name[name_len] = '\0';
-	dev->pdev.id = readl(pdev_bus_base + PDEV_BUS_ID);
-	dev->pdev.resource[0].start = base;
-	dev->pdev.resource[0].end = base +
-				readl(pdev_bus_base + PDEV_BUS_IO_SIZE) - 1;
-	dev->pdev.resource[0].flags = IORESOURCE_MEM;
-	if (irq_count) {
-		irq = readl(pdev_bus_base + PDEV_BUS_IRQ);
-		dev->pdev.resource[1].start = irq;
-		dev->pdev.resource[1].end = irq + irq_count - 1;
-		dev->pdev.resource[1].flags = IORESOURCE_IRQ;
-	}
-
-	pr_debug("goldfish_new_pdev %s at %x irq %d\n", name, base, irq);
-	list_add_tail(&dev->list, &pdev_bus_new_devices);
-	schedule_work(&pdev_bus_worker);
-
-	return 0;
-}
-
-static irqreturn_t goldfish_pdev_bus_interrupt(int irq, void *dev_id)
-{
-	irqreturn_t ret = IRQ_NONE;
-
-	while (1) {
-		u32 op = readl(pdev_bus_base + PDEV_BUS_OP);
-
-		switch (op) {
-		case PDEV_BUS_OP_REMOVE_DEV:
-			goldfish_pdev_remove();
-			ret = IRQ_HANDLED;
-			break;
-
-		case PDEV_BUS_OP_ADD_DEV:
-			goldfish_new_pdev();
-			ret = IRQ_HANDLED;
-			break;
-
-		case PDEV_BUS_OP_DONE:
-		default:
-			return ret;
-		}
-	}
-}
-
-static int goldfish_pdev_bus_probe(struct platform_device *pdev)
-{
-	int ret;
-	struct resource *r;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL)
-		return -EINVAL;
-
-	pdev_bus_addr = r->start;
-	pdev_bus_len = resource_size(r);
-
-	pdev_bus_base = ioremap(pdev_bus_addr, pdev_bus_len);
-	if (pdev_bus_base == NULL) {
-		ret = -ENOMEM;
-		dev_err(&pdev->dev, "unable to map Goldfish MMIO.\n");
-		goto free_resources;
-	}
-
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (r == NULL) {
-		ret = -ENOENT;
-		goto free_map;
-	}
-
-	pdev_bus_irq = r->start;
-
-	ret = request_irq(pdev_bus_irq, goldfish_pdev_bus_interrupt,
-				IRQF_SHARED, "goldfish_pdev_bus", pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request Goldfish IRQ\n");
-		goto free_map;
-	}
-
-	writel(PDEV_BUS_OP_INIT, pdev_bus_base + PDEV_BUS_OP);
-	return 0;
-
-free_map:
-	iounmap(pdev_bus_base);
-free_resources:
-	release_mem_region(pdev_bus_addr, pdev_bus_len);
-	return ret;
-}
-
-static struct platform_driver goldfish_pdev_bus_driver = {
-	.probe = goldfish_pdev_bus_probe,
-	.driver = {
-		.name = "goldfish_pdev_bus"
-	}
-};
-builtin_platform_driver(goldfish_pdev_bus_driver);
-- 
2.18.0.345.g5c9ce644c3-goog


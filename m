Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E709C214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E709C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbeHPKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:36:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeHPKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:36:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 56CF320712; Thu, 16 Aug 2018 09:40:13 +0200 (CEST)
Received: from localhost (unknown [78.250.249.73])
        by mail.bootlin.com (Postfix) with ESMTPSA id 516CA20712;
        Thu, 16 Aug 2018 09:39:59 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] uio: ensure class is registered before devices
Date:   Thu, 16 Aug 2018 09:39:41 +0200
Message-Id: <20180816073941.13618-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both uio and the uio drivers are built in the kernel, it is possible
for a driver to register devices before the uio class is registered.

This may result in a NULL pointer dereference later on in
get_device_parent() when accessing the class glue_dirs spinlock.

The trace looks like that:

Unable to handle kernel NULL pointer dereference at virtual address 00000140
[...]
[<ffff0000089cc234>] _raw_spin_lock+0x14/0x48
[<ffff0000084f56bc>] device_add+0x154/0x6a0
[<ffff0000084f5e48>] device_create_groups_vargs+0x120/0x128
[<ffff0000084f5edc>] device_create+0x54/0x60
[<ffff0000086e72c0>] __uio_register_device+0x120/0x4a8
[<ffff000008528b7c>] jaguar2_pci_probe+0x2d4/0x558
[<ffff0000083fc18c>] local_pci_probe+0x3c/0xb8
[<ffff0000083fd81c>] pci_device_probe+0x11c/0x180
[<ffff0000084f88bc>] driver_probe_device+0x22c/0x2d8
[<ffff0000084f8a24>] __driver_attach+0xbc/0xc0
[<ffff0000084f69fc>] bus_for_each_dev+0x4c/0x98
[<ffff0000084f81b8>] driver_attach+0x20/0x28
[<ffff0000084f7d08>] bus_add_driver+0x1b8/0x228
[<ffff0000084f93c0>] driver_register+0x60/0xf8
[<ffff0000083fb918>] __pci_register_driver+0x40/0x48

Return EPROBE_DEFER in that case so the driver can register the device
later.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/uio/uio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5d421d7e8904..55b523f7499b 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -275,6 +275,8 @@ static struct class uio_class = {
 	.dev_groups = uio_groups,
 };
 
+bool uio_class_registered;
+
 /*
  * device functions
  */
@@ -884,6 +886,9 @@ static int init_uio_class(void)
 		printk(KERN_ERR "class_register failed for uio\n");
 		goto err_class_register;
 	}
+
+	uio_class_registered = true;
+
 	return 0;
 
 err_class_register:
@@ -894,6 +899,7 @@ static int init_uio_class(void)
 
 static void release_uio_class(void)
 {
+	uio_class_registered = false;
 	class_unregister(&uio_class);
 	uio_major_cleanup();
 }
@@ -920,6 +926,9 @@ int __uio_register_device(struct module *owner,
 	struct uio_device *idev;
 	int ret = 0;
 
+	if (!uio_class_registered)
+		return -EPROBE_DEFER;
+
 	if (!parent || !info || !info->name || !info->version)
 		return -EINVAL;
 
-- 
2.18.0


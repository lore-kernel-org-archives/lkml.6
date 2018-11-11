Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95662084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0VTEMBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95662084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbeKLJUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388729AbeKLIU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:29 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69BC2175B;
        Sun, 11 Nov 2018 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975432;
        bh=K1/56SurJFacMgH/sFqyYM6Y3bKdoOYS9g5636rm55Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0VTEMBBT2ZD78FxqYfxASmP7IRnLtTD+V5/iW+mnXOnGdOQoRSb5H/mz+w1ShFyl
         tfCo8lyPXTn8aBSyZXxSc/qZG/f3TQNfziAXhcr32MWhnARE4SMh4hJo2jSBkcuwTL
         vE1FBR24/QmipkG8NeU4tk8AltEwIxNx519a33wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 177/350] uio: ensure class is registered before devices
Date:   Sun, 11 Nov 2018 14:20:41 -0800
Message-Id: <20181111221715.444476238@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit ae61cf5b9913027c6953a79ed3894da4f47061bd ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

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
@@ -877,6 +879,9 @@ static int init_uio_class(void)
 		printk(KERN_ERR "class_register failed for uio\n");
 		goto err_class_register;
 	}
+
+	uio_class_registered = true;
+
 	return 0;
 
 err_class_register:
@@ -887,6 +892,7 @@ exit:
 
 static void release_uio_class(void)
 {
+	uio_class_registered = false;
 	class_unregister(&uio_class);
 	uio_major_cleanup();
 }
@@ -913,6 +919,9 @@ int __uio_register_device(struct module
 	struct uio_device *idev;
 	int ret = 0;
 
+	if (!uio_class_registered)
+		return -EPROBE_DEFER;
+
 	if (!parent || !info || !info->name || !info->version)
 		return -EINVAL;
 



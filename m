Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48295C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE2B204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2FtU52WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE2B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeKAIMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732318AbeKAIMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2AA920989;
        Wed, 31 Oct 2018 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027545;
        bh=NAnkQ42HELZeI+8/Dx6+xOe4BfsNMc7ODzmkuJvyV4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FtU52WMka5i1QJDJKMxCz1oc5Olw3WSDCnpnLkWBRYmrtW2Sa/t45e0d5Rbo+Nwa
         +Ng15RCcvqWk5P3AfEHzxm5FKUnXPqBgYunOjt9nTB0hMIXz/s9Ca87yWv/toP+7pM
         LU/pQED/H8LFokzetqnJBBWY7+0/QY9jVER9XACM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 19/22] uio: ensure class is registered before devices
Date:   Wed, 31 Oct 2018 19:12:03 -0400
Message-Id: <20181031231206.29509-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/uio/uio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 86055f663a01..db292c085399 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -249,6 +249,8 @@ static struct class uio_class = {
 	.dev_groups = uio_groups,
 };
 
+bool uio_class_registered;
+
 /*
  * device functions
  */
@@ -771,6 +773,9 @@ static int init_uio_class(void)
 		printk(KERN_ERR "class_register failed for uio\n");
 		goto err_class_register;
 	}
+
+	uio_class_registered = true;
+
 	return 0;
 
 err_class_register:
@@ -781,6 +786,7 @@ static int init_uio_class(void)
 
 static void release_uio_class(void)
 {
+	uio_class_registered = false;
 	class_unregister(&uio_class);
 	uio_major_cleanup();
 }
@@ -800,6 +806,9 @@ int __uio_register_device(struct module *owner,
 	struct uio_device *idev;
 	int ret = 0;
 
+	if (!uio_class_registered)
+		return -EPROBE_DEFER;
+
 	if (!parent || !info || !info->name || !info->version)
 		return -EINVAL;
 
-- 
2.17.1


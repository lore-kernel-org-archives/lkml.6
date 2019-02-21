Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA956C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CFA214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfBUL3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:29:45 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:54754 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUL3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:45 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 4506E16402; Thu, 21 Feb 2019 11:29:43 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3] platform: set of_node in platform_device_register_full()
Date:   Thu, 21 Feb 2019 11:29:35 +0000
Message-Id: <20190221112935.4538-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the provided fwnode is an OF node, set dev.of_node as well.

Also add an of_node_reused flag to struct platform_device_info and copy
this to the new device.  This is needed to avoid pinctrl settings being
requested twice.  See 4e75e1d7dac9 ("driver core: add helper to reuse a
device-tree node") for a longer explanation.

Some drivers are just shims that create extra "glue" devices with the
DT device as parent and have the real driver bind to these.  In these
cases, the glue device needs to get a reference to the original DT node
in order for the main driver to access properties and child nodes.

For example, the sunxi-musb driver creates such a glue device using
platform_device_register_full().  Consequently, devices attached to
this USB interface don't get associated with DT nodes, if present,
the way they do with EHCI.

This change will allow sunxi-musb and similar drivers to easily
propagate the DT node to child devices as required.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changes in v3:
- handle of_node_reused
---
 drivers/base/platform.c         | 2 ++
 include/linux/platform_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..7058ecea779a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -512,6 +512,8 @@ struct platform_device *platform_device_register_full(
 
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
+	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
+	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
 		/*
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1a9f38f27f65..4a29fdf16806 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -62,6 +62,7 @@ extern int platform_add_devices(struct platform_device **, int);
 struct platform_device_info {
 		struct device *parent;
 		struct fwnode_handle *fwnode;
+		bool of_node_reused;
 
 		const char *name;
 		int id;
-- 
2.20.1


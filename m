Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CFAC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F17C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F17C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeH2Fv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:51:56 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:36514 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeH2Fvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:51:54 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.11])
        by regular1.263xmail.com (Postfix) with ESMTP id 9DC34316;
        Wed, 29 Aug 2018 09:57:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 36F773BF;
        Wed, 29 Aug 2018 09:57:11 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <63ea444b8b687f321b8cadfaed5b344b>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 12252YD8NJE;
        Wed, 29 Aug 2018 09:57:14 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, seanpaul@chromium.org,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] drm/tockchip: add function to check if endpoint is a subdriver
Date:   Wed, 29 Aug 2018 09:57:03 +0800
Message-Id: <1535507825-195695-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535507825-195695-1-git-send-email-hjc@rock-chips.com>
References: <1535507825-195695-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

To be able to have both internal subdrivers and external bridge
drivers as output endpoints of vops, add a function to be able
to distinguish these.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1d9c4a9..d18f7f8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/component.h>
 #include <linux/console.h>
 #include <linux/iommu.h>
@@ -267,6 +268,32 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
 static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
 static int num_rockchip_sub_drivers;
 
+/*
+ * check if a vop output-endpoint is a subdriver or bridge.
+ */
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
+{
+	struct device_node *node = of_graph_get_remote_port_parent(ep);
+	struct platform_device *pdev;
+	int i;
+
+	if (!node)
+		return false;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return false;
+
+	for (i = 0; i < num_rockchip_sub_drivers; i++) {
+		struct device_driver *drv = pdev->dev.driver;
+
+		if (rockchip_sub_drivers[i] == to_platform_driver(drv))
+			return true;
+	}
+
+	return false;
+}
+
 static int compare_dev(struct device *dev, void *data)
 {
 	return dev == (struct device *)data;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index d67ad0a..305b485 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_driver;
-- 
2.7.4



Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E7B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E7B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHaBQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:16:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55362 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeHaBQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:16:27 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fvUEh-00009T-Nn; Thu, 30 Aug 2018 23:12:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com
Cc:     seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 1/3] drm/rockchip: add function to check if endpoint is a subdriver
Date:   Thu, 30 Aug 2018 23:12:05 +0200
Message-Id: <20180830211207.10480-2-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180830211207.10480-1-heiko@sntech.de>
References: <20180830211207.10480-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to have both internal subdrivers and external bridge
drivers as output endpoints of vops, add a function to be able
to distinguish these.

changes in v8:
- improved function documentation
- better error handling
- put calls for node and pdev references
changes in v6:
- added function to check subdriver vs. bridge

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 48 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1d9c4a9201c8..5864cb452c5c 100644
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
@@ -267,6 +268,53 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
 static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
 static int num_rockchip_sub_drivers;
 
+/*
+ * Check if a vop endpoint is leading to a rockchip subdriver or bridge.
+ * Should be called from the component bind stage of the drivers
+ * to ensure that all subdrivers are probed.
+ *
+ * @ep: endpoint of a rockchip vop
+ *
+ * returns true if subdriver, false if external bridge and -ENODEV
+ * if remote port does not contain a device.
+ */
+int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
+{
+	struct device_node *node = of_graph_get_remote_port_parent(ep);
+	struct platform_device *pdev;
+	struct device_driver *drv;
+	int i;
+
+	if (!node)
+		return -ENODEV;
+
+	/* status disabled will prevent creation of platform-devices */
+	pdev = of_find_device_by_node(node);
+	of_node_put(node);
+	if (!pdev)
+		return -ENODEV;
+
+	/*
+	 * All rockchip subdrivers have probed at this point, so
+	 * any device not having a driver now is an external bridge.
+	 */
+	drv = pdev->dev.driver;
+	if (!drv) {
+		platform_device_put(pdev);
+		return false;
+	}
+
+	for (i = 0; i < num_rockchip_sub_drivers; i++) {
+		if (rockchip_sub_drivers[i] == to_platform_driver(drv)) {
+			platform_device_put(pdev);
+			return true;
+		}
+	}
+
+	platform_device_put(pdev);
+	return false;
+}
+
 static int compare_dev(struct device *dev, void *data)
 {
 	return dev == (struct device *)data;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index d67ad0a3cf36..21a023a97bb8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
+int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_driver;
-- 
2.17.0


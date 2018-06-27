Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB0BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085D26508
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UTs26fxC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VZ+rf2Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E085D26508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeF0Mvg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:51:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933674AbeF0Mvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:51:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C0F3E60AFF; Wed, 27 Jun 2018 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530103890;
        bh=7CKLpKtujKHMWe2C62+YLKSkuED9MhXKCTFPmWBApho=;
        h=From:To:Cc:Subject:Date:From;
        b=UTs26fxCNZCyqcQdCzpRTQdAC7TvvjOJPoUJsJ32tk7MyOxCa0dUen3uCsi0oKWHg
         WU1NnP76owVRdvCweEPSWxm36YELnkj7YHZb6GgrZkOGXXrT6OAP1etInx1l0OU3z8
         EAW1npKSkPI3fQF32RZMSxD0Bw9LrXA2y3QXVSes=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCAFD60234;
        Wed, 27 Jun 2018 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530103878;
        bh=7CKLpKtujKHMWe2C62+YLKSkuED9MhXKCTFPmWBApho=;
        h=From:To:Cc:Subject:Date:From;
        b=VZ+rf2CaQj3d0V6zX67ZYiQYI8BsuDAjI2Y7+7Yj4+v/lESJy7zQWmu5TNgIVsD8y
         uFBVrGx+a9lb9GOt1gO+hRCyoO/JqdjjvM7qTS5aa1cmqgo53rY5vPm8zYw/QdBK1l
         ATizoDFljEY0PYFs0f1DBSyq62R7vuSfHmQ7Hx/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCAFD60234
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] device core: Rename flag AUTOREMOVE to AUTOREMOVE_CONSUMER
Date:   Wed, 27 Jun 2018 18:20:55 +0530
Message-Id: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we want to add another flag to autoremove the device link
on supplier unbind, it's fair to rename the existing flag from
DL_FLAG_AUTOREMOVE to DL_FLAG_AUTOREMOVE_CONSUMER so that we can
add similar flag for supplier later.
And, while we are touching device.h, fix a doc build warning.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
---
 Documentation/driver-api/device_link.rst |  8 ++++----
 drivers/base/core.c                      | 15 ++++++++-------
 drivers/gpu/drm/tegra/dc.c               |  2 +-
 drivers/gpu/ipu-v3/ipu-pre.c             |  3 ++-
 drivers/gpu/ipu-v3/ipu-prg.c             |  3 ++-
 drivers/soc/imx/gpc.c                    |  2 +-
 include/linux/device.h                   | 12 ++++++------
 7 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index 70e328e16aad..a005b904a264 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -81,10 +81,10 @@ integration is desired.
 Two other flags are specifically targeted at use cases where the device
 link is added from the consumer's ``->probe`` callback:  ``DL_FLAG_RPM_ACTIVE``
 can be specified to runtime resume the supplier upon addition of the
-device link.  ``DL_FLAG_AUTOREMOVE`` causes the device link to be automatically
-purged when the consumer fails to probe or later unbinds.  This obviates
-the need to explicitly delete the link in the ``->remove`` callback or in
-the error path of the ``->probe`` callback.
+device link.  ``DL_FLAG_AUTOREMOVE_CONSUMER`` causes the device link to be
+automatically purged when the consumer fails to probe or later unbinds.
+This obviates the need to explicitly delete the link in the ``->remove``
+callback or in the error path of the ``->probe`` callback.
 
 Limitations
 ===========
diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..14c1e3151e08 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -178,10 +178,10 @@ void device_pm_move_to_tail(struct device *dev)
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
  * ignored.
  *
- * If the DL_FLAG_AUTOREMOVE is set, the link will be removed automatically
- * when the consumer device driver unbinds from it.  The combination of both
- * DL_FLAG_AUTOREMOVE and DL_FLAG_STATELESS set is invalid and will cause NULL
- * to be returned.
+ * If the DL_FLAG_AUTOREMOVE_CONSUMER is set, the link will be removed
+ * automatically when the consumer device driver unbinds from it.
+ * The combination of both DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_STATELESS
+ * set is invalid and will cause NULL to be returned.
  *
  * A side effect of the link creation is re-ordering of dpm_list and the
  * devices_kset list by moving the consumer device and all devices depending
@@ -198,7 +198,8 @@ struct device_link *device_link_add(struct device *consumer,
 	struct device_link *link;
 
 	if (!consumer || !supplier ||
-	    ((flags & DL_FLAG_STATELESS) && (flags & DL_FLAG_AUTOREMOVE)))
+	    ((flags & DL_FLAG_STATELESS) &&
+	     (flags & DL_FLAG_AUTOREMOVE_CONSUMER)))
 		return NULL;
 
 	device_links_write_lock();
@@ -479,7 +480,7 @@ static void __device_links_no_driver(struct device *dev)
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
-		if (link->flags & DL_FLAG_AUTOREMOVE)
+		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
 			kref_put(&link->kref, __device_link_del);
 		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
@@ -515,7 +516,7 @@ void device_links_driver_cleanup(struct device *dev)
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
-		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE);
+		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
 		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c3afe7b2237e..965088afcfad 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2312,7 +2312,7 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 	 * POWER_CONTROL registers during CRTC enabling.
 	 */
 	if (dc->soc->coupled_pm && dc->pipe == 1) {
-		u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE;
+		u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
 		struct device_link *link;
 		struct device *partner;
 
diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
index 0f70e8847540..2f8db9d62551 100644
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -128,7 +128,8 @@ ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
 	list_for_each_entry(pre, &ipu_pre_list, list) {
 		if (pre_node == pre->dev->of_node) {
 			mutex_unlock(&ipu_pre_list_mutex);
-			device_link_add(dev, pre->dev, DL_FLAG_AUTOREMOVE);
+			device_link_add(dev, pre->dev,
+					DL_FLAG_AUTOREMOVE_CONSUMER);
 			of_node_put(pre_node);
 			return pre;
 		}
diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 83f9dd934a5d..38a3a9764e49 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -100,7 +100,8 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 	list_for_each_entry(prg, &ipu_prg_list, list) {
 		if (prg_node == prg->dev->of_node) {
 			mutex_unlock(&ipu_prg_list_mutex);
-			device_link_add(dev, prg->dev, DL_FLAG_AUTOREMOVE);
+			device_link_add(dev, prg->dev,
+					DL_FLAG_AUTOREMOVE_CONSUMER);
 			prg->id = ipu_id;
 			of_node_put(prg_node);
 			return prg;
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..aa9e65bc965e 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -202,7 +202,7 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 			goto genpd_err;
 	}
 
-	device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE);
+	device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE_CONSUMER);
 
 	return 0;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..3929805cdd59 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -90,7 +90,7 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @num_vf:	Called to find out how many virtual functions a device on this
  *		bus supports.
  * @dma_configure:	Called to setup DMA configuration on a device on
-			this bus.
+ *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -784,14 +784,14 @@ enum device_link_state {
  * Device link flags.
  *
  * STATELESS: The core won't track the presence of supplier/consumer drivers.
- * AUTOREMOVE: Remove this link automatically on consumer driver unbind.
+ * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
  * PM_RUNTIME: If set, the runtime PM framework will use this link.
  * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  */
-#define DL_FLAG_STATELESS	BIT(0)
-#define DL_FLAG_AUTOREMOVE	BIT(1)
-#define DL_FLAG_PM_RUNTIME	BIT(2)
-#define DL_FLAG_RPM_ACTIVE	BIT(3)
+#define DL_FLAG_STATELESS		BIT(0)
+#define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
+#define DL_FLAG_PM_RUNTIME		BIT(2)
+#define DL_FLAG_RPM_ACTIVE		BIT(3)
 
 /**
  * struct device_link - Device link representation.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


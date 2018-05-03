Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeECXwv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:52:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39736 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeECXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:52:11 -0400
X-Google-Smtp-Source: AB8JxZpz+I76h1HXGTXtO+EgyJpLxNFg1PxzrNkUR17fTdn2GttdD1Kf7nKwh4KA8995Hn1C+ujxBQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] drm/tegra: gr3d: Add IOMMU support
Date: Fri,  4 May 2018 02:47:21 +0300
Message-Id: <20180503234723.4368-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503234723.4368-1-digetx@gmail.com>
References: <20180503234723.4368-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attach GR3D to the displays IOMMU group in order to provide GR3D access
to BO's IOVA.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 28c4ef63065b..ce5120683091 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/host1x.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -20,6 +21,7 @@
 #include "gr3d.h"
 
 struct gr3d {
+	struct iommu_group *group;
 	struct tegra_drm_client client;
 	struct host1x_channel *channel;
 	struct clk *clk_secondary;
@@ -40,7 +42,9 @@ static int gr3d_init(struct host1x_client *client)
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
 	unsigned long flags = HOST1X_SYNCPT_HAS_BASE;
+	struct tegra_drm *tegra = dev->dev_private;
 	struct gr3d *gr3d = to_gr3d(drm);
+	int err;
 
 	gr3d->channel = host1x_channel_request(client->dev);
 	if (!gr3d->channel)
@@ -52,6 +56,23 @@ static int gr3d_init(struct host1x_client *client)
 		return -ENOMEM;
 	}
 
+	if (tegra->domain) {
+		gr3d->group = iommu_group_get(client->dev);
+
+		if (gr3d->group) {
+			err = iommu_attach_group(tegra->domain, gr3d->group);
+			if (err < 0) {
+				dev_err(client->dev,
+					"failed to attach to domain: %d\n",
+					err);
+				host1x_syncpt_free(client->syncpts[0]);
+				host1x_channel_put(gr3d->channel);
+				iommu_group_put(gr3d->group);
+				return err;
+			}
+		}
+	}
+
 	return tegra_drm_register_client(dev->dev_private, drm);
 }
 
@@ -59,6 +80,7 @@ static int gr3d_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct tegra_drm *tegra = dev->dev_private;
 	struct gr3d *gr3d = to_gr3d(drm);
 	int err;
 
@@ -69,6 +91,11 @@ static int gr3d_exit(struct host1x_client *client)
 	host1x_syncpt_free(client->syncpts[0]);
 	host1x_channel_put(gr3d->channel);
 
+	if (gr3d->group) {
+		iommu_detach_group(tegra->domain, gr3d->group);
+		iommu_group_put(gr3d->group);
+	}
+
 	return 0;
 }
 
-- 
2.17.0

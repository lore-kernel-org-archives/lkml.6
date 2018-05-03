Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbeECXwN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:52:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38677 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeECXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:52:10 -0400
X-Google-Smtp-Source: AB8JxZriSuAzFP5+r7DWqapTbzMd9WWDup17ma5j2RZd9lxf0h/tapCTSySnsRgx6n2LWqeOEoR23w==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] drm/tegra: gr2d: Add IOMMU support
Date: Fri,  4 May 2018 02:47:20 +0300
Message-Id: <20180503234723.4368-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503234723.4368-1-digetx@gmail.com>
References: <20180503234723.4368-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attach GR2D to the display IOMMU group in order to provide GR2D access
to BO's IOVA.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 9a8ea93016a9..8eb530a85dd0 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -7,12 +7,14 @@
  */
 
 #include <linux/clk.h>
+#include <linux/iommu.h>
 
 #include "drm.h"
 #include "gem.h"
 #include "gr2d.h"
 
 struct gr2d {
+	struct iommu_group *group;
 	struct tegra_drm_client client;
 	struct host1x_channel *channel;
 	struct clk *clk;
@@ -30,7 +32,9 @@ static int gr2d_init(struct host1x_client *client)
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
 	unsigned long flags = HOST1X_SYNCPT_HAS_BASE;
+	struct tegra_drm *tegra = dev->dev_private;
 	struct gr2d *gr2d = to_gr2d(drm);
+	int err;
 
 	gr2d->channel = host1x_channel_request(client->dev);
 	if (!gr2d->channel)
@@ -42,23 +46,46 @@ static int gr2d_init(struct host1x_client *client)
 		return -ENOMEM;
 	}
 
-	return tegra_drm_register_client(dev->dev_private, drm);
+	if (tegra->domain) {
+		gr2d->group = iommu_group_get(client->dev);
+
+		if (gr2d->group) {
+			err = iommu_attach_group(tegra->domain, gr2d->group);
+			if (err < 0) {
+				dev_err(client->dev,
+					"failed to attach to domain: %d\n",
+					err);
+				host1x_syncpt_free(client->syncpts[0]);
+				host1x_channel_put(gr2d->channel);
+				iommu_group_put(gr2d->group);
+				return err;
+			}
+		}
+	}
+
+	return tegra_drm_register_client(tegra, drm);
 }
 
 static int gr2d_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
+	struct tegra_drm *tegra = dev->dev_private;
 	struct gr2d *gr2d = to_gr2d(drm);
 	int err;
 
-	err = tegra_drm_unregister_client(dev->dev_private, drm);
+	err = tegra_drm_unregister_client(tegra, drm);
 	if (err < 0)
 		return err;
 
 	host1x_syncpt_free(client->syncpts[0]);
 	host1x_channel_put(gr2d->channel);
 
+	if (gr2d->group) {
+		iommu_detach_group(tegra->domain, gr2d->group);
+		iommu_group_put(gr2d->group);
+	}
+
 	return 0;
 }
 
-- 
2.17.0

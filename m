Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDKJR2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:17:28 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51716 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeDKJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:15:54 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/2] vfio: platform: Fix reset module leak in error path
Date: Wed, 11 Apr 2018 11:15:48 +0200
Message-Id: <1523438149-16433-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the IOMMU group setup fails, the reset module is not released.

Fixes: b5add544d677d363 ("vfio, platform: make reset driver a requirement by default")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Reviewed-by,

v2:
  - Add Reviewed-by.
---
 drivers/vfio/platform/vfio_platform_common.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 35469af87f88678e..b60bb5326668498c 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -680,18 +680,23 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 	group = vfio_iommu_group_get(dev);
 	if (!group) {
 		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_reset;
 	}
 
 	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
-	if (ret) {
-		vfio_iommu_group_put(group, dev);
-		return ret;
-	}
+	if (ret)
+		goto put_iommu;
 
 	mutex_init(&vdev->igate);
 
 	return 0;
+
+put_iommu:
+	vfio_iommu_group_put(group, dev);
+put_reset:
+	vfio_platform_put_reset(vdev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
 
-- 
2.7.4

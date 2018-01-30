Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeA3Ukg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:40:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeA3U33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:29 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 02/43] drm/rockchip: support prime import sg table
Date: Tue, 30 Jan 2018 21:28:32 +0100
Message-Id: <20180130202913.28724-3-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haixia Shi <hshi@chromium.org>

The prime fd to handle ioctl was not used with rockchip before. Support
was added in order to pass graphics_Gbm and to support potential uses
within Chrome OS (e.g. zero-copy video decode, camera).

Signed-off-by: Haixia Shi <hshi@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 118 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   5 +-
 3 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index d85431400a0d..88084ca15115 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -230,6 +230,7 @@ static struct drm_driver rockchip_drm_driver = {
 	.gem_prime_import	= drm_gem_prime_import,
 	.gem_prime_export	= drm_gem_prime_export,
 	.gem_prime_get_sg_table	= rockchip_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table	= rockchip_gem_prime_import_sg_table,
 	.gem_prime_vmap		= rockchip_gem_prime_vmap,
 	.gem_prime_vunmap	= rockchip_gem_prime_vunmap,
 	.gem_prime_mmap		= rockchip_gem_mmap_buf,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 1d9655576b6e..5d52020deca1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -16,6 +16,8 @@
 #include <drm/drmP.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_vma_manager.h>
+
+#include <linux/dma-buf.h>
 #include <linux/iommu.h>
 
 #include "rockchip_drm_drv.h"
@@ -309,12 +311,10 @@ static void rockchip_gem_release_object(struct rockchip_gem_object *rk_obj)
 }
 
 struct rockchip_gem_object *
-	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
-				   bool alloc_kmap)
+	rockchip_gem_alloc_object(struct drm_device *drm, unsigned int size)
 {
 	struct rockchip_gem_object *rk_obj;
 	struct drm_gem_object *obj;
-	int ret;
 
 	size = round_up(size, PAGE_SIZE);
 
@@ -326,6 +326,20 @@ struct rockchip_gem_object *
 
 	drm_gem_object_init(drm, obj, size);
 
+	return rk_obj;
+}
+
+struct rockchip_gem_object *
+rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
+			   bool alloc_kmap)
+{
+	struct rockchip_gem_object *rk_obj;
+	int ret;
+
+	rk_obj = rockchip_gem_alloc_object(drm, size);
+	if (IS_ERR(rk_obj))
+		return rk_obj;
+
 	ret = rockchip_gem_alloc_buf(rk_obj, alloc_kmap);
 	if (ret)
 		goto err_free_rk_obj;
@@ -343,11 +357,21 @@ struct rockchip_gem_object *
  */
 void rockchip_gem_free_object(struct drm_gem_object *obj)
 {
-	struct rockchip_gem_object *rk_obj;
-
-	rk_obj = to_rockchip_obj(obj);
+	struct drm_device *drm = obj->dev;
+	struct rockchip_drm_private *private = drm->dev_private;
+	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
-	rockchip_gem_free_buf(rk_obj);
+	if (obj->import_attach) {
+		if (private->domain) {
+			rockchip_gem_iommu_unmap(rk_obj);
+		} else {
+			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
+				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		}
+		drm_prime_gem_destroy(obj, rk_obj->sgt);
+	} else {
+		rockchip_gem_free_buf(rk_obj);
+	}
 
 	rockchip_gem_release_object(rk_obj);
 }
@@ -451,6 +475,86 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return sgt;
 }
 
+static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
+						     int count)
+{
+	struct scatterlist *s;
+	dma_addr_t expected = sg_dma_address(sgt->sgl);
+	unsigned int i;
+	unsigned long size = 0;
+
+	for_each_sg(sgt->sgl, s, count, i) {
+		if (sg_dma_address(s) != expected)
+			break;
+		expected = sg_dma_address(s) + sg_dma_len(s);
+		size += sg_dma_len(s);
+	}
+	return size;
+}
+
+static int
+rockchip_gem_iommu_map_sg(struct drm_device *drm,
+			  struct dma_buf_attachment *attach,
+			  struct sg_table *sg,
+			  struct rockchip_gem_object *rk_obj)
+{
+	rk_obj->sgt = sg;
+	return rockchip_gem_iommu_map(rk_obj);
+}
+
+static int
+rockchip_gem_dma_map_sg(struct drm_device *drm,
+			struct dma_buf_attachment *attach,
+			struct sg_table *sg,
+			struct rockchip_gem_object *rk_obj)
+{
+	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
+			       DMA_BIDIRECTIONAL);
+	if (!count)
+		return -EINVAL;
+
+	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
+		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
+		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
+			     DMA_BIDIRECTIONAL);
+		return -EINVAL;
+	}
+
+	rk_obj->dma_addr = sg_dma_address(sg->sgl);
+	rk_obj->sgt = sg;
+	return 0;
+}
+
+struct drm_gem_object *
+rockchip_gem_prime_import_sg_table(struct drm_device *drm,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sg)
+{
+	struct rockchip_drm_private *private = drm->dev_private;
+	struct rockchip_gem_object *rk_obj;
+	int ret;
+
+	rk_obj = rockchip_gem_alloc_object(drm, attach->dmabuf->size);
+	if (IS_ERR(rk_obj))
+		return ERR_CAST(rk_obj);
+
+	if (private->domain)
+		ret = rockchip_gem_iommu_map_sg(drm, attach, sg, rk_obj);
+	else
+		ret = rockchip_gem_dma_map_sg(drm, attach, sg, rk_obj);
+
+	if (ret < 0) {
+		DRM_ERROR("failed to import sg table: %d\n", ret);
+		goto err_free_rk_obj;
+	}
+
+	return &rk_obj->base;
+
+err_free_rk_obj:
+	rockchip_gem_release_object(rk_obj);
+	return ERR_PTR(ret);
+}
+
 void *rockchip_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index f237375582fb..d41fa65219d2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -36,8 +36,9 @@ struct rockchip_gem_object {
 
 struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *
-rockchip_gem_prime_import_sg_table(struct drm_device *dev, size_t size,
-				   struct sg_table *sgt);
+rockchip_gem_prime_import_sg_table(struct drm_device *dev,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sg);
 void *rockchip_gem_prime_vmap(struct drm_gem_object *obj);
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
-- 
2.14.1

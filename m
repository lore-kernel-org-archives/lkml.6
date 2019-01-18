Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4572420652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfARMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfARMU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6870586676;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F345B5D979;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B71B11FCC1; Fri, 18 Jan 2019 13:20:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 16/23] drm/qxl: implement prime kmap/kunmap
Date:   Fri, 18 Jan 2019 13:20:13 +0100
Message-Id: <20190118122020.27596-17-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic fbdev emulation needs this.  Also: We must keep track of the
number of mappings now, so we don't unmap early in case two users want a
kmap of the same bo.  Add a sanity check to destroy callback to make
sure kmap/kunmap is balanced.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  1 +
 drivers/gpu/drm/qxl/qxl_object.c |  6 ++++++
 drivers/gpu/drm/qxl/qxl_prime.c  | 17 +++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 43c6df9cf9..8c3af1cdbe 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -84,6 +84,7 @@ struct qxl_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	unsigned int pin_count;
 	void				*kptr;
+	unsigned int                    map_count;
 	int                             type;
 
 	/* Constant after initialization */
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 024c8dd317..4928fa6029 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -36,6 +36,7 @@ static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	qdev = (struct qxl_device *)bo->gem_base.dev->dev_private;
 
 	qxl_surface_evict(qdev, bo, false);
+	WARN_ON_ONCE(bo->map_count > 0);
 	mutex_lock(&qdev->gem.mutex);
 	list_del_init(&bo->list);
 	mutex_unlock(&qdev->gem.mutex);
@@ -131,6 +132,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
 	if (bo->kptr) {
 		if (ptr)
 			*ptr = bo->kptr;
+		bo->map_count++;
 		return 0;
 	}
 	r = ttm_bo_kmap(&bo->tbo, 0, bo->tbo.num_pages, &bo->kmap);
@@ -139,6 +141,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
 	bo->kptr = ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
 	if (ptr)
 		*ptr = bo->kptr;
+	bo->map_count = 1;
 	return 0;
 }
 
@@ -180,6 +183,9 @@ void qxl_bo_kunmap(struct qxl_bo *bo)
 {
 	if (bo->kptr == NULL)
 		return;
+	bo->map_count--;
+	if (bo->map_count > 0)
+		return;
 	bo->kptr = NULL;
 	ttm_bo_kunmap(&bo->kmap);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index a55dece118..708378844c 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -22,7 +22,7 @@
  * Authors: Andreas Pokorny
  */
 
-#include "qxl_drv.h"
+#include "qxl_object.h"
 
 /* Empty Implementations as there should not be any other driver for a virtual
  * device that might share buffers with qxl */
@@ -54,13 +54,22 @@ struct drm_gem_object *qxl_gem_prime_import_sg_table(
 
 void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENOSYS);
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+	void *ptr;
+	int ret;
+
+	ret = qxl_bo_kmap(bo, &ptr);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return ptr;
 }
 
 void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 {
-	WARN_ONCE(1, "not implemented");
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+
+	qxl_bo_kunmap(bo);
 }
 
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-- 
2.9.3


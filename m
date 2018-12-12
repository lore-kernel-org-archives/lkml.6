Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E2EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9505D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9505D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeLLNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:22:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbeLLNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B380308212A;
        Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AA025ED26;
        Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 031D55E50B; Wed, 12 Dec 2018 14:21:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/18] drm/qxl: implement prime kmap/kunmap
Date:   Wed, 12 Dec 2018 14:21:07 +0100
Message-Id: <20181212132109.8126-17-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
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


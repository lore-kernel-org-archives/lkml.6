Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CDCECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454292086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454292086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeJSOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJSOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 702607F3FA;
        Fri, 19 Oct 2018 06:18:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 892076111B;
        Fri, 19 Oct 2018 06:18:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C28A7B3D46; Fri, 19 Oct 2018 08:18:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm/virtio: use virtio_gpu_object->hw_res_handle in virtio_gpu_resource_create_ioctl()
Date:   Fri, 19 Oct 2018 08:18:45 +0200
Message-Id: <20181019061847.18958-5-kraxel@redhat.com>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 19 Oct 2018 06:18:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop pointless res_id variable in virtio_gpu_resource_create_ioctl(),
just use the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 98bb238e91..ebb0920411 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -217,7 +217,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_resource_create *rc = data;
 	int ret;
-	uint32_t res_id;
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
@@ -244,8 +243,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
-	virtio_gpu_resource_id_get(vgdev, &res_id);
-
 	size = rc->size;
 
 	/* allocate a single page size object */
@@ -253,17 +250,16 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		size = PAGE_SIZE;
 
 	qobj = virtio_gpu_alloc_object(dev, size, false, false);
-	if (IS_ERR(qobj)) {
-		ret = PTR_ERR(qobj);
-		goto fail_id;
-	}
+	if (IS_ERR(qobj))
+		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
+	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, res_id, rc->format,
+		virtio_gpu_cmd_create_resource(vgdev, qobj, qobj->hw_res_handle, rc->format,
 					       rc->width, rc->height);
 
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, NULL);
+		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, NULL);
 	} else {
 		/* use a gem reference since unref list undoes them */
 		drm_gem_object_get(&qobj->gem_base);
@@ -276,7 +272,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_unref;
 		}
 
-		rc_3d.resource_id = cpu_to_le32(res_id);
+		rc_3d.resource_id = cpu_to_le32(qobj->hw_res_handle);
 		rc_3d.target = cpu_to_le32(rc->target);
 		rc_3d.format = cpu_to_le32(rc->format);
 		rc_3d.bind = cpu_to_le32(rc->bind);
@@ -289,7 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
-		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, &fence);
+		ret = virtio_gpu_object_attach(vgdev, qobj, qobj->hw_res_handle, &fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
 			goto fail_unref;
@@ -297,8 +293,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
 	}
 
-	qobj->hw_res_handle = res_id;
-
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
 
@@ -311,7 +305,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	}
 	drm_gem_object_put_unlocked(obj);
 
-	rc->res_handle = res_id; /* similiar to a VM address */
+	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
 
 	if (vgdev->has_virgl_3d) {
@@ -326,8 +320,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	}
 //fail_obj:
 //	drm_gem_object_handle_unreference_unlocked(obj);
-fail_id:
-	virtio_gpu_resource_id_put(vgdev, res_id);
 	return ret;
 }
 
-- 
2.9.3


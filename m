Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A45C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4E82064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4E82064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeJARJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbeJARJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F5D687642;
        Mon,  1 Oct 2018 10:32:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 556F13091886;
        Mon,  1 Oct 2018 10:32:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CAD099D377; Mon,  1 Oct 2018 12:32:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/8] drm/virtio: track created object state
Date:   Mon,  1 Oct 2018 12:32:19 +0200
Message-Id: <20181001103222.11924-6-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 01 Oct 2018 10:32:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track whenever the virtio_gpu_object is already created (i.e. host knows
about it) in a new variable.  Add checks to virtio_gpu_object_attach()
to do nothing on objects not created yet.

Make virtio_gpu_ttm_bo_destroy() use the new variable too, instead of
expecting hw_res_handle indicating the object state.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_fb.c     | 2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c    | 2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 8 ++++++--
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9b26e8ee84..4a39877ce6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -65,6 +65,7 @@ struct virtio_gpu_object {
 	struct ttm_placement		placement;
 	struct ttm_buffer_object	tbo;
 	struct ttm_bo_kmap_obj		kmap;
+	bool created;
 };
 #define gem_to_virtio_gpu_obj(gobj) \
 	container_of((gobj), struct virtio_gpu_object, gem_base)
@@ -263,7 +264,7 @@ void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 			       uint32_t *resid);
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
-				    uint32_t resource_id,
+				    struct virtio_gpu_object *bo,
 				    uint32_t format,
 				    uint32_t width,
 				    uint32_t height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index b16c62c4d8..c22a8246b6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -232,7 +232,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 		return PTR_ERR(obj);
 
 	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
-	virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_object_kmap(obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 5450f7ab5b..665d18a49d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -104,7 +104,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
 	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
-	virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 44c9160c14..f9c55ecfca 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -256,7 +256,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj->hw_res_handle, rc->format,
+		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
 					       rc->width, rc->height);
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
@@ -285,6 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
 		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
+		qobj->created = true;
 		ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
 		if (ret) {
 			ttm_eu_backoff_reservation(&ticket, &validate_list);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index eca7655374..6611c487d7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -33,7 +33,7 @@ static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	bo = container_of(tbo, struct virtio_gpu_object, tbo);
 	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
 
-	if (bo->hw_res_handle)
+	if (bo->created)
 		virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
 	if (bo->pages)
 		virtio_gpu_object_free_sg_table(bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index dd4464ccb1..45da3c87b6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -388,7 +388,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
-				    uint32_t resource_id,
+				    struct virtio_gpu_object *bo,
 				    uint32_t format,
 				    uint32_t width,
 				    uint32_t height)
@@ -400,12 +400,13 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->format = cpu_to_le32(format);
 	cmd_p->width = cpu_to_le32(width);
 	cmd_p->height = cpu_to_le32(height);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	bo->created = true;
 }
 
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
@@ -868,6 +869,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	struct scatterlist *sg;
 	int si, nents;
 
+	if (!obj->created)
+		return 0;
+
 	if (!obj->pages) {
 		int ret;
 
-- 
2.9.3


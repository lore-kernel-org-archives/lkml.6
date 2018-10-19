Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C9F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJSOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeJSOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:23:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 829C6308212A;
        Fri, 19 Oct 2018 06:18:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A85F5D77C;
        Fri, 19 Oct 2018 06:18:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 78D55A8584; Fri, 19 Oct 2018 08:18:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] drm/virtio: track created object state
Date:   Fri, 19 Oct 2018 08:18:42 +0200
Message-Id: <20181019061847.18958-2-kraxel@redhat.com>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 19 Oct 2018 06:18:51 +0000 (UTC)
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
 drivers/gpu/drm/virtio/virtgpu_drv.h    | 3 +++
 drivers/gpu/drm/virtio/virtgpu_fb.c     | 2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c    | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 7 +++++++
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d29f0c7c76..5edc22d7a7 100644
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
@@ -263,6 +264,7 @@ void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 			       uint32_t *resid);
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_object *bo,
 				    uint32_t resource_id,
 				    uint32_t format,
 				    uint32_t width,
@@ -324,6 +326,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 					struct virtio_gpu_fence **fence);
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
+				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
 				  struct virtio_gpu_fence **fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index cea749f4ec..d39f4f3350 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -232,7 +232,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 		return PTR_ERR(obj);
 
 	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, resid, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, resid, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_object_kmap(obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 82c817f37c..33dbd5aed7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -103,8 +103,9 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		goto fail;
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
+	obj = gem_to_virtio_gpu_obj(gobj);
 	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, resid, format,
+	virtio_gpu_cmd_create_resource(vgdev, obj, resid, format,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index f16b875d6a..98bb238e91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -260,7 +260,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	obj = &qobj->gem_base;
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, res_id, rc->format,
+		virtio_gpu_cmd_create_resource(vgdev, qobj, res_id, rc->format,
 					       rc->width, rc->height);
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, NULL);
@@ -288,7 +288,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
 		rc_3d.flags = cpu_to_le32(rc->flags);
 
-		virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
+		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
 		ret = virtio_gpu_object_attach(vgdev, qobj, res_id, &fence);
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
index 4e2e037aed..3b6904c5b3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -388,6 +388,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_object *bo,
 				    uint32_t resource_id,
 				    uint32_t format,
 				    uint32_t width,
@@ -406,6 +407,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 	cmd_p->height = cpu_to_le32(height);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	bo->created = true;
 }
 
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
@@ -772,6 +774,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
+				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_resource_create_3d *rc_3d,
 				  struct virtio_gpu_fence **fence)
 {
@@ -786,6 +789,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.flags = 0;
 
 	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
+	bo->created = true;
 }
 
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
@@ -869,6 +873,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	struct scatterlist *sg;
 	int si, nents;
 
+	if (!obj->created)
+		return 0;
+
 	if (!obj->pages) {
 		int ret;
 
-- 
2.9.3


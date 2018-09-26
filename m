Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CCECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F8621537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5Aa62qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F8621537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeIZWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DSxauVnSi4fxMqvQFzgVNtZsk4GoWC5xx1tvo9HkB+c=; b=A5Aa62qbPK76kasRxgTSo6YOe
        79/lI8oha+QDrc+gzNGMruLSU5uqkThVUCnBXNMuRm4X471YiaEQUVg0LT6Au7l8LPQvjcp1mc5cy
        KoP2hgy+vH8NkGDZFdWvBrKdyQGu/9SBhc753x6nimLXrpFCOHraaIUjkr3Eu9MJ/Rsnxh7AiNtUd
        m/lBuB+0LFi9B5ePCm5K8pVFsIG8Hy3vopU+uzO0jm934Et5D/QLgkahtLF8AEy5382okJ7NF1P84
        OeU9l1wuIQbf3gAKagSiAlHnG6swK3ec/4dLTwuVa7Hy8n449ItObqH+OOWStbRM2fiDtmVZ9XFQ+
        1Dt5xRkOw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CEu-0004En-J2; Wed, 26 Sep 2018 16:00:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/virtio: Handle object ID allocation errors
Date:   Wed, 26 Sep 2018 09:00:30 -0700
Message-Id: <20180926160031.15721-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to run out of memory while allocating IDs.  The current
code would create an object with an invalid ID; change it to return
-ENOMEM to the caller.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +--
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 10 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 10 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 ++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  6 ++----
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index c4468a4e454e..0a3392f2cda3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -247,8 +247,7 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *qfb,
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-			       uint32_t *resid);
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev);
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    uint32_t resource_id,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c79522..74d815483487 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -244,14 +244,17 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &resid);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		goto err_obj_vmap;
+	resid = ret;
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_vmap_fb(vgdev, obj);
 	if (ret) {
 		DRM_ERROR("failed to vmap fb %d\n", ret);
-		goto err_obj_vmap;
+		goto err_obj_id;
 	}
 
 	/* attach the object to the resource */
@@ -293,8 +296,11 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 err_fb_alloc:
 	virtio_gpu_cmd_resource_inval_backing(vgdev, resid);
 err_obj_attach:
+err_obj_id:
+	virtio_gpu_resource_id_put(vgdev, resid);
 err_obj_vmap:
 	virtio_gpu_gem_free_object(&obj->gem_base);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 0f2768eacaee..9e3af1ec26db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -100,7 +100,10 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		goto fail;
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
-	virtio_gpu_resource_id_get(vgdev, &resid);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		goto fail;
+	resid = ret;
 	virtio_gpu_cmd_create_resource(vgdev, resid, format,
 				       args->width, args->height);
 
@@ -108,13 +111,16 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	obj = gem_to_virtio_gpu_obj(gobj);
 	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
 	if (ret)
-		goto fail;
+		goto fail_id;
 
 	obj->dumb = true;
 	args->pitch = pitch;
 	return ret;
 
+fail_id:
+	virtio_gpu_resource_id_put(vgdev, resid);
 fail:
+	/* Shouldn't we undo virtio_gpu_gem_create()? */
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7bdf6f0e58a5..eec9f09f01f0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -244,7 +244,10 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
-	virtio_gpu_resource_id_get(vgdev, &res_id);
+	ret = virtio_gpu_resource_id_get(vgdev);
+	if (ret < 0)
+		return ret;
+	res_id = ret;
 
 	size = rc->size;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 58be09d2eed6..387951c971d4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -38,11 +38,9 @@
 			       + MAX_INLINE_CMD_SIZE		 \
 			       + MAX_INLINE_RESP_SIZE)
 
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-				uint32_t *resid)
+int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev)
 {
-	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
-	*resid = handle;
+	return ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-- 
2.19.0


Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AD42089E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AD42089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeH2QRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:17:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbeH2QRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:17:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F702401EF2D;
        Wed, 29 Aug 2018 12:20:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-224.ams2.redhat.com [10.36.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22F982166B41;
        Wed, 29 Aug 2018 12:20:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 901629B15; Wed, 29 Aug 2018 14:20:26 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/virtio: add virtio_gpu_object_detach() function
Date:   Wed, 29 Aug 2018 14:20:25 +0200
Message-Id: <20180829122026.27012-2-kraxel@redhat.com>
In-Reply-To: <20180829122026.27012-1-kraxel@redhat.com>
References: <20180829122026.27012-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 12:20:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 12:20:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new function balances virtio_gpu_object_attach().

Also make virtio_gpu_cmd_resource_inval_backing() static and switch
call sites to the new virtio_gpu_object_attach() function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_fb.c  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c |  3 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207b..cbbff01077 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -276,13 +276,13 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     uint32_t resource_id,
 			     struct virtio_gpu_fence **fence);
+void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
+			      struct virtio_gpu_object *obj);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
 			    struct virtio_gpu_output *output);
 int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev);
-void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
-					   uint32_t resource_id);
 int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx);
 int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 			      int idx, int version,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index a121b1c795..b5cebc9a17 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -291,7 +291,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 err_fb_alloc:
-	virtio_gpu_cmd_resource_inval_backing(vgdev, resid);
+	virtio_gpu_object_detach(vgdev, obj);
 err_obj_attach:
 err_obj_vmap:
 	virtio_gpu_gem_free_object(&obj->gem_base);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 11f8ae5b53..3ea115e026 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -377,8 +377,7 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
 
 	if (!new_mem || (new_mem->placement & TTM_PL_FLAG_SYSTEM)) {
 		if (bo->hw_res_handle)
-			virtio_gpu_cmd_resource_inval_backing(vgdev,
-							   bo->hw_res_handle);
+			virtio_gpu_object_detach(vgdev, bo);
 
 	} else if (new_mem->placement & TTM_PL_FLAG_TT) {
 		if (bo->hw_res_handle) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483..af24e91267 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -423,8 +423,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
-					   uint32_t resource_id)
+static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
+						  uint32_t resource_id)
 {
 	struct virtio_gpu_resource_detach_backing *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -882,6 +882,12 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
+			      struct virtio_gpu_object *obj)
+{
+	virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle);
+}
+
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
 			    struct virtio_gpu_output *output)
 {
-- 
2.9.3


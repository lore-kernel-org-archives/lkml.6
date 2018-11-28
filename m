Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91870C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F312081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeK2CMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:12:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13545 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeK2CMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:12:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7953788313;
        Wed, 28 Nov 2018 15:10:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B90E19493;
        Wed, 28 Nov 2018 15:10:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3C8705E4E7; Wed, 28 Nov 2018 16:10:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     robert.foss@collabora.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/virtio: virtio_gpu_cmd_resource_create_3d: drop unused fence arg
Date:   Wed, 28 Nov 2018 16:10:21 +0100
Message-Id: <20181128151021.29565-3-kraxel@redhat.com>
In-Reply-To: <20181128151021.29565-1-kraxel@redhat.com>
References: <20181128151021.29565-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 28 Nov 2018 15:10:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 3 +--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d6cc1a92ca..4e522e0b59 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -324,8 +324,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence *fence);
+				  struct virtio_gpu_resource_create_3d *rc_3d);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e9cdb4c7f6..161b80fee4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -348,7 +348,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_backoff;
 		}
 
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d, NULL);
+		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
 			virtio_gpu_fence_cleanup(fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 97038662b9..e27c4aedb8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -820,8 +820,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d,
-				  struct virtio_gpu_fence *fence)
+				  struct virtio_gpu_resource_create_3d *rc_3d)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -833,7 +832,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
 	cmd_p->hdr.flags = 0;
 
-	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
+	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
 }
 
-- 
2.9.3


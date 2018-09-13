Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26398C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD71E20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIMNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeIMNV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:21:26 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0005490903;
        Thu, 13 Sep 2018 08:13:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 740512010D03;
        Thu, 13 Sep 2018 08:13:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 76431409FB; Thu, 13 Sep 2018 10:12:59 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/virtio: add edid support
Date:   Thu, 13 Sep 2018 10:12:58 +0200
Message-Id: <20180913081259.27457-4-kraxel@redhat.com>
In-Reply-To: <20180913081259.27457-1-kraxel@redhat.com>
References: <20180913081259.27457-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 08:13:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 ++
 drivers/gpu/drm/virtio/virtgpu_display.c |  6 ++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 +++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 59 ++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207b..58358a48df 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -112,6 +112,7 @@ struct virtio_gpu_output {
 	struct drm_encoder enc;
 	struct virtio_gpu_display_one info;
 	struct virtio_gpu_update_cursor cursor;
+	struct edid *edid;
 	int cur_x;
 	int cur_y;
 };
@@ -194,6 +195,7 @@ struct virtio_gpu_device {
 	spinlock_t ctx_id_idr_lock;
 
 	bool has_virgl_3d;
+	bool has_edid;
 
 	struct work_struct config_changed_work;
 
@@ -287,6 +289,7 @@ int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx);
 int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 			      int idx, int version,
 			      struct virtio_gpu_drv_cap_cache **cache_p);
+int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 				   uint32_t nlen, const char *name);
 void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 25503b9335..e573eab1f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -168,6 +168,12 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 	struct drm_display_mode *mode = NULL;
 	int count, width, height;
 
+	if (output->edid) {
+		count = drm_add_edid_modes(connector, output->edid);
+		if (count)
+			return count;
+	}
+
 	width  = le32_to_cpu(output->info.r.width);
 	height = le32_to_cpu(output->info.r.height);
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index d9287c144f..f7f32a885a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -80,6 +80,7 @@ static unsigned int features[] = {
 	 */
 	VIRTIO_GPU_F_VIRGL,
 #endif
+	VIRTIO_GPU_F_EDID,
 };
 static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 65060c0852..f6cbbb27e4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -44,6 +44,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
 		     events_read, &events_read);
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
+		if (vgdev->has_edid)
+			virtio_gpu_cmd_get_edids(vgdev);
 		virtio_gpu_cmd_get_display_info(vgdev);
 		drm_helper_hpd_irq_event(vgdev->ddev);
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
@@ -174,6 +176,10 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 #else
 	DRM_INFO("virgl 3d acceleration not supported by guest\n");
 #endif
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+		vgdev->has_edid = true;
+		DRM_INFO("EDID support available.\n");
+	}
 
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 	if (ret) {
@@ -219,6 +225,8 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 
 	if (num_capsets)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
+	if (vgdev->has_edid)
+		virtio_gpu_cmd_get_edids(vgdev);
 	virtio_gpu_cmd_get_display_info(vgdev);
 	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 			   5 * HZ);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483..7d79211d1f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -596,6 +596,37 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 	wake_up(&vgdev->resp_wq);
 }
 
+static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_resp_edid *resp =
+		(struct virtio_gpu_resp_edid *)vbuf->resp_buf;
+	uint32_t scanout = le32_to_cpu(resp->scanout);
+	uint32_t size = le32_to_cpu(resp->size);
+	struct virtio_gpu_output *output;
+	struct edid *new_edid, *old_edid;
+
+	if (scanout >= vgdev->num_scanouts)
+		return;
+	output = vgdev->outputs + scanout;
+
+	if (drm_edid_is_valid((struct edid *)resp->edid)) {
+		new_edid = kmalloc(size, GFP_KERNEL);
+		memcpy(new_edid, resp->edid, size);
+	} else {
+		new_edid = NULL;
+	}
+
+	spin_lock(&vgdev->display_info_lock);
+	old_edid = output->edid;
+	output->edid = new_edid;
+	drm_connector_update_edid_property(&output->conn, output->edid);
+	spin_unlock(&vgdev->display_info_lock);
+
+	kfree(old_edid);
+	wake_up(&vgdev->resp_wq);
+}
+
 int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_ctrl_hdr *cmd_p;
@@ -697,6 +728,34 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_get_edid *cmd_p;
+	struct virtio_gpu_vbuffer *vbuf;
+	void *resp_buf;
+	int scanout;
+
+	if (WARN_ON(!vgdev->has_edid))
+		return -EINVAL;
+
+	for (scanout = 0; scanout < vgdev->num_scanouts; scanout++) {
+		resp_buf = kzalloc(sizeof(struct virtio_gpu_resp_edid),
+				   GFP_KERNEL);
+		if (!resp_buf)
+			return -ENOMEM;
+
+		cmd_p = virtio_gpu_alloc_cmd_resp
+			(vgdev, &virtio_gpu_cmd_get_edid_cb, &vbuf,
+			 sizeof(*cmd_p), sizeof(struct virtio_gpu_resp_edid),
+			 resp_buf);
+		cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_EDID);
+		cmd_p->scanout = cpu_to_le32(scanout);
+		virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	}
+
+	return 0;
+}
+
 void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 				   uint32_t nlen, const char *name)
 {
-- 
2.9.3


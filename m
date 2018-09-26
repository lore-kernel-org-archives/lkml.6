Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37951214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tEbt37Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37951214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeIZWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xn1FMi+rxNeYnq7jScbAisw+I6VPyHTG8ld3nCyCAaM=; b=tEbt37Oq3lU1JG0GuWvMo9iZw
        q4ncOohPASroXse0Ca1dAVJruXS8X991aFI37u940Zil5gk90iprlvzvCpTNpAlCv+KNk46OZV0oY
        w6FMkclNluVkZBEd6/WzbIxeDdmlw3AKkBgJOdMCr5iIxuX+7vb5qtBV5sdrMEf444tHx32zqICKb
        LCWKFuwlS9csArLDoO0lUfW0we1b5EffU16C/v0uZSv4HLl0xLWjuJyz6hBvx1zFylOxk29+fXM8v
        p32WhCs9V6/maryOqyTKho2tpgYDT4s5Jzm+alvOYINy+aXY/8IaGBWKxerDRhPJTcM0F6ojUkgm+
        fVlGNdOLw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CEt-0004EN-HS; Wed, 26 Sep 2018 16:00:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/virtio: Replace IDRs with IDAs
Date:   Wed, 26 Sep 2018 09:00:28 -0700
Message-Id: <20180926160031.15721-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These IDRs were only being used to allocate unique numbers, not to look
up pointers, so they can use the more space-efficient IDA instead.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  6 ++----
 drivers/gpu/drm/virtio/virtgpu_kms.c | 18 ++++--------------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++----------
 3 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207bbe..c4468a4e454e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -180,8 +180,7 @@ struct virtio_gpu_device {
 	struct kmem_cache *vbufs;
 	bool vqs_ready;
 
-	struct idr	resource_idr;
-	spinlock_t resource_idr_lock;
+	struct ida	resource_ida;
 
 	wait_queue_head_t resp_wq;
 	/* current display info */
@@ -190,8 +189,7 @@ struct virtio_gpu_device {
 
 	struct virtio_gpu_fence_driver fence_drv;
 
-	struct idr	ctx_id_idr;
-	spinlock_t ctx_id_idr_lock;
+	struct ida	ctx_id_ida;
 
 	bool has_virgl_3d;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 65060c08522d..e2604fe1b4ae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -55,21 +55,13 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 static void virtio_gpu_ctx_id_get(struct virtio_gpu_device *vgdev,
 				  uint32_t *resid)
 {
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->ctx_id_idr_lock);
-	handle = idr_alloc(&vgdev->ctx_id_idr, NULL, 1, 0, 0);
-	spin_unlock(&vgdev->ctx_id_idr_lock);
-	idr_preload_end();
+	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
 	*resid = handle;
 }
 
 static void virtio_gpu_ctx_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	spin_lock(&vgdev->ctx_id_idr_lock);
-	idr_remove(&vgdev->ctx_id_idr, id);
-	spin_unlock(&vgdev->ctx_id_idr_lock);
+	ida_free(&vgdev->ctx_id_ida, id);
 }
 
 static void virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
@@ -151,10 +143,8 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 	vgdev->dev = dev->dev;
 
 	spin_lock_init(&vgdev->display_info_lock);
-	spin_lock_init(&vgdev->ctx_id_idr_lock);
-	idr_init(&vgdev->ctx_id_idr);
-	spin_lock_init(&vgdev->resource_idr_lock);
-	idr_init(&vgdev->resource_idr);
+	ida_init(&vgdev->ctx_id_ida);
+	ida_init(&vgdev->resource_ida);
 	init_waitqueue_head(&vgdev->resp_wq);
 	virtio_gpu_init_vq(&vgdev->ctrlq, virtio_gpu_dequeue_ctrl_func);
 	virtio_gpu_init_vq(&vgdev->cursorq, virtio_gpu_dequeue_cursor_func);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d483d3..58be09d2eed6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -41,21 +41,13 @@
 void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				uint32_t *resid)
 {
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->resource_idr_lock);
-	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
-	spin_unlock(&vgdev->resource_idr_lock);
-	idr_preload_end();
+	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
 	*resid = handle;
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	spin_lock(&vgdev->resource_idr_lock);
-	idr_remove(&vgdev->resource_idr, id);
-	spin_unlock(&vgdev->resource_idr_lock);
+	ida_free(&vgdev->resource_ida, id);
 }
 
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
-- 
2.19.0


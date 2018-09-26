Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D264214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KoGSyKS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D264214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIZWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbeIZWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3y1Zd+G/1GesZNdFuHTBFpFvd8m3VWkJBLgvdqi1IeY=; b=KoGSyKS6yPJlI/fcTAyZiTwfT
        mhRK7FJ4ue/DarFAxTqIlv5nZDEk4SnlgA7Cd3QxnikcFOVeZewHq/SbcGiy+IVNMxxUYi8n7yh0q
        g+/y+DTxs0gBK1lpISAU+w29Ol4Xo4wAzNH30jBnJ5+vM2hXrTvR8bkrdxq07bpCpKbc13QbS1c+l
        dceFNvpuvNlNmQsui/DwxpLCZcWCfHrhsa8lMidESB68PMzq50CM/wRHoP4s3xNLWzRAquxSEaiHE
        esahY7qoCEhgBBWEDdFSrCuOgh/Ua9ZQ09PXnA/bp9uYFFLLlXwxlWKZoOk0DYtyFedPiyRwivhXh
        u5vnD/5Rw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CEv-0004Ey-2t; Wed, 26 Sep 2018 16:00:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Date:   Wed, 26 Sep 2018 09:00:31 -0700
Message-Id: <20180926160031.15721-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-based IDAs are more efficient than any other base.  Convert the
1-based IDAs to be 0-based.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index bf609dcae224..b576c9ef6323 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
 
 	if (handle < 0)
 		return handle;
+	handle++;
 	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
 	return handle;
 }
@@ -67,7 +68,7 @@ static void virtio_gpu_context_destroy(struct virtio_gpu_device *vgdev,
 				      uint32_t ctx_id)
 {
 	virtio_gpu_cmd_context_destroy(vgdev, ctx_id);
-	ida_free(&vgdev->ctx_id_ida, ctx_id);
+	ida_free(&vgdev->ctx_id_ida, ctx_id - 1);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 387951c971d4..81297fe0147d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -40,12 +40,15 @@
 
 int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev)
 {
-	return ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
+	if (handle < 0)
+		return handle;
+	return handle + 1;
 }
 
 void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	ida_free(&vgdev->resource_ida, id);
+	ida_free(&vgdev->resource_ida, id - 1);
 }
 
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
-- 
2.19.0


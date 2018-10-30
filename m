Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469EC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZy3VjlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8905C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJaBsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:48:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeJaBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rS9g+6Ctk8k7UtvWGyswZ5XHHFWf/nudIqbMYHp4gW0=; b=JZy3VjlTaIrgEqDyPfRPFSIT6
        oQZe2VhTexbxdnBBh2ARHbGJKq5q3qRU+cCL9BORrVptU06rrqx3vkBhnF2eMsJ3EgcY8Dj8C4IJX
        8iThzvHJ8HQyYj2o636B+NNLK/6AtJ1cdJK19PDoSLBuVswqp5fePQuDZMbF9LaJXJFIFF6JBaGWC
        svlOH4nmwyZCowI9Mu5hzW7IkQw+zwSxdbbWf5csHCSDfnftSyYj5n18c6wcnkLlCRXC2qR7XPJS+
        nS3dZ8lDoeiDF0c2SanG4TS7ma/UdZ5AkkQUWNjBIGQq4sEZnEYkfpSjDNLCZo+39PuHfpV2to5Tj
        c9DMg30kg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHXHL-0003XA-A6; Tue, 30 Oct 2018 16:54:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/2] drm/virtio: Use IDAs more efficiently
Date:   Tue, 30 Oct 2018 09:53:52 -0700
Message-Id: <20181030165352.13065-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181030165352.13065-1-willy@infradead.org>
References: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
 <20181030165352.13065-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-based IDAs are more efficient than any other base.  Convert the
1-based IDAs to be 0-based.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 5 +++--
 drivers/gpu/drm/virtio/virtgpu_object.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index bf609dcae224..8118f10fde4a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -55,10 +55,11 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
 				      uint32_t nlen, const char *name)
 {
-	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
+	handle += 1;
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
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 5ac42dded217..f39a183d59c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -28,18 +28,18 @@
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
-	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
 
-	*resid = handle;
+	*resid = handle + 1;
 	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	ida_free(&vgdev->resource_ida, id);
+	ida_free(&vgdev->resource_ida, id - 1);
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.19.1


Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D3EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50011214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKSm/Fdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50011214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeIZWOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeIZWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i2JAuGk8Z9F9bBTKzVDbbl3DRytNyFZ2c9zLdd3Mu4o=; b=mKSm/Fdw6UPGNj/rjNALwUh9r
        DJ3L3WNbPGOKXSAf6d+iB3BxibmyNp7WPsWBBHL0k8BJJCstmsFAxENKXlzbzW8OBi57wkmr/oWmQ
        3xJcFwkOHxjKoFSEuAm2OVXY+gm0zRZ//IQ+UZWjmi7V/H2ofpfmwXsGaRiQp+z9ymRojxAdcO7HZ
        vm372jFEchV9Z+f5Ql7r6CfXOx222rPk5yd3e2vR90vmTh+oYt8jAuSIFRa4V2DdfBkVieFEB+/FC
        VAy2p8Ws/zKyIbuhaUFILsG+mvd1mTuctJ3MVVzQm1vMBeuPg4vzQAxgStUKe2QGV21/mmd8dt5Su
        WKNlzVSkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CEu-0004EW-1s; Wed, 26 Sep 2018 16:00:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/virtio: Handle context ID allocation errors
Date:   Wed, 26 Sep 2018 09:00:29 -0700
Message-Id: <20180926160031.15721-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180926160031.15721-1-willy@infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to run out of memory while allocating IDs.  The current
code would create a context with an invalid ID; change it to return
-ENOMEM to userspace.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 29 +++++++++++-----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index e2604fe1b4ae..bf609dcae224 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -52,31 +52,22 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 		      events_clear, &events_clear);
 }
 
-static void virtio_gpu_ctx_id_get(struct virtio_gpu_device *vgdev,
-				  uint32_t *resid)
+static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
+				      uint32_t nlen, const char *name)
 {
 	int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
-	*resid = handle;
-}
 
-static void virtio_gpu_ctx_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-{
-	ida_free(&vgdev->ctx_id_ida, id);
-}
-
-static void virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
-				      uint32_t nlen, const char *name,
-				      uint32_t *ctx_id)
-{
-	virtio_gpu_ctx_id_get(vgdev, ctx_id);
-	virtio_gpu_cmd_context_create(vgdev, *ctx_id, nlen, name);
+	if (handle < 0)
+		return handle;
+	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
+	return handle;
 }
 
 static void virtio_gpu_context_destroy(struct virtio_gpu_device *vgdev,
 				      uint32_t ctx_id)
 {
 	virtio_gpu_cmd_context_destroy(vgdev, ctx_id);
-	virtio_gpu_ctx_id_put(vgdev, ctx_id);
+	ida_free(&vgdev->ctx_id_ida, ctx_id);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
@@ -261,7 +252,7 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv;
-	uint32_t id;
+	int id;
 	char dbgname[TASK_COMM_LEN];
 
 	/* can't create contexts without 3d renderer */
@@ -274,7 +265,9 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 		return -ENOMEM;
 
 	get_task_comm(dbgname, current);
-	virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname, &id);
+	id = virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname);
+	if (id < 0)
+		return id;
 
 	vfpriv->ctx_id = id;
 	file->driver_priv = vfpriv;
-- 
2.19.0


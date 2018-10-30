Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0CFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA5A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Av8SrVFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA5A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJaBsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:48:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeJaBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/QkVYXdTlls+1jv1STYgoSEGYthtKRPD5Ye6AW+t4zs=; b=Av8SrVFYNozVQwVWYekbhMy3v
        nNHT5+BodMcUBu2UozUSRHheQWR9dg0f7DjNxJCsVzYZDigvv3RSOKD4Znrj0QKzzCY38LBgtKrm6
        D7UO+KA5fsAAKX76e/z8RqnlRhf9YW2GRw150SXrcpYQQ3ge3ZtUk7gvRZwixN6KI2Fj5XOBw8Knz
        Wn0RTq8UrOrYHBpZfVIPDhvKLMyInJd/IGlWONIaulyLEb5t2JEOSEVbJNptX4eBg29PDe2C1wOiQ
        5YSFLfbdq4xXue+2Te5aqvp1tXGe93DV8dvr26WnFba4kqIpB8apgP4G3PbXEISy7qUtaZegSpGEy
        thLdSHK+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHXHJ-0003Wk-Ce; Tue, 30 Oct 2018 16:54:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/2] drm/virtio: Handle error from virtio_gpu_resource_id_get
Date:   Tue, 30 Oct 2018 09:53:51 -0700
Message-Id: <20181030165352.13065-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
References: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() can return -ENOMEM in the highly unlikely case we run out
of memory.  The current code creates an object with an invalid ID.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 77eac4eb06b1..5ac42dded217 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,11 +25,16 @@
 
 #include "virtgpu_drv.h"
 
-static void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
+static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
 	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+
+	if (handle < 0)
+		return handle;
+
 	*resid = handle;
+	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
@@ -94,7 +99,11 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
+	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
+	if (ret < 0) {
+		kfree(bo);
+		return ret;
+	}
 	size = roundup(size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
 	if (ret != 0) {
-- 
2.19.1


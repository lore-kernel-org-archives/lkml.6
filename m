Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C352C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3830620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfBHOEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:04:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfBHOEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:04:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A15C959479;
        Fri,  8 Feb 2019 14:04:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-137.ams2.redhat.com [10.36.117.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A48391048125;
        Fri,  8 Feb 2019 14:04:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C8EE4A1E3; Fri,  8 Feb 2019 15:04:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: do NOT reuse resource ids
Date:   Fri,  8 Feb 2019 15:04:09 +0100
Message-Id: <20190208140409.15280-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 08 Feb 2019 14:04:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisected guest kernel changes crashing qemu.  Landed at
"6c1cd97bda drm/virtio: fix resource id handling".  Looked again, and
noticed we where not only leaking *some* ids, but *all* ids.  The old
code never ever called virtio_gpu_resource_id_put().

So, commit 6c1cd97bda effectively makes the linux kernel starting
re-using IDs after releasing them, and apparently virglrenderer can't
deal with that.  Oops.

This patch puts a temporary stopgap into place for the 5.0 release.

Cc: David Airlie <airlied@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---

Notes:
    Hi Dave, I'll be offline next week, so please commit to
    drm-next-fixes if you think this patch is acceptable.

 drivers/gpu/drm/virtio/virtgpu_object.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f39a183d59..e7e9460350 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -28,10 +28,21 @@
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
+#if 0
 	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
 
 	if (handle < 0)
 		return handle;
+#else
+	static int handle;
+
+	/*
+	 * FIXME: dirty hack to avoid re-using IDs, virglrenderer
+	 * can't deal with that.  Needs fixing in virglrenderer, also
+	 * should figure a better way to handle that in the guest.
+	 */
+	handle++;
+#endif
 
 	*resid = handle + 1;
 	return 0;
@@ -39,7 +50,9 @@ static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
+#if 0
 	ida_free(&vgdev->resource_ida, id - 1);
+#endif
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.9.3


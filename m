Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B552ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D02086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51D02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJSOXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeJSOXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7DD332FA1;
        Fri, 19 Oct 2018 06:18:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4BF4DA7C;
        Fri, 19 Oct 2018 06:18:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9129BA8585; Fri, 19 Oct 2018 08:18:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] drm/virtio: use virtio_gpu_object->hw_res_handle in virtio_gpufb_create()
Date:   Fri, 19 Oct 2018 08:18:43 +0200
Message-Id: <20181019061847.18958-3-kraxel@redhat.com>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 19 Oct 2018 06:18:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop pointless resid variable in virtio_gpufb_create(), just use
the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index d39f4f3350..800960bdd9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -214,7 +214,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	struct drm_framebuffer *fb;
 	struct drm_mode_fb_cmd2 mode_cmd = {};
 	struct virtio_gpu_object *obj;
-	uint32_t resid, format, size;
+	uint32_t format, size;
 	int ret;
 
 	mode_cmd.width = sizes->surface_width;
@@ -231,8 +231,8 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, obj, resid, format,
+	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
+	virtio_gpu_cmd_create_resource(vgdev, obj, obj->hw_res_handle, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_object_kmap(obj);
@@ -242,7 +242,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	}
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
 	if (ret)
 		goto err_obj_attach;
 
-- 
2.9.3


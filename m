Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701AEC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2862064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2862064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJARJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56763 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbeJARJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 870C230E6845;
        Mon,  1 Oct 2018 10:32:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1242C1001F41;
        Mon,  1 Oct 2018 10:32:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B04019D374; Mon,  1 Oct 2018 12:32:22 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/8] drm/virtio: use virtio_gpu_object->hw_res_handle in virtio_gpu_mode_dumb_create()
Date:   Mon,  1 Oct 2018 12:32:16 +0200
Message-Id: <20181001103222.11924-3-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 01 Oct 2018 10:32:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop pointless resid variable in virtio_gpu_mode_dumb_create(), just use
the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 82c817f37c..2492f5a2e9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -87,7 +87,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_object *obj;
 	int ret;
 	uint32_t pitch;
-	uint32_t resid;
 	uint32_t format;
 
 	if (args->bpp != 32)
@@ -103,13 +102,13 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		goto fail;
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
-	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, resid, format,
+	obj = gem_to_virtio_gpu_obj(gobj);
+	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
+	virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
-	obj = gem_to_virtio_gpu_obj(gobj);
-	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
 	if (ret)
 		goto fail;
 
-- 
2.9.3


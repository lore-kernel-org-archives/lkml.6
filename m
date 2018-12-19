Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD88204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeLSM1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbeLSM1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9C66C057F38;
        Wed, 19 Dec 2018 12:27:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660E05DD63;
        Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8539B4CC90; Wed, 19 Dec 2018 13:27:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/10] drm/virtio: ditch virtio_gpu_object_attach() calls
Date:   Wed, 19 Dec 2018 13:27:08 +0100
Message-Id: <20181219122708.4586-11-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 19 Dec 2018 12:27:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With virtio_gpu_object_create() being called earlier ttm_bo_init() will
handle the virtio_gpu_object_attach() (via backend binding), so we can
drop the extra calls now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 9 ---------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index ca84990382..4b01e5655c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -82,9 +82,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_object *obj;
 	struct virtio_gpu_object_params params = {
 		.pinned = false,
 	};
@@ -108,13 +106,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
-	obj = gem_to_virtio_gpu_obj(gobj);
-
-	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
-	if (ret)
-		goto fail;
-
 	args->pitch = pitch;
 	return ret;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e5bd1fed56..90b3955b6f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -319,8 +319,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
 
-	ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
 		drm_gem_object_release(obj);
-- 
2.9.3


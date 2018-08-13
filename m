Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F16C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD17F21899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD17F21899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbeHMSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:11:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbeHMSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:11:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A19F1818F03C;
        Mon, 13 Aug 2018 15:29:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-23.ams2.redhat.com [10.36.116.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC352156712;
        Mon, 13 Aug 2018 15:29:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5269E31FB4; Mon, 13 Aug 2018 17:29:01 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: track virtual output state
Date:   Mon, 13 Aug 2018 17:28:55 +0200
Message-Id: <20180813152855.12863-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 15:29:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 15:29:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track whenever an virtual output (crtc) is enabled or disabled.

On atomic updates check for both framebuffer being present and crtc
being enabled to figure whenever the output is active or not.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
 drivers/gpu/drm/virtio/virtgpu_display.c | 4 ++++
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 65605e207b..d46f10e656 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -114,6 +114,7 @@ struct virtio_gpu_output {
 	struct virtio_gpu_update_cursor cursor;
 	int cur_x;
 	int cur_y;
+	bool enabled;
 };
 #define drm_crtc_to_virtio_gpu_output(x) \
 	container_of(x, struct virtio_gpu_output, crtc)
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 25503b9335..9f1e0a669d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -109,6 +109,9 @@ static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
 					  struct drm_crtc_state *old_state)
 {
+	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
+
+	output->enabled = true;
 }
 
 static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -119,6 +122,7 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
 
 	virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
+	output->enabled = false;
 }
 
 static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index dc5b5b2b7a..88f2fb8c61 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -152,7 +152,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	if (WARN_ON(!output))
 		return;
 
-	if (plane->state->fb) {
+	if (plane->state->fb && output->enabled) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
 		bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 		handle = bo->hw_res_handle;
-- 
2.9.3


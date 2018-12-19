Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265D2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeLSM1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeLSM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E62F880F94;
        Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD7BB60C44;
        Wed, 19 Dec 2018 12:27:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1C20B750A; Wed, 19 Dec 2018 13:27:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/10] drm/virtio: fix pageflip flush
Date:   Wed, 19 Dec 2018 13:27:00 +0100
Message-Id: <20181219122708.4586-3-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 19 Dec 2018 12:27:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the flush command only makes sense if we actually have
a framebuffer attached to the scanout (handle != 0).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index ead5c53d4e..548265b8e8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -130,11 +130,12 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				   plane->state->src_h >> 16,
 				   plane->state->src_x >> 16,
 				   plane->state->src_y >> 16);
-	virtio_gpu_cmd_resource_flush(vgdev, handle,
-				      plane->state->src_x >> 16,
-				      plane->state->src_y >> 16,
-				      plane->state->src_w >> 16,
-				      plane->state->src_h >> 16);
+	if (handle)
+		virtio_gpu_cmd_resource_flush(vgdev, handle,
+					      plane->state->src_x >> 16,
+					      plane->state->src_y >> 16,
+					      plane->state->src_w >> 16,
+					      plane->state->src_h >> 16);
 }
 
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
-- 
2.9.3


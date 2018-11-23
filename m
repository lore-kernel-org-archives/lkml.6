Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A988C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6913620865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6913620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeKXIkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:40:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33426 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeKXIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:40:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id D15FD263AE1
From:   Helen Koike <helen.koike@collabora.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH v2] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Date:   Fri, 23 Nov 2018 19:53:54 -0200
Message-Id: <20181123215354.14540-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag tells core to jump ahead the queued update if the conditions
in drm_atomic_async_check() are met. That means we are only able to do an
async update if no modeset is pending and update for the same plane is
not queued.

It uses the already in place infrastructure for async updates.

It is useful for cursor updates and async PageFlips over the atomic
ioctl, otherwise in some cases updates may be delayed to the point the
user will notice it. Note that for now it's only enabled for cursor
planes.

DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
feature.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[updated for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
Hi,

This is the second attempt to introduce the new ATOMIC_AMEND flag for atomic
operations, see the commit message for a more detailed description.

This was tested using a small program that exercises the uAPI for easy
sanity testing. The program was created by Alexandros and modified by
Enric to test the capability flag [2].

To test, just build the program and use the --atomic flag to use the cursor
plane with the ATOMIC_AMEND flag. E.g.

  drm_cursor --atomic

The test worked on a rockchip Ficus v1.1 board on top of mainline plus
the patch to update cursors asynchronously through atomic for the
drm/rockchip driver plus the DRM_CAP_ASYNC_UPDATE patch.

Alexandros also did a proof-of-concept to use this flag and draw cursors
using atomic if possible on ozone [1].

Thanks
Helen

[1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
[2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability


Changes in v2:
- rebase tree
- do not fall back to a non-async update if if there isn't any
pending commit to amend

Changes in v1:
- https://patchwork.freedesktop.org/patch/243088/
- Only enable it if userspace requests it.
- Only allow async update for cursor type planes.
- Rename ASYNC_UPDATE for ATOMIC_AMEND.

 drivers/gpu/drm/drm_atomic_helper.c | 6 +++++-
 drivers/gpu/drm/drm_atomic_uapi.c   | 6 ++++++
 include/uapi/drm/drm_mode.h         | 4 +++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 269f1a74de38..333190c6a0a4 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -934,7 +934,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	if (state->legacy_cursor_update)
+	if (state->async_update || state->legacy_cursor_update)
 		state->async_update = !drm_atomic_helper_async_check(dev, state);
 
 	return ret;
@@ -1602,6 +1602,10 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
 	if (new_plane_state->fence)
 		return -EINVAL;
 
+	/* Only allow async update for cursor type planes. */
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
 	/*
 	 * Don't do an async update if there is an outstanding commit modifying
 	 * the plane.  This prevents our async update's changes from getting
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index d5b7f315098c..d5d26fe85ecf 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -28,6 +28,7 @@
 
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_writeback.h>
@@ -1275,6 +1276,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
 		return -EINVAL;
 
+	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
+			(arg->flags & DRM_MODE_ATOMIC_AMEND))
+		return -EINVAL;
+
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 
 	state = drm_atomic_state_alloc(dev);
@@ -1283,6 +1288,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
+	state->async_update = !!(arg->flags & DRM_MODE_ATOMIC_AMEND);
 
 retry:
 	copied_objs = 0;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d3e0fe31efc5..0adb28d27e9e 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -733,13 +733,15 @@ struct drm_mode_destroy_dumb {
 #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
 #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
 #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
+#define DRM_MODE_ATOMIC_AMEND 0x0800
 
 #define DRM_MODE_ATOMIC_FLAGS (\
 		DRM_MODE_PAGE_FLIP_EVENT |\
 		DRM_MODE_PAGE_FLIP_ASYNC |\
 		DRM_MODE_ATOMIC_TEST_ONLY |\
 		DRM_MODE_ATOMIC_NONBLOCK |\
-		DRM_MODE_ATOMIC_ALLOW_MODESET)
+		DRM_MODE_ATOMIC_ALLOW_MODESET |\
+		DRM_MODE_ATOMIC_AMEND)
 
 struct drm_mode_atomic {
 	__u32 flags;
-- 
2.19.1


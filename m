Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DEAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717021A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E717021A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbeHFSK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:10:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733014AbeHFSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:10:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E7DB2260C4A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Date:   Mon,  6 Aug 2018 18:01:02 +0200
Message-Id: <20180806160102.11877-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

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
---
Hi,

This is an attempt to introduce the new ATOMIC_AMEND flag for atomic
operations, see the commit message for a more detailed description.

This was tested using a small program that exercises the uAPI for easy
sanity testing. The program created by Alexandros can be found here
[2]. To test, just build the program and use the --atomic flag to use the
cursor plane in normal (blocking mode), and --atomic-async to use the cursor
plane with the ATOMIC_AMEND flag. E.g.

  drm_cursor --atomic

or

  drm_cursor --atomic-async

The test worked on a Samsung Chromebook Plus on top of mainline plus
the patch to update cursors asynchronously through atomic for the
drm/rockchip driver.

Alexandros also did a proof-of-concept to use this flag and draw cursors
using atomic if possible on ozone [1].

Best regards,
 Enric

[1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
[2] https://gitlab.collabora.com/alf/drm-cursor


Changes in v1:
- Only enable it if userspace requests it.
- Only allow async update for cursor type planes.
- Rename ASYNC_UPDATE for ATOMIC_AMEND.

 drivers/gpu/drm/drm_atomic.c        |  5 +++++
 drivers/gpu/drm/drm_atomic_helper.c | 10 +++++++++-
 include/uapi/drm/drm_mode.h         |  4 +++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 895741e9cd7d..7b3e4aa2874d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2338,6 +2338,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
 		return -EINVAL;
 
+	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
+			(arg->flags & DRM_MODE_ATOMIC_AMEND))
+		return -EINVAL;
+
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 
 	state = drm_atomic_state_alloc(dev);
@@ -2346,6 +2350,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
+	state->async_update = !!(arg->flags & DRM_MODE_ATOMIC_AMEND);
 
 retry:
 	plane_mask = 0;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 81e32199d3ef..59495f61c583 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -902,7 +902,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	if (state->legacy_cursor_update)
+	if (state->async_update || state->legacy_cursor_update)
 		state->async_update = !drm_atomic_helper_async_check(dev, state);
 
 	return ret;
@@ -1539,6 +1539,14 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
 	if (new_plane_state->fence)
 		return -EINVAL;
 
+	/* Only allow async update for cursor type planes. */
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
+	/* Don't do an async update if there isn't a pending commit. */
+	if (!old_plane_state->commit)
+		return -EINVAL;
+
 	/*
 	 * Don't do an async update if there is an outstanding commit modifying
 	 * the plane.  This prevents our async update's changes from getting
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 4b3a1bb58e68..6dae18428123 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -724,13 +724,15 @@ struct drm_mode_destroy_dumb {
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
2.18.0


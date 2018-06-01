Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeFAUGZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:06:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33243 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbeFAUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:06:22 -0400
X-Google-Smtp-Source: ADUXVKLwkHZFNFhJLcTm7bHA6mA4Xl94W2cFY/y5sXERAc6JWWS6mzOgat5XxuNC75IhEnTr+h3sgw==
From: Jeremy Cline <jcline@redhat.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Ray Strode <rstrode@redhat.com>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] drm/qxl: Call qxl_bo_unref outside atomic context
Date: Fri,  1 Jun 2018 16:05:32 -0400
Message-Id: <20180601200532.13619-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"qxl_bo_unref" may sleep, but calling "qxl_release_map" causes
"preempt_disable()" to be called and "preempt_enable()" isn't called
until "qxl_release_unmap" is used. Move the call to "qxl_bo_unref" out
from in between the two to avoid sleeping from an atomic context.

This issue can be demonstrated on a kernel with CONFIG_LOCKDEP=y by
creating a VM using QXL, using a desktop environment using Xorg, then
moving the cursor on or off a window.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1571128
Fixes: 9428088c90b6 ("drm/qxl: reapply cursor after resetting primary")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ecb35ed0eac8..61e51516fec5 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -630,7 +630,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_cursor *cursor;
 	struct drm_gem_object *obj;
-	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL;
+	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL, *old_cursor_bo = NULL;
 	int ret;
 	void *user_ptr;
 	int size = 64*64*4;
@@ -684,7 +684,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 							   cursor_bo, 0);
 		cmd->type = QXL_CURSOR_SET;
 
-		qxl_bo_unref(&qcrtc->cursor_bo);
+		old_cursor_bo = qcrtc->cursor_bo;
 		qcrtc->cursor_bo = cursor_bo;
 		cursor_bo = NULL;
 	} else {
@@ -704,6 +704,9 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
 
+	if (old_cursor_bo)
+		qxl_bo_unref(&old_cursor_bo);
+
 	qxl_bo_unref(&cursor_bo);
 
 	return;
-- 
2.17.0

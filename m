Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933316AbeEIAO2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:14:28 -0400
Received: from anholt.net ([50.246.234.109]:53694 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933175AbeEIAO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:14:27 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] drm: Fix render node numbering regression from control node removal.
Date: Tue,  8 May 2018 17:14:25 -0700
Message-Id: <20180509001425.12574-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_minor_alloc() does multiplication on this enum, so the removal
ended up moving render nodes down from 128 base to 64.  This caused
Mesa's surfaceless backend to be unable to open the render nodes,
since it was still looking up at 128.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 0d49f303e8a7 ("drm: remove all control node code")
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <seanpaul@chromium.org>
---
 include/drm/drm_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 99ab50cbab00..69b0a8b57502 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -49,6 +49,7 @@ struct device;
 
 enum drm_minor_type {
 	DRM_MINOR_PRIMARY,
+	DRM_MINOR_CONTROL,
 	DRM_MINOR_RENDER,
 };
 
-- 
2.17.0

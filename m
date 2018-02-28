Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeB1RDI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:03:08 -0500
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:55391 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933613AbeB1Pvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:51:49 -0500
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: DRI-devel <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] drm/drm_ioctl.c: Test client capability value early when setting.
Date: Wed, 28 Feb 2018 15:27:41 +0000
Message-Id: <20180228152741.22507-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_setclientcap() function implementing the DRM_IOCTL_SET_CLIENT_CAP
ioctl expects that any capability set by the client will have a value of 1.
Make the check early so that we don't have to test the value for each
capability.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_ioctl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index af782911c505..02ffa0e8d77b 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -306,22 +306,19 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 {
 	struct drm_set_client_cap *req = data;
 
+	if (req->value > 1)
+		return -EINVAL;
+
 	switch (req->capability) {
 	case DRM_CLIENT_CAP_STEREO_3D:
-		if (req->value > 1)
-			return -EINVAL;
 		file_priv->stereo_allowed = req->value;
 		break;
 	case DRM_CLIENT_CAP_UNIVERSAL_PLANES:
-		if (req->value > 1)
-			return -EINVAL;
 		file_priv->universal_planes = req->value;
 		break;
 	case DRM_CLIENT_CAP_ATOMIC:
 		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
 			return -EINVAL;
-		if (req->value > 1)
-			return -EINVAL;
 		file_priv->atomic = req->value;
 		file_priv->universal_planes = req->value;
 		break;
-- 
2.16.2

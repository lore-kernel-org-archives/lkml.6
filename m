Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755737AbeD3X7a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:59:30 -0400
Received: from anholt.net ([50.246.234.109]:41754 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755633AbeD3X73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:59:29 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stefan Schake <stschake@gmail.com>
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/vc4: Add a pad field to align drm_vc4_submit_cl to 64 bits.
Date: Mon, 30 Apr 2018 16:59:27 -0700
Message-Id: <20180430235927.28712-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had originally asked Stefan Schake to drop the pad field from the
syncobj changes that just landed, because I couldn't come up with a
reason to align to 64 bits.

Talking with Dave Airlie about the new v3d driver's submit ioctl, we
came up with a reason: sizeof() on 64-bit platforms may align to 64
bits, in which case the userspace will be submitting the aligned size
and the final 32 bits won't be zero-padded by the kernel.  If
userspace doesn't zero-fill, then a future ABI change adding a 32-bit
field at the end could potentially cause the kernel to read undefined
data from old userspace (our userspace happens to use structure
initialization that zero-fills, but as a general rule we try not to
rely on that in the kernel).

Signed-off-by: Eric Anholt <eric@anholt.net>
---

danvet, could you update the "Botching up IOCTLs" post with this
explanation for why we need struct size alignment for non-array
structs?

 drivers/gpu/drm/vc4/vc4_gem.c | 5 +++++
 include/uapi/drm/vc4_drm.h    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index a4c4be3ac6af..7910b9acedd6 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -1132,6 +1132,11 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	if (args->pad2 != 0) {
+		DRM_DEBUG("Invalid pad: 0x%08x\n", args->pad2);
+		return -EINVAL;
+	}
+
 	exec = kcalloc(1, sizeof(*exec), GFP_KERNEL);
 	if (!exec) {
 		DRM_ERROR("malloc failure on exec struct\n");
diff --git a/include/uapi/drm/vc4_drm.h b/include/uapi/drm/vc4_drm.h
index 2be4fe3610b8..2cac6277a1d7 100644
--- a/include/uapi/drm/vc4_drm.h
+++ b/include/uapi/drm/vc4_drm.h
@@ -193,6 +193,8 @@ struct drm_vc4_submit_cl {
 	 * render job. 0 means ignore.
 	 */
 	__u32 out_sync;
+
+	__u32 pad2;
 };
 
 /**
-- 
2.17.0

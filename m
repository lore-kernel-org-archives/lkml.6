Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424943AbeE1Lsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423670AbeE1LK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 141/272] drm/vmwgfx: Unpin the screen object backup buffer when not used
Date: Mon, 28 May 2018 12:02:54 +0200
Message-Id: <20180528100252.873156950@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

[ Upstream commit 20fb5a635a0c8478ac98f15cfafc2ea83df29565 ]

We were relying on the pinned screen object backup buffer to be destroyed
when not used. But if we hold a copy of the atomic state, like when
hibernating, the backup buffer might not be destroyed since it's
refcounted by the atomic state. This causes us to hibernate with a
buffer pinned in VRAM.

Fix this by only having the buffer pinned when it is actually used by a
screen object.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -453,7 +453,11 @@ vmw_sou_primary_plane_cleanup_fb(struct
 				 struct drm_plane_state *old_state)
 {
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
+	struct drm_crtc *crtc = plane->state->crtc ?
+		plane->state->crtc : old_state->crtc;
 
+	if (vps->dmabuf)
+		vmw_dmabuf_unpin(vmw_priv(crtc->dev), vps->dmabuf, false);
 	vmw_dmabuf_unreference(&vps->dmabuf);
 	vps->dmabuf_size = 0;
 
@@ -491,10 +495,17 @@ vmw_sou_primary_plane_prepare_fb(struct
 	}
 
 	size = new_state->crtc_w * new_state->crtc_h * 4;
+	dev_priv = vmw_priv(crtc->dev);
 
 	if (vps->dmabuf) {
-		if (vps->dmabuf_size == size)
-			return 0;
+		if (vps->dmabuf_size == size) {
+			/*
+			 * Note that this might temporarily up the pin-count
+			 * to 2, until cleanup_fb() is called.
+			 */
+			return vmw_dmabuf_pin_in_vram(dev_priv, vps->dmabuf,
+						      true);
+		}
 
 		vmw_dmabuf_unreference(&vps->dmabuf);
 		vps->dmabuf_size = 0;
@@ -504,7 +515,6 @@ vmw_sou_primary_plane_prepare_fb(struct
 	if (!vps->dmabuf)
 		return -ENOMEM;
 
-	dev_priv = vmw_priv(crtc->dev);
 	vmw_svga_enable(dev_priv);
 
 	/* After we have alloced the backing store might not be able to
@@ -515,13 +525,16 @@ vmw_sou_primary_plane_prepare_fb(struct
 			      &vmw_vram_ne_placement,
 			      false, &vmw_dmabuf_bo_free);
 	vmw_overlay_resume_all(dev_priv);
-
-	if (ret != 0)
+	if (ret) {
 		vps->dmabuf = NULL; /* vmw_dmabuf_init frees on error */
-	else
-		vps->dmabuf_size = size;
+		return ret;
+	}
 
-	return ret;
+	/*
+	 * TTM already thinks the buffer is pinned, but make sure the
+	 * pin_count is upped.
+	 */
+	return vmw_dmabuf_pin_in_vram(dev_priv, vps->dmabuf, true);
 }
 
 

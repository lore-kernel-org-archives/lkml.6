Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeDXAqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:46:16 -0400
Received: from anholt.net ([50.246.234.109]:34440 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932624AbeDXAqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:46:14 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/3] drm: Make the prime vmap/vunmap hooks optional.
Date: Mon, 23 Apr 2018 17:46:08 -0700
Message-Id: <20180424004610.4637-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424004610.4637-1-eric@anholt.net>
References: <20180424004610.4637-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers leave these unimplemented, so don't make them have
unimplemented stubs.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_prime.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index caf675e3e692..397b46b33739 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -409,7 +409,10 @@ void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct drm_device *dev = obj->dev;
 
-	return dev->driver->gem_prime_vmap(obj);
+	if (dev->driver->gem_prime_vmap)
+		return dev->driver->gem_prime_vmap(obj);
+	else
+		return NULL;
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_vmap);
 
@@ -426,7 +429,8 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, void *vaddr)
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct drm_device *dev = obj->dev;
 
-	dev->driver->gem_prime_vunmap(obj, vaddr);
+	if (dev->driver->gem_prime_vunmap)
+		dev->driver->gem_prime_vunmap(obj, vaddr);
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_vunmap);
 
-- 
2.17.0

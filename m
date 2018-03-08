Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbeCHCDG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:03:06 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36792 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:03:04 -0500
X-Google-Smtp-Source: AG47ELv8fpR8D282mVUp/Ke19ohnm61azL9zSrTtJr/MUQoDBlDuEjNO2BXlhl/l9V8M38S9RbF08A==
Date: Wed, 7 Mar 2018 23:03:01 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/vgem: Remove assignment in if condition
Message-ID: <092e934559446abe0aa381c0390d49caa1c42062.1520474055.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

vgem_fence.c:196: ERROR: do not use assignment in if condition

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_fence.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index b28876c222b4..f5b659463b00 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -191,10 +191,13 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	/* Expose the fence via the dma-buf */
 	ret = 0;
 	reservation_object_lock(resv, NULL);
-	if (arg->flags & VGEM_FENCE_WRITE)
+	if (arg->flags & VGEM_FENCE_WRITE) {
 		reservation_object_add_excl_fence(resv, fence);
-	else if ((ret = reservation_object_reserve_shared(resv)) == 0)
-		reservation_object_add_shared_fence(resv, fence);
+	} else {
+		ret = reservation_object_reserve_shared(resv);
+		if (!ret)
+			reservation_object_add_shared_fence(resv, fence);
+	}
 	reservation_object_unlock(resv);
 
 	/* Record the fence in our idr for later signaling */
-- 
2.16.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeEWLgm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:36:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33154 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeEWLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:36:39 -0400
X-Google-Smtp-Source: AB8JxZrNnJYV8khkavmnOcmG535qriqB6QkRLnAiWkwFNoh16DbxeLVw1EGBDCEoAQ3qJaIAVOgEtA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2] drm/xen-front: fix pointer casts
Date: Wed, 23 May 2018 14:36:30 +0300
Message-Id: <20180523113630.29811-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Building for a 32-bit target results in warnings from casting
between a 32-bit pointer and a 64-bit integer. Fix the warnings
by casting those pointers to uintptr_t first.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
Changes since v1:
 - remove unneeded u64 and phys_addr_t casts (Juergen)

 drivers/gpu/drm/xen/xen_drm_front.h       | 4 ++--
 drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
index 2c2479b571ae..5693b4a4b02b 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.h
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -126,12 +126,12 @@ struct xen_drm_front_drm_info {
 
 static inline u64 xen_drm_front_fb_to_cookie(struct drm_framebuffer *fb)
 {
-	return (u64)fb;
+	return (uintptr_t)fb;
 }
 
 static inline u64 xen_drm_front_dbuf_to_cookie(struct drm_gem_object *gem_obj)
 {
-	return (u64)gem_obj;
+	return (uintptr_t)gem_obj;
 }
 
 int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline *pipeline,
diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
index 8099cb343ae3..d333b67cc1a0 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
@@ -122,7 +122,7 @@ static void guest_calc_num_grefs(struct xen_drm_front_shbuf *buf)
 }
 
 #define xen_page_to_vaddr(page) \
-		((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
+		((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
 
 static int backend_unmap(struct xen_drm_front_shbuf *buf)
 {
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966956AbeEYPvk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:51:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drm/xen-front: fix 32-bit build warning
Date: Fri, 25 May 2018 17:50:10 +0200
Message-Id: <20180525155030.3667352-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ddItXKM++H9uoM10jODuwDQmtzeUlfdXwaNe+h8Gc45QuVb0Vjv
 vj8p5lfr9ZUYWoZi5rIzYdO+S0EwAiSLJrbHSBGntelCdaI5GcOO0T0tpSr6xD2IrVD4VIf
 +G4B4Qno+W4OMy0OFaP3oRbWLgVciurqY9PPvb/pxJrM6Z/ZuRYHOz8BOtYlg/XU/vtBj3S
 RzNFOSMsWuLZMQZ8xo/5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GVuNtDLgXEs=:MZa0Sr4rSDFUigfEOJjDRW
 5b88AJTYzyeyOwri29jS2qCSg7gjHwCPLbtrWEe9lXm0+8NIDBO0xmUkLijeBKOg9rRc/nTXR
 JiFteRLzTVSeJiwqMmLsK8hOMu7JLfJ2vYrEkKf0VqB19cFZ7qvZBrR9vENfDHLb57aeLB+4x
 f2wMChkD3lOAuSk3XOmx05Qh18YgV0cc2qf6Gxcy2tiajYU+j0cgrdoUov11JaizoyqlkvJz5
 l+5jENN11PP8lpE9w9g8L4U8HPCS5qN3CIr57T5lxVB1Sbkx9mIpP3emCryhgXn+eJ3BzzdTe
 v7uGxjTBViRvJ7RoO/I+vImMjBICg98bmNv+uBG6fEkwWu4E9LvCma8e5povV5uQtNrvxoqbR
 w5hcvZ74dIGQbR4vFraBcVnrmeXly5pfwSvH9k25pGl426+POoX2fIv4kzsdQeE3NukdyBazE
 WPeFHxpFliRJ4qniixeyNuPhiX+sIWT9pRdnARpZ66ZURSDY3Gten0RV13YiXUezHkcGGt+r+
 eRy7Bfch9vinQGszqPOYH2KoNgEWfbq32+7kwdFTrpH27WMeuxk3O9B94VTrNaBy66AgSoNvZ
 E9fL+LakVFjl6xnC3FfdJpQKjsv485d4HoztJe3GTBGOpblfmQji0N900k/yj1AEIEgh0Mfwo
 0kLlzklYn52RqwsHa0XmEDOtOc1Y+H7PyIH98yP3Yb4nUTozdftlxMDvEMI/OF0YKdUs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 32-bit kernel builds, we cannot cast between a pointer and a 64-bit
type:

In file included from drivers/gpu/drm/xen/xen_drm_front_cfg.c:18:
drivers/gpu/drm/xen/xen_drm_front.h: In function 'xen_drm_front_fb_to_cookie':
drivers/gpu/drm/xen/xen_drm_front.h:129:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (u64)fb;

drivers/gpu/drm/xen/xen_drm_front.h: In function 'xen_drm_front_dbuf_to_cookie':
drivers/gpu/drm/xen/xen_drm_front.h:134:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (u64)gem_obj;

drivers/gpu/drm/xen/xen_drm_front_shbuf.c: In function 'backend_unmap':
drivers/gpu/drm/xen/xen_drm_front_shbuf.c:125:4: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   ((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))

Using uintptr_t instead probably does what we want here, although it's
not clear to me why we assign a virtual address pointer to a phys_addr_t
in backend_unmap().

Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
2.9.0

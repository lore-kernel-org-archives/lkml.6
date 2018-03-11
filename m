Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCKXTQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 19:19:16 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:19995 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbeCKXTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 19:19:15 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Mar 2018 00:19:13 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maxime.ripard@free-electrons.com, airlied@linux.ie, wens@csie.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/sun4i: Fix an error handling path in 'sun4i_drv_bind()'
Date: Mon, 12 Mar 2018 00:19:09 +0100
Message-Id: <20180311231909.5381-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number
of crtcs") has moved some code without updating the error handling gotos
accordingly.

Branch to the correct label and remove a now unused lablel.

Fixes: 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number of crtcs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 4570da0227b4..d9a71f361b14 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -111,7 +111,7 @@ static int sun4i_drv_bind(struct device *dev)
 	/* drm_vblank_init calls kcalloc, which can fail */
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (ret)
-		goto free_mem_region;
+		goto cleanup_mode_config;
 
 	drm->irq_enabled = true;
 
@@ -139,7 +139,6 @@ static int sun4i_drv_bind(struct device *dev)
 	sun4i_framebuffer_free(drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-free_mem_region:
 	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_unref(drm);
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164314AbeE1M61 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164019AbeE1KyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <skeggsb@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 252/496] drm/nouveau/bl: fix backlight regression
Date: Mon, 28 May 2018 12:00:37 +0200
Message-Id: <20180528100330.510973807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit 9e75dc61eaa9acd1bff83c3b814ac2af6dc1f64c ]

Fixes: 3c66c87dc9 ("drm/nouveau/disp: remove hw-specific customisation
of output paths")
Suggested-by: Ben Skeggs <skeggsb@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -134,7 +134,7 @@ nv50_get_intensity(struct backlight_devi
 	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int or = nv_encoder->or;
+	int or = ffs(nv_encoder->dcb->or) - 1;
 	u32 div = 1025;
 	u32 val;
 
@@ -149,7 +149,7 @@ nv50_set_intensity(struct backlight_devi
 	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int or = nv_encoder->or;
+	int or = ffs(nv_encoder->dcb->or) - 1;
 	u32 div = 1025;
 	u32 val = (bd->props.brightness * div) / 100;
 
@@ -170,7 +170,7 @@ nva3_get_intensity(struct backlight_devi
 	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int or = nv_encoder->or;
+	int or = ffs(nv_encoder->dcb->or) - 1;
 	u32 div, val;
 
 	div  = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
@@ -188,7 +188,7 @@ nva3_set_intensity(struct backlight_devi
 	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int or = nv_encoder->or;
+	int or = ffs(nv_encoder->dcb->or) - 1;
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
@@ -228,7 +228,7 @@ nv50_backlight_init(struct drm_connector
 			return -ENODEV;
 	}
 
-	if (!nvif_rd32(device, NV50_PDISP_SOR_PWM_CTL(nv_encoder->or)))
+	if (!nvif_rd32(device, NV50_PDISP_SOR_PWM_CTL(ffs(nv_encoder->dcb->or) - 1)))
 		return 0;
 
 	if (drm->client.device.info.chipset <= 0xa0 ||

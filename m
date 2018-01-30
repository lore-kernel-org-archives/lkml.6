Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeA3Tvv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:51:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeA3Tvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:51:49 -0500
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Martin Peres <martin.peres@free.fr>, Rhys Kidd <rhyskidd@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC v5 5/5] drm/nouveau: Introduce NvPmEnableGating option
Date: Tue, 30 Jan 2018 14:49:25 -0500
Message-Id: <20180130195024.18172-6-lyude@redhat.com>
In-Reply-To: <20180130195024.18172-1-lyude@redhat.com>
References: <20180130195024.18172-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the NvPmEnableGating config option to nouveau, which can be
used to enable or disable clockgating for supported chipsets. Enabling
can be done by passing

	config=NvPmEnableGating=1

To nouveau. If your chipset supports it, you'll see a message in your
kernel log indicating that clockgating is enabled. Since clockgating has
only had limited testing thus far, we leave this option disabled by
default for now.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index de07bc07abdb..bf62303571b3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -434,7 +434,9 @@ nvkm_therm_ctor(struct nvkm_therm *therm, struct nvkm_device *device,
 	therm->attr_get = nvkm_therm_attr_get;
 	therm->attr_set = nvkm_therm_attr_set;
 	therm->mode = therm->suspend = -1; /* undefined */
-	therm->clkgating_enabled = false;
+
+	therm->clkgating_enabled = nvkm_boolopt(device->cfgopt,
+						"NvPmEnableGating", false);
 }
 
 int
-- 
2.14.3

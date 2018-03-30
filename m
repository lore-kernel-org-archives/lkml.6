Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeC3NP5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:15:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57782 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeC3NP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:15:57 -0400
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: kernel@collabora.com, Jyri Sarha <jsarha@ti.com>,
        David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tilcdc: Defer probe if there are no connectors
Date: Fri, 30 Mar 2018 15:15:53 +0200
Message-Id: <20180330131553.9060-1-sjoerd.simons@collabora.co.uk>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe there may not be any connectors yet if e.g. the panel
failed or hasn't been probed yet. I hitting this in practice the panels
probing was being delayed due to using a gpio backlight.

Fix this by returning -EPROBE_DEFER so the probing will be retried.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1afde61f1247..59f0a44bb6e3 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -380,7 +380,7 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	if (!priv->external_connector &&
 	    ((priv->num_encoders == 0) || (priv->num_connectors == 0))) {
 		dev_err(dev, "no encoders/connectors found\n");
-		ret = -ENXIO;
+		ret = -EPROBE_DEFER;
 		goto init_failed;
 	}
 
-- 
2.16.3

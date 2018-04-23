Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbeDWOLW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:11:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755562AbeDWOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:11:17 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 3/4] drm/panel: otm8009a: no message if probe success
Date: Mon, 23 Apr 2018 16:10:52 +0200
Message-ID: <20180423141054.13128-4-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180423141054.13128-1-philippe.cornu@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the message in case of probe success. This comes from
a suggestion followed in the recent integration of the
raydium rm68200 panel.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index de4a16d5275c..4c638b7b9943 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -14,8 +14,6 @@
 #include <linux/regulator/consumer.h>
 #include <video/mipi_display.h>
 
-#define DRV_NAME "orisetech_otm8009a"
-
 #define OTM8009A_BACKLIGHT_DEFAULT	240
 #define OTM8009A_BACKLIGHT_MAX		255
 
@@ -461,7 +459,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 	ctx->panel.dev = dev;
 	ctx->panel.funcs = &otm8009a_drm_funcs;
 
-	ctx->bl_dev = backlight_device_register(DRV_NAME "_backlight", dev, ctx,
+	ctx->bl_dev = backlight_device_register(dev_name(dev), dev, ctx,
 						&otm8009a_backlight_ops, NULL);
 	if (IS_ERR(ctx->bl_dev)) {
 		dev_err(dev, "failed to register backlight device\n");
@@ -483,11 +481,6 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready\n",
-		 default_mode.hdisplay, default_mode.vdisplay,
-		 default_mode.vrefresh,
-		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
-
 	return 0;
 }
 
@@ -513,7 +506,7 @@ static struct mipi_dsi_driver orisetech_otm8009a_driver = {
 	.probe  = otm8009a_probe,
 	.remove = otm8009a_remove,
 	.driver = {
-		.name = DRV_NAME "_panel",
+		.name = "panel-orisetech-otm8009a",
 		.of_match_table = orisetech_otm8009a_of_match,
 	},
 };
-- 
2.15.1

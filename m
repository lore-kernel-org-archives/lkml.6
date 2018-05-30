Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbeE3WIG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:08:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeE3WIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:08:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benoit Parrot <bparrot@ti.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: v4l: cadence: add VIDEO_V4L2 dependency
Date: Thu, 31 May 2018 00:07:10 +0200
Message-Id: <20180530220735.1651221-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:/8xdBscKlf2sf05at1uW9tsRcLE3pMaRcP5bF3HeO5jRStGAa9V
 kYzW8deZ5T5ElEhACm+WPXKyM6oDBC6zdc1+WLchdO4beLDAGs75wUOGbLHlNoxRijr0zHm
 ztVjMPBsSpiZLDu5UK8cp6yBYAKo66iokjbt3X/H+4M1OyJ5zbteTMz4mxgd8FYkkOiAEID
 +EiCQDY84CR53GEUa95/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7oC3GyGlxnU=:lgNMblleJOfk39n/Csggen
 aHaU0gBN2ty/FnC7ZQ42UtgSUsbFRL/+j7kZMEJvH4aIBSRuMNwewihjKPWyK4tzF8UnieQhY
 E3irPHRLr22SxwBTJubiYthrOi3nqIOjuF0I1rW+dmwM4nzqatHBbqZBmY1z1Ye7DxQddMK16
 l94jkQAAisyVMFXe1sESO4lFgU7UYtH089iwz1rwlswXhAOIxtXa+bWiQ20qX5m9HMXYZzaFH
 Bad08QIZ7Bhe08CiAiZCN4wXtNuAuFi1RPwKLwIjzhUZma6+1ATp15beHIkL0AQgOePXsXYxS
 pLXFbEeivkz+32NfBnLXMo7VPuBGNVKZs1qF28n24RA0F3ezWvBtydT7pJSfctVTtj4NwsqvG
 xyYuG8Y4eCr8XpqbYZCrcGwwdkUJVJqx7IRIuTjOCgu4KE3SHtNo7ZZ1Ag8Nja4OB29lrUK1E
 pnG6hyugjv44pRcswt1Rwu3+AWRZbbgxknNSlNdQVcisbjCXdrFPRpfSlkErEy96/oQYGOu1H
 xpCmfHBR2OglQV6lClLV44mLQgkTB+YePW2JlV8tkm0QZ6JprYR3bUAiZrSl6JFhcSnn4jZpT
 6BM5WYkDb02Y+777zj4AGcpu3+2LFgZbylJQx6K/a2zQ31EUJ/gBxM0+aIFgNy2BZkABopAEB
 qRlMnjPzXO+8SygxVH9gQ9SepgjHn94vMkiHsaXinX1lOQbSpA7awwoZoC19P447kZpU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cadence media drivers can be built-in while the v4l2 core is a loadable
module. This is a mistake and leads to link errors:

drivers/media/v4l2-core/v4l2-fwnode.o: In function `v4l2_async_register_subdev_sensor_common':
v4l2-fwnode.c:(.text+0x12f0): undefined reference to `v4l2_async_subdev_notifier_register'
v4l2-fwnode.c:(.text+0x1304): undefined reference to `v4l2_async_register_subdev'
v4l2-fwnode.c:(.text+0x1318): undefined reference to `v4l2_async_notifier_unregister'
v4l2-fwnode.c:(.text+0x1338): undefined reference to `v4l2_async_notifier_cleanup'
cdns-csi2rx.c:(.text+0x9f8): undefined reference to `v4l2_subdev_init'
cdns-csi2rx.c:(.text+0xa78): undefined reference to `v4l2_async_register_subdev'
drivers/media/platform/cadence/cdns-csi2tx.o: In function `csi2tx_remove':
cdns-csi2tx.c:(.text+0x88): undefined reference to `v4l2_async_unregister_subdev'
drivers/media/platform/cadence/cdns-csi2tx.o: In function `csi2tx_probe':
cdns-csi2tx.c:(.text+0x884): undefined reference to `v4l2_subdev_init'
cdns-csi2tx.c:(.text+0xa9c): undefined reference to `v4l2_async_register_subdev'

An explicit Kconfig dependency on VIDEO_V4L2 avoids the problem.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/cadence/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/cadence/Kconfig b/drivers/media/platform/cadence/Kconfig
index 3bf0f2454384..cf6124da3c54 100644
--- a/drivers/media/platform/cadence/Kconfig
+++ b/drivers/media/platform/cadence/Kconfig
@@ -11,6 +11,7 @@ if VIDEO_CADENCE
 
 config VIDEO_CADENCE_CSI2RX
 	tristate "Cadence MIPI-CSI2 RX Controller"
+	depends on VIDEO_V4L2
 	depends on MEDIA_CONTROLLER
 	depends on VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
@@ -22,6 +23,7 @@ config VIDEO_CADENCE_CSI2RX
 
 config VIDEO_CADENCE_CSI2TX
 	tristate "Cadence MIPI-CSI2 TX Controller"
+	depends on VIDEO_V4L2
 	depends on MEDIA_CONTROLLER
 	depends on VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
-- 
2.9.0

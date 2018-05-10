Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756433AbeEJBoA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:44:00 -0400
Received: from anholt.net ([50.246.234.109]:36242 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756317AbeEJBnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:43:47 -0400
From: Eric Anholt <eric@anholt.net>
To: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] staging/bcm2835-camera: Set ourselves up as a platform driver.
Date: Wed,  9 May 2018 18:43:42 -0700
Message-Id: <20180510014342.718-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510014342.718-1-eric@anholt.net>
References: <20180510014342.718-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows bcm2835-camera to automatically probe after VCHI has
loaded, rather than only successfully probing if the arbitrary probe
order chooses us after VCHI.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../staging/vc04_services/bcm2835-camera/TODO  | 11 -----------
 .../bcm2835-camera/bcm2835-camera.c            | 18 ++++++++++++++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index 0ab9e88d769a..cefce72d814f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -21,14 +21,3 @@ less copy it needed to do.
 The bulk_receive() does some manual cache flushing that are 32-bit ARM
 only, which we should convert to proper cross-platform APIs.
 
-4) Convert to be a platform driver.
-
-Right now when the module probes, it tries to initialize VCHI and
-errors out if it wasn't ready yet.  If bcm2835-v4l2 was built in, then
-VCHI generally isn't ready because it depends on both the firmware and
-mailbox drivers having already loaded.
-
-We should have VCHI create a platform device once it's initialized,
-and have this driver bind to it, so that we automatically load the
-v4l2 module after VCHI loads.
-
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index d2262275a870..aac876c35dea 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -23,6 +23,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include "mmal-common.h"
 #include "mmal-encodings.h"
@@ -1803,7 +1804,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int __init bm2835_mmal_init(void)
+static int __init bcm2835_mmal_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct bm2835_mmal_dev *dev;
@@ -1923,7 +1924,7 @@ static int __init bm2835_mmal_init(void)
 	return ret;
 }
 
-static void __exit bm2835_mmal_exit(void)
+static int bcm2835_mmal_remove(struct platform_device *pdev)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1933,7 +1934,16 @@ static void __exit bm2835_mmal_exit(void)
 		gdev[camera] = NULL;
 	}
 	vchiq_mmal_finalise(instance);
+
+	return 0;
 }
 
-module_init(bm2835_mmal_init);
-module_exit(bm2835_mmal_exit);
+static struct platform_driver bcm2835_camera_driver = {
+	.probe		= bcm2835_mmal_probe,
+	.remove		= bcm2835_mmal_remove,
+	.driver		= {
+		.name	= "bcm2835-camera",
+	},
+};
+
+module_platform_driver(bcm2835_camera_driver)
-- 
2.17.0

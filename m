Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeEJBnr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:43:47 -0400
Received: from anholt.net ([50.246.234.109]:36230 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756306AbeEJBnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:43:46 -0400
From: Eric Anholt <eric@anholt.net>
To: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2] staging/vc04_services: Register a platform device for the camera driver.
Date: Wed,  9 May 2018 18:43:41 -0700
Message-Id: <20180510014342.718-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had the camera driver set up in a module_init function, but that
meant that the camera driver would fail to load if it was initialized
before VCHI.  This enforces that it loads after we've successfully set
up.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

I'm going to try to get Dave Stevenson's new v4l2 codec driver merged
to staging (my primary motivation for getting vchi merged in the first
place!), and since his series touches the camera driver I needed to
probe the camera successfully in order to test it.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3cd6177a7373..aaa264f3b598 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -168,6 +168,7 @@ static VCHIQ_STATE_T g_state;
 static struct class  *vchiq_class;
 static struct device *vchiq_dev;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
+static struct platform_device *bcm2835_camera;
 
 static const char *const ioctl_names[] = {
 	"CONNECT",
@@ -3638,6 +3639,10 @@ static int vchiq_probe(struct platform_device *pdev)
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
+	bcm2835_camera = platform_device_register_data(&pdev->dev,
+						       "bcm2835-camera", -1,
+						       NULL, 0);
+
 	return 0;
 
 failed_debugfs_init:
@@ -3655,6 +3660,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
 	class_destroy(vchiq_class);
-- 
2.17.0

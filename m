Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966711AbeEYP0y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:26:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966018AbeEYP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:26:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] media: marvel-ccic: allow ccic and mmp drivers to coexist
Date: Fri, 25 May 2018 17:25:11 +0200
Message-Id: <20180525152523.2821369-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525152523.2821369-1-arnd@arndb.de>
References: <20180525152523.2821369-1-arnd@arndb.de>
X-Provags-ID: V03:K1:HOVlfreSyqqznhiA4hm8zrijy4s0I5qMaH8mQOSLFPB2k2t2TbI
 59nb/JyhDJI5gVS4UKGduMUUITLFfPm20bLDrOWPN0lZPl40wXWyXUUPHOWNej9Hcml8Vi2
 6d5rJZxDexHRqnUfTSyZZSIbqvv9VKB9MGpvWRmC/isYmT9/V/Au5fyYXseBTEqJPpYoCf1
 qfAUuWQxtHBifNnsK/esg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jljPvD3mKN0=:jspWfsIRf1Lqk9UdctfvG4
 AQF8fOhYrulbLyuTYYxSGksMH4iao6+a3V5xfBQX8sdjZrItN47x2ZarS7RwYsY3lMj26dIsD
 5yhIdQqIshjQ7pKtF0c07GLKgnmDhyUTa1V7sOLT80l/V+44nLk+BWIFIJ0BKTKZWa5iF5Sm+
 0zJM8Y34t2hyWTC2eaxl84zREj4M7owWNIVVeveebENWfa7Z/3+QShk1ZLYJz0fKGJ4JCWUnp
 qQz6rhxqca9gU1AfWMANxC5pt64uIKJF7n4m5QrtjpeISUGyFtw4P2Uw9Gq1Fy3fo7WPqw7sK
 D2nr4mskneFfBiu2L/YHKB9jI0jOGhKKCXf4rbcN9TV+ZGBjsahVQPHhdLhwOCpVUcaoyth/j
 0xGhKQhveypcse+s+PpKIYLzn6gVw5eIv74hF2D6oM7N5ZTE2jU0XdSJrjfLUNS9b8BLf0bbt
 BfCpfF2WgeRGVquqTeq65KOvdOvsrRRcw41Mga4HGfOy9omidD4E5m/GBVrSUN6N/Ri1M4af4
 WkCa8iiS2UKwMWApl2nUOtw6iZ9KjMx1XeVoa1K85LA+TYP9D0y/cWN52La/xrppI+CJXrS5I
 gEJYjr28kc+YQaK156CVrFuoIPjty5ousW5ecqfONQO2kFXMIfURUgyz/EUcpjunqZa26yHFx
 tCv7HCmU8OBS459qZA6gO18z2HXLO5hFjRaaCZHDT1xu882FUI1Qvhnvtsp+mh/sQ+gc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randconfig builds fail when one of the two is a built-in driver and
the other one is a loadable module:

drivers/media/platform/marvell-ccic/mcam-core.o: In function `mccic_register':
mcam-core.c:(.text+0x2594): undefined reference to `__this_module'
drivers/media/platform/marvell-ccic/mcam-core.o:(.rodata+0x50): undefined reference to `__this_module'

The problem is that mcam-core.c can not be built both ways at the smae
time. However, we can make kbuild take care of that by making the core
driver a separate module, which can be either built-in or loadable
as needed.
Making it a separate module requires exporting a few symbols and
adding the module license from the header.

Fixes: 0a9c643c8faa ("media: marvel-ccic: re-enable mmp-driver build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/marvell-ccic/Makefile    | 9 ++++-----
 drivers/media/platform/marvell-ccic/mcam-core.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/marvell-ccic/Makefile b/drivers/media/platform/marvell-ccic/Makefile
index 05a792c579a2..b3a4d0cdccb8 100644
--- a/drivers/media/platform/marvell-ccic/Makefile
+++ b/drivers/media/platform/marvell-ccic/Makefile
@@ -1,6 +1,5 @@
-obj-$(CONFIG_VIDEO_CAFE_CCIC) += cafe_ccic.o
-cafe_ccic-y := cafe-driver.o mcam-core.o
-
-obj-$(CONFIG_VIDEO_MMP_CAMERA) += mmp_camera.o
-mmp_camera-y := mmp-driver.o mcam-core.o
+obj-$(CONFIG_VIDEO_CAFE_CCIC) += cafe_ccic.o mcam-core.o
+cafe_ccic-y := cafe-driver.o
 
+obj-$(CONFIG_VIDEO_MMP_CAMERA) += mmp_camera.o mcam-core.o
+mmp_camera-y := mmp-driver.o
diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
index 80670eeee142..dfdbd4354b74 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -1720,6 +1720,7 @@ int mccic_irq(struct mcam_camera *cam, unsigned int irqs)
 	}
 	return handled;
 }
+EXPORT_SYMBOL_GPL(mccic_irq);
 
 /* ---------------------------------------------------------------------- */
 /*
@@ -1830,7 +1831,7 @@ int mccic_register(struct mcam_camera *cam)
 	v4l2_device_unregister(&cam->v4l2_dev);
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(mccic_register);
 
 void mccic_shutdown(struct mcam_camera *cam)
 {
@@ -1850,6 +1851,7 @@ void mccic_shutdown(struct mcam_camera *cam)
 	v4l2_ctrl_handler_free(&cam->ctrl_handler);
 	v4l2_device_unregister(&cam->v4l2_dev);
 }
+EXPORT_SYMBOL_GPL(mccic_shutdown);
 
 /*
  * Power management
@@ -1868,6 +1870,7 @@ void mccic_suspend(struct mcam_camera *cam)
 	}
 	mutex_unlock(&cam->s_mutex);
 }
+EXPORT_SYMBOL_GPL(mccic_suspend);
 
 int mccic_resume(struct mcam_camera *cam)
 {
@@ -1898,4 +1901,8 @@ int mccic_resume(struct mcam_camera *cam)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mccic_resume);
 #endif /* CONFIG_PM */
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
-- 
2.9.0

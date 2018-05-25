Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936242AbeEYOYJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:24:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60555 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936056AbeEYOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:24:07 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-usb@vger.kernel.org, shuah@kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4] usbip: dynamically allocate idev by nports found in sysfs
Date: Fri, 25 May 2018 16:23:46 +0200
Message-Id: <20180525142346.6591-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.17.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the amount of available ports varies by the kernels build
configuration. To remove the limitation of the fixed 128 ports
we allocate the amount of idevs by using the number we get
from the kernel.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v1 -> v2: - reworked memory allocation into one calloc call
          - added error path on allocation failure
v2 -> v3: - moved check for available nports to beginning of function
v3 -> v4: - changed get_nports to get hc_device via parameter
          - moved calloc after valid get_nports call

 tools/usb/usbip/libsrc/vhci_driver.c | 32 +++++++++++++++++-----------
 tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index c9c81614a66ad..4204359c9feef 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -135,11 +135,11 @@ static int refresh_imported_device_list(void)
 	return 0;
 }
 
-static int get_nports(void)
+static int get_nports(struct udev_device *hc_device)
 {
 	const char *attr_nports;
 
-	attr_nports = udev_device_get_sysattr_value(vhci_driver->hc_device, "nports");
+	attr_nports = udev_device_get_sysattr_value(hc_device, "nports");
 	if (!attr_nports) {
 		err("udev_device_get_sysattr_value nports failed");
 		return -1;
@@ -242,35 +242,41 @@ static int read_record(int rhport, char *host, unsigned long host_len,
 
 int usbip_vhci_driver_open(void)
 {
+	int nports;
+	struct udev_device *hc_device;
+
 	udev_context = udev_new();
 	if (!udev_context) {
 		err("udev_new failed");
 		return -1;
 	}
 
-	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver));
-
 	/* will be freed in usbip_driver_close() */
-	vhci_driver->hc_device =
+	hc_device =
 		udev_device_new_from_subsystem_sysname(udev_context,
 						       USBIP_VHCI_BUS_TYPE,
 						       USBIP_VHCI_DEVICE_NAME);
-	if (!vhci_driver->hc_device) {
+	if (!hc_device) {
 		err("udev_device_new_from_subsystem_sysname failed");
 		goto err;
 	}
 
-	vhci_driver->nports = get_nports();
-	dbg("available ports: %d", vhci_driver->nports);
-
-	if (vhci_driver->nports <= 0) {
+	nports = get_nports(hc_device);
+	if (nports <= 0) {
 		err("no available ports");
 		goto err;
-	} else if (vhci_driver->nports > MAXNPORT) {
-		err("port number exceeds %d", MAXNPORT);
+	}
+	dbg("available ports: %d", nports);
+
+	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver) +
+			nports * sizeof(struct usbip_imported_device));
+	if (!vhci_driver) {
+		err("vhci_driver allocation failed");
 		goto err;
 	}
 
+	vhci_driver->nports = nports;
+	vhci_driver->hc_device = hc_device;
 	vhci_driver->ncontrollers = get_ncontrollers();
 	dbg("available controllers: %d", vhci_driver->ncontrollers);
 
@@ -285,7 +291,7 @@ int usbip_vhci_driver_open(void)
 	return 0;
 
 err:
-	udev_device_unref(vhci_driver->hc_device);
+	udev_device_unref(hc_device);
 
 	if (vhci_driver)
 		free(vhci_driver);
diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
index 418b404d51210..6c9aca2167051 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.h
+++ b/tools/usb/usbip/libsrc/vhci_driver.h
@@ -13,7 +13,6 @@
 
 #define USBIP_VHCI_BUS_TYPE "platform"
 #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
-#define MAXNPORT 128
 
 enum hub_speed {
 	HUB_SPEED_HIGH = 0,
@@ -41,7 +40,7 @@ struct usbip_vhci_driver {
 
 	int ncontrollers;
 	int nports;
-	struct usbip_imported_device idev[MAXNPORT];
+	struct usbip_imported_device idev[];
 };
 
 
-- 
2.17.0

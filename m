Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935943AbeE3DDj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:03:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:55719 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933740AbeE3DDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:03:38 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, valentina.manea.m@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_detach: fix to check for invalid ports
Date: Tue, 29 May 2018 21:03:08 -0600
Message-Id: <20180530030308.5566-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usbip detach doesn't check for invalid ports and ports that are already
detached. It attempts to remove state file(s) without validating the port
and sends detach request to the driver for ports that are already detached.

Add check for invalid ports (port > maxports) and ports that are already
detached (status == VDEV_ST_NULL). Don't remove state files and don't send
detach request for invalid ports and ports that are already detached.

Add error and information messages that make sense.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/usb/usbip/src/usbip_detach.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index 6a8db858caa5..777f7286a0c5 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -46,6 +46,9 @@ static int detach_port(char *port)
 	int ret = 0;
 	uint8_t portnum;
 	char path[PATH_MAX+1];
+	int i;
+	struct usbip_imported_device *idev;
+	int found = 0;
 
 	unsigned int port_len = strlen(port);
 
@@ -55,28 +58,46 @@ static int detach_port(char *port)
 			return -1;
 		}
 
-	/* check max port */
-
 	portnum = atoi(port);
 
-	/* remove the port state file */
-
-	snprintf(path, PATH_MAX, VHCI_STATE_PATH"/port%d", portnum);
-
-	remove(path);
-	rmdir(VHCI_STATE_PATH);
-
 	ret = usbip_vhci_driver_open();
 	if (ret < 0) {
 		err("open vhci_driver");
 		return -1;
 	}
 
+	/* check for invalid port */
+	for (i = 0; i < vhci_driver->nports; i++) {
+		idev = &vhci_driver->idev[i];
+
+		if (idev->port == portnum) {
+			found = 1;
+			if (idev->status != VDEV_ST_NULL)
+				break;
+			info("Port %d is already detached!\n", idev->port);
+			goto call_driver_close;
+		}
+	}
+
+	if (!found) {
+		err("Invalid port %s > maxports %d",
+			port, vhci_driver->nports);
+		goto call_driver_close;
+	}
+
+	/* remove the port state file */
+	snprintf(path, PATH_MAX, VHCI_STATE_PATH"/port%d", portnum);
+
+	remove(path);
+	rmdir(VHCI_STATE_PATH);
+
 	ret = usbip_vhci_detach_device(portnum);
 	if (ret < 0) {
 		ret = -1;
+		err("Port %d detach request failed!\n", portnum);
 		goto call_driver_close;
 	}
+	info("Port %d is now detached!\n", portnum);
 
 call_driver_close:
 	usbip_vhci_driver_close();
-- 
2.14.1

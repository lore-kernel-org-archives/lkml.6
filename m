Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967667AbeE2WNi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:13:38 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:54295 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966170AbeE2WNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:13:32 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, valentina.manea.m@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] usbip: usbip_detach: Fix memory, udev context and udev leak
Date: Tue, 29 May 2018 16:13:03 -0600
Message-Id: <20180529221303.27042-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

detach_port() fails to call usbip_vhci_driver_close() from its error
path after usbip_vhci_detach_device() returns failure, leaking memory
allocated in usbip_vhci_driver_open() and holding udev_context and udev
references. Fix it to call usbip_vhci_driver_close().

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/usb/usbip/src/usbip_detach.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index 9db9d21bb2ec..6a8db858caa5 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -43,7 +43,7 @@ void usbip_detach_usage(void)
 
 static int detach_port(char *port)
 {
-	int ret;
+	int ret = 0;
 	uint8_t portnum;
 	char path[PATH_MAX+1];
 
@@ -73,9 +73,12 @@ static int detach_port(char *port)
 	}
 
 	ret = usbip_vhci_detach_device(portnum);
-	if (ret < 0)
-		return -1;
+	if (ret < 0) {
+		ret = -1;
+		goto call_driver_close;
+	}
 
+call_driver_close:
 	usbip_vhci_driver_close();
 
 	return ret;
-- 
2.14.1

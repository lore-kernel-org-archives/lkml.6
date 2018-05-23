Return-Path: <mgr@pengutronix.de>
X-Google-Smtp-Source: AB8JxZrCAsgpA5JCEOmrgiOIOAAP5992S9DhUEjqt66aEfoBYjPDcsHwO3/4iQ6LLiGp/YIAuYC0
ARC-Seal: i=1; a=rsa-sha256; t=1527067393; cv=none;
        d=google.com; s=arc-20160816;
        b=qZgOTasIuZpdLHQoV2c9ZNLnu1Azc9C3rXouI4TQ1dFg+rncyGoZnpnMFTkfh9Ddku
         chh46WRH67mC6w2EsoPlZMx/l+Z9T2ywhuaWMeykwUixdEu1l9VHMeDwxpHT0r02bB2e
         8HGHS59bumz1CkaKXVeiaOaE7bWw15sePDEPC/U2//ptKtLeQThQp5JtjciIgg0fLpEU
         JUXq4nVYmgmzrIDMMiWLRJ5UiQ+lBeM6P5q47OyKFKOz+/mFIg1t1aiOlSFKen8yzHlZ
         rXVBJRYeD+drUHYQcOV5Qu0RaZHhnHWXl+ivGC5oloOcJCyq1wAcxQB15U7hwFClVOgp
         OQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M8hShWgHUdJ00rnUBKzLhpbxuAMSQtcwt9waEzMBXMc=;
        b=YFPDjUnplLVCReeK4HTtB8p4GIydmR7ZyxqX+923H52bYan9H8SKSaCiZxpQwHuu4x
         Z/qZCwX+H1/zEefZLlcYfpKXXKq08X5ZADL9mTresCYWVzv6Sxy+z80oDq4Y7p1n60wv
         amG6NkOQEUct4aRN2yGVvYqSOf8c3RD/26QmOIlcYNEJSg9rgd0xdM+RHU/IP2XwuBmD
         AgdUJkxidh86MFDZY0j5tFr/2RkrkFHPStT7YAh87ZwK8KeTCK9ZlSgWvAy/cWdKC4VA
         ayKccYoh1AQFnS6ZDDqvM5AlyQ1tg4jXrOszr79G8UJi82+7AUW3TyzzmYlYp1dFsDZp
         F0Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mgr@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=mgr@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mgr@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=mgr@pengutronix.de
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: shuah@kernel.org,
	linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3] usbip: dynamically allocate idev by nports found in sysfs
Date: Wed, 23 May 2018 11:22:56 +0200
Message-Id: <20180523092256.25922-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
References: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600813163471096562?=
X-GMAIL-MSGID: =?utf-8?q?1601246219056409519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the amount of available ports varies by the kernels build
configuration. To remove the limitation of the fixed 128 ports
we allocate the amount of idevs by using the number we get
from the kernel.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v1 -> v2: - reworked memory allocation into one calloc call
          - added error path on allocation failure
v2 -> v3: - moved check for available nports to beginning of function

 tools/usb/usbip/libsrc/vhci_driver.c | 24 ++++++++++++++----------
 tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index c9c81614a66ad..c5db1be784bab 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -242,13 +242,25 @@ static int read_record(int rhport, char *host, unsigned long host_len,
 
 int usbip_vhci_driver_open(void)
 {
+	int nports = get_nports();
+
+	if (nports <= 0) {
+		err("no available ports");
+		return -1;
+	}
+
 	udev_context = udev_new();
 	if (!udev_context) {
 		err("udev_new failed");
 		return -1;
 	}
 
-	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver));
+	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver) +
+			nports * sizeof(struct usbip_imported_device));
+	if (!vhci_driver) {
+		err("vhci_driver allocation failed");
+		return -1;
+	}
 
 	/* will be freed in usbip_driver_close() */
 	vhci_driver->hc_device =
@@ -260,17 +272,9 @@ int usbip_vhci_driver_open(void)
 		goto err;
 	}
 
-	vhci_driver->nports = get_nports();
+	vhci_driver->nports = nports;
 	dbg("available ports: %d", vhci_driver->nports);
 
-	if (vhci_driver->nports <= 0) {
-		err("no available ports");
-		goto err;
-	} else if (vhci_driver->nports > MAXNPORT) {
-		err("port number exceeds %d", MAXNPORT);
-		goto err;
-	}
-
 	vhci_driver->ncontrollers = get_ncontrollers();
 	dbg("available controllers: %d", vhci_driver->ncontrollers);
 
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

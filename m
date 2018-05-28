Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeE1GdT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:33:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44694 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeE1GdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:33:09 -0400
X-Google-Smtp-Source: AB8JxZqpOjdx4jXjAhUH/mXd7L+NQGBOSbU670b62grRfxQxQUcBfUsXSiOUKbHIQIoczI3V4QG0mg==
From: Nicolas Boichat <drinkcat@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: [PATCH] usb: hub: Per-port setting to reduce TRSTRCY to 10 ms
Date: Mon, 28 May 2018 14:32:19 +0800
Message-Id: <20180528063219.234757-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180528063219.234757-1-drinkcat@chromium.org>
References: <20180528063219.234757-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the USB hub core waits for 50 ms after enumerating the
device. This was added to help "some high speed devices" to
enumerate (b789696af8 "[PATCH] USB: relax usbcore reset timings").

On some devices, the time-to-active is important, so we provide
a per-port option to reduce the time to what the USB specification
requires: 10 ms.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Reduces enumeration time by ~40ms in conjunction with previous
patch/quirk (or ~80ms on its own).

 Documentation/ABI/testing/sysfs-bus-usb | 4 ++++
 drivers/usb/core/hub.c                  | 6 +++++-
 include/linux/usb.h                     | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index a31a66d62cbba..08d456e07b538 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -206,6 +206,10 @@ Description:
 		   using /sys/module/usbcore/parameters/old_scheme_first, but
 		   it is often not desirable as the new scheme was introduced to
 		   increase compatibility with more devices.
+		 - Bit 1 reduces TRSTRCY to the 10 ms that are required by the
+		   USB 2.0 specification, instead of the 50 ms that are normally
+		   used to help make enumeration work better on some high speed
+		   devices.
 
 What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
 Date:		February 2018
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f900f66a62856..26c2438d28893 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2879,7 +2879,11 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 done:
 	if (status == 0) {
 		/* TRSTRCY = 10 ms; plus some extra */
-		msleep(10 + 40);
+		if (port_dev->quirks & USB_PORT_QUIRK_FAST_ENUM)
+			usleep_range(10000, 12000);
+		else
+			msleep(10 + 40);
+
 		if (udev) {
 			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 2ade17992ed66..4cdd515a4385f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -496,6 +496,9 @@ enum usb_port_connect_type {
 /* For the given port, prefer the old (faster) enumeration scheme. */
 #define USB_PORT_QUIRK_OLD_SCHEME	BIT(0)
 
+/* Decrease TRSTRCY to 10ms during device enumeration. */
+#define USB_PORT_QUIRK_FAST_ENUM	BIT(1)
+
 /*
  * USB 2.0 Link Power Management (LPM) parameters.
  */
-- 
2.17.0.921.gf22659ad46-goog

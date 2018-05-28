Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeE1GdH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:33:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35296 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeE1GdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:33:04 -0400
X-Google-Smtp-Source: AB8JxZrjd+1SyLZQq13EBSo5KDU8Tc2n+KwVWr4Z/AWSaeN9PZn8thk54xzD8diWRaLHcyvPxYWYAg==
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
Subject: [PATCHv2 1/2] usb: hub: Per-port setting to use old enumeration scheme
Date: Mon, 28 May 2018 14:32:18 +0800
Message-Id: <20180528063219.234757-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "old" enumeration scheme is considerably faster (it takes
~244ms instead of ~356ms to get the descriptor).

It is currently only possible to use the old scheme globally
(/sys/module/usbcore/parameters/old_scheme_first), which is not
desirable as the new scheme was introduced to increase compatibility
with more devices.

However, in our case, we care about time-to-active for a specific
USB device (which we make the firmware for), on a specific port
(that is pogo-pin based: not a standard USB port). This new
sysfs option makes it possible to use the old scheme on a single
port only.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v1:
 - Added documentation in Documentation/ABI
 - Updated timing in commit message to account for recent improvement
   in USB core (74072bae88fb3b)

 Documentation/ABI/testing/sysfs-bus-usb | 18 ++++++++++++++++++
 drivers/usb/core/hub.c                  | 13 +++++++++----
 drivers/usb/core/hub.h                  |  1 +
 drivers/usb/core/port.c                 | 23 +++++++++++++++++++++++
 include/linux/usb.h                     |  7 +++++++
 5 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index c6e9b30f05b13..a31a66d62cbba 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -189,6 +189,24 @@ Description:
 		The file will read "hotplug", "wired" and "not used" if the
 		information is available, and "unknown" otherwise.
 
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/quirks
+Date:		May 2018
+Contact:	Nicolas Boichat <drinkcat@chromium.org>
+Description:
+		In some cases, we care about time-to-active for devices
+		connected on a specific port (e.g. non-standard USB port like
+		pogo pins), where the device to be connected is known in
+		advance, and behaves well according to the specification.
+		This attribute is a bit-field that controls the behavior of
+		a specific port:
+		 - Bit 0 of this field selects the "old" enumeration scheme,
+		   as it is considerably faster (it only causes one USB reset
+		   instead of 2).
+		   The old enumeration scheme can also be selected globally
+		   using /sys/module/usbcore/parameters/old_scheme_first, but
+		   it is often not desirable as the new scheme was introduced to
+		   increase compatibility with more devices.
+
 What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
 Date:		February 2018
 Contact:	Richard Leitner <richard.leitner@skidata.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c2d993d3816f0..f900f66a62856 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2636,7 +2636,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_ADDRESS_TRIES	2
 #define GET_DESCRIPTOR_TRIES	2
 #define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i)	((i) / 2 == (int)old_scheme_first)
+#define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)scheme)
 
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
@@ -2651,12 +2651,16 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
  * enumeration failures, so disable this enumeration scheme for USB3
  * devices.
  */
-static bool use_new_scheme(struct usb_device *udev, int retry)
+static bool use_new_scheme(struct usb_device *udev, int retry,
+			   struct usb_port *port_dev)
 {
+	int old_scheme_first_port =
+		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
+
 	if (udev->speed >= USB_SPEED_SUPER)
 		return false;
 
-	return USE_NEW_SCHEME(retry);
+	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
 }
 
 /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
@@ -4392,6 +4396,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 {
 	struct usb_device	*hdev = hub->hdev;
 	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
+	struct usb_port		*port_dev = hub->ports[port1 - 1];
 	int			retries, operations, retval, i;
 	unsigned		delay = HUB_SHORT_RESET_TIME;
 	enum usb_device_speed	oldspeed = udev->speed;
@@ -4513,7 +4518,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
 		bool did_new_scheme = false;
 
-		if (use_new_scheme(udev, retry_counter)) {
+		if (use_new_scheme(udev, retry_counter, port_dev)) {
 			struct usb_device_descriptor *buf;
 			int r = 0;
 
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 4dc769ee9c740..4accfb63f7dcb 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -98,6 +98,7 @@ struct usb_port {
 	struct mutex status_lock;
 	u32 over_current_count;
 	u8 portnum;
+	u32 quirks;
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 6979bde87d310..4a21431953953 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -50,6 +50,28 @@ static ssize_t over_current_count_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(over_current_count);
 
+static ssize_t quirks_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sprintf(buf, "%08x\n", port_dev->quirks);
+}
+
+static ssize_t quirks_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	u32 value;
+
+	if (kstrtou32(buf, 16, &value))
+		return -EINVAL;
+
+	port_dev->quirks = value;
+	return count;
+}
+static DEVICE_ATTR_RW(quirks);
+
 static ssize_t usb3_lpm_permit_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -118,6 +140,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
 	NULL,
 };
diff --git a/include/linux/usb.h b/include/linux/usb.h
index beffceec49158..2ade17992ed66 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -489,6 +489,13 @@ enum usb_port_connect_type {
 	USB_PORT_NOT_USED,
 };
 
+/*
+ * USB port quirks.
+ */
+
+/* For the given port, prefer the old (faster) enumeration scheme. */
+#define USB_PORT_QUIRK_OLD_SCHEME	BIT(0)
+
 /*
  * USB 2.0 Link Power Management (LPM) parameters.
  */
-- 
2.17.0.921.gf22659ad46-goog

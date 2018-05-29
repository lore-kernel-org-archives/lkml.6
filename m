Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965199AbeE2Qho (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:37:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33827 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935486AbeE2Qhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:37:39 -0400
X-Google-Smtp-Source: AB8JxZrhxd3t1NcJq76d1p4Z144i1R6JFZU9oqkGxPXdIbD1W0e+X2Rt4UMZfMIX0L9qZCdgq8xV6w==
From: Martin Liu <liumartin@google.com>
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        johan@kernel.org, stern@rowland.harvard.edu, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jenhaochen@google.com, Martin Liu <liumartin@google.com>
Subject: [RFC PATCH v3] driver core: hold dev's parent lock when needed
Date: Wed, 30 May 2018 00:34:29 +0800
Message-Id: <20180529163428.234106-1-liumartin@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <Pine.LNX.4.44L0.1805291003470.1458-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1805291003470.1458-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOC have internal I/O buses that can't be proved for devices. The
devices on the buses can be accessed directly without additinal
configuration required. This type of bus is represented as
"simple-bus". In some platforms, we name "soc" with "simple-bus"
attribute and many devices are hooked under it desribed in DT
(device tree).

In commit 'bf74ad5bc417 introduce ("[PATCH] Hold the device's
parent's lock during probe and remove")' to solve USB subsystem
lock sequence since usb device's characteristic. Thus "soc"
needs to be locked whenever a device and driver's probing
happen under "soc" bus. During this period, an async driver
tries to probe a device which is under the "soc" bus would be
blocked until previous driver finish the probing and release "soc"
lock. And the next probing under the "soc" bus need to wait for
async finish. Because of that, driver's async probe for init
time improvement will be shadowed.

Since many devices don't have USB devices' characteristic, they
actually don't need parent's lock. Thus, we introduce a lock flag
in bus_type struct and driver core would lock the parent lock base
on the flag. For usbsystem, we set this flag in usb relatvie
bus_type struct to keep original lock behavior in driver core.

Async probe could have more benefit after this patch.

Signed-off-by: Martin Liu <liumartin@google.com>
---
Changes in v3:
 -move lock flag to bus_type struct and set the flag in usb
 relative bus_type struct to keep original lock behavior.
 -fix sign name.

[v2]: https://lkml.org/lkml/2018/5/29/108
[v1]: https://lkml.org/lkml/2018/5/22/545

Currently, I have the flag set in USB relatvie bus_type struct.
Since I'm not familar with USB part, need some feedback to know
if they cover all the cases that original case driver core
protects. Thanks.

 drivers/base/bus.c        | 16 ++++++++--------
 drivers/base/dd.c         |  8 ++++----
 drivers/usb/common/ulpi.c |  1 +
 drivers/usb/core/driver.c |  1 +
 drivers/usb/serial/bus.c  |  1 +
 include/linux/device.h    |  3 +++
 6 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..1e606fbc95a7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -184,10 +184,10 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_unlock(dev->parent);
 		err = count;
 	}
@@ -211,12 +211,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_lock(dev->parent);
 		device_lock(dev);
 		err = driver_probe_device(drv, dev);
 		device_unlock(dev);
-		if (dev->parent)
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_unlock(dev->parent);
 
 		if (err > 0) {
@@ -735,10 +735,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
 	int ret = 0;
 
 	if (!dev->driver) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_lock(dev->parent);
 		ret = device_attach(dev);
-		if (dev->parent)
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_unlock(dev->parent);
 	}
 	return ret < 0 ? ret : 0;
@@ -770,10 +770,10 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
 int device_reprobe(struct device *dev)
 {
 	if (dev->driver) {
-		if (dev->parent)        /* Needed for USB */
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && dev->bus->need_parent_lock)
 			device_unlock(dev->parent);
 	}
 	return bus_rescan_devices_helper(dev, NULL);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c9f54089429b..7c09f73b96f3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -817,13 +817,13 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
-	if (dev->parent)	/* Needed for USB */
+	if (dev->parent && dev->bus->need_parent_lock)
 		device_lock(dev->parent);
 	device_lock(dev);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
 	device_unlock(dev);
-	if (dev->parent)
+	if (dev->parent && dev->bus->need_parent_lock)
 		device_unlock(dev->parent);
 
 	return 0;
@@ -919,7 +919,7 @@ void device_release_driver_internal(struct device *dev,
 				    struct device_driver *drv,
 				    struct device *parent)
 {
-	if (parent)
+	if (parent && dev->bus->need_parent_lock)
 		device_lock(parent);
 
 	device_lock(dev);
@@ -927,7 +927,7 @@ void device_release_driver_internal(struct device *dev,
 		__device_release_driver(dev, parent);
 
 	device_unlock(dev);
-	if (parent)
+	if (parent && dev->bus->need_parent_lock)
 		device_unlock(parent);
 }
 
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 9a2ab6751a23..073954a1a1c5 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -94,6 +94,7 @@ static struct bus_type ulpi_bus = {
 	.uevent = ulpi_uevent,
 	.probe = ulpi_probe,
 	.remove = ulpi_remove,
+	.need_parent_lock = 1,
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 9792cedfc351..209ee5d8a92d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1922,4 +1922,5 @@ struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
+	.need_parent_lock =	1,
 };
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e265eb92611..55b2636b2804 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -166,6 +166,7 @@ struct bus_type usb_serial_bus_type = {
 	.probe =	usb_serial_device_probe,
 	.remove =	usb_serial_device_remove,
 	.drv_groups = 	usb_serial_drv_groups,
+	.need_parent_lock =	1,
 };
 
 int usb_serial_bus_register(struct usb_serial_driver *driver)
diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..019b193aeb24 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -98,6 +98,8 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @lock_key:	Lock class key for use by the lock validator
  * @force_dma:	Assume devices on this bus should be set up by dma_configure()
  * 		even if DMA capability is not explicitly described by firmware.
+ * @need_parent_lock:	Assume devices on this bus should hold its' parent's
+ *			lock during probe and remove. Currently, USB needs it.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -138,6 +140,7 @@ struct bus_type {
 	struct lock_class_key lock_key;
 
 	bool force_dma;
+	bool need_parent_lock;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
-- 
2.17.0.921.gf22659ad46-goog

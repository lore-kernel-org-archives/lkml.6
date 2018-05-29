Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754952AbeE2Hgv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:36:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44697 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbeE2Hgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:36:46 -0400
X-Google-Smtp-Source: AB8JxZocbVq2d64OT+N6khDJiJr2gI9Z3WYdOetsD2U5LSokRHTHUpfoINAqVFgf2maiOqcEPld4qA==
From: martin_liu <liumartin@google.com>
To: stern@rowland.harvard.edu
Cc: heikki.krogerus@linux.intel.com, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jenhaochen@google.com,
        martin_liu <liumartin@google.com>
Subject: [RFC PATCH v2] driver core: hold dev's parent lock when needed
Date: Tue, 29 May 2018 15:07:20 +0800
Message-Id: <20180529070719.164626-1-liumartin@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org>
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
in device struct and driver core would lock the parent lock base
on the flag. For usbsystem, we set this flag when its device and
driver is matched and to keep original lock behavior in driver
core.

Async probe could have more benefit after this patch.

Signed-off-by: martin_liu <liumartin@google.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
---
Changes in v2:
 - take Alan's suggestion to introudce a flag to guide driver
   core to hold device parent's lock.

[v1]: https://lkml.org/lkml/2018/5/22/545

Currently, I have the flag set in USB subsystem match function.
Since I'm not familar with USB part, need some feedback to know
if they cover all the cases that original case driver core
protects.

 drivers/base/bus.c          | 16 ++++++++--------
 drivers/base/dd.c           |  8 ++++----
 drivers/usb/common/ulpi.c   | 16 ++++++++++++----
 drivers/usb/core/driver.c   |  9 +++++++--
 drivers/usb/core/usb-acpi.c |  6 +++++-
 drivers/usb/serial/bus.c    |  4 +++-
 include/linux/device.h      |  1 +
 7 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..18ea94caec02 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -184,10 +184,10 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->need_parent_lock)/* Needed for USB */
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && dev->need_parent_lock)
 			device_unlock(dev->parent);
 		err = count;
 	}
@@ -211,12 +211,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->need_parent_lock)/* Needed for USB */
 			device_lock(dev->parent);
 		device_lock(dev);
 		err = driver_probe_device(drv, dev);
 		device_unlock(dev);
-		if (dev->parent)
+		if (dev->parent && dev->need_parent_lock)
 			device_unlock(dev->parent);
 
 		if (err > 0) {
@@ -735,10 +735,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
 	int ret = 0;
 
 	if (!dev->driver) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && dev->need_parent_lock)/* Needed for USB */
 			device_lock(dev->parent);
 		ret = device_attach(dev);
-		if (dev->parent)
+		if (dev->parent && dev->need_parent_lock)
 			device_unlock(dev->parent);
 	}
 	return ret < 0 ? ret : 0;
@@ -770,10 +770,10 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
 int device_reprobe(struct device *dev)
 {
 	if (dev->driver) {
-		if (dev->parent)        /* Needed for USB */
+		if (dev->parent && dev->need_parent_lock)/* Needed for USB */
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && dev->need_parent_lock)
 			device_unlock(dev->parent);
 	}
 	return bus_rescan_devices_helper(dev, NULL);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c9f54089429b..c9a118568775 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -817,13 +817,13 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
-	if (dev->parent)	/* Needed for USB */
+	if (dev->parent && dev->need_parent_lock)/* Needed for USB */
 		device_lock(dev->parent);
 	device_lock(dev);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
 	device_unlock(dev);
-	if (dev->parent)
+	if (dev->parent && dev->need_parent_lock)
 		device_unlock(dev->parent);
 
 	return 0;
@@ -919,7 +919,7 @@ void device_release_driver_internal(struct device *dev,
 				    struct device_driver *drv,
 				    struct device *parent)
 {
-	if (parent)
+	if (parent && dev->need_parent_lock)
 		device_lock(parent);
 
 	device_lock(dev);
@@ -927,7 +927,7 @@ void device_release_driver_internal(struct device *dev,
 		__device_release_driver(dev, parent);
 
 	device_unlock(dev);
-	if (parent)
+	if (parent && dev->need_parent_lock)
 		device_unlock(parent);
 }
 
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 9a2ab6751a23..609566396bf8 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -40,13 +40,21 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 	const struct ulpi_device_id *id;
 
 	/* Some ULPI devices don't have a vendor id so rely on OF match */
-	if (ulpi->id.vendor == 0)
-		return of_driver_match_device(dev, driver);
+	if (ulpi->id.vendor == 0) {
+		if (of_driver_match_device(dev, driver)) {
+			dev->need_parent_lock = 1;
+			return 1;
+		}
+		return o;
+	}
 
-	for (id = drv->id_table; id->vendor; id++)
+	for (id = drv->id_table; id->vendor; id++) {
 		if (id->vendor == ulpi->id.vendor &&
-		    id->product == ulpi->id.product)
+		    id->product == ulpi->id.product) {
+			dev->need_parent_lock = 1;
 			return 1;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 9792cedfc351..3dbabf8d3cb8 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -808,6 +808,7 @@ static int usb_device_match(struct device *dev, struct device_driver *drv)
 			return 0;
 
 		/* TODO: Add real matching code */
+		dev->need_parent_lock = 1;
 		return 1;
 
 	} else if (is_usb_interface(dev)) {
@@ -823,12 +824,16 @@ static int usb_device_match(struct device *dev, struct device_driver *drv)
 		usb_drv = to_usb_driver(drv);
 
 		id = usb_match_id(intf, usb_drv->id_table);
-		if (id)
+		if (id) {
+			dev->need_parent_lock = 1;
 			return 1;
+		}
 
 		id = usb_match_dynamic_id(intf, usb_drv);
-		if (id)
+		if (id) {
+			dev->need_parent_lock = 1;
 			return 1;
+		}
 	}
 
 	return 0;
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index e221861b3187..03901fc86227 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -224,7 +224,11 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 
 static bool usb_acpi_bus_match(struct device *dev)
 {
-	return is_usb_device(dev) || is_usb_port(dev);
+	if (is_usb_device(dev) || is_usb_port(dev)) {
+		dev->need_parent_lock = 1;
+		return 1;
+	}
+	return 0;
 }
 
 static struct acpi_bus_type usb_acpi_bus = {
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e265eb92611..599ba0046f8e 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -29,8 +29,10 @@ static int usb_serial_device_match(struct device *dev,
 
 	driver = to_usb_serial_driver(drv);
 
-	if (driver == port->serial->type)
+	if (driver == port->serial->type) {
+		dev->need_parent_lock = 1;
 		return 1;
+	}
 
 	return 0;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..a96194f39dbe 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -992,6 +992,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			need_parent_lock:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
-- 
2.17.0.921.gf22659ad46-goog

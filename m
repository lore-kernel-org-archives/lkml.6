Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEVOMi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:12:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42045 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:12:33 -0400
X-Google-Smtp-Source: AB8JxZoYMx57Gs+df6EnnJj7LYN2vmp7AvVU67Ps/9KF+zNGMCYepWN37q9EPBHHGzuNtkReeqxiUA==
Date: Tue, 22 May 2018 22:12:27 +0800
From: martin_liu <liumartin@google.com>
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] driver core: don't hold dev's parent lock when using async
 probe
Message-ID: <20180522141227.GA118442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOC have internal I/O buses that can't be probed for devices. The
devices on the buses can be accessed directly without additinal
configuration required. This type of bus is represented as
"simple-bus". In some platforms, we name "soc" with "simple-bus"
attribute and many devices are hooked under and desribe them in DT
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
actually don't need parent's lock. However, in order to control
the risk and minimize the impact, we don't request parent's lock
only when a driver requests async probe.

Async probe could have more benefit after we have this patch.

Signed-off-by: martin_liu <liumartin@google.com>
---
This RFC is asked to get some feedback since it involed driver
core and USB subsystem. I'm not familiar with USB subsystem and
not sure if we still need 'bf74ad5bc417 ("[PATCH] Hold the
device's parent's lock during probe and remove")' since it has
been there over 10 years. If we still need it and hard to fix it
, the simple way is to find a place not to allow USB subsystem
drivers to have async probe capability. Any suggestion is welcome.

 drivers/base/bus.c | 19 +++++++++++++------
 drivers/base/dd.c  | 23 ++++++++++++++++-------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..6434333995d4 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -181,13 +181,15 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 	struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
+	bool allow_async;
 
+	allow_async = driver_allows_async_probing(drv);
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && !allow_async)/* Needed for USB */
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && !allow_async)
 			device_unlock(dev->parent);
 		err = count;
 	}
@@ -208,15 +210,17 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
+	bool allow_async;
 
+	allow_async = driver_allows_async_probing(drv);
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
-		if (dev->parent)	/* Needed for USB */
+		if (dev->parent && !allow_async)/* Needed for USB */
 			device_lock(dev->parent);
 		device_lock(dev);
 		err = driver_probe_device(drv, dev);
 		device_unlock(dev);
-		if (dev->parent)
+		if (dev->parent && !allow_async)
 			device_unlock(dev->parent);
 
 		if (err > 0) {
@@ -769,11 +773,14 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
  */
 int device_reprobe(struct device *dev)
 {
+	bool allow_async;
+
 	if (dev->driver) {
-		if (dev->parent)        /* Needed for USB */
+		allow_async = driver_allows_async_probing(dev->driver);
+		if (dev->parent && !allow_async)/* Needed for USB */
 			device_lock(dev->parent);
 		device_release_driver(dev);
-		if (dev->parent)
+		if (dev->parent && !allow_async)
 			device_unlock(dev->parent);
 	}
 	return bus_rescan_devices_helper(dev, NULL);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c9f54089429b..36aed1576c58 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -794,6 +794,7 @@ static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
 	int ret;
+	bool allow_async;
 
 	/*
 	 * Lock device and try to bind to it. We drop the error
@@ -817,13 +818,14 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
-	if (dev->parent)	/* Needed for USB */
+	allow_async = driver_allows_async_probing(drv);
+	if (dev->parent && !allow_async)/* Needed for USB */
 		device_lock(dev->parent);
 	device_lock(dev);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
 	device_unlock(dev);
-	if (dev->parent)
+	if (dev->parent && !allow_async)
 		device_unlock(dev->parent);
 
 	return 0;
@@ -851,19 +853,21 @@ EXPORT_SYMBOL_GPL(driver_attach);
 static void __device_release_driver(struct device *dev, struct device *parent)
 {
 	struct device_driver *drv;
+	bool allow_async;
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
+		allow_async = driver_allows_async_probing(drv);
+		if (allow_async)
 			async_synchronize_full();
 
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
-			if (parent)
+			if (parent && !allow_async)
 				device_unlock(parent);
 
 			device_links_unbind_consumers(dev);
-			if (parent)
+			if (parent && !allow_async)
 				device_lock(parent);
 
 			device_lock(dev);
@@ -919,7 +923,12 @@ void device_release_driver_internal(struct device *dev,
 				    struct device_driver *drv,
 				    struct device *parent)
 {
-	if (parent)
+	bool allow_async = false;
+
+	if (drv)
+		allow_async = driver_allows_async_probing(drv);
+
+	if (parent && !allow_async)
 		device_lock(parent);
 
 	device_lock(dev);
@@ -927,7 +936,7 @@ void device_release_driver_internal(struct device *dev,
 		__device_release_driver(dev, parent);
 
 	device_unlock(dev);
-	if (parent)
+	if (parent && !allow_async)
 		device_unlock(parent);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

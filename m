Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61812C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D7920644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D7920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeJOWzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:55:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:23571 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeJOWzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:55:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 08:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="100389728"
Received: from jhli-desk1.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2018 08:09:20 -0700
Subject: [driver-core PATCH v4 3/6] device core: Consolidate locking and
 unlocking of parent and device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com
Date:   Mon, 15 Oct 2018 08:09:20 -0700
Message-ID: <20181015150920.29520.32815.stgit@localhost.localdomain>
In-Reply-To: <20181015150305.29520.86363.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is meant to try and consolidate all of the locking and unlocking
of both the parent and device when attaching or removing a driver from a
given device.

To do that I first consolidated the lock pattern into two functions
__device_driver_lock and __device_driver_unlock. After doing that I then
created functions specific to attaching and detaching the driver while
acquiring this locks. By doing this I was able to reduce the number of
spots where we touch need_parent_lock from 12 down to 4.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/base.h |    2 +
 drivers/base/bus.c  |   23 ++------------
 drivers/base/dd.c   |   83 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..3f22ebd6117a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -124,6 +124,8 @@ extern int driver_add_groups(struct device_driver *drv,
 			     const struct attribute_group **groups);
 extern void driver_remove_groups(struct device_driver *drv,
 				 const struct attribute_group **groups);
+int device_driver_attach(struct device_driver *drv, struct device *dev);
+void device_driver_detach(struct device *dev);
 
 extern char *make_class_name(const char *name, struct kobject *kobj);
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27ec73d6..8a630f9bd880 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -184,11 +184,7 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_lock(dev->parent);
-		device_release_driver(dev);
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_unlock(dev->parent);
+		device_driver_detach(dev);
 		err = count;
 	}
 	put_device(dev);
@@ -211,13 +207,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
-		if (dev->parent && bus->need_parent_lock)
-			device_lock(dev->parent);
-		device_lock(dev);
-		err = driver_probe_device(drv, dev);
-		device_unlock(dev);
-		if (dev->parent && bus->need_parent_lock)
-			device_unlock(dev->parent);
+		err = device_driver_attach(drv, dev);
 
 		if (err > 0) {
 			/* success */
@@ -769,13 +759,8 @@ int bus_rescan_devices(struct bus_type *bus)
  */
 int device_reprobe(struct device *dev)
 {
-	if (dev->driver) {
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_lock(dev->parent);
-		device_release_driver(dev);
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_unlock(dev->parent);
-	}
+	if (dev->driver)
+		device_driver_detach(dev);
 	return bus_rescan_devices_helper(dev, NULL);
 }
 EXPORT_SYMBOL_GPL(device_reprobe);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..e845cd2a87af 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -864,6 +864,60 @@ void device_initial_probe(struct device *dev)
 	__device_attach(dev, true);
 }
 
+/*
+ * __device_driver_lock - acquire locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device needed if the bus requires parent lock
+ *
+ * This function will take the required locks for manipulating dev->drv.
+ * Normally this will just be the @dev lock, but when called for a USB
+ * interface, @parent lock will be held as well.
+ */
+static void __device_driver_lock(struct device *dev, struct device *parent)
+{
+	if (parent && dev->bus->need_parent_lock)
+		device_lock(parent);
+	device_lock(dev);
+}
+
+/*
+ * __device_driver_lock - release locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device needed if the bus requires parent lock
+ *
+ * This function will release the required locks for manipulating dev->drv.
+ * Normally this will just be the the @dev lock, but when called for a
+ * USB interface, @parent lock will be released as well.
+ */
+static void __device_driver_unlock(struct device *dev, struct device *parent)
+{
+	device_unlock(dev);
+	if (parent && dev->bus->need_parent_lock)
+		device_unlock(parent);
+}
+
+/**
+ * device_driver_attach - attach a specific driver to a specific device
+ * @drv: Driver to attach
+ * @dev: Device to attach it to
+ *
+ * Manually attach driver to a device. Will acquire both @dev lock and
+ * @dev->parent lock if needed.
+ */
+int device_driver_attach(struct device_driver *drv, struct device *dev)
+{
+	int ret = 0;
+
+	__device_driver_lock(dev, dev->parent);
+
+	if (!dev->driver)
+		ret = driver_probe_device(drv, dev);
+
+	__device_driver_unlock(dev, dev->parent);
+
+	return ret;
+}
+
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
@@ -891,14 +945,7 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
-	if (dev->parent && dev->bus->need_parent_lock)
-		device_lock(dev->parent);
-	device_lock(dev);
-	if (!dev->driver)
-		driver_probe_device(drv, dev);
-	device_unlock(dev);
-	if (dev->parent && dev->bus->need_parent_lock)
-		device_unlock(dev->parent);
+	device_driver_attach(drv, dev);
 
 	return 0;
 }
@@ -993,16 +1040,12 @@ void device_release_driver_internal(struct device *dev,
 				    struct device_driver *drv,
 				    struct device *parent)
 {
-	if (parent && dev->bus->need_parent_lock)
-		device_lock(parent);
+	__device_driver_lock(dev, parent);
 
-	device_lock(dev);
 	if (!drv || drv == dev->driver)
 		__device_release_driver(dev, parent);
 
-	device_unlock(dev);
-	if (parent && dev->bus->need_parent_lock)
-		device_unlock(parent);
+	__device_driver_unlock(dev, parent);
 }
 
 /**
@@ -1028,6 +1071,18 @@ void device_release_driver(struct device *dev)
 EXPORT_SYMBOL_GPL(device_release_driver);
 
 /**
+ * device_driver_detach - detach driver from a specific device
+ * @dev: device to detach driver from
+ *
+ * Manually detach driver from device. Will acquire both @dev lock and
+ * @dev->parent lock if needed.
+ */
+void device_driver_detach(struct device *dev)
+{
+	device_release_driver_internal(dev, NULL, dev->parent);
+}
+
+/**
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.
  */


Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62EDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722A2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7722A2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbeKFGdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:33:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:38228 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbeKFGdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:33:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 13:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="106131489"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2018 13:11:54 -0800
Subject: [driver-core PATCH v5 3/9] device core: Consolidate locking and
 unlocking of parent and device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Mon, 05 Nov 2018 13:11:54 -0800
Message-ID: <154145231466.29224.18133339266088170952.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
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
acquiring these locks. By doing this I was able to reduce the number of
spots where we touch need_parent_lock from 12 down to 4.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/base.h |    2 +
 drivers/base/bus.c  |   23 ++-----------
 drivers/base/dd.c   |   91 ++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 77 insertions(+), 39 deletions(-)

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
@@ -769,13 +759,8 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
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
index 169412ee4ae8..76c40fe69463 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -864,6 +864,60 @@ void device_initial_probe(struct device *dev)
 	__device_attach(dev, true);
 }
 
+/*
+ * __device_driver_lock - acquire locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device. Needed if the bus requires parent lock
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
+ * @parent: Parent device. Needed if the bus requires parent lock
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
@@ -932,15 +979,11 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			async_synchronize_full();
 
 		while (device_links_busy(dev)) {
-			device_unlock(dev);
-			if (parent)
-				device_unlock(parent);
+			__device_driver_unlock(dev, parent);
 
 			device_links_unbind_consumers(dev);
-			if (parent)
-				device_lock(parent);
 
-			device_lock(dev);
+			__device_driver_lock(dev, parent);
 			/*
 			 * A concurrent invocation of the same function might
 			 * have released the driver successfully while this one
@@ -993,16 +1036,12 @@ void device_release_driver_internal(struct device *dev,
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
@@ -1027,6 +1066,18 @@ void device_release_driver(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_release_driver);
 
+/**
+ * device_driver_detach - detach driver from a specific device
+ * @dev: device to detach driver from
+ *
+ * Detach driver from device. Will acquire both @dev lock and @dev->parent
+ * lock if needed.
+ */
+void device_driver_detach(struct device *dev)
+{
+	device_release_driver_internal(dev, NULL, dev->parent);
+}
+
 /**
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.


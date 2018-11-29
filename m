Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6B206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeK2Lf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:35:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:20870 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeK2Lf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:35:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 16:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="96427173"
Received: from ahduyck-desk1.jf.intel.com (HELO ahduyck-desk1.amr.corp.intel.com) ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2018 16:32:27 -0800
Subject: [driver-core PATCH v7 4/9] driver core: Probe devices
 asynchronously instead of the driver
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 28 Nov 2018 16:32:26 -0800
Message-ID: <154345154692.18040.8161459765233879389.stgit@ahduyck-desk1.amr.corp.intel.com>
In-Reply-To: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe devices asynchronously instead of the driver. This results in us
seeing the same behavior if the device is registered before the driver or
after. This way we can avoid serializing the initialization should the
driver not be loaded until after the devices have already been added.

The motivation behind this is that if we have a set of devices that
take a significant amount of time to load we can greatly reduce the time to
load by processing them in parallel instead of one at a time. In addition,
each device can exist on a different node so placing a single thread on one
CPU to initialize all of the devices for a given driver can result in poor
performance on a system with multiple nodes.

This approach can reduce the time needed to scan SCSI LUNs significantly.
The only way to realize that speedup is by enabling more concurrency which
is what is achieved with this patch.

To achieve this it was necessary to add a new member "async_driver" to the
device_private structure to store the driver pointer while we wait on the
deferred probe call.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/base.h |    2 +
 drivers/base/bus.c  |   23 ++---------------
 drivers/base/dd.c   |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 3f22ebd6117a..c95384a8e53c 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -64,6 +64,7 @@ struct driver_private {
  *	binding of drivers which were unable to get all the resources needed by
  *	the device; typically because it depends on another driver getting
  *	probed first.
+ * @async_driver - pointer to device driver awaiting probe via async_probe
  * @device - pointer back to the struct device that this structure is
  * associated with.
  *
@@ -75,6 +76,7 @@ struct device_private {
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
+	struct device_driver *async_driver;
 	struct device *device;
 };
 #define to_device_private_parent(obj)	\
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8a630f9bd880..0cd2eadd0816 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -606,17 +606,6 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
-static void driver_attach_async(void *_drv, async_cookie_t cookie)
-{
-	struct device_driver *drv = _drv;
-	int ret;
-
-	ret = driver_attach(drv);
-
-	pr_debug("bus: '%s': driver %s async attach completed: %d\n",
-		 drv->bus->name, drv->name, ret);
-}
-
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -649,15 +638,9 @@ int bus_add_driver(struct device_driver *drv)
 
 	klist_add_tail(&priv->knode_bus, &bus->p->klist_drivers);
 	if (drv->bus->p->drivers_autoprobe) {
-		if (driver_allows_async_probing(drv)) {
-			pr_debug("bus: '%s': probing driver %s asynchronously\n",
-				drv->bus->name, drv->name);
-			async_schedule(driver_attach_async, drv);
-		} else {
-			error = driver_attach(drv);
-			if (error)
-				goto out_unregister;
-		}
+		error = driver_attach(drv);
+		if (error)
+			goto out_unregister;
 	}
 	module_add_driver(drv->owner, drv);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d2515520569e..036c8ffa522f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -674,6 +674,22 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static inline struct device_driver *dev_get_drv_async(const struct device *dev)
+{
+	return dev->async_probe ? dev->p->async_driver : NULL;
+}
+
+static inline void dev_set_drv_async(struct device *dev,
+				     struct device_driver *drv)
+{
+	/*
+	 * Set async_probe to true indicating we are waiting for this data to be
+	 * loaded as a potential driver.
+	 */
+	dev->p->async_driver = drv;
+	dev->async_probe = true;
+}
+
 bool driver_allows_async_probing(struct device_driver *drv)
 {
 	switch (drv->probe_type) {
@@ -836,7 +852,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			dev->async_probe = true;
+			dev_set_drv_async(dev, NULL);
 			async_schedule(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
@@ -929,6 +945,32 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
+{
+	struct device *dev = _dev;
+	struct device_driver *drv;
+
+	__device_driver_lock(dev, dev->parent);
+
+	/*
+	 * If someone attempted to bind a driver either successfully or
+	 * unsuccessfully before we got here we should just skip the driver
+	 * probe call.
+	 */
+	drv = dev_get_drv_async(dev);
+	if (drv && !dev->driver)
+		driver_probe_device(drv, dev);
+
+	/* We made our attempt at an async_probe, clear the flag */
+	dev->async_probe = false;
+
+	__device_driver_unlock(dev, dev->parent);
+
+	put_device(dev);
+
+	dev_dbg(dev, "async probe completed\n");
+}
+
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
@@ -956,6 +998,25 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
+	if (driver_allows_async_probing(drv)) {
+		/*
+		 * Instead of probing the device synchronously we will
+		 * probe it asynchronously to allow for more parallelism.
+		 *
+		 * We only take the device lock here in order to guarantee
+		 * that the dev->driver and async_driver fields are protected
+		 */
+		dev_dbg(dev, "scheduling asynchronous probe\n");
+		device_lock(dev);
+		if (!dev->driver) {
+			get_device(dev);
+			dev_set_drv_async(dev, drv);
+			async_schedule(__driver_attach_async_helper, dev);
+		}
+		device_unlock(dev);
+		return 0;
+	}
+
 	device_driver_attach(drv, dev);
 
 	return 0;
@@ -1054,6 +1115,12 @@ void device_release_driver_internal(struct device *dev,
 {
 	__device_driver_lock(dev, parent);
 
+	/*
+	 * We shouldn't need to add a check for any pending async_probe here
+	 * because the only caller that will pass us a driver, driver_detach,
+	 * should have been called after the driver was removed from the bus
+	 * and will call async_synchronize_full before we get to this point.
+	 */
 	if (!drv || drv == dev->driver)
 		__device_release_driver(dev, parent);
 


Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C36BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361AA205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361AA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeLERZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:25:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:41954 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeLERZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="96373051"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2018 09:25:34 -0800
Subject: [driver-core PATCH v8 4/9] driver core: Probe devices
 asynchronously instead of the driver
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 05 Dec 2018 09:25:34 -0800
Message-ID: <154403073429.11544.13495666211219472007.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
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
 drivers/base/base.h |    2 ++
 drivers/base/bus.c  |   23 +++--------------------
 drivers/base/dd.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 20 deletions(-)

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
index e50d768cd3b5..b731741059cb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -929,6 +929,30 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
+{
+	struct device *dev = _dev;
+	struct device_driver *drv;
+	int ret = 0;
+
+	__device_driver_lock(dev, dev->parent);
+
+	drv = dev->p->async_driver;
+
+	/*
+	 * If device has been removed or someone has already successfully
+	 * bound a driver before us just skip the driver probe call.
+	 */
+	if (!dev->dead && !dev->driver)
+		ret = driver_probe_device(drv, dev);
+
+	__device_driver_unlock(dev, dev->parent);
+
+	dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);
+
+	put_device(dev);
+}
+
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
@@ -956,6 +980,25 @@ static int __driver_attach(struct device *dev, void *data)
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
+		dev_dbg(dev, "probing driver %s asynchronously\n", drv->name);
+		device_lock(dev);
+		if (!dev->driver) {
+			get_device(dev);
+			dev->p->async_driver = drv;
+			async_schedule(__driver_attach_async_helper, dev);
+		}
+		device_unlock(dev);
+		return 0;
+	}
+
 	device_driver_attach(drv, dev);
 
 	return 0;


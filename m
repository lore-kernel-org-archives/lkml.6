Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B08ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021B20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKIDnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:43:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:2500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeKIDnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:43:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 10:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="106592079"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2018 10:07:06 -0800
Subject: [driver-core PATCH v6 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Thu, 08 Nov 2018 10:07:06 -0800
Message-ID: <154170042611.12967.14256799141542560553.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional bit flag to the device struct named async_probe. This
additional flag allows us to guarantee ordering between probe and remove
operations.

This allows us to guarantee that if we execute a remove operation or a
driver load attempt on a given interface it will not attempt to update the
driver member asynchronously following the earlier operation. Previously
this guarantee was not present and could result in us attempting to remove
a driver from an interface only to have it show up later when it is
asynchronously loaded.

One change I made in addition is I replaced the use of "bool X:1" to define
the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
warnings.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c      |  104 +++++++++++++++++++++++++++---------------------
 include/linux/device.h |    3 +
 2 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e74cefeb5b69..ed19cf0d6f9a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -472,6 +472,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
 	WARN_ON(!list_empty(&dev->devres_head));
 
+	/* clear async_probe flag as we are no longer deferring driver load */
+	dev->async_probe = false;
 re_probe:
 	dev->driver = drv;
 
@@ -771,6 +773,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	device_lock(dev);
 
+	/* nothing to do if async_probe has been cleared */
+	if (!dev->async_probe)
+		goto out_unlock;
+
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
 
@@ -781,7 +787,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
-
+out_unlock:
 	device_unlock(dev);
 
 	put_device(dev);
@@ -826,6 +832,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
+			dev->async_probe = true;
 			async_schedule(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
@@ -971,62 +978,69 @@ EXPORT_SYMBOL_GPL(driver_attach);
  */
 static void __device_release_driver(struct device *dev, struct device *parent)
 {
-	struct device_driver *drv;
+	struct device_driver *drv = dev->driver;
 
-	drv = dev->driver;
-	if (drv) {
-		while (device_links_busy(dev)) {
-			__device_driver_unlock(dev, parent);
+	/*
+	 * In the event that we are asked to release the driver on an
+	 * interface that is still waiting on a probe we can just terminate
+	 * the probe by setting async_probe to false. When the async call
+	 * is finally completed it will see this state and just exit.
+	 */
+	dev->async_probe = false;
+	if (!drv)
+		return;
 
-			device_links_unbind_consumers(dev);
+	while (device_links_busy(dev)) {
+		__device_driver_unlock(dev, parent);
 
-			__device_driver_lock(dev, parent);
-			/*
-			 * A concurrent invocation of the same function might
-			 * have released the driver successfully while this one
-			 * was waiting, so check for that.
-			 */
-			if (dev->driver != drv)
-				return;
-		}
+		device_links_unbind_consumers(dev);
 
-		pm_runtime_get_sync(dev);
-		pm_runtime_clean_up_links(dev);
+		__device_driver_lock(dev, parent);
+		/*
+		 * A concurrent invocation of the same function might
+		 * have released the driver successfully while this one
+		 * was waiting, so check for that.
+		 */
+		if (dev->driver != drv)
+			return;
+	}
 
-		driver_sysfs_remove(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_clean_up_links(dev);
 
-		if (dev->bus)
-			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-						     BUS_NOTIFY_UNBIND_DRIVER,
-						     dev);
+	driver_sysfs_remove(dev);
 
-		pm_runtime_put_sync(dev);
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_UNBIND_DRIVER,
+					     dev);
 
-		if (dev->bus && dev->bus->remove)
-			dev->bus->remove(dev);
-		else if (drv->remove)
-			drv->remove(dev);
+	pm_runtime_put_sync(dev);
 
-		device_links_driver_cleanup(dev);
-		arch_teardown_dma_ops(dev);
+	if (dev->bus && dev->bus->remove)
+		dev->bus->remove(dev);
+	else if (drv->remove)
+		drv->remove(dev);
 
-		devres_release_all(dev);
-		dev->driver = NULL;
-		dev_set_drvdata(dev, NULL);
-		if (dev->pm_domain && dev->pm_domain->dismiss)
-			dev->pm_domain->dismiss(dev);
-		pm_runtime_reinit(dev);
-		dev_pm_set_driver_flags(dev, 0);
+	device_links_driver_cleanup(dev);
+	arch_teardown_dma_ops(dev);
+
+	devres_release_all(dev);
+	dev->driver = NULL;
+	dev_set_drvdata(dev, NULL);
+	if (dev->pm_domain && dev->pm_domain->dismiss)
+		dev->pm_domain->dismiss(dev);
+	pm_runtime_reinit(dev);
+	dev_pm_set_driver_flags(dev, 0);
 
-		klist_remove(&dev->p->knode_driver);
-		device_pm_check_callbacks(dev);
-		if (dev->bus)
-			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-						     BUS_NOTIFY_UNBOUND_DRIVER,
-						     dev);
+	klist_remove(&dev->p->knode_driver);
+	device_pm_check_callbacks(dev);
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_UNBOUND_DRIVER,
+					     dev);
 
-		kobject_uevent(&dev->kobj, KOBJ_UNBIND);
-	}
+	kobject_uevent(&dev->kobj, KOBJ_UNBIND);
 }
 
 void device_release_driver_internal(struct device *dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..4d2eb2c74149 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -957,6 +957,8 @@ struct dev_links_info {
  *              device.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @async_probe: This device has an asynchronous probe event pending. Should
+ *		 only be updated while holding device lock.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -1051,6 +1053,7 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+	bool			async_probe:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)


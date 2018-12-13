Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A1C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1642020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1642020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLMApB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:45:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:26560 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeLMAo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:44:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 16:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,346,1539673200"; 
   d="scan'208";a="118349132"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2018 16:44:58 -0800
Subject: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 12 Dec 2018 16:44:58 -0800
Message-ID: <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional bit flag to the device struct named "dead".

This additional flag provides a guarantee that when a device_del is
executed on a given interface an async worker will not attempt to attach
the driver following the earlier device_del call. Previously this
guarantee was not present and could result in the device_del call
attempting to remove a driver from an interface only to have the async
worker attempt to probe the driver later when it finally completes the
asynchronous probe call.

One additional change added was that I pulled the check for dev->driver
out of the __device_attach_driver call and instead placed it in the
__device_attach_async_helper call. This was motivated by the fact that the
only other caller of this, __device_attach, had already taken the
device_lock() and checked for dev->driver. Instead of testing for this
twice in this path it makes more sense to just consolidate the dev->dead
and dev->driver checks together into one set of checks.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/core.c    |   11 +++++++++++
 drivers/base/dd.c      |   22 +++++++++++-----------
 include/linux/device.h |    5 +++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..950e25495726 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2080,6 +2080,17 @@ void device_del(struct device *dev)
 	struct kobject *glue_dir = NULL;
 	struct class_interface *class_intf;
 
+	/*
+	 * Hold the device lock and set the "dead" flag to guarantee that
+	 * the update behavior is consistent with the other bitfields near
+	 * it and that we cannot have an asynchronous probe routine trying
+	 * to run while we are tearing out the bus/class/sysfs from
+	 * underneath the device.
+	 */
+	device_lock(dev);
+	dev->dead = true;
+	device_unlock(dev);
+
 	/* Notify clients of device removal.  This call must come
 	 * before dpm_sysfs_remove().
 	 */
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 88713f182086..74c194ac99df 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -731,15 +731,6 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	bool async_allowed;
 	int ret;
 
-	/*
-	 * Check if device has already been claimed. This may
-	 * happen with driver loading, device discovery/registration,
-	 * and deferred probe processing happens all at once with
-	 * multiple threads.
-	 */
-	if (dev->driver)
-		return -EBUSY;
-
 	ret = driver_match_device(drv, dev);
 	if (ret == 0) {
 		/* no match */
@@ -774,6 +765,15 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	device_lock(dev);
 
+	/*
+	 * Check if device has already been removed or claimed. This may
+	 * happen with driver loading, device discovery/registration,
+	 * and deferred probe processing happens all at once with
+	 * multiple threads.
+	 */
+	if (dev->dead || dev->driver)
+		goto out_unlock;
+
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
 
@@ -784,7 +784,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
-
+out_unlock:
 	device_unlock(dev);
 
 	put_device(dev);
@@ -897,7 +897,7 @@ static int __driver_attach(struct device *dev, void *data)
 	if (dev->parent && dev->bus->need_parent_lock)
 		device_lock(dev->parent);
 	device_lock(dev);
-	if (!dev->driver)
+	if (!dev->dead && !dev->driver)
 		driver_probe_device(drv, dev);
 	device_unlock(dev);
 	if (dev->parent && dev->bus->need_parent_lock)
diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..f73dad81e811 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -957,6 +957,10 @@ struct dev_links_info {
  *              device.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @dead:	This device is currently either in the process of or has
+ *		been removed from the system. Any asynchronous events
+ *		scheduled for this device should exit without taking any
+ *		action.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -1051,6 +1055,7 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+	bool			dead:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)


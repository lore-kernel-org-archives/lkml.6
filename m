Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D85C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9612206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9612206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeK2Lfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:35:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:46453 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeK2Lfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:35:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 16:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="278487374"
Received: from ahduyck-desk1.jf.intel.com (HELO ahduyck-desk1.amr.corp.intel.com) ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 16:32:16 -0800
Subject: [driver-core PATCH v7 2/9] driver core: Establish clear order of
 operations for deferred probe and remove
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 28 Nov 2018 16:32:16 -0800
Message-ID: <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
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

Add an additional bit flag to the device struct named async_probe. This
additional flag allows us to guarantee ordering between probe and remove
operations.

This allows us to guarantee that if we execute a remove operation on a
given interface it will not attempt to update the driver member
asynchronously following the earlier operation. Previously this guarantee
was not present and could result in us attempting to remove a driver from
an interface only to have it attempt to attach the driver later when we
finally complete the deferred asynchronous probe call.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c      |   16 ++++++++++++++++
 include/linux/device.h |    3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 88713f182086..ef3f70a7cb5a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	device_lock(dev);
 
+	/* nothing to do if async_probe has been cleared */
+	if (!dev->async_probe)
+		goto out_unlock;
+
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
 
@@ -785,6 +789,9 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 
+	/* We made our attempt at an async_probe, clear the flag */
+	dev->async_probe = false;
+out_unlock:
 	device_unlock(dev);
 
 	put_device(dev);
@@ -829,6 +836,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
+			dev->async_probe = true;
 			async_schedule(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
@@ -929,6 +937,14 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 {
 	struct device_driver *drv;
 
+	/*
+	 * In the event that we are asked to release the driver on an
+	 * interface that is still waiting on a probe we can just terminate
+	 * the probe by setting async_probe to false. When the async call
+	 * is finally completed it will see this state and just exit.
+	 */
+	dev->async_probe = false;
+
 	drv = dev->driver;
 	if (drv) {
 		while (device_links_busy(dev)) {
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


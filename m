Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025C222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfBMEJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:09:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:48760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388163AbfBMEJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:09:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 20:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="117475921"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2019 20:09:04 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 7/9] vfio/mdev: Add iommu related member in mdev_device
Date:   Wed, 13 Feb 2019 12:02:59 +0800
Message-Id: <20190213040301.23021-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213040301.23021-1-baolu.lu@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A parent device might create different types of mediated
devices. For example, a mediated device could be created
by the parent device with full isolation and protection
provided by the IOMMU. One usage case could be found on
Intel platforms where a mediated device is an assignable
subset of a PCI, the DMA requests on behalf of it are all
tagged with a PASID. Since IOMMU supports PASID-granular
translations (scalable mode in VT-d 3.0), this mediated
device could be individually protected and isolated by an
IOMMU.

This patch adds a new member in the struct mdev_device to
indicate that the mediated device represented by mdev could
be isolated and protected by attaching a domain to a device
represented by mdev->iommu_device. It also adds a helper to
add or set the iommu device.

* mdev_device->iommu_device
  - This, if set, indicates that the mediated device could
    be fully isolated and protected by IOMMU via attaching
    an iommu domain to this device. If empty, it indicates
    using vendor defined isolation, hence bypass IOMMU.

* mdev_set/get_iommu_device(dev, iommu_device)
  - Set or get the iommu device which represents this mdev
    in IOMMU's device scope. Drivers don't need to set the
    iommu device if it uses vendor defined isolation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
 drivers/vfio/mdev/mdev_private.h |  1 +
 include/linux/mdev.h             | 14 ++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0ee8aea..9be58d392d2b 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	return 0;
 }
 
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->iommu_device = iommu_device;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->iommu_device;
+}
+EXPORT_SYMBOL(mdev_get_iommu_device);
+
 static int __init mdev_init(void)
 {
 	return mdev_bus_register();
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index b5819b7d7ef7..891841862ef8 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -34,6 +34,7 @@ struct mdev_device {
 	struct list_head next;
 	struct kobject *type_kobj;
 	bool active;
+	struct device *iommu_device;
 };
 
 #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index b6e048e1045f..c3ab8a9cfcc7 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -15,6 +15,20 @@
 
 struct mdev_device;
 
+/*
+ * Called by the parent device driver to set the device which represents
+ * this mdev in iommu protection scope. By default, the iommu device is
+ * NULL, that indicates using vendor defined isolation.
+ *
+ * @dev: the mediated device that iommu will isolate.
+ * @iommu_device: a pci device which represents the iommu for @dev.
+ *
+ * Return 0 for success, otherwise negative error value.
+ */
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev);
+
 /**
  * struct mdev_parent_ops - Structure to be registered for each parent device to
  * register the device to mdev module.
-- 
2.17.1


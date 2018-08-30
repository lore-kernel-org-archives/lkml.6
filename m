Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB34C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1120645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeH3ILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:11:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:31597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeH3ILZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 21:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="68959977"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 21:11:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH v2 07/10] vfio/mdev: Add mediated device domain type
Date:   Thu, 30 Aug 2018 12:09:19 +0800
Message-Id: <20180830040922.30426-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
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
translations (scalable mode in vt-d 3.0), this mediated
device could be individually protected and isolated by the
IOMMU.

This patch defines the domain types of a mediated device
and allows the parent driver to specify this attributes
when a mediated device is being careated. The following
types are defined:

* DOMAIN_TYPE_NO_IOMMU
  - Do not need any IOMMU support. All isolation and
    protection are handled by the parent device driver
    through the callbacks with device specific mechanism.
* DOMAIN_TYPE_ATTACH_PARENT
  - IOMMU can isolate and protect this mediated device,
    and an isolation domain should be attaced to the
    the parent device.

This also reseves a place in mdev private data structure
to save the iommu domain, and adds interfaces to store and
retrieve the domain. Below APIs are introduced:

* mdev_set/get_domain_type(type)
  - Set or query the domain type of a mediated device.
    The parent device driver should set the domain type
    (or keep DOMAIN_TYPE_NO_IOMMU by default) during the
    mediated device creation.

* mdev_set/get_domain(domain)
  - A iommu domain which has been attached to the parent
    device in order to protect and isolate the mediated
    device will be kept in the mdev data structure and
    could be retrieved later.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c    | 36 ++++++++++++++++++++++++++++++++
 drivers/vfio/mdev/mdev_private.h |  2 ++
 include/linux/mdev.h             | 26 +++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0ee8aea..d45a829c5b11 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	return 0;
 }
 
+int mdev_set_domain_type(struct device *dev, enum mdev_domain_type type)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->domain_type = type;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_domain_type);
+
+enum mdev_domain_type mdev_get_domain_type(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->domain_type;
+}
+EXPORT_SYMBOL(mdev_get_domain_type);
+
+int mdev_set_domain(struct device *dev, void *domain)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->domain = domain;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_domain);
+
+void *mdev_get_domain(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->domain;
+}
+EXPORT_SYMBOL(mdev_get_domain);
+
 static int __init mdev_init(void)
 {
 	return mdev_bus_register();
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index b5819b7d7ef7..fd9e33fbd6e5 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -34,6 +34,8 @@ struct mdev_device {
 	struct list_head next;
 	struct kobject *type_kobj;
 	bool active;
+	int domain_type;
+	void *domain;
 };
 
 #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index b6e048e1045f..3224587bda1e 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -15,6 +15,32 @@
 
 struct mdev_device;
 
+enum mdev_domain_type {
+	DOMAIN_TYPE_NO_IOMMU,		/* Don't need any IOMMU support.
+					 * All isolation and protection
+					 * are handled by the parent
+					 * device driver with a device
+					 * specific mechanism.
+					 */
+	DOMAIN_TYPE_ATTACH_PARENT,	/* IOMMU can isolate and protect
+					 * the mdev, and the isolation
+					 * domain should be attaced with
+					 * the parent device.
+					 */
+};
+
+/*
+ * Called by the parent device driver to set the domain type.
+ * By default, the domain type is set to DOMAIN_TYPE_EXTERNAL.
+ */
+int mdev_set_domain_type(struct device *dev, enum mdev_domain_type type);
+
+/* Check the domain type. */
+enum mdev_domain_type mdev_get_domain_type(struct device *dev);
+
+int mdev_set_domain(struct device *dev, void *domain);
+void *mdev_get_domain(struct device *dev);
+
 /**
  * struct mdev_parent_ops - Structure to be registered for each parent device to
  * register the device to mdev module.
-- 
2.17.1


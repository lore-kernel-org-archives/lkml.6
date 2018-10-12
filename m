Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3024C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39CF2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39CF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJLMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:49:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:62493 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeJLMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:49:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 22:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="80842215"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 22:18:41 -0700
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
Subject: [PATCH v3 1/8] iommu: Add APIs for multiple domains per device
Date:   Fri, 12 Oct 2018 13:16:25 +0800
Message-Id: <20181012051632.26064-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012051632.26064-1-baolu.lu@linux.intel.com>
References: <20181012051632.26064-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharing a physical PCI device in a finer-granularity way
is becoming a consensus in the industry. IOMMU vendors
are also engaging efforts to support such sharing as well
as possible. Among the efforts, the capability of support
finer-granularity DMA isolation is a common requirement
due to the security consideration. With finer-granularity
DMA isolation, all DMA requests out of or to a subset of
a physical PCI device can be protected by the IOMMU. As a
result, there is a request in software to attach multiple
domains to a physical PCI device. One example of such use
model is the Intel Scalable IOV [1] [2]. The Intel vt-d
3.0 spec [3] introduces the scalable mode which enables
PASID granularity DMA isolation.

This adds the APIs to support multiple domains per device.
In order to ease the discussions, we call it 'a domain in
auxiliary mode' or simply 'auxiliary domain' when multiple
domains are attached to a physical device.

The APIs includes:

* iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_CAPABILITY)
  - Represents the ability of supporting multiple domains
    per device.

* iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLE)
  - Enable the multiple domains capability for the device
    referenced by @dev.

* iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_DISABLE)
  - Disable the multiple domains capability for the device
    referenced by @dev.

* iommu_domain_get_attr(domain, DOMAIN_ATTR_AUXD_ID)
  - Return ID used for finer-granularity DMA translation.
    For the Intel Scalable IOV usage model, this will be
    a PASID. The device which supports Scalalbe IOV needs
    to writes this ID to the device register so that DMA
    requests could be tagged with a right PASID prefix.

Many people involved in discussions of this design.

Kevin Tian <kevin.tian@intel.com>
Liu Yi L <yi.l.liu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Sanjay Kumar <sanjay.k.kumar@intel.com>
Jacob Pan <jacob.jun.pan@linux.intel.com>
Alex Williamson <alex.williamson@redhat.com>
Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

and some discussions can be found here [4].

[1] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[2] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
[3] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[4] https://lkml.org/lkml/2018/7/26/4

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..d06cfdcf38a7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2014,3 +2014,28 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+/*
+ * Generic interfaces to get or set per device IOMMU attributions.
+ */
+int iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->get_dev_attr)
+		return ops->get_dev_attr(dev, attr, data);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_get_dev_attr);
+
+int iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->set_dev_attr)
+		return ops->set_dev_attr(dev, attr, data);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_set_dev_attr);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..0230b64cc6e9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -125,6 +125,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_MAX,
+	DOMAIN_ATTR_AUXD_ID,
 };
 
 /* These are the possible reserved region types */
@@ -155,6 +156,13 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
+/* Per device IOMMU attributions */
+enum iommu_dev_attr {
+	IOMMU_DEV_ATTR_AUXD_CAPABILITY,
+	IOMMU_DEV_ATTR_AUXD_ENABLE,
+	IOMMU_DEV_ATTR_AUXD_DISABLE,
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -184,6 +192,8 @@ struct iommu_resv_region {
  * @domain_set_windows: Set the number of windows for a domain
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
+ * @get_dev_attr: get per device IOMMU attributions
+ * @set_dev_attr: set per device IOMMU attributions
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -231,6 +241,12 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	/* Get/set per device IOMMU attributions */
+	int (*get_dev_attr)(struct device *dev,
+			    enum iommu_dev_attr attr, void *data);
+	int (*set_dev_attr)(struct device *dev,
+			    enum iommu_dev_attr attr, void *data);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -400,6 +416,11 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_get_dev_attr(struct device *dev,
+		       enum iommu_dev_attr attr, void *data);
+int iommu_set_dev_attr(struct device *dev,
+		       enum iommu_dev_attr attr, void *data);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -684,6 +705,18 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int
+iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
+static inline int
+iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.17.1


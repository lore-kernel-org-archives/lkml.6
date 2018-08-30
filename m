Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8333EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBE62082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBE62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeH3IML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:12:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:20569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeH3IML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:12:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 21:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="68959948"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 21:10:45 -0700
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
Subject: [RFC PATCH v2 01/10] iommu: Add APIs for multiple domains per device
Date:   Thu, 30 Aug 2018 12:09:13 +0800
Message-Id: <20180830040922.30426-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
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

* iommu_capable(IOMMU_CAP_AUX_DOMAIN)
  - Represents the ability of supporting multiple domains
    per device.

* iommu_en(dis)able_aux_domain(struct device *dev)
  - Enable/disable the multiple domains capability for a
    device referenced by @dev.

* iommu_auxiliary_id(struct iommu_domain *domain)
  - Return ID used for finer-granularity DMA translation.
    For the Intel Scalable IOV usage model, this will be
    a PASID. The device which supports Scalalbe IOV needs
    to writes this ID to the device register so that DMA
    requests could be tagged with a right PASID prefix.

Many people involved in discussions of this design. They're

Kevin Tian <kevin.tian@intel.com>
Liu Yi L <yi.l.liu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Sanjay Kumar <sanjay.k.kumar@intel.com>
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
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 29 +++++++++++++++++++++++++++++
 include/linux/iommu.h | 13 +++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..2c6faf417dd5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2014,3 +2014,32 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+int iommu_enable_aux_domain(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->enable_auxd)
+		return ops->enable_auxd(dev);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_enable_aux_domain);
+
+void iommu_disable_aux_domain(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->disable_auxd)
+		ops->disable_auxd(dev);
+}
+EXPORT_SYMBOL_GPL(iommu_disable_aux_domain);
+
+int iommu_auxiliary_id(struct iommu_domain *domain)
+{
+	if (domain->ops->auxd_id)
+		return domain->ops->auxd_id(domain);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_auxiliary_id);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..ffd20b315bee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -101,6 +101,8 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_AUX_DOMAIN,		/* IOMMU supports multiple domains per
+					   device */
 };
 
 /*
@@ -185,6 +187,9 @@ struct iommu_resv_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @enable_auxd: enable multiple domains per device support
+ * @disable_auxd: disable multiple domains per device support
+ * @auxd_id: return the id of an auxiliary domain
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -231,6 +236,10 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	int (*enable_auxd)(struct device *dev);
+	void (*disable_auxd)(struct device *dev);
+	int (*auxd_id)(struct iommu_domain *domain);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -400,6 +409,10 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_enable_aux_domain(struct device *dev);
+void iommu_disable_aux_domain(struct device *dev);
+int iommu_auxiliary_id(struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1


Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91352075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91352075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJLMtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:49:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:62493 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeJLMte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:49:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 22:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="80842237"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 22:18:51 -0700
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
Subject: [PATCH v3 4/8] iommu/vt-d: Attach/detach domains in auxiliary mode
Date:   Fri, 12 Oct 2018 13:16:28 +0800
Message-Id: <20181012051632.26064-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012051632.26064-1-baolu.lu@linux.intel.com>
References: <20181012051632.26064-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple domains per device has been enabled by the
device driver, the device will tag the default PASID for
the domain to all DMA traffics out of the subset of this
device; and the IOMMU should translate the DMA requests
in PASID granularity.

This extends the intel_iommu_attach/detach_device() ops
to support managing PASID granular translation structures
when the device driver has enabled multiple domains per
device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 132 +++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  10 +++
 2 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27beda7f9d88..3ca42b0e80df 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2477,6 +2477,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->iommu = iommu;
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
+	INIT_LIST_HEAD(&info->auxiliary_domains);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5013,6 +5014,124 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	domain_exit(to_dmar_domain(domain));
 }
 
+/*
+ * Check whether a @domain will be attached to the @dev in the
+ * auxiliary mode.
+ */
+static inline bool
+is_device_attach_aux_domain(struct device *dev, struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev->archdata.iommu;
+
+	return info && info->auxd_enabled &&
+			domain->type == IOMMU_DOMAIN_UNMANAGED;
+}
+
+static void auxiliary_link_device(struct dmar_domain *domain,
+				  struct device *dev)
+{
+	struct device_domain_info *info = dev->archdata.iommu;
+
+	assert_spin_locked(&device_domain_lock);
+	if (WARN_ON(!info))
+		return;
+
+	domain->auxd_refcnt++;
+	list_add(&domain->auxd, &info->auxiliary_domains);
+}
+
+static void auxiliary_unlink_device(struct dmar_domain *domain,
+				    struct device *dev)
+{
+	struct device_domain_info *info = dev->archdata.iommu;
+
+	assert_spin_locked(&device_domain_lock);
+	if (WARN_ON(!info))
+		return;
+
+	list_del(&domain->auxd);
+	domain->auxd_refcnt--;
+
+	if (!domain->auxd_refcnt && domain->default_pasid > 0)
+		intel_pasid_free_id(domain->default_pasid);
+}
+
+static int domain_add_dev_auxd(struct dmar_domain *domain,
+			       struct device *dev)
+{
+	int ret;
+	u8 bus, devfn;
+	unsigned long flags;
+	struct intel_iommu *iommu;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	if (domain->default_pasid <= 0) {
+		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
+				intel_pasid_get_dev_max_id(dev), GFP_ATOMIC);
+		if (domain->default_pasid < 0) {
+			pr_err("Can't allocate default pasid\n");
+			ret = -ENODEV;
+			goto pasid_failed;
+		}
+	}
+
+	spin_lock(&iommu->lock);
+	ret = domain_attach_iommu(domain, iommu);
+	if (ret)
+		goto attach_failed;
+
+	/* Setup the PASID entry for mediated devices: */
+	ret = intel_pasid_setup_second_level(iommu, domain, dev,
+					     domain->default_pasid, false);
+	if (ret)
+		goto table_failed;
+	spin_unlock(&iommu->lock);
+
+	auxiliary_link_device(domain, dev);
+
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+
+table_failed:
+	domain_detach_iommu(domain, iommu);
+attach_failed:
+	spin_unlock(&iommu->lock);
+	if (!domain->auxd_refcnt && domain->default_pasid > 0)
+		intel_pasid_free_id(domain->default_pasid);
+pasid_failed:
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
+static void domain_remove_dev_aux(struct dmar_domain *domain,
+				  struct device *dev)
+{
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	iommu = info->iommu;
+
+	intel_pasid_tear_down_second_level(iommu, domain,
+					   dev, domain->default_pasid);
+
+	auxiliary_unlink_device(domain, dev);
+
+	spin_lock(&iommu->lock);
+	domain_detach_iommu(domain, iommu);
+	spin_unlock(&iommu->lock);
+
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
@@ -5027,7 +5146,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	}
 
 	/* normally dev is not mapped */
-	if (unlikely(domain_context_mapped(dev))) {
+	if (unlikely(domain_context_mapped(dev) &&
+		     !is_device_attach_aux_domain(dev, domain))) {
 		struct dmar_domain *old_domain;
 
 		old_domain = find_domain(dev);
@@ -5074,13 +5194,19 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
-	return domain_add_dev_info(dmar_domain, dev);
+	if (is_device_attach_aux_domain(dev, domain))
+		return domain_add_dev_auxd(dmar_domain, dev);
+	else
+		return domain_add_dev_info(dmar_domain, dev);
 }
 
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
+	if (is_device_attach_aux_domain(dev, domain))
+		domain_remove_dev_aux(to_dmar_domain(domain), dev);
+	else
+		dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6b198e13e75e..678c7fb05e74 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -473,9 +473,11 @@ struct dmar_domain {
 					/* Domain ids per IOMMU. Use u16 since
 					 * domain ids are 16 bit wide according
 					 * to VT-d spec, section 9.3 */
+	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
 
 	bool has_iotlb_device;
 	struct list_head devices;	/* all devices' list */
+	struct list_head auxd;		/* link to device's auxiliary list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -494,6 +496,11 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	u64		max_addr;	/* maximum mapped address */
 
+	int		default_pasid;	/*
+					 * The default pasid used for non-SVM
+					 * traffic on mediated devices.
+					 */
+
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
@@ -543,6 +550,9 @@ struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
+	struct list_head auxiliary_domains; /* auxiliary domains
+					     * attached to this device
+					     */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
 	u16 pfsid;		/* SRIOV physical function source ID */
-- 
2.17.1


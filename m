Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA819C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F7F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfAJDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:05:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:11620 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfAJDE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:04:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 19:04:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="115608424"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2019 19:04:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng@vger.kernel.org,
        Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 4/8] iommu/vt-d: Aux-domain specific domain attach/detach
Date:   Thu, 10 Jan 2019 11:00:23 +0800
Message-Id: <20190110030027.31447-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110030027.31447-1-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple domains per device has been enabled by the
device driver, the device will tag the default PASID for
the domain to all DMA traffics out of the subset of this
device; and the IOMMU should translate the DMA requests
in PASID granularity.

This adds the intel_iommu_aux_attach/detach_device() ops
to support managing PASID granular translation structures
when the device driver has enabled multiple domains per
device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 152 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  10 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e9119d45a29d..b8fb6a4bd447 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2482,6 +2482,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->iommu = iommu;
 	info->pasid_table = NULL;
 	info->auxd_enabled = 0;
+	INIT_LIST_HEAD(&info->auxiliary_domains);
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5058,6 +5059,131 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	domain_exit(to_dmar_domain(domain));
 }
 
+/*
+ * Check whether a @domain could be attached to the @dev through the
+ * aux-domain attach/detach APIs.
+ */
+static inline bool
+is_aux_domain(struct device *dev, struct iommu_domain *domain)
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
+static int aux_domain_add_dev(struct dmar_domain *domain,
+			      struct device *dev)
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
+	if (domain->default_pasid <= 0) {
+		int pasid;
+
+		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
+					     pci_max_pasids(to_pci_dev(dev)),
+					     GFP_KERNEL);
+		if (pasid <= 0) {
+			pr_err("Can't allocate default pasid\n");
+			return -ENODEV;
+		}
+		domain->default_pasid = pasid;
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	/*
+	 * iommu->lock must be held to attach domain to iommu and setup the
+	 * pasid entry for second level translation.
+	 */
+	spin_lock(&iommu->lock);
+	ret = domain_attach_iommu(domain, iommu);
+	if (ret)
+		goto attach_failed;
+
+	/* Setup the PASID entry for mediated devices: */
+	ret = intel_pasid_setup_second_level(iommu, domain, dev,
+					     domain->default_pasid);
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
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+	if (!domain->auxd_refcnt && domain->default_pasid > 0)
+		intel_pasid_free_id(domain->default_pasid);
+
+	return ret;
+}
+
+static void aux_domain_remove_dev(struct dmar_domain *domain,
+				  struct device *dev)
+{
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+
+	if (!is_aux_domain(dev, &domain->domain))
+		return;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	iommu = info->iommu;
+
+	auxiliary_unlink_device(domain, dev);
+
+	spin_lock(&iommu->lock);
+	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
+	domain_detach_iommu(domain, iommu);
+	spin_unlock(&iommu->lock);
+
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static int prepare_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev)
 {
@@ -5111,6 +5237,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		return -EPERM;
 	}
 
+	if (is_aux_domain(dev, domain))
+		return -EPERM;
+
 	/* normally dev is not mapped */
 	if (unlikely(domain_context_mapped(dev))) {
 		struct dmar_domain *old_domain;
@@ -5134,12 +5263,33 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
+static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
+					 struct device *dev)
+{
+	int ret;
+
+	if (!is_aux_domain(dev, domain))
+		return -EPERM;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	return aux_domain_add_dev(to_dmar_domain(domain), dev);
+}
+
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
+					  struct device *dev)
+{
+	aux_domain_remove_dev(to_dmar_domain(domain), dev);
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5480,6 +5630,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_free		= intel_iommu_domain_free,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
+	.aux_attach_dev		= intel_iommu_aux_attach_device,
+	.aux_detach_dev		= intel_iommu_aux_detach_device,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7cf9f7f3724a..b563a61a6c39 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -492,9 +492,11 @@ struct dmar_domain {
 					/* Domain ids per IOMMU. Use u16 since
 					 * domain ids are 16 bit wide according
 					 * to VT-d spec, section 9.3 */
+	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
 
 	bool has_iotlb_device;
 	struct list_head devices;	/* all devices' list */
+	struct list_head auxd;		/* link to device's auxiliary list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -513,6 +515,11 @@ struct dmar_domain {
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
@@ -562,6 +569,9 @@ struct device_domain_info {
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


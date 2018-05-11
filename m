Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpey8EFqWXIvs7RTVESHQrcO3xB6n9x8KBA0rcmrtpqLNDgwnaO6WzxHxbLdqO3sJp4vapE
ARC-Seal: i=1; a=rsa-sha256; t=1526071893; cv=none;
        d=google.com; s=arc-20160816;
        b=asFo8hmUp4R1Baw/fAl5e1+hBe5AuQKgb2T6TATNUhjbj+MfI55kucW9T0Xylx6yls
         3pm9CVAU7lDt512NlmS7G8R+a2JpY34XLgkjZzHeryrSUyFvJOeAuYS1oH5wLqE0sOKK
         HXAodF7gu57U5FJ6ojEpl8bLo6ngq7ZOebC+OjyjLz5+MkkBrQwNgs1k3TylVKVwpNBN
         PeU75W/S+Fb96vDskWidfXZJmVd7qRF3AjEA4T8sKc63drA144tOrnTlbytepcSRum9r
         7OgSHOoslTJk/oE6U2xeowGQrmjv8sMJZNFI4WB+OuIkxTHqbXsUCrGa3wwsAUXDud1E
         aZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oo6n7LU1Wbo1k/jmTNIZWjBrIEdO837aL1D7rup8Qh0=;
        b=ETp0LkYow+T3tF2F84viE1Ho4YIUrbmW0T4YvdMxDjtzojAy7YIkClO64BwMI2j15D
         LpBBs87/+R2vIhKUugx4iyRvfl+wp+RExx3vc+OXBezIugysa40W+uDRpGD6XVQgQ3BY
         XK8JnK7YO9KR/nSYPQCk0pFERA3LCRayL3WZ2ZnbzmZxIFSZmNa0yypRJJjBSXF6gqlN
         N1vja/afitnxZI16FPpdKQtsRXs/WklML3T+4gOuhar7+LKrFrXi4g4cSloYpYpI4zge
         +ldYAzQuTf44Je5i9ph47c9cV5V7FY01Kjx5Y68nKycQJUFp2mKBNHon+Uw5DZrHIaMW
         xOPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104740"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Liu,
	Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH v5 04/23] iommu/vt-d: add bind_pasid_table function
Date: Fri, 11 May 2018 13:53:56 -0700
Message-Id: <1526072055-86990-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361435281537?=
X-GMAIL-MSGID: =?utf-8?q?1600202361435281537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add Intel VT-d ops to the generic iommu_bind_pasid_table API
functions.

The primary use case is for direct assignment of SVM capable
device. Originated from emulated IOMMU in the guest, the request goes
through many layers (e.g. VFIO). Upon calling host IOMMU driver, caller
passes guest PASID table pointer (GPA) and size.

Device context table entry is modified by Intel IOMMU specific
bind_pasid_table function. This will turn on nesting mode and matching
translation type.

The unbind operation restores default context mapping.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c   | 122 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma_remapping.h |   1 +
 2 files changed, 123 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a0f81a4..4623294 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2409,6 +2409,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
 	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
 	info->ats_qdep = 0;
+	info->pasid_table_bound = 0;
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
@@ -5132,6 +5133,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
+#define MIN_NR_PASID_BITS (5)
 static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
 {
 	/*
@@ -5258,6 +5260,122 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 
 	return iommu;
 }
+
+static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
+		struct device *dev, struct pasid_table_config *pasidt_binfo)
+{
+	struct intel_iommu *iommu;
+	struct context_entry *context;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	struct pci_dev *pdev;
+	u8 bus, devfn, host_table_pasid_bits;
+	u16 did, sid;
+	int ret = 0;
+	unsigned long flags;
+	u64 ctx_lo;
+
+	if ((pasidt_binfo->version != PASID_TABLE_CFG_VERSION_1) ||
+		pasidt_binfo->bytes != sizeof(*pasidt_binfo))
+		return -EINVAL;
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+	/* VT-d spec section 9.4 says pasid table size is encoded as 2^(x+5) */
+	host_table_pasid_bits = intel_iommu_get_pts(iommu) + MIN_NR_PASID_BITS;
+	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||
+		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
+		pr_err("Invalid gPASID bits %d, host range %d - %d\n",
+			pasidt_binfo->pasid_bits,
+			MIN_NR_PASID_BITS, host_table_pasid_bits);
+		return -ERANGE;
+	}
+	if (!ecap_nest(iommu->ecap)) {
+		dev_err(dev, "Cannot bind PASID table, no nested translation\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	pdev = to_pci_dev(dev);
+	sid = PCI_DEVID(bus, devfn);
+	info = dev->archdata.iommu;
+
+	if (!info) {
+		dev_err(dev, "Invalid device domain info\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (info->pasid_table_bound) {
+		dev_err(dev, "Device PASID table already bound\n");
+		ret = -EBUSY;
+		goto out;
+	}
+	if (!info->pasid_enabled) {
+		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
+		if (ret) {
+			dev_err(dev, "Failed to enable PASID\n");
+			goto out;
+		}
+	}
+	spin_lock_irqsave(&iommu->lock, flags);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!context_present(context)) {
+		dev_err(dev, "Context not present\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Anticipate guest to use SVM and owns the first level, so we turn
+	 * nested mode on
+	 */
+	ctx_lo = context[0].lo;
+	ctx_lo |= CONTEXT_NESTE | CONTEXT_PRS | CONTEXT_PASIDE;
+	ctx_lo &= ~CONTEXT_TT_MASK;
+	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
+	context[0].lo = ctx_lo;
+
+	/* Assign guest PASID table pointer and size order */
+	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
+		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);
+	context[1].lo = ctx_lo;
+	/* make sure context entry is updated before flushing */
+	wmb();
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	iommu->flush.flush_context(iommu, did,
+				(((u16)bus) << 8) | devfn,
+				DMA_CCMD_MASK_NOBIT,
+				DMA_CCMD_DEVICE_INVL);
+	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	info->pasid_table_bound = 1;
+out_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+out:
+	return ret;
+}
+
+static void intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	u8 bus, devfn;
+
+	info = dev->archdata.iommu;
+	if (!info) {
+		dev_err(dev, "Invalid device domain info\n");
+		return;
+	}
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu) {
+		dev_err(dev, "No IOMMU for device to unbind PASID table\n");
+		return;
+	}
+
+	domain_context_clear(iommu, dev);
+
+	domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
+	info->pasid_table_bound = 0;
+}
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 const struct iommu_ops intel_iommu_ops = {
@@ -5266,6 +5384,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_free		= intel_iommu_domain_free,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	.bind_pasid_table	= intel_iommu_bind_pasid_table,
+	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+#endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
 	.map_sg			= default_iommu_map_sg,
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 21b3e7d..db290b2 100644
--- a/include/linux/dma_remapping.h
+++ b/include/linux/dma_remapping.h
@@ -28,6 +28,7 @@
 
 #define CONTEXT_DINVE		(1ULL << 8)
 #define CONTEXT_PRS		(1ULL << 9)
+#define CONTEXT_NESTE		(1ULL << 10)
 #define CONTEXT_PASIDE		(1ULL << 11)
 
 struct intel_iommu;
-- 
2.7.4

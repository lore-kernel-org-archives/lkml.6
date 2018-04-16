Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/tbT5jgSvyY5IeDX9FfSfRCQxMPyT29vXhtoRVIET4esBF1Fy8oa+arLd3FQh4zhbSB4iI
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=ILpRGjsvg8LXIFrPVKeixYoWli2EtpXpbasP9jAQhuNE5z7fcXeuPTRgeBp4h2a2HD
         9JRLVL/MOCUekcyDiMuoceJjsCKZKiSbIsnJCkw7+soEkq0ZfPQA+ojdvBNDvq5Y7aGA
         fXc3SFKcEBobh109IlcSCYh87Wo4wysjrDLkUB630cdPgiENTIAQBlvmW3dXBz8rPVLl
         aLfl7PLpNRrX0L4qZCtoVG1MpOeC+yrahtx7kDo941kiPuRbQ7fj5YejgXmDLFpSXUHv
         B/Z45RR2F75B17k+rJBAMwlCVv+YIIMKFKLGHcFdbbtrJr/y1B3i9PYcsyzCFjUU7IUk
         jgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nr0CDf5H4W9nGWGomx2Gwwp8VxbuL2u+RSwJNMLbN9Y=;
        b=QGwYwxFbNKr0t4t0/EFXMpLmrJiuNbolJfsKuYqwzp8YSKO7pveZcxR2sPCAsO5pgW
         yNn/zlnD7yEByQdHndpgPRzSyyY2MoKW/epXVez5mlhITMjVnUwbEsJI7B0usQQxqsxW
         UEnFT8ra9gc02EGqOuPB/RFIISoCEjBE9HE+wFZUNOcICdVhRV/VWoJGdCiiPurmGk4o
         GQRkXh9OJ4yQ9MqhiFJNTrqhPD/J3tEHifOy770oGCdcQmjBlnA4TSnuuIjksYL+E/TR
         X45YVp3s7lTwXfTUC7rG4ctvijZNiwFUMmvl6OUk+G3aGNOaQjTMNahxbEBq0qq+tUeC
         Gn0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740161"
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
Subject: [PATCH v4 09/22] iommu/vt-d: add svm/sva invalidate function
Date: Mon, 16 Apr 2018 14:48:58 -0700
Message-Id: <1523915351-54415-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910542844280?=
X-GMAIL-MSGID: =?utf-8?q?1597940910542844280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Shared Virtual Address (SVA) is enabled for a guest OS via
vIOMMU, we need to provide invalidation support at IOMMU API and driver
level. This patch adds Intel VT-d specific function to implement
iommu passdown invalidate API for shared virtual address.

The use case is for supporting caching structure invalidation
of assigned SVM capable devices. Emulated IOMMU exposes queue
invalidation capability and passes down all descriptors from the guest
to the physical IOMMU.

The assumption is that guest to host device ID mapping should be
resolved prior to calling IOMMU driver. Based on the device handle,
host IOMMU driver can replace certain fields before submit to the
invalidation queue.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 170 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cae4042..c765448 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4973,6 +4973,175 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
+/*
+ * 3D array for converting IOMMU generic type-granularity to VT-d granularity
+ * X indexed by enum iommu_inv_type
+ * Y indicates request without and with PASID
+ * Z indexed by enum iommu_inv_granularity
+ *
+ * For an example, if we want to find the VT-d granularity encoding for IOTLB
+ * type, DMA request with PASID, and page selective. The look up indices are:
+ * [1][1][8], where
+ * 1: IOMMU_INV_TYPE_TLB
+ * 1: with PASID
+ * 8: IOMMU_INV_GRANU_PAGE_PASID
+ *
+ * Granu_map array indicates validity of the table. 1: valid, 0: invalid
+ *
+ */
+const static int inv_type_granu_map[IOMMU_INV_NR_TYPE][2][IOMMU_INV_NR_GRANU] = {
+	/* extended dev IOTLBs, for dev-IOTLB, only global is valid,
+	   for dev-EXIOTLB, two valid granu */
+	{
+		{1},
+		{0, 0, 0, 0, 1, 1, 0, 0, 0}
+	},
+	/* IOTLB and EIOTLB */
+	{
+		{1, 1, 0, 1, 0, 0, 0, 0, 0},
+		{0, 0, 0, 0, 1, 0, 1, 1, 1}
+	},
+	/* PASID cache */
+	{
+		{0},
+		{0, 0, 0, 0, 1, 1, 0, 0, 0}
+	},
+	/* context cache */
+	{
+		{1, 1, 1}
+	}
+};
+
+const static u64 inv_type_granu_table[IOMMU_INV_NR_TYPE][2][IOMMU_INV_NR_GRANU] = {
+	/* extended dev IOTLBs, only global is valid */
+	{
+		{QI_DEV_IOTLB_GRAN_ALL},
+		{0, 0, 0, 0, QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0, 0, 0}
+	},
+	/* IOTLB and EIOTLB */
+	{
+		{DMA_TLB_GLOBAL_FLUSH, DMA_TLB_DSI_FLUSH, 0, DMA_TLB_PSI_FLUSH},
+		{0, 0, 0, 0, QI_GRAN_ALL_ALL, 0, QI_GRAN_NONG_ALL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID}
+	},
+	/* PASID cache */
+	{
+		{0},
+		{0, 0, 0, 0, QI_PC_ALL_PASIDS, QI_PC_PASID_SEL}
+	},
+	/* context cache */
+	{
+		{DMA_CCMD_GLOBAL_INVL, DMA_CCMD_DOMAIN_INVL, DMA_CCMD_DEVICE_INVL}
+	}
+};
+
+static inline int to_vtd_granularity(int type, int granu, int with_pasid, u64 *vtd_granu)
+{
+	if (type >= IOMMU_INV_NR_TYPE || granu >= IOMMU_INV_NR_GRANU || with_pasid > 1)
+		return -EINVAL;
+
+	if (inv_type_granu_map[type][with_pasid][granu] == 0)
+		return -EINVAL;
+
+	*vtd_granu = inv_type_granu_table[type][with_pasid][granu];
+
+	return 0;
+}
+
+static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	u16 did, sid;
+	u8 bus, devfn;
+	int ret = 0;
+	u64 granu;
+	unsigned long flags;
+
+	if (!inv_info || !dmar_domain)
+		return -EINVAL;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	sid = PCI_DEVID(bus, devfn);
+	ret = to_vtd_granularity(inv_info->hdr.type, inv_info->granularity,
+				!!(inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED), &granu);
+	if (ret) {
+		pr_err("Invalid range type %d, granu %d\n", inv_info->hdr.type,
+			inv_info->granularity);
+		return ret;
+	}
+
+	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&device_domain_lock, flags);
+
+	switch (inv_info->hdr.type) {
+	case IOMMU_INV_TYPE_CONTEXT:
+		iommu->flush.flush_context(iommu, did, sid,
+					DMA_CCMD_MASK_NOBIT, granu);
+		break;
+	case IOMMU_INV_TYPE_TLB:
+		/* We need to deal with two scenarios:
+		 * - IOTLB for request w/o PASID
+		 * - extended IOTLB for request with PASID.
+		 */
+		if (inv_info->size &&
+			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT + inv_info->size)) - 1))) {
+			pr_err("Addr out of range, addr 0x%llx, size order %d\n",
+				inv_info->addr, inv_info->size);
+			ret = -ERANGE;
+			goto out_unlock;
+		}
+
+		if (inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED)
+			qi_flush_eiotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
+					inv_info->pasid,
+					inv_info->size, granu,
+					inv_info->flags & IOMMU_INVALIDATE_GLOBAL_PAGE);
+		else
+			qi_flush_iotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
+				inv_info->size, granu);
+		/**
+		 * Always flush device IOTLB if ATS is enabled since guest
+		 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
+		 * down.
+		 */
+		info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
+		if (info && info->ats_enabled) {
+			if (inv_info->flags & IOMMU_INVALIDATE_PASID_TAGGED)
+				qi_flush_dev_eiotlb(iommu, sid,
+						inv_info->pasid, info->ats_qdep,
+						inv_info->addr, inv_info->size,
+						granu);
+			else
+				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+						info->ats_qdep, inv_info->addr,
+						inv_info->size);
+		}
+		break;
+	case IOMMU_INV_TYPE_PASID:
+		qi_flush_pasid(iommu, did, granu, inv_info->pasid);
+
+		break;
+	default:
+		dev_err(dev, "Unknown IOMMU invalidation type %d\n",
+			inv_info->hdr.type);
+		ret = -EINVAL;
+	}
+out_unlock:
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5398,6 +5567,7 @@ const struct iommu_ops intel_iommu_ops = {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+	.sva_invalidate		= intel_iommu_sva_invalidate,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
-- 
2.7.4

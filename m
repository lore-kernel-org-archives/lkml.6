Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqdyO+m9NBnCw3K/dbWSXWS1JJnmZOJRreOtkODoDzznbNmQrACR95hH8uWFRH5407pn9kk
ARC-Seal: i=1; a=rsa-sha256; t=1526071893; cv=none;
        d=google.com; s=arc-20160816;
        b=gCpnfUgZSU1W58fZFGxnae6xwUnjCjutPju4E1RGsPqaeT388cDZwBohnN6D2dAJIf
         9UvTibl4mQ3v3I/ARmPZDy9+a/sGIe72l2GK/3IdYnzjTIoUlxxqOZKHUEOb2T5x7Rza
         rR0BQ6corrBVirc2PAHA6P82zVFpkhAe0WgCagUSbHXUQlTggvhPf6DpttSodh0WSR+h
         EbMPx0XjSNPUmPb/HiIeSbayMEUy6nNDVgWzee+FVDhviFgxHbS3OI7MHfmZCk9BwssQ
         YcjlgdBmxSH7M4u12HiBDsEhtc90KYPCA9kv2c4NomROt8k1XF3BxXVeQb8Lt0fjycvW
         Ermw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/d6n/ojglXSJImxrpWEEIQKywsBxvOF/4FgRaOYe28Y=;
        b=sDbAQPIO2hfQaeVbxOaHFlcjYVB/e9AlexyQMtHJM8Fa3SSUActKYCF+ONkg1gYrAc
         shkNdCNyYeWY3ghjWx2M1MqsnUKI9EO7UPdRI0FJc5/ZEFGsnC2AzZBpWsquQlzk6dBv
         BHP3Ryy+wcoHM3OGLu/uc5P4N15UO4+/ShEaMYz41MRcfnkgJQvu24ABGN0bcJp9e1uP
         UUbYVWnHdSD5w94LycX91TqCJEu0emdZkyUiKmAbTTMnt0g4JriAiCfLqFbvMM+zGwwS
         1h0o0mMu5+Ifz/chogUJfA0yy3/KYx4RtzroyZVyuw2lGsB4hy0hOo83IkYDRORtYBGZ
         09Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104744"
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
	"Liu, Yi L" <yi.l.liu@linux.intel.com>,
	Liu,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 05/23] iommu: introduce iommu invalidate API function
Date: Fri, 11 May 2018 13:53:57 -0700
Message-Id: <1526072055-86990-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361842428803?=
X-GMAIL-MSGID: =?utf-8?q?1600202361842428803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

When an SVM capable device is assigned to a guest, the first level page
tables are owned by the guest and the guest PASID table pointer is
linked to the device context entry of the physical IOMMU.

Host IOMMU driver has no knowledge of caching structure updates unless
the guest invalidation activities are passed down to the host. The
primary usage is derived from emulated IOMMU in the guest, where QEMU
can trap invalidation activities before passing them down to the
host/physical IOMMU.
Since the invalidation data are obtained from user space and will be
written into physical IOMMU, we must allow security check at various
layers. Therefore, generic invalidation data format are proposed here,
model specific IOMMU drivers need to convert them into their own format.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c      | 14 +++++++
 include/linux/iommu.h      | 12 ++++++
 include/uapi/linux/iommu.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a69620..784e019 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1344,6 +1344,20 @@ void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
 
+int iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	int ret = 0;
+
+	if (unlikely(!domain->ops->sva_invalidate))
+		return -ENODEV;
+
+	ret = domain->ops->sva_invalidate(domain, dev, inv_info);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5199ca4..e8cadb6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -190,6 +190,7 @@ struct iommu_resv_region {
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
+ * @sva_invalidate: invalidate translation caches of shared virtual address
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -243,6 +244,8 @@ struct iommu_ops {
 				struct pasid_table_config *pasidt_binfo);
 	void (*unbind_pasid_table)(struct iommu_domain *domain,
 				struct device *dev);
+	int (*sva_invalidate)(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
 
 	unsigned long pgsize_bitmap;
 };
@@ -309,6 +312,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
 		struct device *dev, struct pasid_table_config *pasidt_binfo);
 extern void iommu_unbind_pasid_table(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info);
+
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -720,6 +726,12 @@ void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
 {
 }
 
+static inline int iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct tlb_invalidate_info *inv_info)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index cb2d625..79d93ef 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -30,4 +30,95 @@ struct pasid_table_config {
 	__u8 pasid_bits;
 };
 
+/**
+ * enum iommu_inv_granularity - Generic invalidation granularity
+ * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID caches of all
+ *					PASIDs associated with a domain ID
+ * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID cache associated
+ *					with a PASID and a domain
+ * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of selected page range
+ *					within a PASID
+ *
+ * When an invalidation request is passed down to IOMMU to flush translation
+ * caches, it may carry different granularity levels, which can be specific
+ * to certain types of translation caches.
+ * This enum is a collection of granularities for all types of translation
+ * caches. The idea is to make it easy for IOMMU model specific driver to
+ * convert from generic to model specific value. Each IOMMU driver
+ * can enforce check based on its own conversion table. The conversion is
+ * based on 2D look-up with inputs as follows:
+ * - translation cache types
+ * - granularity
+ *
+ *             type |   DTLB    |    TLB    |   PASID   |
+ *  granule         |           |           |   cache   |
+ * -----------------+-----------+-----------+-----------+
+ *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
+ *  PASID_SEL       |   Y       |   Y       |   Y       |
+ *  PAGE_PASID      |   Y       |   Y       |   N/A     |
+ *
+ */
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
+	IOMMU_INV_GRANU_PASID_SEL,
+	IOMMU_INV_GRANU_PAGE_PASID,
+	IOMMU_INV_NR_GRANU,
+};
+
+/**
+ * enum iommu_inv_type - Generic translation cache types for invalidation
+ *
+ * @IOMMU_INV_TYPE_DTLB:	device IOTLB
+ * @IOMMU_INV_TYPE_TLB:		IOMMU paging structure cache
+ * @IOMMU_INV_TYPE_PASID:	PASID cache
+ * Invalidation requests sent to IOMMU for a given device need to indicate
+ * which type of translation cache to be operated on. Combined with enum
+ * iommu_inv_granularity, model specific driver can do a simple lookup to
+ * convert from generic to model specific value.
+ */
+enum iommu_inv_type {
+	IOMMU_INV_TYPE_DTLB,
+	IOMMU_INV_TYPE_TLB,
+	IOMMU_INV_TYPE_PASID,
+	IOMMU_INV_NR_TYPE
+};
+
+/**
+ * Translation cache invalidation header that contains mandatory meta data.
+ * @version:	info format version, expecting future extesions
+ * @type:	type of translation cache to be invalidated
+ */
+struct tlb_invalidate_hdr {
+	__u32 version;
+#define TLB_INV_HDR_VERSION_1 1
+	enum iommu_inv_type type;
+};
+
+/**
+ * Translation cache invalidation information, contains generic IOMMU
+ * data which can be parsed based on model ID by model specific drivers.
+ * Since the invalidation of second level page tables are included in the
+ * unmap operation, this info is only applicable to the first level
+ * translation caches, i.e. DMA request with PASID.
+ *
+ * @granularity:	requested invalidation granularity, type dependent
+ * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
+ * @nr_pages:		number of pages to invalidate
+ * @pasid:		processor address space ID value per PCI spec.
+ * @addr:		page address to be invalidated
+ * @flags		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
+ *			IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
+ *
+ */
+struct tlb_invalidate_info {
+	struct tlb_invalidate_hdr	hdr;
+	enum iommu_inv_granularity	granularity;
+	__u32		flags;
+#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 0)
+#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 1)
+	__u8		size;
+	__u64		nr_pages;
+	__u32		pasid;
+	__u64		addr;
+};
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

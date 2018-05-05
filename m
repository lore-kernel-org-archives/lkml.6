Return-Path: <jsnitsel@redhat.com>
X-Google-Smtp-Source: AB8JxZp6+suIZ3sIuyuwi1sgbHXK2ojULHUHGZvK3WK6g/WBW9aGdGr9KRk0Rh7yBQnphtH8oOhc
ARC-Seal: i=1; a=rsa-sha256; t=1525558788; cv=none;
        d=google.com; s=arc-20160816;
        b=MAB7lbi9qv14k1aumlS0dBq3Q3EkEZHxxP6csp+yw+Ae4U+gRR38esJvy1OZhE0Fr7
         zBwUAa5O/ZnS0bZDFcZgnHipdRy9NrX8QEsDcHsW0fjpA5PwPZdFA9ZwXaA7B8cOmR/a
         G5/9ojNveH1icmvXDGBCHWCUwqCql4YiVAOcrurK+o3PFgCgd+JDoumDjFECZM58E9ub
         s5DsQjJeBaAmtEQwwOMV+6DYCeP7nGhLv/jBMCgPp4dznwPrXWtz47RGxhHcaDCD+0eK
         z3I8c6bzZ/X2aJK6RS8pmn+WL6YfHILvS6I3TWLoOgKCxC2N3pw0xRX577rA8VtaaPs2
         n15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=1AG4U7GtKaacDNSJyEcsjRW+XfjwnnkXFDucNr6q4dY=;
        b=Lmu/mpXf/M1+746olqmCU1vWop5xwzbgkUYBnCi/ivYSh3zxr1BwTiaLEJx13ldRE6
         gE2/4/UMNNDsMrqyWiG0wH07lrNsq8CqLAqoLQqE1YceiYf08Rtvgb9mUh7iCEz1Onz4
         O8hrU81NkgGn0XbQbs5AqjHR5HEB5ZL3nzFjt1cUSEPeNxpBVu3M6B1Am86W+5HL6K3m
         5+Fe0XT/bRNVPfMmjbfl9fmJXx2+Sfyio/h8RuWIDQPce87lPfOhFXgTipiilImz4O/c
         6E0qclbd0aTCnR+mM3foKULG6u/hRiYImNQaSJsn+EF+VKDHSaQ+RLSmREDY+ygwJ5rm
         r7mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jsnitsel@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jsnitsel@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jsnitsel@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jsnitsel@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Sat, 5 May 2018 15:19:43 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	"Liu, Yi L" <yi.l.liu@linux.intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Message-ID: <20180505221943.iy724cn4ltmycv5i@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	"Liu, Yi L" <yi.l.liu@linux.intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599664332712482797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon Apr 16 18, Jacob Pan wrote:
>From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
>
>When an SVM capable device is assigned to a guest, the first level page
>tables are owned by the guest and the guest PASID table pointer is
>linked to the device context entry of the physical IOMMU.
>
>Host IOMMU driver has no knowledge of caching structure updates unless
>the guest invalidation activities are passed down to the host. The
>primary usage is derived from emulated IOMMU in the guest, where QEMU
>can trap invalidation activities before passing them down to the
>host/physical IOMMU.
>Since the invalidation data are obtained from user space and will be
>written into physical IOMMU, we must allow security check at various
>layers. Therefore, generic invalidation data format are proposed here,
>model specific IOMMU drivers need to convert them into their own format.
>
>Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>---
> drivers/iommu/iommu.c      | 14 ++++++++
> include/linux/iommu.h      | 12 +++++++
> include/uapi/linux/iommu.h | 79 ++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 105 insertions(+)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 3a69620..784e019 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -1344,6 +1344,20 @@ void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> }
> EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
>
>+int iommu_sva_invalidate(struct iommu_domain *domain,
>+		struct device *dev, struct tlb_invalidate_info *inv_info)
>+{
>+	int ret = 0;
>+
>+	if (unlikely(!domain->ops->sva_invalidate))
>+		return -ENODEV;
>+
>+	ret = domain->ops->sva_invalidate(domain, dev, inv_info);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
>+
> static void __iommu_detach_device(struct iommu_domain *domain,
> 				  struct device *dev)
> {
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index 8ad111f..e963dbd 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -190,6 +190,7 @@ struct iommu_resv_region {
>  * @pgsize_bitmap: bitmap of all possible supported page sizes
>  * @bind_pasid_table: bind pasid table pointer for guest SVM
>  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
>+ * @sva_invalidate: invalidate translation caches of shared virtual address
>  */
> struct iommu_ops {
> 	bool (*capable)(enum iommu_cap);
>@@ -243,6 +244,8 @@ struct iommu_ops {
> 				struct pasid_table_config *pasidt_binfo);
> 	void (*unbind_pasid_table)(struct iommu_domain *domain,
> 				struct device *dev);
>+	int (*sva_invalidate)(struct iommu_domain *domain,
>+		struct device *dev, struct tlb_invalidate_info *inv_info);
>
> 	unsigned long pgsize_bitmap;
> };
>@@ -309,6 +312,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> 		struct device *dev, struct pasid_table_config *pasidt_binfo);
> extern void iommu_unbind_pasid_table(struct iommu_domain *domain,
> 				struct device *dev);
>+extern int iommu_sva_invalidate(struct iommu_domain *domain,
>+		struct device *dev, struct tlb_invalidate_info *inv_info);
>+
> extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> 		     phys_addr_t paddr, size_t size, int prot);
>@@ -720,6 +726,12 @@ void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> {
> }
>
>+static inline int iommu_sva_invalidate(struct iommu_domain *domain,
>+		struct device *dev, struct tlb_invalidate_info *inv_info)
>+{
>+	return -EINVAL;
>+}
>+

Would -ENODEV make more sense here?

> #endif /* CONFIG_IOMMU_API */
>
> #endif /* __LINUX_IOMMU_H */
>diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>index 9f7a6bf..4447943 100644
>--- a/include/uapi/linux/iommu.h
>+++ b/include/uapi/linux/iommu.h
>@@ -29,4 +29,83 @@ struct pasid_table_config {
> 	__u8 pasid_bits;
> };
>
>+/**
>+ * enum iommu_inv_granularity - Generic invalidation granularity
>+ *
>+ * When an invalidation request is sent to IOMMU to flush translation caches,
>+ * it may carry different granularity. These granularity levels are not specific
>+ * to a type of translation cache. For an example, PASID selective granularity
>+ * is only applicable to PASID cache invalidation.
>+ * This enum is a collection of granularities for all types of translation
>+ * caches. The idea is to make it easy for IOMMU model specific driver do
>+ * conversion from generic to model specific value.
>+ */
>+enum iommu_inv_granularity {
>+	IOMMU_INV_GRANU_DOMAIN = 1,	/* all TLBs associated with a domain */
>+	IOMMU_INV_GRANU_DEVICE,		/* caching structure associated with a
>+					 * device ID
>+					 */
>+	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* address range with a domain */
>+	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given PASID */
>+	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate specified PASID */
>+
>+	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within all PASIDs */
>+	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a PASIDs */
>+	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective within a PASID */
>+	IOMMU_INV_NR_GRANU,
>+};
>+
>+/** enum iommu_inv_type - Generic translation cache types for invalidation
>+ *
>+ * Invalidation requests sent to IOMMU may indicate which translation cache
>+ * to be operated on.
>+ * Combined with enum iommu_inv_granularity, model specific driver can do a
>+ * simple lookup to convert generic type to model specific value.
>+ */
>+enum iommu_inv_type {
>+	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
>+	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache */
>+	IOMMU_INV_TYPE_PASID,	/* PASID cache */
>+	IOMMU_INV_TYPE_CONTEXT,	/* device context entry cache */
>+	IOMMU_INV_NR_TYPE
>+};
>+
>+/**
>+ * Translation cache invalidation header that contains mandatory meta data.
>+ * @version:	info format version, expecting future extesions
>+ * @type:	type of translation cache to be invalidated
>+ */
>+struct tlb_invalidate_hdr {
>+	__u32 version;
>+#define TLB_INV_HDR_VERSION_1 1
>+	enum iommu_inv_type type;
>+};
>+
>+/**
>+ * Translation cache invalidation information, contains generic IOMMU
>+ * data which can be parsed based on model ID by model specific drivers.
>+ *
>+ * @granularity:	requested invalidation granularity, type dependent
>+ * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
>+ * @pasid:		processor address space ID value per PCI spec.
>+ * @addr:		page address to be invalidated
>+ * @flags	IOMMU_INVALIDATE_PASID_TAGGED: DMA with PASID tagged,
>+ *						@pasid validity can be
>+ *						deduced from @granularity
>+ *		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
>+ *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
>+ *
>+ */
>+struct tlb_invalidate_info {
>+	struct tlb_invalidate_hdr	hdr;
>+	enum iommu_inv_granularity	granularity;
>+	__u32		flags;
>+#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
>+#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 1)
>+#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 2)
>+#define IOMMU_INVALIDATE_PASID_TAGGED	(1 << 3)
>+	__u8		size;
>+	__u32		pasid;
>+	__u64		addr;
>+};
> #endif /* _UAPI_IOMMU_H */
>-- 
>2.7.4
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

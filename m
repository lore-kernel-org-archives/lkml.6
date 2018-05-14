Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoBhrY/JL8Me/H2bjewjHdGOGBEYC1xLqS1Q6AVsgi5nF5TYkBq0seq9BRzSPjXGEuyVB3N
ARC-Seal: i=1; a=rsa-sha256; t=1526268908; cv=none;
        d=google.com; s=arc-20160816;
        b=0a05X9AmqVGsqxWQVcg8vwJlUmlEBjzebe97V2iJSw8N3DNw9OUbXL97eRFFswBtGv
         iArBOZYQL4bWzEGVkmFIjg3TTEPwE7EjTMxH07jM7JGvcpMv9knGRVCjHLgLI2f83E/8
         A1WHKrd068MD7WyB7nxRe5cgo4LIYBhjohMbncWxVM1pfgjn02k6fq8HKrj/oEblAlWe
         4qOj9GNif9pj2TmnAVcoOQ+jSFmv4/xz7BDj3mLW//MfYjEUEWaIvyDNbArodIW5R2i8
         4XCXrdKFjAoQnu4vu7mVo1Hcd9DTo9G6er37ITVaJGoNvna6eZRZCIVkVqCAwKHkqzzB
         2uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=rh3eNJD3P9kDPmu8Rf7xTsJLlNA+AevdBc1Dn+oh9hc=;
        b=BQi+v0hT3mgyw0qliHCzl7tvGg6g4Kzf3etVZQI6ZAl5vdp9nH2ZIVwy/hpfDpVxOV
         xydRPl44o4sOaoq9lERSUT1Pws7FJjQj0P4koklVZcc/ZT9oL7NFyO6AsvS4+t0m5UQp
         teHiz5xpqST8WaGuwsxhytTMa7oT8wgmXHZyzZivon+6CeSrdjQ0eiqReh0vPLF8Jm9Z
         R3RiYPdVrX1r1jT6Ya99MxAEutaLEZFKHa3JsZdqFtg+R3KQg7lNFG+B4Tc0SgdON6r6
         M/IYyNzUvWI87ru/0sY2LwDQkkiac0jBSlEBR5aljGjyAylHPerBvtYh4zgLVWHVGqwa
         2Bqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="45898845"
Subject: Re: [PATCH v5 09/23] iommu/vt-d: add svm/sva invalidate function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-10-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF903E9.6070408@linux.intel.com>
Date: Mon, 14 May 2018 11:35:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362454788780?=
X-GMAIL-MSGID: =?utf-8?q?1600408946842269769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
>
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
>
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.
>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 732a10f..684bd98 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4973,6 +4973,134 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
>  	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
>  }
>  
> +/*
> + * 2D array for converting and sanitizing IOMMU generic TLB granularity to
> + * VT-d granularity. Invalidation is typically included in the unmap operation
> + * as a result of DMA or VFIO unmap. However, for assigned device where guest
> + * could own the first level page tables without being shadowed by QEMU. In
> + * this case there is no pass down unmap to the host IOMMU as a result of unmap
> + * in the guest. Only invalidations are trapped and passed down.
> + * In all cases, only first level TLB invalidation (request with PASID) can be
> + * passed down, therefore we do not include IOTLB granularity for request
> + * without PASID (second level).
> + *
> + * For an example, to find the VT-d granularity encoding for IOTLB
> + * type and page selective granularity within PASID:
> + * X: indexed by enum iommu_inv_type
> + * Y: indexed by enum iommu_inv_granularity
> + * [IOMMU_INV_TYPE_TLB][IOMMU_INV_GRANU_PAGE_PASID]
> + *
> + * Granu_map array indicates validity of the table. 1: valid, 0: invalid
> + *
> + */
> +const static int inv_type_granu_map[IOMMU_INV_NR_TYPE][IOMMU_INV_NR_GRANU] = {
> +	/* Extended dev TLBs */
> +	{1, 1, 1},
> +	/* Extended IOTLB */
> +	{1, 1, 1},
> +	/* PASID cache */
> +	{1, 1, 0}
> +};
> +
> +const static u64 inv_type_granu_table[IOMMU_INV_NR_TYPE][IOMMU_INV_NR_GRANU] = {
> +	/* extended dev IOTLBs */
> +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> +	/* Extended IOTLB */
> +	{QI_GRAN_NONG_ALL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> +	/* PASID cache */
> +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
> +};
> +
> +static inline int to_vtd_granularity(int type, int granu, u64 *vtd_granu)
> +{
> +	if (type >= IOMMU_INV_NR_TYPE || granu >= IOMMU_INV_NR_GRANU ||
> +		!inv_type_granu_map[type][granu])

Alignment should match open parenthesis.

> +		return -EINVAL;
> +
> +	*vtd_granu = inv_type_granu_table[type][granu];
> +
> +	return 0;
> +}
> +
> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)

Ditto.

> +{
> +	struct intel_iommu *iommu;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	u16 did, sid;
> +	u8 bus, devfn;
> +	int ret = 0;
> +	u64 granu;
> +	unsigned long flags;
> +

I prefer to keep this in order.

        struct dmar_domain *dmar_domain = to_dmar_domain(domain);
        struct device_domain_info *info;
        struct intel_iommu *iommu;
        unsigned long flags;
        u8 bus, devfn;
        u16 did, sid;
        int ret = 0;
        u64 granu;

> +	if (!inv_info || !dmar_domain ||
> +		inv_info->hdr.type != TLB_INV_HDR_VERSION_1)

Ditto.

> +		return -EINVAL;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	did = dmar_domain->iommu_did[iommu->seq_id];
> +	sid = PCI_DEVID(bus, devfn);
> +	ret = to_vtd_granularity(inv_info->hdr.type, inv_info->granularity,
> +				&granu);
> +	if (ret) {
> +		pr_err("Invalid range type %d, granu %d\n", inv_info->hdr.type,
> +			inv_info->granularity);
> +		return ret;
> +	}
> +
> +	spin_lock(&iommu->lock);
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +
> +	switch (inv_info->hdr.type) {
> +	case IOMMU_INV_TYPE_TLB:
> +		if (inv_info->size &&
> +			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT + inv_info->size)) - 1))) {
> +			pr_err("Addr out of range, addr 0x%llx, size order %d\n",
> +				inv_info->addr, inv_info->size);
> +			ret = -ERANGE;
> +			goto out_unlock;
> +		}
> +
> +		qi_flush_eiotlb(iommu, did, mm_to_dma_pfn(inv_info->addr),
> +				inv_info->pasid,
> +				inv_info->size, granu,
> +				inv_info->flags & IOMMU_INVALIDATE_GLOBAL_PAGE);
> +		/**
> +		 * Always flush device IOTLB if ATS is enabled since guest
> +		 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
> +		 * down.
> +		 */
> +		info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
> +		if (info && info->ats_enabled) {
> +			qi_flush_dev_eiotlb(iommu, sid,
> +					inv_info->pasid, info->ats_qdep,
> +					inv_info->addr, inv_info->size,
> +					granu);
> +		}
> +		break;
> +	case IOMMU_INV_TYPE_PASID:
> +		qi_flush_pasid(iommu, did, granu, inv_info->pasid);
> +
> +		break;
> +	default:
> +		dev_err(dev, "Unknown IOMMU invalidation type %d\n",
> +			inv_info->hdr.type);

There are three types of invalidation:

enum iommu_inv_type {
        IOMMU_INV_TYPE_DTLB,
        IOMMU_INV_TYPE_TLB,
        IOMMU_INV_TYPE_PASID,
        IOMMU_INV_NR_TYPE
};

So "unsupported" looks better than "unknown" in the message.

> +		ret = -EINVAL;
> +	}
> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  			   unsigned long iova, phys_addr_t hpa,
>  			   size_t size, int iommu_prot)
> @@ -5401,6 +5529,7 @@ const struct iommu_ops intel_iommu_ops = {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	.bind_pasid_table	= intel_iommu_bind_pasid_table,
>  	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
> +	.sva_invalidate		= intel_iommu_sva_invalidate,
>  #endif
>  	.map			= intel_iommu_map,
>  	.unmap			= intel_iommu_unmap,

Best regards,
Lu Baolu

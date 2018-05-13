Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZps8xaUBEW24wPDEkNFmbFTm8hHWOXCDR+gXJvQpO5swh6XWrQSjbfG7KX2o1GdPGVUhvN+
ARC-Seal: i=1; a=rsa-sha256; t=1526203795; cv=none;
        d=google.com; s=arc-20160816;
        b=e6TZSyGyuiGVpP6O/JOq5aFOqYVHo1TuWI0nNS/Ar07gpUSAfQOPmxCEv6DaNnV2Vz
         O8TpclvSEMd8amV3iH06ws3CLTBV7Y/VqDyg3hGjusgLpho0tCEjGMvdxyIaUoohgezw
         YL3KN7VkKBimM06GZbywck/7wwPjEgtkzI0VKryfm+vY9sAmVJCXluY0NlzDKi/wpI4x
         0eh3/OYGIjzMpzMHCStOojZLqpmLntFfzbUXnruXXHtaJf9tV4Gt3sNKePggPhOWyr4r
         QIylzfXN/2/i9V5HMU6Ro6iFUk5mhFqYqbYSaULfA3L7YmgD1xEcP5EhWKbCxhKYqlx3
         MKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=p7HXudMq9vMMOY28Q8Wium+Q9ukN8RjrSPDTVUTAqZM=;
        b=jK1xpNdxjE6r3kQzuLKZePW61rkijHOK7dYdonfeZIgxFUvBtyYB2/8BEESiLuVujA
         58CV0isoSxggl+9orkNSLWjUv42n33ss4Cyyu0/v2+lyE/murrW6B6aaAm43P093iWnL
         XqM7xUwVyxRGuaA006iU7dPeSa786RDBfiN3qVA/Gbv9X+zzyMqEQAbzBuaygM2lmIAI
         ppkN78kInjnGj4SB4LfdLAn9YTvr0qWeTNkDcWepUs0mInyZes5mwyyUwYyJGm5x18Mn
         SWDi71OwEz4XHEpoLT6FQsBi9rU+eBOFNsymflvoX9g8cZVsBpiFvPCeicyKkjvHPY44
         44Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,395,1520924400";
   d="scan'208";a="223828748"
Subject: Re: [PATCH v5 04/23] iommu/vt-d: add bind_pasid_table function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-5-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF8058B.4090703@linux.intel.com>
Date: Sun, 13 May 2018 17:29:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361435281537?=
X-GMAIL-MSGID: =?utf-8?q?1600340670882561571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:53 AM, Jacob Pan wrote:
> Add Intel VT-d ops to the generic iommu_bind_pasid_table API
> functions.
>
> The primary use case is for direct assignment of SVM capable
> device. Originated from emulated IOMMU in the guest, the request goes
> through many layers (e.g. VFIO). Upon calling host IOMMU driver, caller
> passes guest PASID table pointer (GPA) and size.
>
> Device context table entry is modified by Intel IOMMU specific
> bind_pasid_table function. This will turn on nesting mode and matching
> translation type.
>
> The unbind operation restores default context mapping.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/intel-iommu.c   | 122 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_remapping.h |   1 +
>  2 files changed, 123 insertions(+)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a0f81a4..4623294 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2409,6 +2409,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
>  	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
>  	info->ats_qdep = 0;
> +	info->pasid_table_bound = 0;
>  	info->dev = dev;
>  	info->domain = domain;
>  	info->iommu = iommu;
> @@ -5132,6 +5133,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  #define MAX_NR_PASID_BITS (20)
> +#define MIN_NR_PASID_BITS (5)
>  static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
>  {
>  	/*
> @@ -5258,6 +5260,122 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>  
>  	return iommu;
>  }
> +
> +static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_config *pasidt_binfo)
> +{
> +	struct intel_iommu *iommu;
> +	struct context_entry *context;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev;
> +	u8 bus, devfn, host_table_pasid_bits;
> +	u16 did, sid;
> +	int ret = 0;
> +	unsigned long flags;
> +	u64 ctx_lo;

I personally prefer to have this in order.

        struct dmar_domain *dmar_domain = to_dmar_domain(domain);
        u8 bus, devfn, host_table_pasid_bits;
        struct device_domain_info *info;
        struct context_entry *context;
        struct intel_iommu *iommu;
        struct pci_dev *pdev;
        unsigned long flags;
        u16 did, sid;
        int ret = 0;
        u64 ctx_lo;

> +
> +	if ((pasidt_binfo->version != PASID_TABLE_CFG_VERSION_1) ||

Unnecessary parentheses.

> +		pasidt_binfo->bytes != sizeof(*pasidt_binfo))

Alignment should match open parenthesis.

> +		return -EINVAL;
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +	/* VT-d spec section 9.4 says pasid table size is encoded as 2^(x+5) */
> +	host_table_pasid_bits = intel_iommu_get_pts(iommu) + MIN_NR_PASID_BITS;
> +	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||

"!pasidt_binfo" checking should be moved up to the version checking.

> +		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
> +		pr_err("Invalid gPASID bits %d, host range %d - %d\n",

How about dev_err()? 

> +			pasidt_binfo->pasid_bits,
> +			MIN_NR_PASID_BITS, host_table_pasid_bits);
> +		return -ERANGE;
> +	}
> +	if (!ecap_nest(iommu->ecap)) {
> +		dev_err(dev, "Cannot bind PASID table, no nested translation\n");
> +		ret = -ENODEV;
> +		goto out;

How about
+        return -ENODEV;
?

> +	}
> +	pdev = to_pci_dev(dev);

We can't always assume that it is a PCI device, right?

> +	sid = PCI_DEVID(bus, devfn);
> +	info = dev->archdata.iommu;
> +
> +	if (!info) {
> +		dev_err(dev, "Invalid device domain info\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (info->pasid_table_bound) {

We should do this checking with lock hold.

Otherwise,

Thread A on CPUx                Thread B on CPUy
===========                ============
check pasid_table_bound    check pasid_table_bound

mutex_lock()
Setup context
pasid_table_bound = 1
mutex_unlock()

                                               mutex_lock()
                                               Setup context
                                               pasid_table_bound = 1
                                               mutex_unlock()


> +		dev_err(dev, "Device PASID table already bound\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	if (!info->pasid_enabled) {
> +		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable PASID\n");
> +			goto out;
> +		}
> +	}

I prefer a blank line here.

> +	spin_lock_irqsave(&iommu->lock, flags);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	if (!context_present(context)) {
> +		dev_err(dev, "Context not present\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/* Anticipate guest to use SVM and owns the first level, so we turn
> +	 * nested mode on
> +	 */
> +	ctx_lo = context[0].lo;
> +	ctx_lo |= CONTEXT_NESTE | CONTEXT_PRS | CONTEXT_PASIDE;
> +	ctx_lo &= ~CONTEXT_TT_MASK;
> +	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
> +	context[0].lo = ctx_lo;
> +
> +	/* Assign guest PASID table pointer and size order */
> +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);
> +	context[1].lo = ctx_lo;
> +	/* make sure context entry is updated before flushing */
> +	wmb();
> +	did = dmar_domain->iommu_did[iommu->seq_id];
> +	iommu->flush.flush_context(iommu, did,
> +				(((u16)bus) << 8) | devfn,
> +				DMA_CCMD_MASK_NOBIT,
> +				DMA_CCMD_DEVICE_INVL);
> +	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +	info->pasid_table_bound = 1;
> +out_unlock:
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +out:
> +	return ret;
> +}
> +
> +static void intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	struct intel_iommu *iommu;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	u8 bus, devfn;
> +
> +	info = dev->archdata.iommu;
> +	if (!info) {
> +		dev_err(dev, "Invalid device domain info\n");
> +		return;
> +	}
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu) {
> +		dev_err(dev, "No IOMMU for device to unbind PASID table\n");
> +		return;
> +	}
> +
> +	domain_context_clear(iommu, dev);
> +
> +	domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
> +	info->pasid_table_bound = 0;
> +}
>  #endif /* CONFIG_INTEL_IOMMU_SVM */
>  
>  const struct iommu_ops intel_iommu_ops = {
> @@ -5266,6 +5384,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.domain_free		= intel_iommu_domain_free,
>  	.attach_dev		= intel_iommu_attach_device,
>  	.detach_dev		= intel_iommu_detach_device,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.bind_pasid_table	= intel_iommu_bind_pasid_table,
> +	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
> +#endif
>  	.map			= intel_iommu_map,
>  	.unmap			= intel_iommu_unmap,
>  	.map_sg			= default_iommu_map_sg,
> diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
> index 21b3e7d..db290b2 100644
> --- a/include/linux/dma_remapping.h
> +++ b/include/linux/dma_remapping.h
> @@ -28,6 +28,7 @@
>  
>  #define CONTEXT_DINVE		(1ULL << 8)
>  #define CONTEXT_PRS		(1ULL << 9)
> +#define CONTEXT_NESTE		(1ULL << 10)
>  #define CONTEXT_PASIDE		(1ULL << 11)
>  
>  struct intel_iommu;

Best regards,
Lu Baolu

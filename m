Return-Path: <alex.williamson@redhat.com>
X-Google-Smtp-Source: AIpwx4/28F4G86EZH01Hj7tdxvfoH6PUupZvoZNtNRre85pF6Wz3IIsu4HywRM8xdyHUBYt/eIgj
ARC-Seal: i=1; a=rsa-sha256; t=1523992268; cv=none;
        d=google.com; s=arc-20160816;
        b=hhANtsj7D9JKamHnjFfdBGkH5Kqy1uHIHRnAeaZTonyUj27ALZWb5m2NxwLbMlamok
         rEUIFjaK7vMhq3Eg1Cu1ouaQVe/xl7nHl+CFW9Z6pIZwLPFDqFm4y5WM4BEKVobODkUc
         iP9oCc2srOXWQpAEDT+n65OAK8hmkz1cmrnX6RTRMha9Avnj2/APr++Sz3qdm8wXn7YJ
         pB45OPYIyrY14sss5e7r5mDPA0aLEhNA20BDsXCe/UC5F1pAs6td5BmvP6eJZAHaN2vJ
         fIwr/eSp4RVsLrsHfos+LLgpjWev0t+teLAmpEEDCf38oYBWMc2yFQslzYd7eaQtxOhN
         rboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=528SzXtl3kv6MAaZWvs1xuZm/1EvjF97Aa/Ka48AWbs=;
        b=aIfI1/KJNt09I/FZ0cufd1THb45Nx/kPdaqd1BK4vIlJ/K6VbalMnh2pKG+QW16RVv
         Zm+jh8FK2l9/T8sHbC2ZkQJ+Th/bzyaqV1Em0kcVybyv9n7WUo8uJMs+I1tejLL9qgu6
         2d7qXxC+9rx/ubEZ2rTfFXNFH//1jxnzNcjtuGWFp69mwxu8K+TaA3GnrkT8sl9kOOE3
         RXN/Z7JCs5BhRMZ5DdzmCE5zDMS2/wWaauzdYRejLGBPZc56hxtOhtPKBgGhrTPEjcqM
         v9MMfXr+2aDlx1IKZXyaTo5tF0+eVa9mJCILL1zco/Fsdd2SY5xmXybKNi6QQe5cDXY1
         h2QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alex.williamson@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=alex.williamson@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alex.williamson@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=alex.williamson@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 17 Apr 2018 13:10:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, "Christoph Hellwig" <hch@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180417131047.0a9c310f@w520.home>
In-Reply-To: <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909380631347?=
X-GMAIL-MSGID: =?utf-8?q?1598021716710880090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Mon, 16 Apr 2018 14:48:53 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

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
>  drivers/iommu/intel-iommu.c   | 119 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_remapping.h |   1 +
>  2 files changed, 120 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a0f81a4..d8058be 100644
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
> @@ -5258,6 +5260,119 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>  
>  	return iommu;
>  }
> +
> +static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_config *pasidt_binfo)
> +{

Never validates pasidt_binfo->{version,bytes}

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
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +	/* VT-d spec section 9.4 says pasid table size is encoded as 2^(x+5) */
> +	host_table_pasid_bits = intel_iommu_get_pts(iommu) + MIN_NR_PASID_BITS;
> +	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||
> +		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
> +		pr_err("Invalid gPASID bits %d, host range %d - %d\n",
> +			pasidt_binfo->pasid_bits,
> +			MIN_NR_PASID_BITS, host_table_pasid_bits);
> +		return -ERANGE;
> +	}
> +	if (!ecap_nest(iommu->ecap)) {
> +		dev_err(dev, "Cannot bind PASID table, no nested translation\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}

Gratuitous use of pr_err, some of these look user reachable, for
instance can vfio know in advance the supported widths or can the user
trigger that pr_err at will?  Some of these errno values are also maybe
not as descriptive as they could be.  For instance if the iommu doesn't
support nesting, that's not a calling argument error, that's an
unsupported device error, right?

> +	pdev = to_pci_dev(dev);
> +	sid = PCI_DEVID(bus, devfn);
> +	info = dev->archdata.iommu;
> +
> +	if (!info) {
> +		dev_err(dev, "Invalid device domain info\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (info->pasid_table_bound) {
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

Where does this IOMMU API interface define that base_ptr is 4K
aligned or the format of the PASID table?  Are these all standardized
or do they vary by host IOMMU?  If they're standards, maybe we could
note that and the spec which defines them when we declare base_ptr.  If
they're IOMMU specific then I don't understand how we'll match a user
provided PASID table to the requirements and format of the host IOMMU.
Thanks,

Alex

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
> @@ -5266,6 +5381,10 @@ const struct iommu_ops intel_iommu_ops = {
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

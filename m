Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BBFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DFE2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAGUDK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:03:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:52466 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfAGUDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:03:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 12:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124951738"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 12:03:09 -0800
Date:   Mon, 7 Jan 2019 12:04:53 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     James Sewart <jamessewart@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [RFC v2] iommu/vt-d: Allow iommu_domain_alloc to allocate
 IOMMU_DOMAIN_DMA
Message-ID: <20190107120453.7bbaa4b2@jacob-builder>
In-Reply-To: <E1FC52F0-B31C-4FB5-9C57-C72E5F4BCBCE@arista.com>
References: <E1FC52F0-B31C-4FB5-9C57-C72E5F4BCBCE@arista.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 17:19:35 +0000
James Sewart <jamessewart@arista.com> wrote:

> Hey,
> 
> There exists an issue in the logic used to determine domain
> association with devices. Currently the driver uses
> find_or_alloc_domain to either reuse an existing domain or allocate a
> new one if one isn’t found. Domains should be shared between all
> members of an IOMMU group as this is the minimum granularity that we
> can guarantee address space isolation.
> 
> The intel IOMMU driver exposes pci_device_group in intel_iommu_ops as
> the function to call to determine the group of a device, this is
> implemented in the generic IOMMU code and checks: dma aliases,
> upstream pcie switch ACS, pci aliases, and pci function aliases. The
> find_or_alloc_domain code currently only uses dma aliases to
> determine if a domain is shared. This causes a disconnect between
> IOMMU groups and domains. We have observed devices under a pcie
> switch each having their own domain but assigned the same group.
> 
> One solution would be to fix the logic in find_or_alloc_domain to add 
> checks for the other conditions that a device may share a domain.
> However, this duplicates code which the generic IOMMU code
> implements. Instead this issue can be fixed by allowing the
> allocation of default_domain on the IOMMU group. This is not
> currently supported as the intel driver does not allow allocation of
> domain type IOMMU_DOMAIN_DMA.
> 
> Allowing allocation of DMA domains has the effect that the
> default_domain is non NULL and is attached to a device when
> initialising. This delegates the handling of domains to the generic
> IOMMU code. Once this is implemented it is possible to remove the
> lazy allocation of domains entirely.
> 
This can also consolidate the domain storage, i.e. move domain from
device_domain_info to iommu_group.
> This patch implements DMA and identity domains to be allocated for 
> external management. As it isn’t known which device will be attached
> to a domain, the dma domain is not initialised at alloc time. Instead
> it is allocated when attached. As we may lose RMRR mappings when
> attaching a device to a new domain, we also ensure these are mapped
> at attach time.
> 
> This will likely conflict with the work done for auxiliary domains by 
> Baolu but the code to accommodate won’t change much.
> 
> I had also started on a patch to remove find_or_alloc_domain and
> various functions that call it but had issues with edge cases such as 
> iommu_prepare_isa that is doing domain operations at IOMMU init time.
> 
> Cheers,
> James.
> 
> 
> ---
>  drivers/iommu/intel-iommu.c | 159
> +++++++++++++++++++++++++----------- 1 file changed, 110
> insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 41a4b8808802..6437cb2e9b22 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -351,6 +351,14 @@ static int hw_pass_through = 1;
>  /* si_domain contains mulitple devices */
>  #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
>  
> +/* Domain managed externally, don't cleanup if it isn't attached
> + * to any devices. */
> +#define DOMAIN_FLAG_NO_CLEANUP	(1 << 2)
> +
the name NO_CLEANUP is a little counter intuitive to me, should it be
called UNINITIALISED?
> +/* Set after domain initialisation. Used when allocating dma domains
> to
> + * defer domain initialisation until it is attached to a device */
> +#define DOMAIN_FLAG_INITIALISED	(1 << 4)
> +
>  #define for_each_domain_iommu(idx, domain)			\
>  	for (idx = 0; idx < g_num_of_iommus; idx++)		\
>  		if (domain->iommu_refcnt[idx])
> @@ -624,6 +632,16 @@ static inline int domain_type_is_vm_or_si(struct
> dmar_domain *domain) DOMAIN_FLAG_STATIC_IDENTITY);
>  }
>  
> +static inline int domain_managed_externally(struct dmar_domain
> *domain) +{
> +	return domain->flags & DOMAIN_FLAG_NO_CLEANUP;
> +}
> +
> +static inline int domain_is_initialised(struct dmar_domain *domain)
> +{
> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
> +}
> +
>  static inline int domain_pfn_supported(struct dmar_domain *domain,
>  				       unsigned long pfn)
>  {
> @@ -1717,7 +1735,7 @@ static void disable_dmar_iommu(struct
> intel_iommu *iommu) 
>  		__dmar_remove_one_dev_info(info);
>  
> -		if (!domain_type_is_vm_or_si(domain)) {
> +		if (!domain_managed_externally(domain)) {
>  			/*
>  			 * The domain_exit() function  can't be
> called under
>  			 * device_domain_lock, as it takes this lock
> itself. @@ -1951,6 +1969,7 @@ static int domain_init(struct
> dmar_domain *domain, struct intel_iommu *iommu, domain->pgd = (struct
> dma_pte *)alloc_pgtable_page(domain->nid); if (!domain->pgd)
>  		return -ENOMEM;
> +	domain->flags |= DOMAIN_FLAG_INITIALISED;
>  	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
>  	return 0;
>  }
> @@ -3234,11 +3253,9 @@ static int copy_translation_tables(struct
> intel_iommu *iommu) static int __init init_dmars(void)
>  {
>  	struct dmar_drhd_unit *drhd;
> -	struct dmar_rmrr_unit *rmrr;
>  	bool copied_tables = false;
> -	struct device *dev;
>  	struct intel_iommu *iommu;
> -	int i, ret;
> +	int ret;
>  
>  	/*
>  	 * for each drhd
> @@ -4529,7 +4522,7 @@ static int device_notifier(struct
> notifier_block *nb, return 0;
>  
>  	dmar_remove_one_dev_info(domain, dev);
> -	if (!domain_type_is_vm_or_si(domain) &&
> list_empty(&domain->devices))
> +	if (!domain_managed_externally(domain) &&
> list_empty(&domain->devices)) domain_exit(domain);
>  
>  	return 0;
> @@ -4930,6 +4923,7 @@ static int md_domain_init(struct dmar_domain
> *domain, int guest_width) domain->pgd = (struct dma_pte
> *)alloc_pgtable_page(domain->nid); if (!domain->pgd)
>  		return -ENOMEM;
> +	domain->flags |= DOMAIN_FLAG_INITIALISED;
>  	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
>  	return 0;
>  }
> @@ -4938,28 +4932,65 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type) {
>  	struct dmar_domain *dmar_domain;
>  	struct iommu_domain *domain;
> +	int flags = DOMAIN_FLAG_NO_CLEANUP;
> +	int nid;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> -
> -	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
> -	if (!dmar_domain) {
> -		pr_err("Can't allocate dmar_domain\n");
> -		return NULL;
> -	}
> -	if (md_domain_init(dmar_domain,
> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
> -		pr_err("Domain initialization failed\n");
> -		domain_exit(dmar_domain);
> +	switch (type) {
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		flags |= DOMAIN_FLAG_VIRTUAL_MACHINE |
> DOMAIN_FLAG_INITIALISED;
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");
> +			return NULL;
> +		}
> +		if (md_domain_init(dmar_domain,
> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
> +			pr_err("Domain initialization failed\n");
> +			domain_exit(dmar_domain);
> +			return NULL;
> +		}
> +		domain_update_iommu_cap(dmar_domain);
> +		domain->geometry.aperture_start = 0;
> +		domain->geometry.aperture_end   =
> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
> +		domain->geometry.force_aperture = true;
> +		break;
> +	case IOMMU_DOMAIN_DMA:
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");
> +			return NULL;
> +		}
> +		/* init domain in device attach when we know IOMMU
> capabilities */
> +		break;
> +	case IOMMU_DOMAIN_IDENTITY:
> +		flags |= DOMAIN_FLAG_STATIC_IDENTITY |
> DOMAIN_FLAG_INITIALISED;
> +		dmar_domain = alloc_domain(flags);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate dmar_domain\n");
> +			return NULL;
> +		}
> +		if (md_domain_init(dmar_domain,
> DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
> +			pr_err("Domain initialization failed\n");
> +			domain_exit(dmar_domain);
> +			return NULL;
> +		}
> +		domain_update_iommu_cap(dmar_domain);
> +		for_each_online_node(nid) {
> +			unsigned long start_pfn, end_pfn;
> +			int i, ret;
> +
> +			for_each_mem_pfn_range(i, nid, &start_pfn,
> &end_pfn, NULL) {
> +				ret =
> iommu_domain_identity_map(dmar_domain,
> +						PFN_PHYS(start_pfn),
> PFN_PHYS(end_pfn));
> +				if (ret)
> +					return NULL;
> +			}
> +		}
> +		break;
> +	default:
>  		return NULL;
>  	}
> -	domain_update_iommu_cap(dmar_domain);
> -
> -	domain = &dmar_domain->domain;
> -	domain->geometry.aperture_start = 0;
> -	domain->geometry.aperture_end   =
> __DOMAIN_MAX_ADDR(dmar_domain->gaw);
> -	domain->geometry.force_aperture = true;
>  
> -	return domain;
> +	return &dmar_domain->domain;
>  }
>  
>  static void intel_iommu_domain_free(struct iommu_domain *domain)
> @@ -4974,6 +5005,9 @@ static int intel_iommu_attach_device(struct
> iommu_domain *domain, struct intel_iommu *iommu;
>  	int addr_width;
>  	u8 bus, devfn;
> +	struct dmar_rmrr_unit *rmrr;
> +	struct device *i_dev;
> +	int i, ret;
>  
>  	if (device_is_rmrr_locked(dev)) {
>  		dev_warn(dev, "Device is ineligible for IOMMU domain
> attach due to platform RMRR requirement.  Contact your platform
> vendor.\n"); @@ -4990,8 +5024,8 @@ static int
> intel_iommu_attach_device(struct iommu_domain *domain,
> dmar_remove_one_dev_info(old_domain, dev); rcu_read_unlock(); 
> -			if (!domain_type_is_vm_or_si(old_domain) &&
> -			     list_empty(&old_domain->devices))
> +			if (list_empty(&old_domain->devices) &&
> +			     !domain_managed_externally(old_domain))
>  				domain_exit(old_domain);
If the old_domain is allocated by lazy DMA map call, the default domain
is not used in any case, right? why can't you use the default domain
for map call? I guess that is the next step?
>  		}
>  	}
> @@ -5000,6 +5034,12 @@ static int intel_iommu_attach_device(struct
> iommu_domain *domain, if (!iommu)
>  		return -ENODEV;
>  
> +	/* Initialise domain with IOMMU capabilities if it isn't
> already initialised */
> +	if (!domain_is_initialised(dmar_domain)) {
> +		if (domain_init(dmar_domain, iommu,
> DEFAULT_DOMAIN_ADDRESS_WIDTH))
> +			return -ENOMEM;
> +	}
> +
>  	/* check if this iommu agaw is sufficient for max mapped
> address */ addr_width = agaw_to_width(iommu->agaw);
>  	if (addr_width > cap_mgaw(iommu->cap))
> @@ -5028,6 +5068,27 @@ static int intel_iommu_attach_device(struct
> iommu_domain *domain, dmar_domain->agaw--;
>  	}
>  
> +	if (domain_type_is_vm_or_si(dmar_domain))
> +		goto out;
> +
> +	/* Ensure DMA domain has devices RMRR */
> +	rcu_read_lock();
> +	for_each_rmrr_units(rmrr) {
> +		for_each_active_dev_scope(rmrr->devices,
> rmrr->devices_cnt,
> +					  i, i_dev) {
> +			if (i_dev != dev)
why do we need to go through all devices, can we deduce the information
from device_domain_info? If RMRR is already mapped during init_dmar.
> +				continue;
> +
> +			ret = domain_prepare_identity_map(dev,
> dmar_domain,
> +
> rmrr->base_address,
> +
> rmrr->end_address);
> +			if (ret)
> +				dev_err(dev, "Mapping reserved
> region failed\n");
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +out:
Isn't it duplicate with the RMRR setup in init_dmars? I am guessing,
for device with RMRR, we can reuse the domain setup up during init
time, just inherit the mappings.

>  	return domain_add_dev_info(dmar_domain, dev);
>  }
>  

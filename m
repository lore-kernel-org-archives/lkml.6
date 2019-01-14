Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C354CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F120657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANM0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:26:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfANM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:26:21 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 80578E9DF404496BABA9;
        Mon, 14 Jan 2019 20:26:18 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 14 Jan 2019
 20:26:16 +0800
Date:   Mon, 14 Jan 2019 12:26:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, <kevin.tian@intel.com>,
        <ashok.raj@intel.com>, <tiwei.bie@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <sanjay.k.kumar@intel.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <Zeng@mail.linuxfoundation.org>,
        <yi.y.sun@intel.com>, <jacob.jun.pan@intel.com>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] iommu/vt-d: Aux-domain specific domain
 attach/detach
Message-ID: <20190114122603.00001450@huawei.com>
In-Reply-To: <20190110030027.31447-5-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
        <20190110030027.31447-5-baolu.lu@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 11:00:23 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> When multiple domains per device has been enabled by the
> device driver, the device will tag the default PASID for
> the domain to all DMA traffics out of the subset of this
> device; and the IOMMU should translate the DMA requests
> in PASID granularity.
> 
> This adds the intel_iommu_aux_attach/detach_device() ops
> to support managing PASID granular translation structures
> when the device driver has enabled multiple domains per
> device.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

The following is probably a rather naive review given I don't know
the driver or hardware well at all.  Still, it seems like things
are a lot less balanced than I'd expect and isn't totally obvious
to me why that is.

> ---
>  drivers/iommu/intel-iommu.c | 152 ++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  10 +++
>  2 files changed, 162 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index e9119d45a29d..b8fb6a4bd447 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2482,6 +2482,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	info->iommu = iommu;
>  	info->pasid_table = NULL;
>  	info->auxd_enabled = 0;
> +	INIT_LIST_HEAD(&info->auxiliary_domains);
>  
>  	if (dev && dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(info->dev);
> @@ -5058,6 +5059,131 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
>  	domain_exit(to_dmar_domain(domain));
>  }
>  
> +/*
> + * Check whether a @domain could be attached to the @dev through the
> + * aux-domain attach/detach APIs.
> + */
> +static inline bool
> +is_aux_domain(struct device *dev, struct iommu_domain *domain)

I'm finding the distinction between an aux domain capability on
a given device and whether one is actually in use to be obscured
slightly in the function naming.

This one for example is actually checking if we have a domain
that is capable of being enabled for aux domain use, but not
yet actually in that mode?

Mind you I'm not sure I have a better answer for the naming.
can_aux_domain_be_enabled?  is_unattached_aux_domain?



> +{
> +	struct device_domain_info *info = dev->archdata.iommu;
> +
> +	return info && info->auxd_enabled &&
> +			domain->type == IOMMU_DOMAIN_UNMANAGED;
> +}
> +
> +static void auxiliary_link_device(struct dmar_domain *domain,
> +				  struct device *dev)
> +{
> +	struct device_domain_info *info = dev->archdata.iommu;
> +
> +	assert_spin_locked(&device_domain_lock);
> +	if (WARN_ON(!info))
> +		return;
> +
> +	domain->auxd_refcnt++;
> +	list_add(&domain->auxd, &info->auxiliary_domains);
> +}
> +
> +static void auxiliary_unlink_device(struct dmar_domain *domain,
> +				    struct device *dev)
> +{
> +	struct device_domain_info *info = dev->archdata.iommu;
> +
> +	assert_spin_locked(&device_domain_lock);
> +	if (WARN_ON(!info))
> +		return;
> +
> +	list_del(&domain->auxd);
> +	domain->auxd_refcnt--;
> +
> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> +		intel_pasid_free_id(domain->default_pasid);

This seems unbalanced wrt to what is happening in auxiliary_link_device.
If this is necessary then it would be good to have comments saying why.
To my uniformed eye, looks like we could do this at the end of
aux_domain_remove_dev, except that we need to hold the lock.
As such perhaps it makes sense to do the pasid allocation under that
lock in the first place?

I'm not 100% sure, but is there a race if you get the final
remove running against a new add currently?

> +}
> +
> +static int aux_domain_add_dev(struct dmar_domain *domain,
> +			      struct device *dev)
> +{
> +	int ret;
> +	u8 bus, devfn;
> +	unsigned long flags;
> +	struct intel_iommu *iommu;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	if (domain->default_pasid <= 0) {

device_domain_lock isn't held, so we might be in process of removing, see
the pasid as set, just as it becomes unset and hence leave here without
one set?

> +		int pasid;
> +
> +		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> +					     pci_max_pasids(to_pci_dev(dev)),
> +					     GFP_KERNEL);
> +		if (pasid <= 0) {
> +			pr_err("Can't allocate default pasid\n");
> +			return -ENODEV;
> +		}
> +		domain->default_pasid = pasid;
> +	}
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	/*
> +	 * iommu->lock must be held to attach domain to iommu and setup the
> +	 * pasid entry for second level translation.
> +	 */
> +	spin_lock(&iommu->lock);
> +	ret = domain_attach_iommu(domain, iommu);
> +	if (ret)
> +		goto attach_failed;
> +
> +	/* Setup the PASID entry for mediated devices: */
> +	ret = intel_pasid_setup_second_level(iommu, domain, dev,
> +					     domain->default_pasid);
> +	if (ret)
> +		goto table_failed;
> +	spin_unlock(&iommu->lock);
> +
> +	auxiliary_link_device(domain, dev);
> +
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return 0;
> +
> +table_failed:
> +	domain_detach_iommu(domain, iommu);
> +attach_failed:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> +		intel_pasid_free_id(domain->default_pasid);

It would be odd for this to race against a remove, but in
theory it 'might' I think, potentially giving a double free.

> +
> +	return ret;
> +}
> +
> +static void aux_domain_remove_dev(struct dmar_domain *domain,
> +				  struct device *dev)
> +{
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +
> +	if (!is_aux_domain(dev, &domain->domain))
> +		return;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	info = dev->archdata.iommu;
> +	iommu = info->iommu;
> +
> +	auxiliary_unlink_device(domain, dev);
> +
> +	spin_lock(&iommu->lock);
> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
> +	domain_detach_iommu(domain, iommu);
> +	spin_unlock(&iommu->lock);
> +
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +}
> +
>  static int prepare_domain_attach_device(struct iommu_domain *domain,
>  					struct device *dev)
>  {
> @@ -5111,6 +5237,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  		return -EPERM;
>  	}
>  
> +	if (is_aux_domain(dev, domain))
> +		return -EPERM;
> +
>  	/* normally dev is not mapped */
>  	if (unlikely(domain_context_mapped(dev))) {
>  		struct dmar_domain *old_domain;
> @@ -5134,12 +5263,33 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  	return domain_add_dev_info(to_dmar_domain(domain), dev);
>  }
>  
> +static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	int ret;
> +
> +	if (!is_aux_domain(dev, domain))
> +		return -EPERM;
> +
> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	return aux_domain_add_dev(to_dmar_domain(domain), dev);
> +}
> +
>  static void intel_iommu_detach_device(struct iommu_domain *domain,
>  				      struct device *dev)
>  {
>  	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
>  }
>  
> +static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
> +					  struct device *dev)
> +{
> +	aux_domain_remove_dev(to_dmar_domain(domain), dev);
> +}
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  			   unsigned long iova, phys_addr_t hpa,
>  			   size_t size, int iommu_prot)
> @@ -5480,6 +5630,8 @@ const struct iommu_ops intel_iommu_ops = {
>  	.domain_free		= intel_iommu_domain_free,
>  	.attach_dev		= intel_iommu_attach_device,
>  	.detach_dev		= intel_iommu_detach_device,
> +	.aux_attach_dev		= intel_iommu_aux_attach_device,
> +	.aux_detach_dev		= intel_iommu_aux_detach_device,
>  	.map			= intel_iommu_map,
>  	.unmap			= intel_iommu_unmap,
>  	.iova_to_phys		= intel_iommu_iova_to_phys,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 7cf9f7f3724a..b563a61a6c39 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -492,9 +492,11 @@ struct dmar_domain {
>  					/* Domain ids per IOMMU. Use u16 since
>  					 * domain ids are 16 bit wide according
>  					 * to VT-d spec, section 9.3 */
> +	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
>  
>  	bool has_iotlb_device;
>  	struct list_head devices;	/* all devices' list */
> +	struct list_head auxd;		/* link to device's auxiliary list */
>  	struct iova_domain iovad;	/* iova's that belong to this domain */
>  
>  	struct dma_pte	*pgd;		/* virtual address */
> @@ -513,6 +515,11 @@ struct dmar_domain {
>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
>  
> +	int		default_pasid;	/*
> +					 * The default pasid used for non-SVM
> +					 * traffic on mediated devices.
> +					 */
> +
>  	struct iommu_domain domain;	/* generic domain data structure for
>  					   iommu core */
>  };
> @@ -562,6 +569,9 @@ struct device_domain_info {
>  	struct list_head link;	/* link to domain siblings */
>  	struct list_head global; /* link to global list */
>  	struct list_head table;	/* link to pasid table */
> +	struct list_head auxiliary_domains; /* auxiliary domains
> +					     * attached to this device
> +					     */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
>  	u16 pfsid;		/* SRIOV physical function source ID */



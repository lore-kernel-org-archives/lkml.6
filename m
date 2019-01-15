Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF30720659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAOCOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:14:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:44105 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAOCOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:14:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="106624765"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2019 18:14:34 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Zeng@mail.linuxfoundation.org,
        yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] iommu/vt-d: Aux-domain specific domain
 attach/detach
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
 <20190110030027.31447-5-baolu.lu@linux.intel.com>
 <20190114122603.00001450@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cf37ed74-81ea-9708-8d99-5bc3b64b1f23@linux.intel.com>
Date:   Tue, 15 Jan 2019 10:10:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114122603.00001450@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/19 8:26 PM, Jonathan Cameron wrote:
> On Thu, 10 Jan 2019 11:00:23 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> When multiple domains per device has been enabled by the
>> device driver, the device will tag the default PASID for
>> the domain to all DMA traffics out of the subset of this
>> device; and the IOMMU should translate the DMA requests
>> in PASID granularity.
>>
>> This adds the intel_iommu_aux_attach/detach_device() ops
>> to support managing PASID granular translation structures
>> when the device driver has enabled multiple domains per
>> device.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> The following is probably a rather naive review given I don't know
> the driver or hardware well at all.  Still, it seems like things
> are a lot less balanced than I'd expect and isn't totally obvious
> to me why that is.

Thank you!

> 
>> ---
>>   drivers/iommu/intel-iommu.c | 152 ++++++++++++++++++++++++++++++++++++
>>   include/linux/intel-iommu.h |  10 +++
>>   2 files changed, 162 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index e9119d45a29d..b8fb6a4bd447 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2482,6 +2482,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>   	info->iommu = iommu;
>>   	info->pasid_table = NULL;
>>   	info->auxd_enabled = 0;
>> +	INIT_LIST_HEAD(&info->auxiliary_domains);
>>   
>>   	if (dev && dev_is_pci(dev)) {
>>   		struct pci_dev *pdev = to_pci_dev(info->dev);
>> @@ -5058,6 +5059,131 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
>>   	domain_exit(to_dmar_domain(domain));
>>   }
>>   
>> +/*
>> + * Check whether a @domain could be attached to the @dev through the
>> + * aux-domain attach/detach APIs.
>> + */
>> +static inline bool
>> +is_aux_domain(struct device *dev, struct iommu_domain *domain)
> 
> I'm finding the distinction between an aux domain capability on
> a given device and whether one is actually in use to be obscured
> slightly in the function naming.
> 
> This one for example is actually checking if we have a domain
> that is capable of being enabled for aux domain use, but not
> yet actually in that mode?
> 
> Mind you I'm not sure I have a better answer for the naming.
> can_aux_domain_be_enabled?  is_unattached_aux_domain?
> 
> 

device aux mode vs. normal mode
===============================

When we talk about the auxiliary mode (simply aux-mode), it means "the
device works in aux-mode or normal mode". "normal mode" means that the
device (and it's corresponding IOMMU) supports only RID (PCI Request ID)
based DMA translation; while, aux-mode means the the device (and it's
IOMMU) supports fine-grained DMA translation, like PASID based DMA
translation with Intel VT-d scalable mode.

We are adding below APIs to switch a device between these two modes:

int iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)

And this API (still under discussion) to check which mode the device is
working in:

bool iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)

aux-domain
==========

If a device is working in aux-mode and we are going to attach a domain
to this device, we say "this domain will be attached to the device in
aux mode", and simply "aux domain". So a domain is "normal" when it is
going to attach to a device in normal mode; and is "aux-domain" when it
is going to attach to a device in aux mode.

> 
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	return info && info->auxd_enabled &&
>> +			domain->type == IOMMU_DOMAIN_UNMANAGED;
>> +}
>> +
>> +static void auxiliary_link_device(struct dmar_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +	if (WARN_ON(!info))
>> +		return;
>> +
>> +	domain->auxd_refcnt++;
>> +	list_add(&domain->auxd, &info->auxiliary_domains);
>> +}
>> +
>> +static void auxiliary_unlink_device(struct dmar_domain *domain,
>> +				    struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +	if (WARN_ON(!info))
>> +		return;
>> +
>> +	list_del(&domain->auxd);
>> +	domain->auxd_refcnt--;
>> +
>> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>> +		intel_pasid_free_id(domain->default_pasid);
> 
> This seems unbalanced wrt to what is happening in auxiliary_link_device.
> If this is necessary then it would be good to have comments saying why.
> To my uniformed eye, looks like we could do this at the end of
> aux_domain_remove_dev, except that we need to hold the lock.
> As such perhaps it makes sense to do the pasid allocation under that
> lock in the first place?
> 
> I'm not 100% sure, but is there a race if you get the final
> remove running against a new add currently?

Yes. This is unbalanced.

I will move pasid free out here and it should be done with the lock
held to avoid race.

> 
>> +}
>> +
>> +static int aux_domain_add_dev(struct dmar_domain *domain,
>> +			      struct device *dev)
>> +{
>> +	int ret;
>> +	u8 bus, devfn;
>> +	unsigned long flags;
>> +	struct intel_iommu *iommu;
>> +
>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>> +	if (!iommu)
>> +		return -ENODEV;
>> +
>> +	if (domain->default_pasid <= 0) {
> 
> device_domain_lock isn't held, so we might be in process of removing, see
> the pasid as set, just as it becomes unset and hence leave here without
> one set?

Good catch, the lock should be held.

> 
>> +		int pasid;
>> +
>> +		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>> +					     pci_max_pasids(to_pci_dev(dev)),
>> +					     GFP_KERNEL);
>> +		if (pasid <= 0) {
>> +			pr_err("Can't allocate default pasid\n");
>> +			return -ENODEV;
>> +		}
>> +		domain->default_pasid = pasid;
>> +	}
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	/*
>> +	 * iommu->lock must be held to attach domain to iommu and setup the
>> +	 * pasid entry for second level translation.
>> +	 */
>> +	spin_lock(&iommu->lock);
>> +	ret = domain_attach_iommu(domain, iommu);
>> +	if (ret)
>> +		goto attach_failed;
>> +
>> +	/* Setup the PASID entry for mediated devices: */
>> +	ret = intel_pasid_setup_second_level(iommu, domain, dev,
>> +					     domain->default_pasid);
>> +	if (ret)
>> +		goto table_failed;
>> +	spin_unlock(&iommu->lock);
>> +
>> +	auxiliary_link_device(domain, dev);
>> +
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return 0;
>> +
>> +table_failed:
>> +	domain_detach_iommu(domain, iommu);
>> +attach_failed:
>> +	spin_unlock(&iommu->lock);
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>> +		intel_pasid_free_id(domain->default_pasid);
> 
> It would be odd for this to race against a remove, but in
> theory it 'might' I think, potentially giving a double free.

Yes. Should be done with the lock held.

Best regards,
Lu Baolu

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static void aux_domain_remove_dev(struct dmar_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +	struct intel_iommu *iommu;
>> +	unsigned long flags;
>> +
>> +	if (!is_aux_domain(dev, &domain->domain))
>> +		return;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	info = dev->archdata.iommu;
>> +	iommu = info->iommu;
>> +
>> +	auxiliary_unlink_device(domain, dev);
>> +
>> +	spin_lock(&iommu->lock);
>> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
>> +	domain_detach_iommu(domain, iommu);
>> +	spin_unlock(&iommu->lock);
>> +
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +}
>> +
>>   static int prepare_domain_attach_device(struct iommu_domain *domain,
>>   					struct device *dev)
>>   {
>> @@ -5111,6 +5237,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>   		return -EPERM;
>>   	}
>>   
>> +	if (is_aux_domain(dev, domain))
>> +		return -EPERM;
>> +
>>   	/* normally dev is not mapped */
>>   	if (unlikely(domain_context_mapped(dev))) {
>>   		struct dmar_domain *old_domain;
>> @@ -5134,12 +5263,33 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>   	return domain_add_dev_info(to_dmar_domain(domain), dev);
>>   }
>>   
>> +static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
>> +					 struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	if (!is_aux_domain(dev, domain))
>> +		return -EPERM;
>> +
>> +	ret = prepare_domain_attach_device(domain, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return aux_domain_add_dev(to_dmar_domain(domain), dev);
>> +}
>> +
>>   static void intel_iommu_detach_device(struct iommu_domain *domain,
>>   				      struct device *dev)
>>   {
>>   	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
>>   }
>>   
>> +static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>> +					  struct device *dev)
>> +{
>> +	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>> +}
>> +
>>   static int intel_iommu_map(struct iommu_domain *domain,
>>   			   unsigned long iova, phys_addr_t hpa,
>>   			   size_t size, int iommu_prot)
>> @@ -5480,6 +5630,8 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.domain_free		= intel_iommu_domain_free,
>>   	.attach_dev		= intel_iommu_attach_device,
>>   	.detach_dev		= intel_iommu_detach_device,
>> +	.aux_attach_dev		= intel_iommu_aux_attach_device,
>> +	.aux_detach_dev		= intel_iommu_aux_detach_device,
>>   	.map			= intel_iommu_map,
>>   	.unmap			= intel_iommu_unmap,
>>   	.iova_to_phys		= intel_iommu_iova_to_phys,
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 7cf9f7f3724a..b563a61a6c39 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -492,9 +492,11 @@ struct dmar_domain {
>>   					/* Domain ids per IOMMU. Use u16 since
>>   					 * domain ids are 16 bit wide according
>>   					 * to VT-d spec, section 9.3 */
>> +	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
>>   
>>   	bool has_iotlb_device;
>>   	struct list_head devices;	/* all devices' list */
>> +	struct list_head auxd;		/* link to device's auxiliary list */
>>   	struct iova_domain iovad;	/* iova's that belong to this domain */
>>   
>>   	struct dma_pte	*pgd;		/* virtual address */
>> @@ -513,6 +515,11 @@ struct dmar_domain {
>>   					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>>   	u64		max_addr;	/* maximum mapped address */
>>   
>> +	int		default_pasid;	/*
>> +					 * The default pasid used for non-SVM
>> +					 * traffic on mediated devices.
>> +					 */
>> +
>>   	struct iommu_domain domain;	/* generic domain data structure for
>>   					   iommu core */
>>   };
>> @@ -562,6 +569,9 @@ struct device_domain_info {
>>   	struct list_head link;	/* link to domain siblings */
>>   	struct list_head global; /* link to global list */
>>   	struct list_head table;	/* link to pasid table */
>> +	struct list_head auxiliary_domains; /* auxiliary domains
>> +					     * attached to this device
>> +					     */
>>   	u8 bus;			/* PCI bus number */
>>   	u8 devfn;		/* PCI devfn number */
>>   	u16 pfsid;		/* SRIOV physical function source ID */
> 
> 
> 

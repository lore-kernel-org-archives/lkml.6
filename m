Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9952AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C247207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C247207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJYDN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbeJYDN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69BDB3097031;
        Wed, 24 Oct 2018 18:44:15 +0000 (UTC)
Received: from [10.36.116.114] (ovpn-116-114.ams2.redhat.com [10.36.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F044608EC;
        Wed, 24 Oct 2018 18:44:06 +0000 (UTC)
Subject: Re: [RFC v2 12/20] dma-iommu: Implement NESTED_MSI cookie
To:     Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
References: <20180918142457.3325-1-eric.auger@redhat.com>
 <20180918142457.3325-13-eric.auger@redhat.com>
 <bd90bf0e-1bf6-244b-0ed6-0018ddc25eb4@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <167b1683-9dfe-d471-da2e-37bf53278007@redhat.com>
Date:   Wed, 24 Oct 2018 20:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bd90bf0e-1bf6-244b-0ed6-0018ddc25eb4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Oct 2018 18:44:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 10/24/18 8:02 PM, Robin Murphy wrote:
> Hi Eric,
> 
> On 2018-09-18 3:24 pm, Eric Auger wrote:
>> Up to now, when the type was UNMANAGED, we used to
>> allocate IOVA pages within a range provided by the user.
>> This does not work in nested mode.
>>
>> If both the host and the guest are exposed with SMMUs, each
>> would allocate an IOVA. The guest allocates an IOVA (gIOVA)
>> to map onto the guest MSI doorbell (gDB). The Host allocates
>> another IOVA (hIOVA) to map onto the physical doorbell (hDB).
>>
>> So we end up with 2 unrelated mappings, at S1 and S2:
>>           S1             S2
>> gIOVA    ->     gDB
>>                 hIOVA    ->    hDB
>>
>> The PCI device would be programmed with hIOVA.
>>
>> iommu_dma_bind_doorbell allows to pass gIOVA/gDB to the host
>> so that gIOVA can be used by the host instead of re-allocating
>> a new IOVA. That way the host can create the following nested
>> mapping:
>>
>>           S1           S2
>> gIOVA    ->    gDB    ->    hDB
>>
>> this time, the PCI device will be programmed with the gIOVA MSI
>> doorbell which is correctly map through the 2 stages.
> 
> If I'm understanding things correctly, this plus a couple of the
> preceding patches all add up to a rather involved way of coercing an
> automatic allocator to only "allocate" predetermined addresses in an
> entirely known-ahead-of-time manner.
agreed
 Given that the guy calling
> iommu_dma_bind_doorbell() could seemingly just as easily call
> iommu_map() at that point and not bother with an allocator cookie and
> all this machinery at all, what am I missing?
Well iommu_dma_map_msi_msg() gets called and is part of this existing
MSI mapping machinery. If we do not do anything this function allocates
an hIOVA that is not involved in any nested setup. So either we coerce
the allocator in place (which is what this series does) or we unplug the
allocator to replace this latter with a simple S2 mapping, as you
suggest, ie. iommu_map(gDB, hDB). Assuming we unplug the allocator, the
guy who actually calls  iommu_dma_bind_doorbell() knows gDB but does not
know hDB. So I don't really get how we can simplify things.

Thanks

Eric

> 
> Robin.
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - unmap stage2 on put()
>> ---
>>   drivers/iommu/dma-iommu.c | 97 +++++++++++++++++++++++++++++++++++++--
>>   include/linux/dma-iommu.h | 11 +++++
>>   2 files changed, 105 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 511ff9a1d6d9..53444c3e8f2f 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -37,12 +37,14 @@
>>   struct iommu_dma_msi_page {
>>       struct list_head    list;
>>       dma_addr_t        iova;
>> +    dma_addr_t        ipa;
>>       phys_addr_t        phys;
>>   };
>>     enum iommu_dma_cookie_type {
>>       IOMMU_DMA_IOVA_COOKIE,
>>       IOMMU_DMA_MSI_COOKIE,
>> +    IOMMU_DMA_NESTED_MSI_COOKIE,
>>   };
>>     struct iommu_dma_cookie {
>> @@ -109,14 +111,17 @@ EXPORT_SYMBOL(iommu_get_dma_cookie);
>>    *
>>    * Users who manage their own IOVA allocation and do not want DMA
>> API support,
>>    * but would still like to take advantage of automatic MSI
>> remapping, can use
>> - * this to initialise their own domain appropriately. Users should
>> reserve a
>> + * this to initialise their own domain appropriately. Users may
>> reserve a
>>    * contiguous IOVA region, starting at @base, large enough to
>> accommodate the
>>    * number of PAGE_SIZE mappings necessary to cover every MSI
>> doorbell address
>> - * used by the devices attached to @domain.
>> + * used by the devices attached to @domain. The other way round is to
>> provide
>> + * usable iova pages through the iommu_dma_bind_doorbell API (nested
>> stages
>> + * use case)
>>    */
>>   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>>   {
>>       struct iommu_dma_cookie *cookie;
>> +    int nesting, ret;
>>         if (domain->type != IOMMU_DOMAIN_UNMANAGED)
>>           return -EINVAL;
>> @@ -124,7 +129,12 @@ int iommu_get_msi_cookie(struct iommu_domain
>> *domain, dma_addr_t base)
>>       if (domain->iova_cookie)
>>           return -EEXIST;
>>   -    cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
>> +    ret =  iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &nesting);
>> +    if (!ret && nesting)
>> +        cookie = cookie_alloc(IOMMU_DMA_NESTED_MSI_COOKIE);
>> +    else
>> +        cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
>> +
>>       if (!cookie)
>>           return -ENOMEM;
>>   @@ -145,6 +155,7 @@ void iommu_put_dma_cookie(struct iommu_domain
>> *domain)
>>   {
>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>       struct iommu_dma_msi_page *msi, *tmp;
>> +    bool s2_unmap = false;
>>         if (!cookie)
>>           return;
>> @@ -152,7 +163,15 @@ void iommu_put_dma_cookie(struct iommu_domain
>> *domain)
>>       if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
>>           put_iova_domain(&cookie->iovad);
>>   +    if (cookie->type == IOMMU_DMA_NESTED_MSI_COOKIE)
>> +        s2_unmap = true;
>> +
>>       list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
>> +        if (s2_unmap && msi->phys) {
>> +            size_t size = cookie_msi_granule(cookie);
>> +
>> +            WARN_ON(iommu_unmap(domain, msi->ipa, size) != size);
>> +        }
>>           list_del(&msi->list);
>>           kfree(msi);
>>       }
>> @@ -161,6 +180,50 @@ void iommu_put_dma_cookie(struct iommu_domain
>> *domain)
>>   }
>>   EXPORT_SYMBOL(iommu_put_dma_cookie);
>>   +/**
>> + * iommu_dma_bind_doorbell - Allows to provide a usable IOVA page
>> + * @domain: domain handle
>> + * @binding: IOVA/IPA binding
>> + *
>> + * In nested stage use case, the user can provide IOVA/IPA bindings
>> + * corresponding to a guest MSI stage 1 mapping. When the host needs
>> + * to map its own MSI doorbells, it can use the IPA as stage 2 input
>> + * and map it onto the physical MSI doorbell.
>> + */
>> +int iommu_dma_bind_doorbell(struct iommu_domain *domain,
>> +                struct iommu_guest_msi_binding *binding)
>> +{
>> +    struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +    struct iommu_dma_msi_page *msi;
>> +    dma_addr_t ipa, iova;
>> +    size_t size;
>> +
>> +    if (!cookie)
>> +        return -EINVAL;
>> +
>> +    if (cookie->type != IOMMU_DMA_NESTED_MSI_COOKIE)
>> +        return -EINVAL;
>> +
>> +    size = 1 << binding->granule;
>> +    iova = binding->iova & ~(phys_addr_t)(size - 1);
>> +    ipa = binding->gpa & ~(phys_addr_t)(size - 1);
>> +
>> +    list_for_each_entry(msi, &cookie->msi_page_list, list) {
>> +        if (msi->iova == iova)
>> +            return 0; /* this page is already registered */
>> +    }
>> +
>> +    msi = kzalloc(sizeof(*msi), GFP_KERNEL);
>> +    if (!msi)
>> +        return -ENOMEM;
>> +
>> +    msi->iova = iova;
>> +    msi->ipa = ipa;
>> +    list_add(&msi->list, &cookie->msi_page_list);
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(iommu_dma_bind_doorbell);
>> +
>>   /**
>>    * iommu_dma_get_resv_regions - Reserved region driver helper
>>    * @dev: Device from iommu_get_resv_regions()
>> @@ -846,6 +909,34 @@ static struct iommu_dma_msi_page
>> *iommu_dma_get_msi_page(struct device *dev,
>>           if (msi_page->phys == msi_addr)
>>               return msi_page;
>>   +    /*
>> +     * In nested stage mode, we do not allocate an MSI page in
>> +     * a range provided by the user. Instead, IOVA/IPA bindings are
>> +     * individually provided. We reuse thise IOVAs to build the
>> +     * IOVA -> IPA -> MSI PA nested stage mapping.
>> +     */
>> +    if (cookie->type == IOMMU_DMA_NESTED_MSI_COOKIE) {
>> +        list_for_each_entry(msi_page, &cookie->msi_page_list, list)
>> +            if (!msi_page->phys) { /* this binding is free to use */
>> +                dma_addr_t ipa = msi_page->ipa;
>> +                int ret;
>> +
>> +                msi_page->phys = msi_addr;
>> +
>> +                /* do the stage 2 mapping */
>> +                ret = iommu_map(domain, ipa, msi_addr, size,
>> +                        IOMMU_MMIO | IOMMU_WRITE);
>> +                if (ret) {
>> +                    pr_warn("MSI S2 mapping failed (%d)\n",
>> +                        ret);
>> +                    return NULL;
>> +                }
>> +                return msi_page;
>> +            }
>> +        pr_warn("%s no MSI binding found\n", __func__);
>> +        return NULL;
>> +    }
>> +
>>       msi_page = kzalloc(sizeof(*msi_page), GFP_ATOMIC);
>>       if (!msi_page)
>>           return NULL;
>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> index e8ca5e654277..324745eef644 100644
>> --- a/include/linux/dma-iommu.h
>> +++ b/include/linux/dma-iommu.h
>> @@ -24,6 +24,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/iommu.h>
>>   #include <linux/msi.h>
>> +#include <uapi/linux/iommu.h>
>>     int iommu_dma_init(void);
>>   @@ -74,12 +75,15 @@ int iommu_dma_mapping_error(struct device *dev,
>> dma_addr_t dma_addr);
>>   /* The DMA API isn't _quite_ the whole story, though... */
>>   void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head
>> *list);
>> +int iommu_dma_bind_doorbell(struct iommu_domain *domain,
>> +                struct iommu_guest_msi_binding *binding);
>>     #else
>>     struct iommu_domain;
>>   struct msi_msg;
>>   struct device;
>> +struct iommu_guest_msi_binding;
>>     static inline int iommu_dma_init(void)
>>   {
>> @@ -104,6 +108,13 @@ static inline void iommu_dma_map_msi_msg(int irq,
>> struct msi_msg *msg)
>>   {
>>   }
>>   +static inline int
>> +iommu_dma_bind_doorbell(struct iommu_domain *domain,
>> +            struct iommu_guest_msi_binding *binding)
>> +{
>> +    return -ENODEV;
>> +}
>> +
>>   static inline void iommu_dma_get_resv_regions(struct device *dev,
>> struct list_head *list)
>>   {
>>   }
>>

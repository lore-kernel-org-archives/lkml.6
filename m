Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfAYRvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:51:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbfAYRvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:51:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5D5E1487FC;
        Fri, 25 Jan 2019 17:51:15 +0000 (UTC)
Received: from [10.36.116.52] (ovpn-116-52.ams2.redhat.com [10.36.116.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAFA2183E9;
        Fri, 25 Jan 2019 17:51:11 +0000 (UTC)
Subject: Re: [RFC v3 03/21] iommu: Introduce bind_guest_msi
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-4-eric.auger@redhat.com>
 <20190111154419.502b3850@x1.home>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6969a418-bd9c-7ae9-1790-fece4a42e81e@redhat.com>
Date:   Fri, 25 Jan 2019 18:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111154419.502b3850@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 17:51:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,
On 1/11/19 11:44 PM, Alex Williamson wrote:
> On Tue,  8 Jan 2019 11:26:15 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> On ARM, MSI are translated by the SMMU. An IOVA is allocated
>> for each MSI doorbell. If both the host and the guest are exposed
>> with SMMUs, we end up with 2 different IOVAs allocated by each.
>> guest allocates an IOVA (gIOVA) to map onto the guest MSI
>> doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
>> onto the physical doorbell (hDB).
>>
>> So we end up with 2 untied mappings:
>>          S1            S2
>> gIOVA    ->    gDB
>>               hIOVA    ->    gDB
>                                ^^^ hDB
right!
> 
>> Currently the PCI device is programmed by the host with hIOVA
>> as MSI doorbell. So this does not work.
>>
>> This patch introduces an API to pass gIOVA/gDB to the host so
>> that gIOVA can be reused by the host instead of re-allocating
>> a new IOVA. So the goal is to create the following nested mapping:
>>
>>          S1            S2
>> gIOVA    ->    gDB     ->    hDB
>>
>> and program the PCI device with gIOVA MSI doorbell.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - add a struct device handle
>> ---
>>  drivers/iommu/iommu.c      | 10 ++++++++++
>>  include/linux/iommu.h      | 13 +++++++++++++
>>  include/uapi/linux/iommu.h |  6 ++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index b2e248770508..ea11442e7054 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1431,6 +1431,16 @@ static void __iommu_detach_device(struct iommu_domain *domain,
>>  	trace_detach_device_from_domain(dev);
>>  }
>>  
>> +int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
>> +			 struct iommu_guest_msi_binding *binding)
>> +{
>> +	if (unlikely(!domain->ops->bind_guest_msi))
>> +		return -ENODEV;
>> +
>> +	return domain->ops->bind_guest_msi(domain, dev, binding);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
>> +
>>  void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>>  {
>>  	struct iommu_group *group;
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 96d59886f230..244c1a3d5989 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -235,6 +235,9 @@ struct iommu_ops {
>>  	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
>>  				struct iommu_cache_invalidate_info *inv_info);
>>  
>> +	int (*bind_guest_msi)(struct iommu_domain *domain, struct device *dev,
>> +			      struct iommu_guest_msi_binding *binding);
>> +
>>  	unsigned long pgsize_bitmap;
>>  };
>>  
>> @@ -301,6 +304,9 @@ extern int iommu_set_pasid_table(struct iommu_domain *domain,
>>  extern int iommu_cache_invalidate(struct iommu_domain *domain,
>>  				struct device *dev,
>>  				struct iommu_cache_invalidate_info *inv_info);
>> +extern int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
>> +				struct iommu_guest_msi_binding *binding);
>> +
>>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>> @@ -724,6 +730,13 @@ iommu_cache_invalidate(struct iommu_domain *domain,
>>  	return -ENODEV;
>>  }
>>  
>> +static inline
>> +int iommu_bind_guest_msi(struct iommu_domain *domain, struct device *dev,
>> +			 struct iommu_guest_msi_binding *binding)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>  #endif /* CONFIG_IOMMU_API */
>>  
>>  #ifdef CONFIG_IOMMU_DEBUGFS
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 4605f5cfac84..f28cd9a1aa96 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -142,4 +142,10 @@ struct iommu_cache_invalidate_info {
>>  	__u64		arch_id;
>>  	__u64		addr;
>>  };
>> +
>> +struct iommu_guest_msi_binding {
>> +	__u64		iova;
>> +	__u64		gpa;
>> +	__u32		granule;
> 
> What's granule?  The size?  This looks a lot like just a stage 1
> mapping interface, I can't really figure out from the description how
> this matches to any specific MSI mapping.
Yes that's just a stage 1 binding. The granule is the log2size of the
stage1 page. As this is a guest mapping of a virtual doorbell, this is
WRITE only.

What about something like:
/**
 * 1st level/stage1 binding of a virtual MSI doorbell
 *
 * @iova:       iova
 * @gpa:        guest physical address of the virtual doorbell
 * @log2size:   log2size of the doorbell (generally a guest page)
 *
 * As this is an MSI doorbell, the mapping is write only.
 */
struct iommu_guest_msi_binding {
        __u64   iova;
        __u64   gpa;
        __u32   log2size;
};

Also added:

/**
 * iommu_bind_guest_msi - Passes the stage1 binding of the virtual
 * doorbell used by the assigned device @dev.
 *
 * @domain: iommu domain the stage 1 mapping will be attached to
 * @dev: assigned device which uses this stage1 mapping
 * @binding: stage1 MSI binding
 *
 * The associated IOVA can be reused by the host to create a nested
 * stage2 binding mapping onto the physical doorbell used by @dev
 */


Thanks

Eric

  Zero comments in the code
> or headers here about how this is supposed to work.  Thanks,
> 
> Alex
> 

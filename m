Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DAE20868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfAPSdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:33:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbfAPSds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:33:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E4B9C079C2B;
        Wed, 16 Jan 2019 18:33:48 +0000 (UTC)
Received: from [10.36.116.96] (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6A34600C8;
        Wed, 16 Jan 2019 18:33:39 +0000 (UTC)
Subject: Re: [RFC v3 14/21] iommu: introduce device fault data
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-15-eric.auger@redhat.com>
 <20190110104544.26f3bcb1@jacob-builder>
 <63a19100-c3dd-9dbd-b37a-9dfbe254459e@arm.com>
 <20190114143208.66eac25a@jacob-builder>
 <519a1669-1343-1296-8f04-6ba63085d9a5@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d1bee719-4d15-6f60-41ae-7937d74e6999@redhat.com>
Date:   Wed, 16 Jan 2019 19:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <519a1669-1343-1296-8f04-6ba63085d9a5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 16 Jan 2019 18:33:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 1/16/19 4:52 PM, Jean-Philippe Brucker wrote:
> On 14/01/2019 22:32, Jacob Pan wrote:
>>> [...]
>>>>> +/**
>>>>> + * struct iommu_fault - Generic fault data
>>>>> + *
>>>>> + * @type contains fault type
>>>>> + * @reason fault reasons if relevant outside IOMMU driver.
>>>>> + * IOMMU driver internal faults are not reported.
>>>>> + * @addr: tells the offending page address
>>>>> + * @fetch_addr: tells the address that caused an abort, if any
>>>>> + * @pasid: contains process address space ID, used in shared
>>>>> virtual memory
>>>>> + * @page_req_group_id: page request group index
>>>>> + * @last_req: last request in a page request group
>>>>> + * @pasid_valid: indicates if the PRQ has a valid PASID
>>>>> + * @prot: page access protection flag:
>>>>> + *	IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
>>>>> + */
>>>>> +
>>>>> +struct iommu_fault {
>>>>> +	__u32	type;   /* enum iommu_fault_type */
>>>>> +	__u32	reason; /* enum iommu_fault_reason */
>>>>> +	__u64	addr;
>>>>> +	__u64	fetch_addr;
>>>>> +	__u32	pasid;
>>>>> +	__u32	page_req_group_id;
>>>>> +	__u32	last_req;
>>>>> +	__u32	pasid_valid;
>>>>> +	__u32	prot;
>>>>> +	__u32	access;  
>>>
>>> What does @access contain? Can it be squashed into @prot?
>>>
>> I agreed.
>>
>> how about this?
>> #define IOMMU_FAULT_VERSION_V1 0x1
>> struct iommu_fault {
>> 	__u16 version;
> 
> Right, but the version field becomes redundant when we present a batch
> of these to userspace, in patch 18 (assuming we don't want to mix fault
> structure versions within a batch... I certainly don't).>
> When introducing IOMMU_FAULT_VERSION_V2, in a distant future, I think we
> still need to support a userspace that uses IOMMU_FAULT_VERSION_V1. One
> strategy for this:
> 
> * We define structs iommu_fault_v1 (the current iommu_fault) and
>   iommu_fault_v2.
> * Userspace selects IOMMU_FAULT_VERSION_V1 when registering the fault
>   queue
> * The IOMMU driver fills iommu_fault_v2 and passes it to VFIO
> * VFIO does its best to translate this into a iommu_fault_v1 struct
> 
> So what we need now, is a way for userspace to tell the kernel which
> structure version it expects. I'm not sure we even need to pass the
> actual version number we're using back to userspace. Agreeing on one
> version at registration should be sufficient.

As we expose a VFIO region we can report its size, entry size, max
supported entry version, actual entry version in the region capabilities.

Conveying the version along with the eventfd at registration time will
require to introduce a new flag at vfio_irq_set level (if we still plan
to use this VFIO_DEVICE_SET_IRQS API) but that should be feasible.
> 
>> 	__u16 type;
>> 	__u32 reason;
>> 	__u64 addr;
> 
> I'm in favor of keeping @fetch_addr as well, it can contain useful
> information. For example, while attempting to translate an IOVA
> 0xfffff000, the IOMMU can't find the PASID table that we installed with
> address 0xdead - the guest passed an invalid address to
> bind_pasid_table(). We can then report 0xfffff000 in @addr, and 0xdead
> in @fetch_addr.
agreed
> 
>> 	__u32 pasid;
>> 	__u32 page_req_group_id;
>> 	__u32 last_req : 1;
>> 	__u32 pasid_valid : 1;
> 
> Agreed, with some explicit padding or combined as a @flag field. In fact
> if we do add the @fetch_addr field, I think we need a bit that indicates
> its validity as well.
Can't we simply state fetch_addr is valid for
IOMMU_FAULT_REASON_PASID_FETCH, IOMMU_FAULT_REASON_DEVICE_CONTEXT_FETCH,
IOMMU_FAULT_REASON_WALK_EABT which maps to its usage in SMMU spec.

Thanks

Eric

> 
> Thanks,
> Jean
> 
>> 	__u32 prot;
>> 	__u64 device_private[2];
>> 	__u8 padding[48];
>> };
>>
>>
>>> Thanks,
>>> Jean
>>>
>>>> relocated to uapi, Yi can you confirm?
>>>> 	__u64 device_private[2];
>>>>   
>>>>> +};
>>>>>  #endif /* _UAPI_IOMMU_H */  
>>>>
>>>> _______________________________________________
>>>> iommu mailing list
>>>> iommu@lists.linux-foundation.org
>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>>   
>>>
>>
>> [Jacob Pan]
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

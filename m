Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E803F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394178AbfAPQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:54:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfAPQyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:54:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C69BFA78;
        Wed, 16 Jan 2019 08:54:51 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B31B3F5AF;
        Wed, 16 Jan 2019 08:54:48 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC v3 14/21] iommu: introduce device fault data
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-15-eric.auger@redhat.com>
 <20190110104544.26f3bcb1@jacob-builder>
 <63a19100-c3dd-9dbd-b37a-9dfbe254459e@arm.com>
 <07fc2059-3a4e-6b36-262b-779eb98b2334@redhat.com>
Message-ID: <99e03a7e-2a5c-5f8f-5a16-e01088c59fff@arm.com>
Date:   Wed, 16 Jan 2019 16:54:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <07fc2059-3a4e-6b36-262b-779eb98b2334@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2019 21:27, Auger Eric wrote:
[...]
>>>>  /* iommu fault flags */
>>>> -#define IOMMU_FAULT_READ	0x0
>>>> -#define IOMMU_FAULT_WRITE	0x1
>>>> +#define IOMMU_FAULT_READ		(1 << 0)
>>>> +#define IOMMU_FAULT_WRITE		(1 << 1)
>>>> +#define IOMMU_FAULT_EXEC		(1 << 2)
>>>> +#define IOMMU_FAULT_PRIV		(1 << 3)
>>>>  
>>>>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>>>>  			struct device *, unsigned long, int, void *);
>>>> +typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *,
>>>> void *); 
>>>>  struct iommu_domain_geometry {
>>>>  	dma_addr_t aperture_start; /* First address that can be
>>>> mapped    */ @@ -255,6 +259,52 @@ struct iommu_device {
>>>>  	struct device *dev;
>>>>  };
>>>>  
>>>> +/**
>>>> + * struct iommu_fault_event - Generic per device fault data
>>>> + *
>>>> + * - PCI and non-PCI devices
>>>> + * - Recoverable faults (e.g. page request), information based on
>>>> PCI ATS
>>>> + * and PASID spec.
>>>> + * - Un-recoverable faults of device interest
>>>> + * - DMA remapping and IRQ remapping faults
>>>> + *
>>>> + * @fault: fault descriptor
>>>> + * @device_private: if present, uniquely identify device-specific
>>>> + *                  private data for an individual page request.
>>>> + * @iommu_private: used by the IOMMU driver for storing
>>>> fault-specific
>>>> + *                 data. Users should not modify this field before
>>>> + *                 sending the fault response.
>>>> + */
>>>> +struct iommu_fault_event {
>>>> +	struct iommu_fault fault;
>>>> +	u64 device_private;
>>> I think we want to move device_private to uapi since it gets injected
>>> into the guest, then returned by guest in case of page response. For
>>> VT-d we also need 128 bits of private data. VT-d spec. 7.7.1
>>
>> Ah, I didn't notice the format changed in VT-d rev3. On that topic, how
>> do we manage future extensions to the iommu_fault struct? Should we add
>> ~48 bytes of padding after device_private, along with some flags telling
>> which field is valid, or deal with it using a structure version like we
>> do for the invalidate and bind structs? In the first case, iommu_fault
>> wouldn't fit in a 64-byte cacheline anymore, but I'm not sure we care.
>>
>>> For exception tracking (e.g. unanswered page request), I can add timer
>>> and list info later when I include PRQ. sounds ok?
>>>> +	u64 iommu_private;
>> [...]
>>>> +/**
>>>> + * struct iommu_fault - Generic fault data
>>>> + *
>>>> + * @type contains fault type
>>>> + * @reason fault reasons if relevant outside IOMMU driver.
>>>> + * IOMMU driver internal faults are not reported.
>>>> + * @addr: tells the offending page address
>>>> + * @fetch_addr: tells the address that caused an abort, if any
>>>> + * @pasid: contains process address space ID, used in shared virtual
>>>> memory
>>>> + * @page_req_group_id: page request group index
>>>> + * @last_req: last request in a page request group
>>>> + * @pasid_valid: indicates if the PRQ has a valid PASID
>>>> + * @prot: page access protection flag:
>>>> + *	IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
>>>> + */
>>>> +
>>>> +struct iommu_fault {
>>>> +	__u32	type;   /* enum iommu_fault_type */
>>>> +	__u32	reason; /* enum iommu_fault_reason */
>>>> +	__u64	addr;
>>>> +	__u64	fetch_addr;
>>>> +	__u32	pasid;
>>>> +	__u32	page_req_group_id;
>>>> +	__u32	last_req;
>>>> +	__u32	pasid_valid;
>>>> +	__u32	prot;
>>>> +	__u32	access;
>>
>> What does @access contain? Can it be squashed into @prot?
> it was related to F_ACCESS event record and was a placeholder for
> reporting access attributes of the input transaction (Rnw, InD, PnU
> fields). But I wonder whether this is needed to implement such fine
> level fault reporting. Do we really care?

I think we do, to properly inject PRI/Stall later. But RnW, InD and PnU
can already be described with the IOMMU_FAULT_* flags defined above.
We're missing CLASS and S2, which could also be useful for debugging.
CLASS is specific to SMMUv3 but could probably be represented with
@reason. For S2, we could keep printing stage-2 faults in the driver,
and not report them to userspace.

Thanks,
Jean

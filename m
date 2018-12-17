Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55792C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FB120672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbeLQJEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:04:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLQJEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:04:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C580C04959E;
        Mon, 17 Dec 2018 09:04:12 +0000 (UTC)
Received: from [10.36.117.46] (ovpn-117-46.ams2.redhat.com [10.36.117.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 710325C1B5;
        Mon, 17 Dec 2018 09:04:05 +0000 (UTC)
Subject: Re: [RFC v2 14/20] iommu: introduce device fault data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, tianyu.lan@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
References: <20180918142457.3325-1-eric.auger@redhat.com>
 <20180918142457.3325-15-eric.auger@redhat.com>
 <20180920150653.567287c5@jacob-builder>
 <09404da4-98c6-7afc-4510-caeaeaf6e4c4@redhat.com>
 <20181214163023.156aada9@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b174ef22-4a40-249f-19b0-74c9ea8a1071@redhat.com>
Date:   Mon, 17 Dec 2018 10:04:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214163023.156aada9@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 09:04:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 12/15/18 1:30 AM, Jacob Pan wrote:
> On Wed, 12 Dec 2018 09:21:43 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 9/21/18 12:06 AM, Jacob Pan wrote:
>>> On Tue, 18 Sep 2018 16:24:51 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>>
>>>> Device faults detected by IOMMU can be reported outside IOMMU
>>>> subsystem for further processing. This patch intends to provide
>>>> a generic device fault data such that device drivers can be
>>>> communicated with IOMMU faults without model specific knowledge.
>>>>
>>>> The proposed format is the result of discussion at:
>>>> https://lkml.org/lkml/2017/11/10/291
>>>> Part of the code is based on Jean-Philippe Brucker's patchset
>>>> (https://patchwork.kernel.org/patch/9989315/).
>>>>
>>>> The assumption is that model specific IOMMU driver can filter and
>>>> handle most of the internal faults if the cause is within IOMMU
>>>> driver control. Therefore, the fault reasons can be reported are
>>>> grouped and generalized based common specifications such as PCI
>>>> ATS.
>>>>
>>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Signed-off-by: Jean-Philippe Brucker
>>>> <jean-philippe.brucker@arm.com> Signed-off-by: Liu, Yi L
>>>> <yi.l.liu@linux.intel.com> Signed-off-by: Ashok Raj
>>>> <ashok.raj@intel.com> Signed-off-by: Eric Auger
>>>> <eric.auger@redhat.com> [moved part of the iommu_fault_event
>>>> struct in the uapi, enriched the fault reasons to be able to map
>>>> unrecoverable SMMUv3 errors]  
>>> Sounds good to me.
>>> There are also other "enrichment" we need to do to support mdev or
>>> finer granularity fault reporting below physical device. e.g. PASID
>>> level.
>>>
>>> The current scheme works for PCIe physical device level, where each
>>> device registers a single handler only once. When device fault is
>>> detected by the IOMMU, it will find the matching handler and private
>>> data to report back. However, for devices partitioned by PASID and
>>> represented by mdev this may not work. Since IOMMU is not mdev aware
>>> and only works at physical device level.
>>> So I am thinking we should allow multiple registration of fault
>>> handler with different data and ID. i.e.
>>>
>>> int iommu_register_device_fault_handler(struct device *dev,
>>> 					iommu_dev_fault_handler_t
>>> handler, int id,
>>> 					void *data)
>>>
>>> where the new "id field" is
>>>  * @id: Identification of the handler private data, will be used by
>>> fault
>>>  *      reporting code to match the handler data to be returned.
>>> For page
>>>  *      request, this can be the PASID. ID must be unique per
>>> device, i.e.
>>>  *      each ID can only be registered once per device.
>>>  *      - IOMMU_DEV_FAULT_ID_UNRECOVERY (~0U) is reserved for fault
>>> reporting
>>>  *      w/o ID. e.g. unrecoverable faults.
>>>
>>> I am still testing, but just wanted to have feedback on this idea.  
>>
>> I am currently respinning this series. Do you have a respin for this
>> patch including iommu_register_device_fault_handler with the @id param
>> as you suggested above? Otherwise 2 solutions: I keep the code as is
>> or I do the modification myself implementing a list of fault_params?
>>
> you can keep the code as is if it fits your current needs. Yi and I
> have thought of some new cases for supporting mdev. We are thinking to
> support many to many handler vs PASID relationship. i.e. allow
> registration of many fault handlers per device, each associated with an
> ID and data. The use case is that a physical device may register a
> fault handler for its own PASID or non-PASID related faults. Such
> physical device can also be partitioned into sub-device, e.g. mdev, but
> fault handler registration is at physical device level in that IOMMU is
> not mdev aware.
> Anyway, still need some work to flush out the details.
>> Besides do you plans for "[PATCH v5 00/23] IOMMU and VT-d driver
>> support for Shared Virtual Address (SVA)" respin - hope I didn't miss
>> anything? - ?

Thank you for your reply. OK I will see how much time I can dedicate to
this API change. At the moment I am working on the vfio-pci side and
exposing a fault region as initiated by Yi.

>>
> You did not miss anything. Yes, we are still working on some internal
> integration issues. It should not affect the common interface much. Or
> I can send out a common API spin first once we have the functionality
> tested.

No worries. I can live without at the moment

Thanks

Eric
> 
> Thanks for checking.
> 
>> Thanks
>>
>> Eric
>>>
>>> Thanks,
>>>
>>> Jacob
>>>
>>>   
>>>> ---
>>>>  include/linux/iommu.h      | 55 ++++++++++++++++++++++++-
>>>>  include/uapi/linux/iommu.h | 83
>>>> ++++++++++++++++++++++++++++++++++++++ 2 files changed, 136
>>>> insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index 9bd3e63d562b..7529c14ff506 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -49,13 +49,17 @@ struct bus_type;
>>>>  struct device;
>>>>  struct iommu_domain;
>>>>  struct notifier_block;
>>>> +struct iommu_fault_event;
>>>>  
>>>>  /* iommu fault flags */
>>>> -#define IOMMU_FAULT_READ	0x0
>>>> -#define IOMMU_FAULT_WRITE	0x1
>>>> +#define IOMMU_FAULT_READ		(1 << 0)
>>>> +#define IOMMU_FAULT_WRITE		(1 << 1)
>>>> +#define IOMMU_FAULT_EXEC		(1 << 2)
>>>> +#define IOMMU_FAULT_PRIV		(1 << 3)
>>>>  
>>>>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>>>>  			struct device *, unsigned long, int, void
>>>> *); +typedef int (*iommu_dev_fault_handler_t)(struct
>>>> iommu_fault_event *, void *); 
>>>>  struct iommu_domain_geometry {
>>>>  	dma_addr_t aperture_start; /* First address that can be
>>>> mapped    */ @@ -262,6 +266,52 @@ struct iommu_device {
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
>>>> +	u64 iommu_private;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct iommu_fault_param - per-device IOMMU fault data
>>>> + * @dev_fault_handler: Callback function to handle IOMMU faults at
>>>> device level
>>>> + * @data: handler private data
>>>> + *
>>>> + */
>>>> +struct iommu_fault_param {
>>>> +	iommu_dev_fault_handler_t handler;
>>>> +	void *data;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct iommu_param - collection of per-device IOMMU data
>>>> + *
>>>> + * @fault_param: IOMMU detected device fault reporting data
>>>> + *
>>>> + * TODO: migrate other per device data pointers under
>>>> iommu_dev_data, e.g.
>>>> + *	struct iommu_group	*iommu_group;
>>>> + *	struct iommu_fwspec	*iommu_fwspec;
>>>> + */
>>>> +struct iommu_param {
>>>> +	struct iommu_fault_param *fault_param;
>>>> +};
>>>> +
>>>>  int  iommu_device_register(struct iommu_device *iommu);
>>>>  void iommu_device_unregister(struct iommu_device *iommu);
>>>>  int  iommu_device_sysfs_add(struct iommu_device *iommu,
>>>> @@ -429,6 +479,7 @@ struct iommu_ops {};
>>>>  struct iommu_group {};
>>>>  struct iommu_fwspec {};
>>>>  struct iommu_device {};
>>>> +struct iommu_fault_param {};
>>>>  
>>>>  static inline bool iommu_present(struct bus_type *bus)
>>>>  {
>>>> diff --git a/include/uapi/linux/iommu.h
>>>> b/include/uapi/linux/iommu.h index 21adb2a964e5..a0fe5c2fb236
>>>> 100644 --- a/include/uapi/linux/iommu.h
>>>> +++ b/include/uapi/linux/iommu.h
>>>> @@ -150,5 +150,88 @@ struct iommu_guest_msi_binding {
>>>>  	__u64		gpa;
>>>>  	__u32		granule;
>>>>  };
>>>> +
>>>> +/*  Generic fault types, can be expanded IRQ remapping fault */
>>>> +enum iommu_fault_type {
>>>> +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable
>>>> fault */
>>>> +	IOMMU_FAULT_PAGE_REQ,		/* page request
>>>> fault */ +};
>>>> +
>>>> +enum iommu_fault_reason {
>>>> +	IOMMU_FAULT_REASON_UNKNOWN = 0,
>>>> +
>>>> +	/* IOMMU internal error, no specific reason to report out
>>>> */
>>>> +	IOMMU_FAULT_REASON_INTERNAL,
>>>> +
>>>> +	/* Could not access the PASID table (fetch caused external
>>>> abort) */
>>>> +	IOMMU_FAULT_REASON_PASID_FETCH,
>>>> +
>>>> +	/* could not access the device context (fetch caused
>>>> external abort) */
>>>> +	IOMMU_FAULT_REASON_DEVICE_CONTEXT_FETCH,
>>>> +
>>>> +	/* pasid entry is invalid or has configuration errors */
>>>> +	IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
>>>> +
>>>> +	/* device context entry is invalid or has configuration
>>>> errors */
>>>> +	IOMMU_FAULT_REASON_BAD_DEVICE_CONTEXT_ENTRY,
>>>> +	/*
>>>> +	 * PASID is out of range (e.g. exceeds the maximum PASID
>>>> +	 * supported by the IOMMU) or disabled.
>>>> +	 */
>>>> +	IOMMU_FAULT_REASON_PASID_INVALID,
>>>> +
>>>> +	/* source id is out of range */
>>>> +	IOMMU_FAULT_REASON_SOURCEID_INVALID,
>>>> +
>>>> +	/*
>>>> +	 * An external abort occurred fetching (or updating) a
>>>> translation
>>>> +	 * table descriptor
>>>> +	 */
>>>> +	IOMMU_FAULT_REASON_WALK_EABT,
>>>> +
>>>> +	/*
>>>> +	 * Could not access the page table entry (Bad address),
>>>> +	 * actual translation fault
>>>> +	 */
>>>> +	IOMMU_FAULT_REASON_PTE_FETCH,
>>>> +
>>>> +	/* Protection flag check failed */
>>>> +	IOMMU_FAULT_REASON_PERMISSION,
>>>> +
>>>> +	/* access flag check failed */
>>>> +	IOMMU_FAULT_REASON_ACCESS,
>>>> +
>>>> +	/* Output address of a translation stage caused Address
>>>> Size fault */
>>>> +	IOMMU_FAULT_REASON_OOR_ADDRESS
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct iommu_fault - Generic fault data
>>>> + *
>>>> + * @type contains fault type
>>>> + * @reason fault reasons if relevant outside IOMMU driver.
>>>> + * IOMMU driver internal faults are not reported.
>>>> + * @addr: tells the offending page address
>>>> + * @fetch_addr: tells the address that caused an abort, if any
>>>> + * @pasid: contains process address space ID, used in shared
>>>> virtual memory
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
>>>> +};
>>>>  #endif /* _UAPI_IOMMU_H */
>>>>    
>>>
>>> [Jacob Pan]
>>>   
> 
> [Jacob Pan]
> 

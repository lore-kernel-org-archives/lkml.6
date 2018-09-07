Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C922077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C922077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeIGQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:03:47 -0400
Received: from foss.arm.com ([217.140.101.70]:59138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbeIGQDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:03:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A4818A;
        Fri,  7 Sep 2018 04:23:16 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3B83F614;
        Fri,  7 Sep 2018 04:23:14 -0700 (PDT)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jean Delvare <khali@linux-fr.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <2094d667-5dbf-b4b8-8e19-c76d67b82362@redhat.com>
 <e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
 <9013df5a-02f9-55b8-eb5e-fad4be0a2c92@redhat.com>
 <289610e3-2633-e448-259c-194e6f2c2b52@arm.com>
 <953746f3-352b-cd17-9938-eb78af3b58a9@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <21349516-030a-93df-35bd-3597fa1cba79@arm.com>
Date:   Fri, 7 Sep 2018 12:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <953746f3-352b-cd17-9938-eb78af3b58a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 08:11, Auger Eric wrote:
>>> On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
>>>> On 06/09/2018 10:25, Auger Eric wrote:
>>>>>> +		mutex_lock(&fparam->lock);
>>>>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>>>>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>>>>> void the queue and deallocate this memory.
>>>
>>> By the way I saw there is a kind of garbage collectors for faults which
>>> wouldn't have received any responses. However I am not sure this removes
>>> the concern of having the fault list on kernel side growing beyond
>>> acceptable limits.
>>
>> How about per-device quotas? (https://lkml.org/lkml/2018/4/23/706 for
>> reference) With PRI the IOMMU driver already sets per-device credits
>> when initializing the device (pci_enable_pri), so if the device behaves
>> properly it shouldn't send new page requests once the number of
>> outstanding ones is maxed out.
> 
> But this needs to work for non PRI use case too?

Only recoverable faults, PRI and stall, are added to the fparam->faults
list, because the kernel needs to make sure that each of these faults
gets a reply, or else they are held in hardware indefinitely.
Non-recoverable faults don't need tracking, the IOMMU API can forget
about them after they're reported. Rate-limiting could be done by the
consumer if it gets flooded by non-recoverable faults, for example by
dropping some of them.

>> Right, an event contains more information than a PRI page request.
>> Stage-2 fields (CLASS, S2, IPA, TTRnW) cannot be represented by
>> iommu_fault_event at the moment.
> 
> Yes I am currently doing the mapping exercise between SMMUv3 events and
> iommu_fault_event and I miss config errors for instance.

We may have initially focused only on guest and userspace config errors
(IOMMU_FAULT_REASON_PASID_FETCH, IOMMU_FAULT_REASON_PASID_INVALID, etc),
since other config errors are most likely a bug in the host IOMMU
driver, and could be reported with pr_err

>  For precise emulation it might be
>> useful to at least add the S2 flag (as a new iommu_fault_reason?), so
>> that when the guest maps stage-1 to an invalid GPA, QEMU could for
>> example inject an external abort.
> 
> Actually we may even need to filter events and return to the guest only
> the S1 related.
>>
>>> queue
>>> size, that may deserve to create different APIs and internal data
>>> structs. Also this may help separating the concerns.
>>
>> It might duplicate them. If the consumer of the event report is a host
>> device driver, the SMMU needs to report a "generic" iommu_fault_event,
>> and if the consumer is VFIO it would report a specialized one
> 
> I am unsure of my understanding of the UNRECOVERABLE error type. Is it
> everything else than a PRI. For instance are all SMMUv3 event errors
> supposed to be put under the IOMMU_FAULT_DMA_UNRECOV umbrella?

I guess it's more clear-cut in VT-d, which defines recoverable and
non-recoverable faults. In SMMUv3, PRI Page Requests are recoverable,
but event errors can also be recoverable if they have the Stall flag set.

Stall is a way for non-PCI endpoints to do SVA, and I have a patch in my
series that sorts events into PAGE_REQ and DMA_UNRECOV before feeding
them to this API: https://patchwork.kernel.org/patch/10395043/

> If I understand correctly there are different consumers for PRI and
> unrecoverable data, so why not having 2 different APIs.

My reasoning was that for virtualization they go through the same
channel, VFIO, until the guest or the vIOMMU dispatches them depending
on their type, so we might as well use the same API.

In addition, host device drivers might also want to handle stall or PRI
events themselves instead of relying on the SVA infrastructure. For
example the MSM GPU with SMMUv2: https://patchwork.kernel.org/patch/9953803/

>>> My remark also
>>> stems from the fact the SMMU uses 2 different queues, whose size can
>>> also be different.
>>
>> Hm, for PRI requests the kernel-userspace queue size should actually be
>> the number of PRI credits for that device. Hadn't thought about it
>> before, where do we pass that info to userspace?
> Cannot help here at the moment, sorry.
>  For fault events, the
>> queue could be as big as the SMMU event queue, though using all that
>> space might be wasteful.
> The guest has its own programming of the SMMU_EVENTQ_BASE.LOG2SIZE. This
> could be used to program the SW fifo
> 
>  Non-stalled events should be rare and reporting
>> them isn't urgent. Stalled ones would need the number of stall credits I
>> mentioned above, which realistically will be a lot less than the SMMU
>> event queue size. Given that a device will use either PRI or stall but
>> not both, I still think events and PRI could go through the same queue.
> Did I get it right PRI is for PCIe and STALL for non PCIe? But all that
> stuff also is related to Page Request use case, right?

Yes, a stall event is a page request from a non-PCI device, but it comes
in through the SMMU event queue

Thanks,
Jean

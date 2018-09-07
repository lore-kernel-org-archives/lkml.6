Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5323C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D0206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771D0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIGLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:50:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbeIGLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5DBC2636E;
        Fri,  7 Sep 2018 07:11:19 +0000 (UTC)
Received: from [10.36.116.217] (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA549A30D5;
        Fri,  7 Sep 2018 07:11:15 +0000 (UTC)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
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
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <953746f3-352b-cd17-9938-eb78af3b58a9@redhat.com>
Date:   Fri, 7 Sep 2018 09:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <289610e3-2633-e448-259c-194e6f2c2b52@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 07:11:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 07:11:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On 09/06/2018 07:06 PM, Jean-Philippe Brucker wrote:
> On 06/09/2018 14:14, Auger Eric wrote:
>> Hi Jean-Philippe,
>>
>> On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
>>> On 06/09/2018 10:25, Auger Eric wrote:
>>>>> +		mutex_lock(&fparam->lock);
>>>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>>>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>>>> void the queue and deallocate this memory.
>>
>> By the way I saw there is a kind of garbage collectors for faults which
>> wouldn't have received any responses. However I am not sure this removes
>> the concern of having the fault list on kernel side growing beyond
>> acceptable limits.
> 
> How about per-device quotas? (https://lkml.org/lkml/2018/4/23/706 for
> reference) With PRI the IOMMU driver already sets per-device credits
> when initializing the device (pci_enable_pri), so if the device behaves
> properly it shouldn't send new page requests once the number of
> outstanding ones is maxed out.

But this needs to work for non PRI use case too?
> 
> The stall mode of SMMU doesn't have per-device limit, and depending on
> the implementation it might be easy for one guest using stall to prevent
> other guests from receiving faults. For this reason we'll have to
> enforce a per-device stall quota in the SMMU driver, and immediately
> terminate faults that exceed this quota. We could easily do the same for
> PRI, if we don't trust devices to follow the spec. The difficult part is
> finding the right number of credits...
> 
>>> Host device drivers that use this API to be notified on fault can't deal
>>> with arch-specific event formats (SMMU event, Vt-d fault event, etc), so
>>> the APIs should be arch-agnostic. Given that requirement, using a single
>>> iommu_fault_event structure for both PRI and event queues made sense,
>>> especially since the even queue can have stall events that look a lot
>>> like PRI page requests.
>> I understand the data structure needs to be generic. Now I guess PRI
>> events and other standard translator error events (that can happen
>> without PRI) may have different characteristics in event fields,
> 
> Right, an event contains more information than a PRI page request.
> Stage-2 fields (CLASS, S2, IPA, TTRnW) cannot be represented by
> iommu_fault_event at the moment.

Yes I am currently doing the mapping exercise between SMMUv3 events and
iommu_fault_event and I miss config errors for instance.
 For precise emulation it might be
> useful to at least add the S2 flag (as a new iommu_fault_reason?), so
> that when the guest maps stage-1 to an invalid GPA, QEMU could for
> example inject an external abort.

Actually we may even need to filter events and return to the guest only
the S1 related.
> 
>> queue
>> size, that may deserve to create different APIs and internal data
>> structs. Also this may help separating the concerns.
> 
> It might duplicate them. If the consumer of the event report is a host
> device driver, the SMMU needs to report a "generic" iommu_fault_event,
> and if the consumer is VFIO it would report a specialized one

I am unsure of my understanding of the UNRECOVERABLE error type. Is it
everything else than a PRI. For instance are all SMMUv3 event errors
supposed to be put under the IOMMU_FAULT_DMA_UNRECOV umbrella?

If I understand correctly there are different consumers for PRI and
unrecoverable data, so why not having 2 different APIs.
> 
>> My remark also
>> stems from the fact the SMMU uses 2 different queues, whose size can
>> also be different.
> 
> Hm, for PRI requests the kernel-userspace queue size should actually be
> the number of PRI credits for that device. Hadn't thought about it
> before, where do we pass that info to userspace?
Cannot help here at the moment, sorry.
 For fault events, the
> queue could be as big as the SMMU event queue, though using all that
> space might be wasteful.
The guest has its own programming of the SMMU_EVENTQ_BASE.LOG2SIZE. This
could be used to program the SW fifo

 Non-stalled events should be rare and reporting
> them isn't urgent. Stalled ones would need the number of stall credits I
> mentioned above, which realistically will be a lot less than the SMMU
> event queue size. Given that a device will use either PRI or stall but
> not both, I still think events and PRI could go through the same queue.
Did I get it right PRI is for PCIe and STALL for non PCIe? But all that
stuff also is related to Page Request use case, right?

Thanks

Eric
> 
> Thanks,
> Jean
> 

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C589FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0862083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0862083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeIFVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:43:17 -0400
Received: from foss.arm.com ([217.140.101.70]:48686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbeIFVnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:43:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3AB47A9;
        Thu,  6 Sep 2018 10:06:52 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D582F3F557;
        Thu,  6 Sep 2018 10:06:50 -0700 (PDT)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Auger Eric <eric.auger@redhat.com>,
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
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <289610e3-2633-e448-259c-194e6f2c2b52@arm.com>
Date:   Thu, 6 Sep 2018 18:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9013df5a-02f9-55b8-eb5e-fad4be0a2c92@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2018 14:14, Auger Eric wrote:
> Hi Jean-Philippe,
> 
> On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
>> On 06/09/2018 10:25, Auger Eric wrote:
>>>> +		mutex_lock(&fparam->lock);
>>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>>> void the queue and deallocate this memory.
> 
> By the way I saw there is a kind of garbage collectors for faults which
> wouldn't have received any responses. However I am not sure this removes
> the concern of having the fault list on kernel side growing beyond
> acceptable limits.

How about per-device quotas? (https://lkml.org/lkml/2018/4/23/706 for
reference) With PRI the IOMMU driver already sets per-device credits
when initializing the device (pci_enable_pri), so if the device behaves
properly it shouldn't send new page requests once the number of
outstanding ones is maxed out.

The stall mode of SMMU doesn't have per-device limit, and depending on
the implementation it might be easy for one guest using stall to prevent
other guests from receiving faults. For this reason we'll have to
enforce a per-device stall quota in the SMMU driver, and immediately
terminate faults that exceed this quota. We could easily do the same for
PRI, if we don't trust devices to follow the spec. The difficult part is
finding the right number of credits...

>> Host device drivers that use this API to be notified on fault can't deal
>> with arch-specific event formats (SMMU event, Vt-d fault event, etc), so
>> the APIs should be arch-agnostic. Given that requirement, using a single
>> iommu_fault_event structure for both PRI and event queues made sense,
>> especially since the even queue can have stall events that look a lot
>> like PRI page requests.
> I understand the data structure needs to be generic. Now I guess PRI
> events and other standard translator error events (that can happen
> without PRI) may have different characteristics in event fields,

Right, an event contains more information than a PRI page request.
Stage-2 fields (CLASS, S2, IPA, TTRnW) cannot be represented by
iommu_fault_event at the moment. For precise emulation it might be
useful to at least add the S2 flag (as a new iommu_fault_reason?), so
that when the guest maps stage-1 to an invalid GPA, QEMU could for
example inject an external abort.

> queue
> size, that may deserve to create different APIs and internal data
> structs. Also this may help separating the concerns.

It might duplicate them. If the consumer of the event report is a host
device driver, the SMMU needs to report a "generic" iommu_fault_event,
and if the consumer is VFIO it would report a specialized one

> My remark also
> stems from the fact the SMMU uses 2 different queues, whose size can
> also be different.

Hm, for PRI requests the kernel-userspace queue size should actually be
the number of PRI credits for that device. Hadn't thought about it
before, where do we pass that info to userspace? For fault events, the
queue could be as big as the SMMU event queue, though using all that
space might be wasteful. Non-stalled events should be rare and reporting
them isn't urgent. Stalled ones would need the number of stall credits I
mentioned above, which realistically will be a lot less than the SMMU
event queue size. Given that a device will use either PRI or stall but
not both, I still think events and PRI could go through the same queue.

Thanks,
Jean

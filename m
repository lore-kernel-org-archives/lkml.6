Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD89ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399A62075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399A62075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeJYGfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:35:52 -0400
Received: from foss.arm.com ([217.140.101.70]:48738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:35:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7488DA78;
        Wed, 24 Oct 2018 15:06:02 -0700 (PDT)
Received: from [10.43.3.86] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD32B3F71D;
        Wed, 24 Oct 2018 15:05:58 -0700 (PDT)
Subject: Re: [RFC v2 12/20] dma-iommu: Implement NESTED_MSI cookie
To:     Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
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
 <167b1683-9dfe-d471-da2e-37bf53278007@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70ff6bee-5775-cccb-b74a-db915c907bcd@arm.com>
Date:   Wed, 24 Oct 2018 23:05:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <167b1683-9dfe-d471-da2e-37bf53278007@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-24 7:44 pm, Auger Eric wrote:
> Hi Robin,
> 
> On 10/24/18 8:02 PM, Robin Murphy wrote:
>> Hi Eric,
>>
>> On 2018-09-18 3:24 pm, Eric Auger wrote:
>>> Up to now, when the type was UNMANAGED, we used to
>>> allocate IOVA pages within a range provided by the user.
>>> This does not work in nested mode.
>>>
>>> If both the host and the guest are exposed with SMMUs, each
>>> would allocate an IOVA. The guest allocates an IOVA (gIOVA)
>>> to map onto the guest MSI doorbell (gDB). The Host allocates
>>> another IOVA (hIOVA) to map onto the physical doorbell (hDB).
>>>
>>> So we end up with 2 unrelated mappings, at S1 and S2:
>>>            S1             S2
>>> gIOVA    ->     gDB
>>>                  hIOVA    ->    hDB
>>>
>>> The PCI device would be programmed with hIOVA.
>>>
>>> iommu_dma_bind_doorbell allows to pass gIOVA/gDB to the host
>>> so that gIOVA can be used by the host instead of re-allocating
>>> a new IOVA. That way the host can create the following nested
>>> mapping:
>>>
>>>            S1           S2
>>> gIOVA    ->    gDB    ->    hDB
>>>
>>> this time, the PCI device will be programmed with the gIOVA MSI
>>> doorbell which is correctly map through the 2 stages.
>>
>> If I'm understanding things correctly, this plus a couple of the
>> preceding patches all add up to a rather involved way of coercing an
>> automatic allocator to only "allocate" predetermined addresses in an
>> entirely known-ahead-of-time manner.
> agreed
>   Given that the guy calling
>> iommu_dma_bind_doorbell() could seemingly just as easily call
>> iommu_map() at that point and not bother with an allocator cookie and
>> all this machinery at all, what am I missing?
> Well iommu_dma_map_msi_msg() gets called and is part of this existing
> MSI mapping machinery. If we do not do anything this function allocates
> an hIOVA that is not involved in any nested setup. So either we coerce
> the allocator in place (which is what this series does) or we unplug the
> allocator to replace this latter with a simple S2 mapping, as you
> suggest, ie. iommu_map(gDB, hDB). Assuming we unplug the allocator, the
> guy who actually calls  iommu_dma_bind_doorbell() knows gDB but does not
> know hDB. So I don't really get how we can simplify things.

OK, there's what I was missing :D

But that then seems to reveal a somewhat bigger problem - if the callers 
are simply registering IPAs, and relying on the ITS driver to grab an 
entry and fill in a PA later, then how does either one know *which* PA 
is supposed to belong to a given IPA in the case where you have multiple 
devices with different ITS targets assigned to the same guest? (and if 
it's possible to assume a guest will use per-device stage 1 mappings and 
present it with a single vITS backed by multiple pITSes, I think things 
start breaking even harder.)

Other than allowing arbitrary disjoint IOVA pages, I'm not sure this 
really works any differently from the existing MSI cookie now that I 
look more closely :/

Robin.

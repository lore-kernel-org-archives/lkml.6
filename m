Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC29CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820BE219EC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820BE219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeGFQqE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:46:04 -0400
Received: from foss.arm.com ([217.140.101.70]:40048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933157AbeGFQqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:46:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A98318A;
        Fri,  6 Jul 2018 09:46:03 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E4B3F2EA;
        Fri,  6 Jul 2018 09:46:02 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>, JuergenUrban@gmx.de
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
 <20180706141926.GA2313@localhost.localdomain>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bd63815c-260e-078f-4184-561c8e54e636@arm.com>
Date:   Fri, 6 Jul 2018 17:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706141926.GA2313@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 15:19, Fredrik Noring wrote:
> Hi Robin,
> 
> On Fri, Jul 06, 2018 at 12:57:11PM +0100, Robin Murphy wrote:
>> On 05/07/18 20:36, Christoph Hellwig wrote:
>>>> -	BUG_ON(!ops);
>>>> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
>>>> -
>>>>    	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>>>>    		return cpu_addr;
>>>> +	BUG_ON(!ops);
>>>> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
>>>
>>> I think doing dma on a device without ops is completely broken no matter
>>> what you think of it, so I very much disagree with that part of the change.
>>>
>>> Also while I don't think not having a dma mask is a good idea even for
>>> a driver purely using dma coherent pools.  If the pools really are on
>>> the device itself I can see why it might not matter, but for the case
>>> commonly used on some ARM SOCs where we just reserve memory for certain
>>> devices from a system pool it very much does matter.
>>>
>>> There really is no good excuse to not set a coherent mask in the drivers.
>>
>> Right, I was rather on the fence about this - on the one hand it is
>> objectively wrong per the API for drivers to call dma_alloc_coherent()
>> without a prior successful dma_set_coherent_mask() call, but then I thought
>> that in the case when they're *only* using it as a proxy for
>> dma_alloc_from_dev_coherent() and explicitly don't want regular allocations
>> from kernel memory to ever happen, then maybe it might be somewhat
>> reasonable. But indeed I hadn't really given enough thought to the
>> reserved-memory carveout case, where we definitely don't want to let a
>> legitimate warning be hidden on a developer's machine but hit by users with
>> different system configurations.
>>
>> Fredrik, are you happy to fix up your driver to initialise a suitable mask
>> at probe time?
> 
> The driver currently only uses dma_declare_coherent_memory and
> dma_release_declared_memory. It allocates 256 KiB of DMA memory from the IOP
> (a MIPS R3000 I/O processor that is separate from the main MIPS R5900) with
> 
> 	iop_dma_addr = iop_alloc(size);
> 
> and then declares it with
> 
> 	dma_declare_coherent_memory(dev,
> 		iop_bus_to_phys(iop_dma_addr),
> 		iop_dma_addr, size, flags);
> 
> where iop_bus_to_phys is:
> 
> #define IOP_MEMORY_BASE_ADDRESS 0x1c000000
> phys_addr_t iop_bus_to_phys(iop_addr_t baddr)
> {
> 	return (u32)baddr + IOP_MEMORY_BASE_ADDRESS;
> }
> 
> Does dma_set_coherent_mask want a device object representing the IOP? Such
> a thing is currently not implemented, but can certainly be done.

Nope, just the same OHCI device as the dma_declare_coherent_memory() call.

> As you noted, the kernel cannot and must not allocate any kind of normal
> memory for this device. Typical DMA addresses 0-0x200000 are mapped to
> 0x1c000000-0x1c200000 and is memory managed exclusively by the IOP. What
> would be a suitable mask for that?

For the sake of accuracy, I guess maybe DMA_BIT_MASK(20) since that's 
what the OHCI's effective addressing capability is, even if it does 
happen to be to remote IOP RAM. Alternatively, there is perhaps some 
degree of argument for deliberately picking a nonzero but useless value 
like 1, although it looks like the MIPS allocator (at least the 
dma-default one) never actually checks whether the page it gets is 
within range of the device's coherent mask, which it probably should do.

> drivers/usb/host/ohci-sm501.c and drivers/usb/host/ohci-tmio.c are similar,
> so I suppose they need to be fixed as well?

Possibly, or maybe they get away with it by virtue of bus code setting 
some default mask. Since those look to be pretty old bits of hardware 
that I know nothing about, I'd be hesitant to start adding stuff. If 
there is anyone still using such things and running mainline on them, I 
guess we'll hear about it in due course...

Robin.

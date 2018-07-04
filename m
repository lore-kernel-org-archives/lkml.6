Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF03A23EB5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF03A23EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeGDM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:57:06 -0400
Received: from foss.arm.com ([217.140.101.70]:36760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeGDM5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:57:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 253877A9;
        Wed,  4 Jul 2018 05:57:04 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0493C3F5BA;
        Wed,  4 Jul 2018 05:57:02 -0700 (PDT)
Subject: Re: DMA mappings and crossing boundaries
To:     benh@au1.ibm.com, Christoph Hellwig <hch@lst.de>
Cc:     Russell Currey <ruscur@au1.ibm.com>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
 <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
 <5f31e833851f5b9a58ca4ed9b5f0a1958cca0efd.camel@au1.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2786eaad-f359-c88c-a42c-ff1b93e78c21@arm.com>
Date:   Wed, 4 Jul 2018 13:57:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5f31e833851f5b9a58ca4ed9b5f0a1958cca0efd.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 14:37, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-02 at 14:06 +0100, Robin Murphy wrote:
> 
>   .../...
> 
> Thanks Robin, I was starting to depair anybody would reply ;-)
> 
>>> AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
>>> HOWTO.txt) as always allocating to the next power-of-2 order, so we
>>> should never have the problem unless we allocate a single chunk larger
>>> than the IOMMU page size.
>>
>> (and even then it's not *that* much of a problem, since it comes down to
>> just finding n > 1 consecutive unused IOMMU entries for exclusive use by
>> that new chunk)
> 
> Yes, this case is not my biggest worry.
> 
>>> For dma_map_sg() however, if a request that has a single "entry"
>>> spawning such a boundary, we need to ensure that the result mapping is
>>> 2 contiguous "large" iommu pages as well.
>>>
>>> However, that doesn't fit well with us re-using existing mappings since
>>> they may already exist and either not be contiguous, or partially exist
>>> with no free hole around them.
>>>
>>> Now, we *could* possibly construe a way to solve this by detecting this
>>> case and just allocating another "pair" (or set if we cross even more
>>> pages) of IOMMU pages elsewhere, thus partially breaking our re-use
>>> scheme.
>>>
>>> But while doable, this introduce some serious complexity in the
>>> implementation, which I would very much like to avoid.
>>>
>>> So I was wondering if you guys thought that was ever likely to happen ?
>>> Do you see reasonable cases where dma_map_sg() would be called with a
>>> list in which a single entry crosses a 256M or 1G boundary ?
>>
>> For streaming mappings of buffers cobbled together out of any old CPU
>> pages (e.g. user memory), you may well happen to get two
>> physically-adjacent pages falling either side of an IOMMU boundary,
>> which comprise all or part of a single request - note that whilst it's
>> probably less likely than the scatterlist case, this could technically
>> happen for dma_map_{page, single}() calls too.
> 
> Could it ? I wouldn't think dma_map_page is allows to cross page
> boundaries ... what about single() ? The main worry is people using
> these things on kmalloc'ed memory

Oh, absolutely - the underlying operation is just "prepare for DMA 
to/from this physically-contiguous region"; the only real difference 
between map_page and map_single is for the sake of the usual "might be 
highmem" vs. "definitely lowmem" dichotomy. Nobody's policing any limits 
on the size and offset parameters (in fact, if anyone asks I would say 
the outcome of the big "offset > PAGE_SIZE" debate for dma_map_sg a few 
months back is valid for dma_map_page too, however silly it may seem).

Of course, given that the allocators tend to give out size/order-aligned 
chunks, I think you'd have to be pretty tricksy to get two allocations 
to line up either side of a large power-of-two boundary *and* go out of 
your way to then make a single request spanning both, but it's certainly 
not illegal. Realistically, the kind of "scrape together a large buffer 
from smaller pieces" code which is liable to hit a boundary-crossing 
case by sheer chance is almost certainly going to be taking the 
sg_alloc_table_from_pages() + dma_map_sg() route for convenience, rather 
than implementing its own merging and piecemeal mapping.

>> Conceptually it looks pretty easy to extend the allocation constraints
>> to cope with that - even the pathological worst case would have an
>> absolute upper bound of 3 IOMMU entries for any one physical region -
>> but if in practice it's a case of mapping arbitrary CPU pages to 32-bit
>> DMA addresses having only 4 1GB slots to play with, I can't really see a
>> way to make that practical :(
> 
> No we are talking about 40-ish-bits of address space, so there's a bit
> of leeway. Of course no scheme will work if the user app tries to map
> more than the GPU can possibly access.
> 
> But with newer AMD adding a few more bits and nVidia being at 47-bits,
> I think we have some margin, it's just that they can't reach our
> discontiguous memory with a normal 'bypass' mapping and I'd rather not
> teach Linux about every single way our HW can scatter memory accross
> nodes, so an "on demand" mechanism is by far the most flexible way to
> deal with all configurations.
> 
>> Maybe the best compromise would be some sort of hybrid scheme which
>> makes sure that one of the IOMMU entries always covers the SWIOTLB
>> buffer, and invokes software bouncing for the awkward cases.
> 
> Hrm... not too sure about that. I'm happy to limit that scheme to well
> known GPU vendor/device IDs, and SW bouncing is pointless in these
> cases. It would be nice if we could have some kind of guarantee that a
> single mapping or sglist entry never crossed a specific boundary
> though... We more/less have that for 4G already (well, we are supposed
> to at least). Who are the main potential problematic subsystems here ?
> I'm thinking network skb allocation pools ... and page cache if it
> tries to coalesce entries before issuing the map request, does it ?

I don't know of anything definite off-hand, but my hunch is to be most 
wary of anything wanting to do zero-copy access to large buffers in 
userspace pages. In particular, sg_alloc_table_from_pages() lacks any 
kind of boundary enforcement (and most all users don't even use the 
segment-length-limiting variant either), so I'd say any caller of that 
currently has a very small, but nonzero, probability of spoiling your day.

Robin.

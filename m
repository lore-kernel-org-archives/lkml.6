Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E18C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD02533E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DD02533E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeGBNGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:06:12 -0400
Received: from foss.arm.com ([217.140.101.70]:59962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbeGBNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:06:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51B8A18A;
        Mon,  2 Jul 2018 06:06:09 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BEA63F5AD;
        Mon,  2 Jul 2018 06:06:08 -0700 (PDT)
Subject: Re: DMA mappings and crossing boundaries
To:     benh@au1.ibm.com, Christoph Hellwig <hch@lst.de>
Cc:     Russell Currey <ruscur@au1.ibm.com>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
Date:   Mon, 2 Jul 2018 14:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On 24/06/18 08:32, Benjamin Herrenschmidt wrote:
> Hi Folks !
> 
> So due work around issues with devices having to strict limitations in
> DMA address bits (GPUs ugh....) on POWER, we've been playing with a
> mechanism that does dynamic mapping in the IOMMU but using a very large
> IOMMU page size (256M on POWER8 and 1G on POWER9) for performances.
> 
> Now, with such page size, we can't just pop out new entries for every
> DMA map, we need to try to re-use entries for mappings in the same
> "area".
> 
> We've prototypes something using refcounts on the entires. It does
> imply some locking which is potentially problematic, and we'll be
> looking at options there long run, but it works... so far.
> 
> My worry is that it will fail if we ever get a mapping request (or
> coherent allocation request) that spawns one of those giant pages
> boundaries. At least our current implementation.
> 
> AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
> HOWTO.txt) as always allocating to the next power-of-2 order, so we
> should never have the problem unless we allocate a single chunk larger
> than the IOMMU page size.

(and even then it's not *that* much of a problem, since it comes down to 
just finding n > 1 consecutive unused IOMMU entries for exclusive use by 
that new chunk)

> For dma_map_sg() however, if a request that has a single "entry"
> spawning such a boundary, we need to ensure that the result mapping is
> 2 contiguous "large" iommu pages as well.
> 
> However, that doesn't fit well with us re-using existing mappings since
> they may already exist and either not be contiguous, or partially exist
> with no free hole around them.
> 
> Now, we *could* possibly construe a way to solve this by detecting this
> case and just allocating another "pair" (or set if we cross even more
> pages) of IOMMU pages elsewhere, thus partially breaking our re-use
> scheme.
> 
> But while doable, this introduce some serious complexity in the
> implementation, which I would very much like to avoid.
> 
> So I was wondering if you guys thought that was ever likely to happen ?
> Do you see reasonable cases where dma_map_sg() would be called with a
> list in which a single entry crosses a 256M or 1G boundary ?

For streaming mappings of buffers cobbled together out of any old CPU 
pages (e.g. user memory), you may well happen to get two 
physically-adjacent pages falling either side of an IOMMU boundary, 
which comprise all or part of a single request - note that whilst it's 
probably less likely than the scatterlist case, this could technically 
happen for dma_map_{page, single}() calls too.

Conceptually it looks pretty easy to extend the allocation constraints 
to cope with that - even the pathological worst case would have an 
absolute upper bound of 3 IOMMU entries for any one physical region - 
but if in practice it's a case of mapping arbitrary CPU pages to 32-bit 
DMA addresses having only 4 1GB slots to play with, I can't really see a 
way to make that practical :(

Maybe the best compromise would be some sort of hybrid scheme which 
makes sure that one of the IOMMU entries always covers the SWIOTLB 
buffer, and invokes software bouncing for the awkward cases.

Robin.

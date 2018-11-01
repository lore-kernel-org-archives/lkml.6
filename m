Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA202064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA202064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeKBEhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:37:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeKBEhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:37:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872FAA78;
        Thu,  1 Nov 2018 12:32:42 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0AE3F71D;
        Thu,  1 Nov 2018 12:32:41 -0700 (PDT)
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181101180439.GA4746@Asurada-Nvidia.nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <58e3d16e-837c-0610-9e1c-0562babcdd82@arm.com>
Date:   Thu, 1 Nov 2018 19:32:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101180439.GA4746@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 18:04, Nicolin Chen wrote:
> Hi Robin,
> 
> Thanks for the comments.
> 
> On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
>> On 31/10/2018 20:03, Nicolin Chen wrote:
>>> The addresses within a single page are always contiguous, so it's
>>> not so necessary to allocate one single page from CMA area. Since
>>> the CMA area has a limited predefined size of space, it might run
>>> out of space in some heavy use case, where there might be quite a
>>> lot CMA pages being allocated for single pages.
>>>
>>> This patch tries to skip CMA allocations of single pages and lets
>>> them go through normal page allocations. This would save resource
>>> in the CMA area for further more CMA allocations.
>>
>> In general, this seems to make sense to me. It does represent a theoretical
>> change in behaviour for devices which have their own CMA area somewhere
>> other than kernel memory, and only ever make non-atomic allocations, but I'm
>> not sure whether that's a realistic or common enough case to really worry
>> about.
> 
> Hmm..I don't quite understand the part of worrying its realisticness.
> Would you mind elaborating a bit?

I only mean the case where a driver previously happened to get single 
pages allocated from a per-device CMA area, would now always get them 
fulfilled from regular kernel memory instead, and actually cares about 
the difference. As I say, that's a contrived case that I doubt is 
honestly a significant concern, but it's not *entirely* inconceivable. 
I've just been bitten before by drivers relying on specific DMA API 
implementation behaviour which was never guaranteed or even necessarily 
correct by the terms of the API itself, so I'm naturally wary of the 
corner cases ;)

On second thought, however, I suppose we could always key this off 
DMA_ATTR_FORCE_CONTIGUOUS as well if we really want - technically it has 
a more general meaning than "only ever allocate from CMA", but in 
practice if that's the behaviour a driver wants, then that flag is 
already the only way it can even hope to get dma_alloc_coherent() to 
comply anywhere near reliably.

> As I tested this change on Tegra186
> board, and saw some single-page allocations have been directed to the
> normal allocation; and the "CmaFree" size reported from /proc/meminfo
> is also increased. Does this mean it's realistic?

Indeed - I happen to have CMA debug enabled for no good reason in my 
current development config, and on my relatively unexciting Juno board 
single-page allocations turn out to be the majority by number, even if 
not by total consumption:

[    0.519663] cma: cma_alloc(cma (____ptrval____), count 64, align 6)
[    0.527508] cma: cma_alloc(): returned (____ptrval____)
[    3.768066] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    3.774566] cma: cma_alloc(): returned (____ptrval____)
[    3.860097] cma: cma_alloc(cma (____ptrval____), count 1875, align 8)
[    3.867150] cma: cma_alloc(): returned (____ptrval____)
[    3.920796] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
[    3.927093] cma: cma_alloc(): returned (____ptrval____)
[    3.932326] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
[    3.938643] cma: cma_alloc(): returned (____ptrval____)
[    4.022188] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    4.028415] cma: cma_alloc(): returned (____ptrval____)
[    4.033600] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    4.039786] cma: cma_alloc(): returned (____ptrval____)
[    4.044968] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    4.051150] cma: cma_alloc(): returned (____ptrval____)
[    4.113556] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    4.119785] cma: cma_alloc(): returned (____ptrval____)
[    5.012654] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
[    5.019047] cma: cma_alloc(): returned (____ptrval____)
[   11.485179] cma: cma_alloc(cma 000000009dd074ee, count 1, align 0)
[   11.492096] cma: cma_alloc(): returned 000000009264a86c
[   12.269355] cma: cma_alloc(cma 000000009dd074ee, count 1875, align 8)
[   12.277535] cma: cma_alloc(): returned 00000000d7bb9ae5
[   12.286110] cma: cma_alloc(cma 000000009dd074ee, count 4, align 2)
[   12.292507] cma: cma_alloc(): returned 0000000007ba7a39

I don't have any exciting peripherals to really exercise the coherent 
allocator, but I imagine that fragmentation is probably just as good a 
reason as total CMA usage for avoiding trivial allocations by default.

Robin.

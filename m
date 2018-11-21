Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CFF2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CFF2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbeKVJDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:03:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33460 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731518AbeKVJDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:03:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F4A36C2;
        Wed, 21 Nov 2018 14:27:01 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E503F5CF;
        Wed, 21 Nov 2018 14:26:53 -0800 (PST)
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To:     Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
Date:   Wed, 21 Nov 2018 22:26:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121213853.GL3065@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-21 9:38 pm, Matthew Wilcox wrote:
> On Wed, Nov 21, 2018 at 06:20:02PM +0000, Christopher Lameter wrote:
>> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
>>
>>> This is a follow-up to the discussion in [1], to make sure that the page
>>> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
>>> physical address space.
>>
>> Page tables? This means you need a page frame? Why go through the slab
>> allocators?
> 
> Because this particular architecture has sub-page-size PMD page tables.
> We desperately need to hoist page table allocation out of the architectures;
> there're a bunch of different implementations and they're mostly bad,
> one way or another.

These are IOMMU page tables, rather than CPU ones, so we're already well 
outside arch code - indeed the original motivation of io-pgtable was to 
be entirely independent of the p*d types and arch-specific MM code (this 
Armv7 short-descriptor format is already "non-native" when used by 
drivers in an arm64 kernel).

There are various efficiency reasons for using regular kernel memory 
instead of coherent DMA allocations - for the most part it works well, 
we just have the odd corner case like this one where the 32-bit format 
gets used on 64-bit systems such that the tables themselves still need 
to be allocated below 4GB (although the final output address can point 
at higher memory by virtue of the IOMMU in question not implementing 
permissions and repurposing some of those PTE fields as extra address bits).

TBH, if this DMA32 stuff is going to be contentious we could possibly 
just rip out the offending kmem_cache - it seemed like good practice for 
the use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied 
upon to give the same 1KB alignment and chance of succeeding as the 
equivalent kmem_cache_alloc(), then we could quite easily make do with 
that instead.

Thanks,
Robin.

> For each level of page table we generally have three cases:
> 
> 1. single page
> 2. sub-page, naturally aligned
> 3. multiple pages, naturally aligned
> 
> for 1 and 3, the page allocator will do just fine.
> for 2, we should have a per-MM page_frag allocator.  s390 already has
> something like this, although it's more complicated.  ppc also has
> something a little more complex for the cases when it's configured with
> a 64k page size but wants to use a 4k page table entry.
> 
> I'd like x86 to be able to simply do:
> 
> #define pte_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
> #define pmd_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
> #define pud_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
> #define p4d_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
> 
> An architecture with 4k page size and needing a 16k PMD would do:
> 
> #define pmd_alloc_one(mm, addr) page_alloc_table(mm, addr, 2)
> 
> while an architecture with a 64k page size needing a 4k PTE would do:
> 
> #define ARCH_PAGE_TABLE_FRAG
> #define pte_alloc_one(mm, addr) pagefrag_alloc_table(mm, addr, 4096)
> 
> I haven't had time to work on this, but perhaps someone with a problem
> that needs fixing would like to, instead of burying yet another awful
> implementation away in arch/ somewhere.
> 

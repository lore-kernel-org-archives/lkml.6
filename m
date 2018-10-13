Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881DFC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3E0204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cfm6fJZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3E0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeJMHuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 03:50:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10192 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJMHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 03:50:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc139320001>; Fri, 12 Oct 2018 17:15:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 17:15:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 17:15:52 -0700
Received: from [10.2.173.107] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 13 Oct
 2018 00:15:51 +0000
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
To:     Balbir Singh <bsingharora@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com> <20181012105612.GK8537@350D>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b115b2ce-8fe8-db03-da9c-452511c8ed27@nvidia.com>
Date:   Fri, 12 Oct 2018 17:15:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012105612.GK8537@350D>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539389746; bh=FMtUn+bpvsQtJYHyG/4/qDRUUFNJeag/Psp7i7mvpxA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Cfm6fJZekKoFUbUiREQ9heor73hEje8paCNygLLeiB6W0h38X+el1/KYJzHEay4Hp
         nTJfUGu2EIPluiTpkiU41CP7iNEO/k2eGBH05wZmgGp7VUp1pvC+m4TulJfWyWXqw4
         tRFPFwOSFzwASf4e7IgzN5R9BvHfDke6afKraygouhc34+Htum0JnZHty/dlhs7i6t
         FfhjtMtK/I+MKcN3YYSYQPvLigRCNzNFB+CSikN/ZJpAYRhaE9j5ZUoMnctKGgc/IN
         Z2EpWvg8tWGHZezizLWYVmgyruO26yyBENK3q+1vYbbYZxtwfvJUolJEnAjsgzknE/
         LiClXzVg9WVhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 3:56 AM, Balbir Singh wrote:
> On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>> + * Because page->dma_pinned_flags is unioned with page->lru, any page that
>> + * uses these flags must NOT be on an LRU. That's partly enforced by
>> + * ClearPageDmaPinned, which gives the page back to LRU.
>> + *
>> + * PageDmaPinned also corresponds to PageTail (the 0th bit in the first union
>> + * of struct page), and this flag is checked without knowing whether it is a
>> + * tail page or a PageDmaPinned page. Therefore, start the flags at bit 1 (0x2),
>> + * rather than bit 0.
>> + */
>> +#define PAGE_DMA_PINNED		0x2
>> +#define PAGE_DMA_PINNED_FLAGS	(PAGE_DMA_PINNED)
>> +
> 
> This is really subtle, additional changes to compound_head will need to coordinate
> with these flags? Also doesn't this bit need to be unique across all structs in
> the union? I guess that is guaranteed by the fact that page == compound_head(page)
> as per your assertion, but I've forgotten why that is true. Could you please
> add some commentary on that
> 

Yes, agreed. I've rewritten and augmented that comment block, plus removed the 
PAGE_DMA_PINNED_FLAGS (there are no more bits available, so it's just misleading 
to even have it). So now it looks like this:

/*
 * Because page->dma_pinned_flags is unioned with page->lru, any page that
 * uses these flags must NOT be on an LRU. That's partly enforced by
 * ClearPageDmaPinned, which gives the page back to LRU.
 *
 * PageDmaPinned is checked without knowing whether it is a tail page or a
 * PageDmaPinned page. For that reason, PageDmaPinned avoids PageTail (the 0th
 * bit in the first union of struct page), and instead uses bit 1 (0x2),
 * rather than bit 0.
 *
 * PageDmaPinned can only be used if no other systems are using the same bit
 * across the first struct page union. In this regard, it is similar to
 * PageTail, and in fact, because of PageTail's constraint that bit 0 be left
 * alone, bit 1 is also left alone so far: other union elements (ignoring tail
 * pages) put pointers there, and pointer alignment leaves the lower two bits
 * available.
 *
 * So, constraints include:
 *
 *     -- Only use PageDmaPinned on non-tail pages.
 *     -- Remove the page from any LRU list first.
 */
#define PAGE_DMA_PINNED		0x2

/*
 * Because these flags are read outside of a lock, ensure visibility between
 * different threads, by using READ|WRITE_ONCE.
 */
static __always_inline int PageDmaPinned(struct page *page)
{
	VM_BUG_ON(page != compound_head(page));
	return (READ_ONCE(page->dma_pinned_flags) & PAGE_DMA_PINNED) != 0;
}

[...]
>> +static __always_inline void SetPageDmaPinned(struct page *page)
>> +{
>> +	VM_BUG_ON(page != compound_head(page));
> 
> VM_BUG_ON(!list_empty(&page->lru))


There is only one place where we set this flag, and that is when (in patch 6/6)
transitioning from a page that might (or might not) have been
on an LRU. In that case, the calling code has already corrupted page->lru, by
writing to page->dma_pinned_count, which is unions with page->lru:

		atomic_set(&page->dma_pinned_count, 1);
		SetPageDmaPinned(page);

...so it would be inappropriate to call a list function, such as 
list_empty(), on that field.  Let's just leave it as-is.


> 
>> +	WRITE_ONCE(page->dma_pinned_flags, PAGE_DMA_PINNED);
>> +}
>> +
>> +static __always_inline void ClearPageDmaPinned(struct page *page)
>> +{
>> +	VM_BUG_ON(page != compound_head(page));
>> +	VM_BUG_ON_PAGE(!PageDmaPinnedFlags(page), page);
>> +
>> +	/* This does a WRITE_ONCE to the lru.next, which is also the
>> +	 * page->dma_pinned_flags field. So in addition to restoring page->lru,
>> +	 * this provides visibility to other threads.
>> +	 */
>> +	INIT_LIST_HEAD(&page->lru);
> 
> This assumes certain things about list_head, why not use the correct
> initialization bits.
> 

Yes, OK, changed to:

static __always_inline void ClearPageDmaPinned(struct page *page)
{
	VM_BUG_ON(page != compound_head(page));
	VM_BUG_ON_PAGE(!PageDmaPinned(page), page);

	/* Provide visibility to other threads: */
	WRITE_ONCE(page->dma_pinned_flags, 0);

	/*
	 * Safety precaution: restore the list head, before possibly returning
	 * the page to other subsystems.
	 */
	INIT_LIST_HEAD(&page->lru);
}



-- 
thanks,
John Hubbard
NVIDIA

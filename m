Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E7C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B23820865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SorqYFiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B23820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeJMIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:08:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10722 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeJMIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:08:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc13d6a0000>; Fri, 12 Oct 2018 17:33:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 17:33:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Oct 2018 17:33:51 -0700
Received: from [10.2.173.107] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 13 Oct
 2018 00:33:51 +0000
Subject: Re: [PATCH 6/6] mm: track gup pages with page->dma_pinned_* fields
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
 <20181012060014.10242-7-jhubbard@nvidia.com> <20181012110728.GL8537@350D>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <af901585-3f9a-da35-81a4-50ea341844c4@nvidia.com>
Date:   Fri, 12 Oct 2018 17:33:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012110728.GL8537@350D>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539390826; bh=DUdvDPQxRCczCuYi0vUgyjVLHDw8c2xsPK7rTvBnrv0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SorqYFiTbIVJe3TRr10D0pG+MWMk4stQMRiPR4L2F9zFTDBZr1wWA1XLtFaViUAik
         RP22X5P+ZOLWCWMfJ8BTpMZdPh7O6A302VsnTMfkT5P/MnCpLlkSQmmHkY7WlPhu+Q
         95amzjYfuIGawrNBI0AUzqh4ro0rRag1nfN1Gi3vFjGI/YFhYIw/Mjf4YMohOf5oux
         tj59nO39oeXtzojYawdTnwPtetUsoBUhb1mUmCp8njvwLLnF15YXWs8MAEQiHPPlhv
         DkKL5pahHGuMzmocRRr1EhaT/9zN/zRDj6NcBBubcAFid4AOyoOl/8jdR31Ydf5A+1
         a0sPsh3RLOfBw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 4:07 AM, Balbir Singh wrote:
> On Thu, Oct 11, 2018 at 11:00:14PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>> +static int pin_page_for_dma(struct page *page)
>> +{
>> +	int ret = 0;
>> +	struct zone *zone;
>> +
>> +	page = compound_head(page);
>> +	zone = page_zone(page);
>> +
>> +	spin_lock(zone_gup_lock(zone));
>> +
>> +	if (PageDmaPinned(page)) {
>> +		/* Page was not on an LRU list, because it was DMA-pinned. */
>> +		VM_BUG_ON_PAGE(PageLRU(page), page);
>> +
>> +		atomic_inc(&page->dma_pinned_count);
>> +		goto unlock_out;
>> +	}
>> +
>> +	/*
>> +	 * Note that page->dma_pinned_flags is unioned with page->lru.
>> +	 * Therefore, the rules are: checking if any of the
>> +	 * PAGE_DMA_PINNED_FLAGS bits are set may be done while page->lru
>> +	 * is in use. However, setting those flags requires that
>> +	 * the page is both locked, and also, removed from the LRU.
>> +	 */
>> +	ret = isolate_lru_page(page);
>> +
> 
> isolate_lru_page() can be expensive and in terms of the overall locking order
> sounds like zone_gup_lock is higher in the hierarchy than the locks taken
> inside isolate_lru_page()
 
As for the expensive part, that is a concern. But I do think we need some lock
here. The hierarchy shouldn't be a problem, given that this is a new lock. But
I'm not sure how to make this better. In any case, I think it should work--note that
the zone_lru_lock, within isolate_lru_page(), is of similar use, and is held
for a similar duration, so...maybe not really a problem?


>> +	if (ret == 0) {
>> +		/* Avoid problems later, when freeing the page: */
>> +		ClearPageActive(page);
>> +		ClearPageUnevictable(page);
>> +
>> +		/* counteract isolate_lru_page's effects: */
>> +		put_page(page);
> 
> Can the page get reaped here? What's the expected page count?

Nope. The page_count is at least one, because get_user_pages() incremented it.

 
>> +
>> +		atomic_set(&page->dma_pinned_count, 1);
>> +		SetPageDmaPinned(page);
>> +	}
>> +
>> +unlock_out:
>> +	spin_unlock(zone_gup_lock(zone));
>> +
>> +	return ret;
>> +}
>> +
>>  static struct page *no_page_table(struct vm_area_struct *vma,
>>  		unsigned int flags)
>>  {
>> @@ -659,7 +704,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>  		unsigned int gup_flags, struct page **pages,
>>  		struct vm_area_struct **vmas, int *nonblocking)
>>  {
>> -	long i = 0;
>> +	long i = 0, j;
>>  	int err = 0;
>>  	unsigned int page_mask;
>>  	struct vm_area_struct *vma = NULL;
>> @@ -764,6 +809,10 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>  	} while (nr_pages);
>>  
>>  out:
>> +	if (pages)
>> +		for (j = 0; j < i; j++)
>> +			pin_page_for_dma(pages[j]);
>> +
> 
> Why does get_user_pages() unconditionally pin_page_for_dma?

That's the grand plan here: get_user_pages() now means "unconditionally pin the page for dma".
If you didn't want that, then either release it quickly (many callers do), or use a different
way of pinning or acquiring the page.

> 
>>  	return i ? i : err;
>>  }
>>  
>> @@ -1841,7 +1890,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>  			struct page **pages)
>>  {
>>  	unsigned long addr, len, end;
>> -	int nr = 0, ret = 0;
>> +	int nr = 0, ret = 0, i;
>>  
>>  	start &= PAGE_MASK;
>>  	addr = start;
>> @@ -1862,6 +1911,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>  		ret = nr;
>>  	}
>>  
>> +	for (i = 0; i < nr; i++)
>> +		pin_page_for_dma(pages[i]);
> 
> Why does get_user_pages_fast() unconditionally pin_page_for_dma?

All of the get_user_pages*() variants need to follow the same rules, so the same 
explanation as above, applies here also.

>> +
>>  	if (nr < nr_pages) {
>>  		/* Try to get the remaining pages with get_user_pages */
>>  		start += nr << PAGE_SHIFT;
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e79cb59552d9..af9719756081 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2335,6 +2335,11 @@ static void lock_page_lru(struct page *page, int *isolated)
>>  	if (PageLRU(page)) {
>>  		struct lruvec *lruvec;
>>  
>> +		/* LRU and PageDmaPinned are mutually exclusive: they use the
>> +		 * same fields in struct page, but for different purposes.
>> +		 */
> 
> Comment style needs fixing
 
oops, thanks for spotting those, will fix.


-- 
thanks,
John Hubbard
NVIDIA


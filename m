Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910ED247A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910ED247A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeGBVIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:08:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1034 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeGBVIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:08:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a945b0000>; Mon, 02 Jul 2018 14:08:43 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 14:08:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Jul 2018 14:08:45 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 21:08:44 +0000
Subject: Re: [PATCH v2 6/6] mm: page_mkclean, ttu: handle pinned pages
To:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-7-jhubbard@nvidia.com>
 <20180702101542.fi7ndfkg5fpzodey@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b64bda3d-903d-c3b9-f315-bf7a7302e425@nvidia.com>
Date:   Mon, 2 Jul 2018 14:07:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702101542.fi7ndfkg5fpzodey@quack2.suse.cz>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 03:15 AM, Jan Kara wrote:
> On Sun 01-07-18 17:56:54, john.hubbard@gmail.com wrote:
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 9d142b9b86dc..c4bc8d216746 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -931,6 +931,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>  	int kill = 1, forcekill;
>>  	struct page *hpage = *hpagep;
>>  	bool mlocked = PageMlocked(hpage);
>> +	bool skip_pinned_pages = false;
> 
> I'm not sure we can afford to wait for page pins when handling page
> poisoning. In an ideal world we should but... But I guess this is for
> someone understanding memory poisoning better to judge.


OK, then until I hear otherwise, in the next version I'll set 
skipped_pinned_pages = true here, based on the idea that it's probably
better to be sure we don't hang while trying to remove a bad page. It's
hard to achieve perfection in the presence of a memory failure.

> 
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 6db729dc4c50..c137c43eb2ad 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -879,6 +879,26 @@ int page_referenced(struct page *page,
>>  	return pra.referenced;
>>  }
>>  
>> +/* Must be called with pinned_dma_lock held. */
>> +static void wait_for_dma_pinned_to_clear(struct page *page)
>> +{
>> +	struct zone *zone = page_zone(page);
>> +
>> +	while (PageDmaPinnedFlags(page)) {
>> +		spin_unlock(zone_gup_lock(zone));
>> +
>> +		schedule();
>> +
>> +		spin_lock(zone_gup_lock(zone));
>> +	}
>> +}
> 
> Ouch, we definitely need something better here. Either reuse the
> page_waitqueue() mechanism or create at least a global wait queue for this
> (I don't expect too much contention on the waitqueue and even if there
> eventually is, we can switch to page_waitqueue() when we find it).  But
> this is a no-go...

Yes, no problem. At one point I had a separate bit waiting queue, which was
only a few lines of code to do, but I dropped it because I thought that maybe 
it was overkill. I'll put it back in.

> 
>> +
>> +struct page_mkclean_info {
>> +	int cleaned;
>> +	int skipped;
>> +	bool skip_pinned_pages;
>> +};
>> +
>>  static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>>  			    unsigned long address, void *arg)
>>  {
>> @@ -889,7 +909,24 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>>  		.flags = PVMW_SYNC,
>>  	};
>>  	unsigned long start = address, end;
>> -	int *cleaned = arg;
>> +	struct page_mkclean_info *mki = (struct page_mkclean_info *)arg;
>> +	bool is_dma_pinned;
>> +	struct zone *zone = page_zone(page);
>> +
>> +	/* Serialize with get_user_pages: */
>> +	spin_lock(zone_gup_lock(zone));
>> +	is_dma_pinned = PageDmaPinned(page);
> 
> Hum, why do you do this for each page table this is mapped in? Also the
> locking is IMHO going to hurt a lot and we need to avoid it.
> 
> What I think needs to happen is that in page_mkclean(), after you've
> cleared all the page tables, you check PageDmaPinned() and wait if needed.
> Page cannot be faulted in again as we hold page lock and so races with
> concurrent GUP are fairly limited. So with some careful ordering & memory
> barriers you should be able to get away without any locking. Ditto for the
> unmap path...
> 

I guess I was thinking about this backwards. It would work much better if
we go ahead and write protect or unmap first, let things drain, and wait later.
Very nice!


thanks,
-- 
John Hubbard
NVIDIA

Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7752C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5FC21855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfBZMGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:56678 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfBZMGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:50 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gybVT-0007Vl-OC; Tue, 26 Feb 2019 15:06:43 +0300
Subject: Re: [PATCH 1/5] mm/workingset: remove unused @mapping argument in
 workingset_eviction()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
 <e56aea36-f454-a75f-5f83-4150b87c9c15@suse.cz>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <9c4d34b8-60b5-a05b-c196-b1cc4ecb235c@virtuozzo.com>
Date:   Tue, 26 Feb 2019 15:07:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e56aea36-f454-a75f-5f83-4150b87c9c15@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/19 3:01 PM, Vlastimil Babka wrote:
> On 2/22/19 6:43 PM, Andrey Ryabinin wrote:
>> workingset_eviction() doesn't use and never did use the @mapping argument.
>> Remove it.
>>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> ---
>>  include/linux/swap.h | 2 +-
>>  mm/vmscan.c          | 2 +-
>>  mm/workingset.c      | 3 +--
>>  3 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 649529be91f2..fc50e21b3b88 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -307,7 +307,7 @@ struct vma_swap_readahead {
>>  };
>>  
>>  /* linux/mm/workingset.c */
>> -void *workingset_eviction(struct address_space *mapping, struct page *page);
>> +void *workingset_eviction(struct page *page);
>>  void workingset_refault(struct page *page, void *shadow);
>>  void workingset_activation(struct page *page);
>>  
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index ac4806f0f332..a9852ed7b97f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -952,7 +952,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>>  		 */
>>  		if (reclaimed && page_is_file_cache(page) &&
>>  		    !mapping_exiting(mapping) && !dax_mapping(mapping))
>> -			shadow = workingset_eviction(mapping, page);
>> +			shadow = workingset_eviction(page);
>>  		__delete_from_page_cache(page, shadow);
>>  		xa_unlock_irqrestore(&mapping->i_pages, flags);
>>  
>> diff --git a/mm/workingset.c b/mm/workingset.c
>> index dcb994f2acc2..0906137760c5 100644
>> --- a/mm/workingset.c
>> +++ b/mm/workingset.c
>> @@ -215,13 +215,12 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
>>  
>>  /**
>>   * workingset_eviction - note the eviction of a page from memory
>> - * @mapping: address space the page was backing
>>   * @page: the page being evicted
>>   *
>>   * Returns a shadow entry to be stored in @mapping->i_pages in place
> 
> The line above still references @mapping, I guess kerneldoc build will
> complain?
> 

Maybe. Will replace it with @page->mapping->i_pages

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCUHzU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:55:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbeCUHzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:55:19 -0400
Subject: Re: [RFC PATCH v2 2/4] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-3-aaron.lu@intel.com>
 <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
 <20180320141101.GB2033@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5b1f7ef5-0dca-c35f-aba9-3b55f81740b2@suse.cz>
Date: Wed, 21 Mar 2018 08:53:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320141101.GB2033@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 03:11 PM, Aaron Lu wrote:
> On Tue, Mar 20, 2018 at 12:45:50PM +0100, Vlastimil Babka wrote:
>> But why, with all the prefetching in place?
> 
> The prefetch is just for its order 0 buddy, if merge happens, then its
> order 1 buddy will also be checked and on and on, so the cache misses
> are much more in merge mode.

I see.

>> Not thrilled about such disruptive change in the name of a
>> microbenchmark :/ Shouldn't normally the pcplists hide the overhead?
> 
> Sadly, with the default pcp count, it didn't avoid the lock contention.
> We can of course increase pcp->count to a large enough value to avoid
> entering buddy and thus avoid zone->lock contention, but that would
> require admin to manually change the value on a per-machine per-workload
> basis I believe.

Well, anyone who really cares about performance has to invest some time
to tuning anyway, I believe?

>> If not, wouldn't it make more sense to turn zone->lock into a range lock?
> 
> Not familiar with range lock, will need to take a look at it, thanks for
> the pointer.

The suggestion was rather quick and not well thought-out. Range lock
itself is insufficient - for merging/splitting buddies it's ok for
working with struct pages because the candidate buddies are within a
MAX_ORDER range. But the freelists contain pages from the whole zone.

>>
>>> A new document file called "struct_page_filed" is added to explain
>>> the newly reused field in "struct page".
>>
>> Sounds rather ad-hoc for a single field, I'd rather document it via
>> comments.
> 
> Dave would like to have a document to explain all those "struct page"
> fields that are repurposed under different scenarios and this is the
> very start of the document :-)

Oh, I see.

> I probably should have explained the intent of the document more.
> 
> Thanks for taking a look at this.
> 
>>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>>> ---
>>>  Documentation/vm/struct_page_field |  5 +++
>>>  include/linux/mm_types.h           |  1 +
>>>  mm/compaction.c                    | 13 +++++-
>>>  mm/internal.h                      | 27 ++++++++++++
>>>  mm/page_alloc.c                    | 89 +++++++++++++++++++++++++++++++++-----
>>>  5 files changed, 122 insertions(+), 13 deletions(-)
>>>  create mode 100644 Documentation/vm/struct_page_field
>>>

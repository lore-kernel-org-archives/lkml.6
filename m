Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935621AbeCCAjG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:39:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42800 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935606AbeCCAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:39:05 -0500
Subject: Re: [PATCH 1/1] mm: make start_isolate_page_range() fail if already
 isolated
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20180226191054.14025-1-mike.kravetz@oracle.com>
 <20180226191054.14025-2-mike.kravetz@oracle.com>
 <20180302160607.570e13f2157f56503fe1bdaa@linux-foundation.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3887b37d-2bc0-1eff-9aec-6a99cc0715fb@oracle.com>
Date: Fri, 2 Mar 2018 16:38:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180302160607.570e13f2157f56503fe1bdaa@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=931
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803030007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 04:06 PM, Andrew Morton wrote:
> On Mon, 26 Feb 2018 11:10:54 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> start_isolate_page_range() is used to set the migrate type of a
>> set of page blocks to MIGRATE_ISOLATE while attempting to start
>> a migration operation.  It assumes that only one thread is
>> calling it for the specified range.  This routine is used by
>> CMA, memory hotplug and gigantic huge pages.  Each of these users
>> synchronize access to the range within their subsystem.  However,
>> two subsystems (CMA and gigantic huge pages for example) could
>> attempt operations on the same range.  If this happens, page
>> blocks may be incorrectly left marked as MIGRATE_ISOLATE and
>> therefore not available for page allocation.
>>
>> Without 'locking code' there is no easy way to synchronize access
>> to the range of page blocks passed to start_isolate_page_range.
>> However, if two threads are working on the same set of page blocks
>> one will stumble upon blocks set to MIGRATE_ISOLATE by the other.
>> In such conditions, make the thread noticing MIGRATE_ISOLATE
>> clean up as normal and return -EBUSY to the caller.
>>
>> This will allow start_isolate_page_range to serve as a
>> synchronization mechanism and will allow for more general use
>> of callers making use of these interfaces.  So, update comments
>> in alloc_contig_range to reflect this new functionality.
>>
>> ...
>>
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -28,6 +28,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
>>  
>>  	spin_lock_irqsave(&zone->lock, flags);
>>  
>> +	/*
>> +	 * We assume we are the only ones trying to isolate this block.
>> +	 * If MIGRATE_ISOLATE already set, return -EBUSY
>> +	 */
>> +	if (is_migrate_isolate_page(page))
>> +		goto out;
>> +
>>  	pfn = page_to_pfn(page);
>>  	arg.start_pfn = pfn;
>>  	arg.nr_pages = pageblock_nr_pages;
> 
> Seems a bit ugly and I'm not sure that it's correct.  If the loop in
> start_isolate_page_range() gets partway through a number of pages then
> we hit the race, start_isolate_page_range() will then go and "undo" the
> work being done by the thread which it is racing against?

I agree that it is a bit ugly.  However, when a thread hits the above
condition it will only undo what it has done.  Only one thread is able
to set migrate state to isolate (under the zone lock).  So, a thread
will only undo what it has done.

The exact problem of one thread undoing what another thread has done
is possible with the code today and is what this patch is attempting
to address.

> Even if that can't happen, blundering through a whole bunch of pages
> then saying whoops then undoing everything is unpleasing.
> 
> Should we be looking at preventing these races at a higher level?

I could not immediately come up with a good idea here.  The zone lock
would be the obvious choice, but I don't think we want to hold it while
examining each of the page blocks.  Perhaps a new lock or semaphore
associated with the zone?  I'm open to suggestions.

-- 
Mike Kravetz

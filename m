Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B04C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD386223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD386223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeKLVdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:33:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:42294 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeKLVdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:33:06 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gMAZZ-00069c-K3; Mon, 12 Nov 2018 14:40:05 +0300
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
To:     Jan Kara <jack@suse.cz>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
 <20181112113153.GC7175@quack2.suse.cz>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2abdb97e-0fed-0fb5-6941-e7afcc9e0209@virtuozzo.com>
Date:   Mon, 12 Nov 2018 14:40:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112113153.GC7175@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/18 2:31 PM, Jan Kara wrote:
> On Mon 12-11-18 12:57:34, Pavel Tikhomirov wrote:
>> If all pages are deleted from the mapping by memory reclaim and also
>> moved to the cleancache:
>>
>> __delete_from_page_cache
>>   (no shadow case)
>>   unaccount_page_cache_page
>>     cleancache_put_page
>>   page_cache_delete
>>     mapping->nrpages -= nr
>>     (nrpages becomes 0)
>>
>> We don't clean the cleancache for an inode after final file truncation
>> (removal).
>>
>> truncate_inode_pages_final
>>   check (nrpages || nrexceptional) is false
>>     no truncate_inode_pages
>>       no cleancache_invalidate_inode(mapping)
>>
>> These way when reading the new file created with same inode we may get
>> these trash leftover pages from cleancache and see wrong data instead of
>> the contents of the new file.
>>
>> Fix it by always doing truncate_inode_pages which is already ready for
>> nrpages == 0 && nrexceptional == 0 case and just invalidates inode.
>>
>> Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
>> To: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>>  mm/truncate.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> The patch looks good but can you add a short comment before the
> truncate_inode_pages() call explaining why it needs to be called always?
> Something like:
> 
> 	 /*
> 	  * Cleancache needs notification even if there are no pages or
> 	  * shadow entries...
> 	  */

Or we can just call cleancache_invalidate_inode(mapping) on else branch,
so the code would be more self-explanatory, and also avoid
function call in no-cleancache setups, which should the most of setups.



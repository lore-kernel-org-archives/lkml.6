Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E863C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0308A208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0308A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbeKPSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:07:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:53012 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeKPSHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:07:07 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gNYyg-0004Z1-8L; Fri, 16 Nov 2018 10:55:46 +0300
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
To:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
 <20181115143103.c6fa8fec343bb706b91f6c6c@linux-foundation.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <d2a7e3fe-67ca-12f3-d16b-c9de0646c063@virtuozzo.com>
Date:   Fri, 16 Nov 2018 10:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115143103.c6fa8fec343bb706b91f6c6c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 1:31 AM, Andrew Morton wrote:
> On Mon, 12 Nov 2018 12:57:34 +0300 Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> 
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
> 
> Data corruption sounds serious.  Shouldn't we backport this into
> -stable kernels?

Yes, it was broken in 4.14 kernel and it should affect all who uses cleancache
Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")

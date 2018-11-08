Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEDC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BEC2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BEC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeKHRyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:54:18 -0500
Received: from foss.arm.com ([217.140.101.70]:35924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHRyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:54:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50151A78;
        Thu,  8 Nov 2018 00:19:57 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8468A3F5BD;
        Thu,  8 Nov 2018 00:19:55 -0800 (PST)
Subject: Re: [RFC PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-6-mhocko@kernel.org>
 <b23ebcb3-e4f1-be78-bd5f-84c685979ab7@arm.com>
 <20181108081231.GN27423@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <807cde15-a083-e8ae-4bd0-5f83f4b02b6a@arm.com>
Date:   Thu, 8 Nov 2018 13:49:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108081231.GN27423@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/08/2018 01:42 PM, Michal Hocko wrote:
> On Thu 08-11-18 12:46:47, Anshuman Khandual wrote:
>>
>>
>> On 11/07/2018 03:48 PM, Michal Hocko wrote:
> [...]
>>> @@ -1411,8 +1409,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>>  		/* Allocate a new page from the nearest neighbor node */
>>>  		ret = migrate_pages(&source, new_node_page, NULL, 0,
>>>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			list_for_each_entry(page, &source, lru) {
>>> +				pr_warn("migrating pfn %lx failed ",
>>> +				       page_to_pfn(page), ret);
>>
>> Seems like pr_warn() needs to have %d in here to print 'ret'.
> 
> Dohh. Rebase hickup. You are right ret:%d got lost on the way.
> 
>> Though
>> dumping return code from migrate_pages() makes sense, wondering if
>> it is required for each and every page which failed to migrate here
>> or just one instance is enough.
> 
> Does it matter enough to special case one printk?
I just imagined how a bunch of prints will look like when multiple pages
failed to migrate probably for the same reason. But I guess its okay.

> 
>>> +				dump_page(page, NULL);
>>> +			}
>>
>> s/NULL/failed to migrate/ for dump_page().
> 
> Yes, makes sense.
> 
>>
>>>  			putback_movable_pages(&source);
>>> +		}
>>>  	}
>>>  out:
>>>  	return ret;
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index a919ba5cb3c8..23267767bf98 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -7845,6 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>>>  	return false;
>>>  unmovable:
>>>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
>>> +	dump_page(pfn_to_page(pfn+iter), "has_unmovable_pages");
>>
>> s/has_unmovable_pages/is unmovable/
> 
> OK
> 
>> If we eally care about the function name, then dump_page() should be
>> followed by dump_stack() like the case in some other instances.
>>
>>>  	return true;
>>
>> This will be dumped from HugeTLB and CMA allocation paths as well through
>> alloc_contig_range(). But it should be okay as those occurrences should be
>> rare and dumping page state then will also help.
> 
> yes
> 
> Thanks and here is the incremental fix:
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bf214beccda3..820397e18e59 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1411,9 +1411,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
> -				pr_warn("migrating pfn %lx failed ",
> +				pr_warn("migrating pfn %lx failed ret:%d ",
>  				       page_to_pfn(page), ret);
> -				dump_page(page, NULL);
> +				dump_page(page, "migration failure");
>  			}
>  			putback_movable_pages(&source);
>  		}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 23267767bf98..ec2c7916dc2d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7845,7 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	dump_page(pfn_to_page(pfn+iter), "has_unmovable_pages");
> +	dump_page(pfn_to_page(pfn+iter), "unmovable page");
>  	return true;
>  }

It looks good.

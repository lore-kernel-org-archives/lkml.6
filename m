Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CAD2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CAD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbeKPWTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:19:55 -0500
Received: from foss.arm.com ([217.140.101.70]:50416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:19:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E1380D;
        Fri, 16 Nov 2018 04:07:49 -0800 (PST)
Received: from [10.163.1.125] (unknown [10.163.1.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94AFC3F718;
        Fri, 16 Nov 2018 04:07:47 -0800 (PST)
Subject: Re: [PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-6-mhocko@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <68bb826c-104f-3c53-28fe-5e9a55df1d1e@arm.com>
Date:   Fri, 16 Nov 2018 17:37:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116083020.20260-6-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2018 02:00 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> There is only very limited information printed when the memory offlining
> fails:
> [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff
> 
> This tells us that the failure is triggered by the userspace
> intervention but it doesn't tell us much more about the underlying
> reason. It might be that the page migration failes repeatedly and the
> userspace timeout expires and send a signal or it might be some of the
> earlier steps (isolation, memory notifier) takes too long.
> 
> If the migration failes then it would be really helpful to see which
> page that and its state. The same applies to the isolation phase. If we
> fail to isolate a page from the allocator then knowing the state of the
> page would be helpful as well.
> 
> Dump the page state that fails to get isolated or migrated. This will
> tell us more about the failure and what to focus on during debugging.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memory_hotplug.c | 12 ++++++++----
>  mm/page_alloc.c     |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 88d50e74e3fe..c82193db4be6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1388,10 +1388,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  						    page_is_file_cache(page));
>  
>  		} else {
> -#ifdef CONFIG_DEBUG_VM
> -			pr_alert("failed to isolate pfn %lx\n", pfn);
> +			pr_warn("failed to isolate pfn %lx\n", pfn);
>  			dump_page(page, "isolation failed");
> -#endif
>  			put_page(page);
>  			/* Because we don't have big zone->lock. we should
>  			   check this again here. */
> @@ -1411,8 +1409,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		/* Allocate a new page from the nearest neighbor node */
>  		ret = migrate_pages(&source, new_node_page, NULL, 0,
>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> -		if (ret)
> +		if (ret) {
> +			list_for_each_entry(page, &source, lru) {
> +				pr_warn("migrating pfn %lx failed ret:%d ",
> +				       page_to_pfn(page), ret);
> +				dump_page(page, "migration failure");
> +			}
>  			putback_movable_pages(&source);
> +		}
>  	}
>  out:
>  	return ret;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a919ba5cb3c8..ec2c7916dc2d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7845,6 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> +	dump_page(pfn_to_page(pfn+iter), "unmovable page");
>  	return true;
>  }

This seems to have fixed the previous build problem because of the migrate_pages()
return code. Otherwise looks good.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

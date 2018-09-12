Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1561A206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1561A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeILPmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:42:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeILPmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:42:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5994DADEF;
        Wed, 12 Sep 2018 10:38:54 +0000 (UTC)
Date:   Wed, 12 Sep 2018 12:38:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        vbabka@suse.cz, pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
Message-ID: <20180912103853.GC10951@dhcp22.suse.cz>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 14:56:45, Arun KS wrote:
> When free pages are done with pageblock_order, time spend on
> coalescing pages by buddy allocator can be reduced. With
> section size of 256MB, hot add latency of a single section
> shows improvement from 50-60 ms to less than 1 ms, hence
> improving the hot add latency by 60%.

Where does the improvement come from? You are still doing the same
amount of work except that the number of callbacks is lower. Is this the
real source of 60% improvement?

> 
> If this looks okey, I'll modify users of set_online_page_callback
> and resend clean patch.

[...]

> +static int generic_online_pages(struct page *page, unsigned int order);
> +static online_pages_callback_t online_pages_callback = generic_online_pages;
> +
> +static int generic_online_pages(struct page *page, unsigned int order)
> +{
> +	unsigned long nr_pages = 1 << order;
> +	struct page *p = page;
> +	unsigned int loop;
> +
> +	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
> +		__ClearPageReserved(p);
> +		set_page_count(p, 0);
> +	}
> +	adjust_managed_page_count(page, nr_pages);
> +	init_page_count(page);
> +	__free_pages(page, order);
> +
> +	return 0;
> +}
> +
> +static int online_pages_blocks(unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	unsigned long pages_per_block = (1 << pageblock_order);
> +	unsigned long nr_pageblocks = nr_pages / pages_per_block;
> +//	unsigned long rem_pages = nr_pages % pages_per_block;
> +	int i, ret, onlined_pages = 0;
> +	struct page *page;
> +
> +	for (i = 0 ; i < nr_pageblocks ; i++) {
> +		page = pfn_to_page(start_pfn + (i * pages_per_block));
> +		ret = (*online_pages_callback)(page, pageblock_order);
> +		if (!ret)
> +			onlined_pages += pages_per_block;
> +		else if (ret > 0)
> +			onlined_pages += ret;
> +	}

Could you explain why does the pages_per_block step makes any sense? Why
don't you simply apply handle the full nr_pages worth of memory range
instead?

> +/*
> +	if (rem_pages)
> +		onlined_pages += online_page_single(start_pfn + i, rem_pages);
> +*/
> +
> +	return onlined_pages;
> +}
> +
>  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>  			void *arg)
>  {
> -	unsigned long i;
>  	unsigned long onlined_pages = *(unsigned long *)arg;
> -	struct page *page;
>  
>  	if (PageReserved(pfn_to_page(start_pfn)))
> -		for (i = 0; i < nr_pages; i++) {
> -			page = pfn_to_page(start_pfn + i);
> -			(*online_page_callback)(page);
> -			onlined_pages++;
> -		}
> +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
>  
>  	online_mem_sections(start_pfn, start_pfn + nr_pages);
>  
> -- 
> 1.9.1
> 

-- 
Michal Hocko
SUSE Labs

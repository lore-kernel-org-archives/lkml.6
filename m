Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfAOMje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:39:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:33808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbfAOMja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:39:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80BAEACEA;
        Tue, 15 Jan 2019 12:39:29 +0000 (UTC)
Subject: Re: [PATCH 09/25] mm, compaction: Use the page allocator bulk-free
 helper for lists of pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-10-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <a61312d7-8235-fe4d-6411-d3143d965f81@suse.cz>
Date:   Tue, 15 Jan 2019 13:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-10-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:49 PM, Mel Gorman wrote:
> release_pages() is a simpler version of free_unref_page_list() but it
> tracks the highest PFN for caching the restart point of the compaction
> free scanner. This patch optionally tracks the highest PFN in the core
> helper and converts compaction to use it. The performance impact is
> limited but it should reduce lock contention slightly in some cases.
> The main benefit is removing some partially duplicated code.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

...

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2876,18 +2876,26 @@ void free_unref_page(struct page *page)
>  /*
>   * Free a list of 0-order pages
>   */
> -void free_unref_page_list(struct list_head *list)
> +void __free_page_list(struct list_head *list, bool dropref,
> +				unsigned long *highest_pfn)
>  {
>  	struct page *page, *next;
>  	unsigned long flags, pfn;
>  	int batch_count = 0;
>  
> +	if (highest_pfn)
> +		*highest_pfn = 0;
> +
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
> +		if (dropref)
> +			WARN_ON_ONCE(!put_page_testzero(page));

I've thought about it again and still think it can cause spurious
warnings. We enter this function with one page pin, which means somebody
else might be doing pfn scanning and get_page_unless_zero() with
success, so there are two pins. Then we do the put_page_testzero() above
and go back to one pin, and warn. You said "this function simply does
not expect it and the callers do not violate the rule", but this is
rather about potential parallel pfn scanning activity and not about this
function's callers. Maybe there really is no parallel pfn scanner that
would try to pin a page with a state the page has when it's processed by
this function, but I wouldn't bet on it (any state checks preceding the
pin might also be racy etc.).

>  		pfn = page_to_pfn(page);
>  		if (!free_unref_page_prepare(page, pfn))
>  			list_del(&page->lru);
>  		set_page_private(page, pfn);
> +		if (highest_pfn && pfn > *highest_pfn)
> +			*highest_pfn = pfn;
>  	}
>  
>  	local_irq_save(flags);
> 


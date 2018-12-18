Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B99C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A5E2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeLRJze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:55:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbeLRJze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:55:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3924BACB8;
        Tue, 18 Dec 2018 09:55:32 +0000 (UTC)
Subject: Re: [PATCH 08/14] mm, compaction: Use the page allocator bulk-free
 helper for lists of pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-9-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <e5a93476-c31d-5c5e-7649-2b23188aaaac@suse.cz>
Date:   Tue, 18 Dec 2018 10:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214230310.572-9-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:03 AM, Mel Gorman wrote:
> release_pages() is a simpler version of free_unref_page_list() but it
> tracks the highest PFN for caching the restart point of the compaction
> free scanner. This patch optionally tracks the highest PFN in the core
> helper and converts compaction to use it.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2961,18 +2961,26 @@ void free_unref_page(struct page *page)
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

That will warn just once, but then page will remain with elevated count
and free_unref_page_prepare() will warn either immediately or later
depending on DEBUG_VM, for each page.
Also IIRC it's legal for basically anyone to do get_page_unless_zero()
and later put_page(), and this would now cause warning. Maybe just test
for put_page_testzero() result without warning, and continue? Hm but
then we should still do a list_del() and that becomes racy after
dropping our ref...

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


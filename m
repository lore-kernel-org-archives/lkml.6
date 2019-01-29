Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFEFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BEA2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfA2I1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:27:03 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:58869 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfA2I1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:27:02 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 73C3940AC; Tue, 29 Jan 2019 09:27:01 +0100 (CET)
Date:   Tue, 29 Jan 2019 09:27:00 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-ID: <20190129082658.erftot43e5ogasif@d104.suse.de>
References: <20190122154407.18417-1-osalvador@suse.de>
 <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
 <20190125075830.6mqw2io4rwz7wxx5@d104.suse.de>
 <20190128145309.c7dcf075b469d6a54694327d@linux-foundation.org>
 <20190128145617.069b3a5436fc7e34bdebb104@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128145617.069b3a5436fc7e34bdebb104@linux-foundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:56:17PM -0800, Andrew Morton wrote:
> 
> --- a/mm/memory_hotplug.c~mmmemory_hotplug-fix-scan_movable_pages-for-gigantic-hugepages-fix
> +++ a/mm/memory_hotplug.c
> @@ -1305,28 +1305,27 @@ int test_pages_in_a_zone(unsigned long s
>  static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  {
>  	unsigned long pfn;
> -	struct page *page;
> +
>  	for (pfn = start; pfn < end; pfn++) {
> -		if (pfn_valid(pfn)) {
> -			page = pfn_to_page(pfn);
> -			if (PageLRU(page))
> -				return pfn;
> -			if (__PageMovable(page))
> -				return pfn;
> -			if (PageHuge(page)) {
> -				struct page *head = compound_head(page);
> +		struct page *page, *head;
> +		unsigned long skip;
>  
> -				if (hugepage_migration_supported(page_hstate(head)) &&
> -				    page_huge_active(head))
> -					return pfn;
> -				else {
> -					unsigned long skip;
> +		if (!pfn_valid(pfn))
> +			continue;
> +		page = pfn_to_page(pfn);
> +		if (PageLRU(page))
> +			return pfn;
> +		if (__PageMovable(page))
> +			return pfn;
>  
> -					skip = (1 << compound_order(head)) - (page - head);
> -					pfn += skip - 1;
> -				}
> -			}
> -		}
> +		if (!PageHuge(page))
> +			continue;
> +		head = compound_head(page);
> +		if (hugepage_migration_supported(page_hstate(head)) &&
> +		    page_huge_active(head))
> +			return pfn;
> +		skip = (1 << compound_order(head)) - (page - head);
> +		pfn += skip - 1;
>  	}
>  	return 0;
>  }

It looks much better, thanks a lot for the cleanup Andrew!

-- 
Oscar Salvador
SUSE L3

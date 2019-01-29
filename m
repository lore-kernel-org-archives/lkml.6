Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D8DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B71F2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548747217;
	bh=GAyB0WCMSevbWr3awchjmMxGIHIErqEstJMWMJBsU3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qC19wXtQsK8D1tiJOJvrlc7XExnSTTqKQbeo8acrI4C1mT7E0TVJGjYwcoFER+CUT
	 0nZmSW1Fs6L0esurr1VSeW999PhMzl/jcvq01SqkQtzoPdRQ4OLiIcAPRP3WtXOHNc
	 k9JVmw4c0O6xZs0bf30W1AGPHR/sjnfwYAS8KWX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfA2Hdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:33:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfA2Hdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:33:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B807AE60;
        Tue, 29 Jan 2019 07:33:34 +0000 (UTC)
Date:   Tue, 29 Jan 2019 08:33:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-ID: <20190129073332.GB18811@dhcp22.suse.cz>
References: <20190122154407.18417-1-osalvador@suse.de>
 <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
 <20190125075830.6mqw2io4rwz7wxx5@d104.suse.de>
 <20190128145309.c7dcf075b469d6a54694327d@linux-foundation.org>
 <20190128145617.069b3a5436fc7e34bdebb104@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128145617.069b3a5436fc7e34bdebb104@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 14:56:17, Andrew Morton wrote:
[...]
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
> _
> 

LGTM
-- 
Michal Hocko
SUSE Labs

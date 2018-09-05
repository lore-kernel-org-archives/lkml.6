Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E9120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIEKxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:53:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeIEKxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:53:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D93E5ABBE;
        Wed,  5 Sep 2018 06:24:29 +0000 (UTC)
Date:   Wed, 5 Sep 2018 08:24:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
Message-ID: <20180905062428.GV14951@dhcp22.suse.cz>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183345.4416.76515.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904183345.4416.76515.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-09-18 11:33:45, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> It doesn't make much sense to use the atomic SetPageReserved at init time
> when we are using memset to clear the memory and manipulating the page
> flags via simple "&=" and "|=" operations in __init_single_page.
> 
> This patch adds a non-atomic version __SetPageReserved that can be used
> during page init and shows about a 10% improvement in initialization times
> on the systems I have available for testing.

I agree with Dave about a comment is due. I am also quite surprised that
this leads to such a large improvement. Could you be more specific about
your test and machines you were testing on?

Other than that the patch makes sense to me.

> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

With the above addressed, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/page-flags.h |    1 +
>  mm/page_alloc.c            |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 74bee8cecf4c..57ec3fef7e9f 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -292,6 +292,7 @@ static inline int PagePoisoned(const struct page *page)
>  
>  PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
>  	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
> +	__SETPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
>  PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
>  	__CLEARPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
>  	__SETPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 05e983f42316..9c7d6e971630 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1231,7 +1231,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
>  			/* Avoid false-positive PageTail() */
>  			INIT_LIST_HEAD(&page->lru);
>  
> -			SetPageReserved(page);
> +			__SetPageReserved(page);
>  		}
>  	}
>  }
> @@ -5518,7 +5518,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		page = pfn_to_page(pfn);
>  		__init_single_page(page, pfn, zone, nid);
>  		if (context == MEMMAP_HOTPLUG)
> -			SetPageReserved(page);
> +			__SetPageReserved(page);
>  
>  		/*
>  		 * Mark the block movable so that blocks are reserved for
> 

-- 
Michal Hocko
SUSE Labs

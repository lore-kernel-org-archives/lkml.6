Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C46C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D120861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0D120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIFNlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:41:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbeIFNlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:41:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20D98AF75;
        Thu,  6 Sep 2018 09:06:43 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:06:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 26/29] memblock: rename __free_pages_bootmem to
 memblock_free_pages
Message-ID: <20180906090642.GK14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-27-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-27-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:41, Mike Rapoport wrote:
> The conversion is done using
> 
> sed -i 's@__free_pages_bootmem@memblock_free_pages@' \
>     $(git grep -l __free_pages_bootmem)
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/internal.h   | 2 +-
>  mm/memblock.c   | 2 +-
>  mm/nobootmem.c  | 2 +-
>  mm/page_alloc.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 87256ae..291eb2b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -161,7 +161,7 @@ static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
>  }
>  
>  extern int __isolate_free_page(struct page *page, unsigned int order);
> -extern void __free_pages_bootmem(struct page *page, unsigned long pfn,
> +extern void memblock_free_pages(struct page *page, unsigned long pfn,
>  					unsigned int order);
>  extern void prep_compound_page(struct page *page, unsigned int order);
>  extern void post_alloc_hook(struct page *page, unsigned int order,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 63df68b..55d7d50 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1639,7 +1639,7 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
>  	end = PFN_DOWN(base + size);
>  
>  	for (; cursor < end; cursor++) {
> -		__free_pages_bootmem(pfn_to_page(cursor), cursor, 0);
> +		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
>  		totalram_pages++;
>  	}
>  }
> diff --git a/mm/nobootmem.c b/mm/nobootmem.c
> index bb64b09..9608bc5 100644
> --- a/mm/nobootmem.c
> +++ b/mm/nobootmem.c
> @@ -43,7 +43,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  		while (start + (1UL << order) > end)
>  			order--;
>  
> -		__free_pages_bootmem(pfn_to_page(start), start, order);
> +		memblock_free_pages(pfn_to_page(start), start, order);
>  
>  		start += (1UL << order);
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 33c9e27..e143fae 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1333,7 +1333,7 @@ meminit_pfn_in_nid(unsigned long pfn, int node,
>  #endif
>  
>  
> -void __init __free_pages_bootmem(struct page *page, unsigned long pfn,
> +void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
>  	if (early_page_uninitialised(pfn))
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs

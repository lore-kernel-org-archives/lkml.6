Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9D20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE9D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeGPQiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:38:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727514AbeGPQiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:38:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE95FAF41;
        Mon, 16 Jul 2018 16:09:57 +0000 (UTC)
Date:   Mon, 16 Jul 2018 18:09:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] mm: don't do zero_resv_unavail if memmap is not allocated
Message-ID: <20180716160956.GW17280@dhcp22.suse.cz>
References: <20180716151630.770-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716151630.770-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-07-18 11:16:30, Pavel Tatashin wrote:
> Moving zero_resv_unavail before memmap_init_zone(), caused a regression on
> x86-32.
> 
> The cause is that we access struct pages before they are allocated when
> CONFIG_FLAT_NODE_MEM_MAP is used.
> 
> free_area_init_nodes()
>   zero_resv_unavail()
>     mm_zero_struct_page(pfn_to_page(pfn)); <- struct page is not alloced
>   free_area_init_node()
>     if CONFIG_FLAT_NODE_MEM_MAP
>       alloc_node_mem_map()
>         memblock_virt_alloc_node_nopanic() <- struct page alloced here
> 
> On the other hand memblock_virt_alloc_node_nopanic() zeroes all the memory
> that it returns, so we do not need to do zero_resv_unavail() here.

This all is subtle as hell and almost impossible to build a sane code on
top. Your patch sounds good as a stop gap fix but we really need
something resembling an actual design rather than ad-hoc hacks piled on
top of each other.

> Fixes: e181ae0c5db9 ("mm: zero unavailable pages before memmap init")
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h | 2 +-
>  mm/page_alloc.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9ffe380..3982c83fdcbf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2132,7 +2132,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
>  					struct mminit_pfnnid_cache *state);
>  #endif
>  
> -#ifdef CONFIG_HAVE_MEMBLOCK
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
>  void zero_resv_unavail(void);
>  #else
>  static inline void zero_resv_unavail(void) {}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5d800d61ddb7..a790ef4be74e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6383,7 +6383,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
>  	free_area_init_core(pgdat);
>  }
>  
> -#ifdef CONFIG_HAVE_MEMBLOCK
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
>  /*
>   * Only struct pages that are backed by physical memory are zeroed and
>   * initialized by going through __init_single_page(). But, there are some
> @@ -6421,7 +6421,7 @@ void __paginginit zero_resv_unavail(void)
>  	if (pgcnt)
>  		pr_info("Reserved but unavailable: %lld pages", pgcnt);
>  }
> -#endif /* CONFIG_HAVE_MEMBLOCK */
> +#endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>  
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs

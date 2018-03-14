Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeCNWZf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:25:35 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37806 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCNWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:25:33 -0400
X-Google-Smtp-Source: AG47ELvcTfMpJu5AFUCpDeWu2BnlpLh/mNvCYW8B7+6QxYHuvsxw2JxSockjeOzlbt/H9khgK3XiIQ==
From: Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date: Wed, 14 Mar 2018 23:25:30 +0100
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Vacek <neelx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
Message-ID: <20180314222530.GA6300@wintermute>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 07:29:37PM +0000, Ard Biesheuvel wrote:
> This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.

FWIW, the revert fixes the boot hang I'm seeing on ThunderX1.

--Jan

> Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
> alignment") modified the logic in memmap_init_zone() to initialize
> struct pages associated with invalid PFNs, to appease a VM_BUG_ON()
> in move_freepages(), which is redundant by its own admission, and
> dereferences struct page fields to obtain the zone without checking
> whether the struct pages in question are valid to begin with.
> 
> Commit 864b75f9d6b0 only makes it worse, since the rounding it does
> may cause pfn assume the same value it had in a prior iteration of
> the loop, resulting in an infinite loop and a hang very early in the
> boot. Also, since it doesn't perform the same rounding on start_pfn
> itself but only on intermediate values following an invalid PFN, we
> may still hit the same VM_BUG_ON() as before.
> 
> So instead, let's fix this at the core, and ensure that the BUG
> check doesn't dereference struct page fields of invalid pages.
> 
> Fixes: 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> Cc: Daniel Vacek <neelx@redhat.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  mm/page_alloc.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3d974cb2a1a1..635d7dd29d7f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1910,7 +1910,9 @@ static int move_freepages(struct zone *zone,
>  	 * Remove at a later date when no bug reports exist related to
>  	 * grouping pages by mobility
>  	 */
> -	VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
> +	VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
> +	          pfn_valid(page_to_pfn(end_page)) &&
> +	          page_zone(start_page) != page_zone(end_page));
>  #endif
>  
>  	if (num_movable)
> @@ -5359,14 +5361,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			/*
>  			 * Skip to the pfn preceding the next valid one (or
>  			 * end_pfn), such that we hit a valid pfn (or end_pfn)
> -			 * on our next iteration of the loop. Note that it needs
> -			 * to be pageblock aligned even when the region itself
> -			 * is not. move_freepages_block() can shift ahead of
> -			 * the valid region but still depends on correct page
> -			 * metadata.
> +			 * on our next iteration of the loop.
>  			 */
> -			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> -					~(pageblock_nr_pages-1)) - 1;
> +			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
>  #endif
>  			continue;
>  		}
> -- 
> 2.15.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

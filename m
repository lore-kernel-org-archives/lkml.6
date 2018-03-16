Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeCPJGz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:06:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeCPJGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:06:49 -0400
Date: Fri, 16 Mar 2018 10:06:47 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Jia He <hejianet@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>, Daniel Vacek <neelx@redhat.com>,
        linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH] Revert "mm/memblock.c: hardcode the end_pfn being -1"
Message-ID: <20180316090647.GC23100@dhcp22.suse.cz>
References: <1521168966-5245-1-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521168966-5245-1-git-send-email-hejianet@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-03-18 19:56:06, Jia He wrote:
> This reverts commit 379b03b7fa05f7db521b7732a52692448a3c34fe.
> 
> Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
> alignment") introduced boot hang issues in arm/arm64 machines, so
> Ard Biesheuvel reverted in commit 3e04040df6d4. But there is a
> preparation patch for commit 864b75f9d6b0. So just revert it for
> the sake of caution.

Why? Is there anything wrong with this one?

> 
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  mm/memblock.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b6ba6b7..5a9ca2a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1107,7 +1107,7 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
>  	struct memblock_type *type = &memblock.memory;
>  	unsigned int right = type->cnt;
>  	unsigned int mid, left = 0;
> -	phys_addr_t addr = PFN_PHYS(++pfn);
> +	phys_addr_t addr = PFN_PHYS(pfn + 1);
>  
>  	do {
>  		mid = (right + left) / 2;
> @@ -1118,15 +1118,15 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
>  				  type->regions[mid].size))
>  			left = mid + 1;
>  		else {
> -			/* addr is within the region, so pfn is valid */
> -			return pfn;
> +			/* addr is within the region, so pfn + 1 is valid */
> +			return min(pfn + 1, max_pfn);
>  		}
>  	} while (left < right);
>  
>  	if (right == type->cnt)
> -		return -1UL;
> +		return max_pfn;
>  	else
> -		return PHYS_PFN(type->regions[right].base);
> +		return min(PHYS_PFN(type->regions[right].base), max_pfn);
>  }
>  
>  /**
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs

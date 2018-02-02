Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBBJgi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:36:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:42294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeBBJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:36:33 -0500
Date: Fri, 2 Feb 2018 10:36:32 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/migrate: Change migration reason MR_CMA as
 MR_CONTIG_RANGE
Message-ID: <20180202093632.GQ21609@dhcp22.suse.cz>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
 <20180202091518.18798-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202091518.18798-1-khandual@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-02-18 14:45:18, Anshuman Khandual wrote:
> alloc_contig_range() initiates compaction and eventual migration for
> the purpose of either CMA or HugeTLB allocation. At present, reason
> code remains the same MR_CMA for either of these cases. Lets make it
> MR_CONTIG_RANGE which will appropriately reflect reason code in both
> these cases.

It is not very specific but I guess this is better than inventing a code
for each source. If we ever get to need distinguish all of them then we
should better mark a function which calls the allocator or something
like that.

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 2 +-
>  include/linux/migrate.h             | 2 +-
>  include/trace/events/migrate.h      | 2 +-
>  mm/page_alloc.c                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index 91ee2231c527..4c615fcb0cf0 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -111,7 +111,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
>  	put_page(page); /* Drop the gup reference */
>  
>  	ret = migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
> -				NULL, 0, MIGRATE_SYNC, MR_CMA);
> +				NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE);
>  	if (ret) {
>  		if (!list_empty(&cma_migrate_pages))
>  			putback_movable_pages(&cma_migrate_pages);
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index a732598fcf83..7e7e2606bb4c 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -25,7 +25,7 @@ enum migrate_reason {
>  	MR_SYSCALL,		/* also applies to cpusets */
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
> -	MR_CMA,
> +	MR_CONTIG_RANGE,
>  	MR_TYPES
>  };
>  
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index bcf4daccd6be..711372845945 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -20,7 +20,7 @@
>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CMA,		"cma")
> +	EMe(MR_CONTIG_RANGE,	"contig_range")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 242565855d05..b9a22e16b4cf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7622,7 +7622,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  		cc->nr_migratepages -= nr_reclaimed;
>  
>  		ret = migrate_pages(&cc->migratepages, new_page_alloc_contig,
> -				    NULL, 0, cc->mode, MR_CMA);
> +				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs

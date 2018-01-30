Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeA3H7x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 02:59:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:55039 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbeA3H7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:59:52 -0500
Date: Tue, 30 Jan 2018 08:59:49 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
Message-ID: <20180130075949.GN21609@dhcp22.suse.cz>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 08:37:14, Anshuman Khandual wrote:
> alloc_contig_range() initiates compaction and eventual migration for
> the purpose of either CMA or HugeTLB allocation. At present, reason
> code remains the same MR_CMA for either of those cases. Lets add a
> new reason code which will differentiate the purpose of migration
> as HugeTLB allocation instead.

Why do we need it?

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  include/linux/migrate.h        |  1 +
>  include/trace/events/migrate.h |  3 ++-
>  mm/page_alloc.c                | 14 ++++++++++----
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index a732598fcf83..44381c33a2bd 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -26,6 +26,7 @@ enum migrate_reason {
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
>  	MR_CMA,
> +	MR_HUGETLB,
>  	MR_TYPES
>  };
>  
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index bcf4daccd6be..61474c93f8f3 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -20,7 +20,8 @@
>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CMA,		"cma")
> +	EM( MR_CMA,		"cma")				\
> +	EMe(MR_HUGETLB,		"hugetlb")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 242565855d05..ce8a2f2d4994 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7588,13 +7588,14 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
>  
>  /* [start, end) must belong to a single zone. */
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> -					unsigned long start, unsigned long end)
> +					unsigned long start, unsigned long end,
> +					unsigned migratetype)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
>  	unsigned long nr_reclaimed;
>  	unsigned long pfn = start;
>  	unsigned int tries = 0;
> -	int ret = 0;
> +	int ret = 0, migrate_reason = 0;
>  
>  	migrate_prep();
>  
> @@ -7621,8 +7622,13 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  							&cc->migratepages);
>  		cc->nr_migratepages -= nr_reclaimed;
>  
> +		if (migratetype == MIGRATE_CMA)
> +			migrate_reason = MR_CMA;
> +		else
> +			migrate_reason = MR_HUGETLB;
> +
>  		ret = migrate_pages(&cc->migratepages, new_page_alloc_contig,
> -				    NULL, 0, cc->mode, MR_CMA);
> +				    NULL, 0, cc->mode, migrate_reason);
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
> @@ -7710,7 +7716,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * allocated.  So, if we fall through be sure to clear ret so that
>  	 * -EBUSY is not accidentally used or returned to caller.
>  	 */
> -	ret = __alloc_contig_migrate_range(&cc, start, end);
> +	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
>  	if (ret && ret != -EBUSY)
>  		goto done;
>  	ret =0;
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs

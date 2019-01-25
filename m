Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD24F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548426051;
	bh=sB7ga/sa2esXoSHv2bB6G33MEW7nikD2HobnskeNVwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TiU1cSMGoqxKqefiXs9fR/Gkl/Y2aKqSIuMbusk4mFx3QmA2vIJb277r9xd+FQQ3o
	 tTVykAJecChSWZYL08jfPI4hzjxmO0aXiIgviQjrfbZ10VecbI9QU9mUz9Ls3B5WIK
	 Qhl/nRzyrYlQYRB/eJW8e+XtPv8I2pmmVcsZMTwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYOUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:20:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:33984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfAYOUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:20:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90021AEF3;
        Fri, 25 Jan 2019 14:20:41 +0000 (UTC)
Date:   Fri, 25 Jan 2019 15:20:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>, keith.busch@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, mgorman@suse.de
Subject: Re: [PATCH v7 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
Message-ID: <20190125142039.GN3560@dhcp22.suse.cz>
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-01-19 15:21:10, Dan Williams wrote:
[...]

Thanks a lot for the additional information. And...

> Introduce shuffle_free_memory(), and its helper shuffle_zone(), to
> perform a Fisher-Yates shuffle of the page allocator 'free_area' lists
> when they are initially populated with free memory at boot and at
> hotplug time. Do this based on either the presence of a
> page_alloc.shuffle=Y command line parameter, or autodetection of a
> memory-side-cache (to be added in a follow-on patch).

... to make it opt-in and also provide an opt-out to override for the
auto-detected case.

> The shuffling is done in terms of CONFIG_SHUFFLE_PAGE_ORDER sized free
> pages where the default CONFIG_SHUFFLE_PAGE_ORDER is MAX_ORDER-1 i.e.
> 10, 4MB this trades off randomization granularity for time spent
> shuffling.

But I do not really think we want to make this a config option. Who do
you expect will tune this? I would rather wait for those usecases to be
called out and we can give them a command line parameter to do so rather
than something hardcoded during compile time and as such really unusable
for any consumer of the pre-built kernels.

I do not have a problem with the default section though.

> MAX_ORDER-1 was chosen to be minimally invasive to the page
> allocator while still showing memory-side cache behavior improvements,
> and the expectation that the security implications of finer granularity
> randomization is mitigated by CONFIG_SLAB_FREELIST_RANDOM.
> 
> The performance impact of the shuffling appears to be in the noise
> compared to other memory initialization work. Also the bulk of the work
> is done in the background as a part of deferred_init_memmap().
> 
> This initial randomization can be undone over time so a follow-on patch
> is introduced to inject entropy on page free decisions. It is reasonable
> to ask if the page free entropy is sufficient, but it is not enough due
> to the in-order initial freeing of pages. At the start of that process
> putting page1 in front or behind page0 still keeps them close together,
> page2 is still near page1 and has a high chance of being adjacent. As
> more pages are added ordering diversity improves, but there is still
> high page locality for the low address pages and this leads to no
> significant impact to the cache conflict rate.
> 
> [1]: https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
> [2]: https://lkml.org/lkml/2018/9/22/54
> [3]: https://lkml.org/lkml/2018/10/12/309

Please turn lkml.org links into http://lkml.kernel.org/r/$msg_id

[....]
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index cc4a507d7ca4..8c37a023a790 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1272,6 +1272,10 @@ void sparse_init(void);
>  #else
>  #define sparse_init()	do {} while (0)
>  #define sparse_index_init(_sec, _nid)  do {} while (0)
> +static inline int pfn_present(unsigned long pfn)
> +{
> +	return 1;
> +}

Does this really make sense? Shouldn't this default to pfn_valid on
!sparsemem?

[...]
> +config SHUFFLE_PAGE_ALLOCATOR
> +	bool "Page allocator randomization"
> +	depends on ACPI_NUMA
> +	default SLAB_FREELIST_RANDOM
> +	help
> +	  Randomization of the page allocator improves the average
> +	  utilization of a direct-mapped memory-side-cache. See section
> +	  5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
> +	  6.2a specification for an example of how a platform advertises
> +	  the presence of a memory-side-cache. There are also incidental
> +	  security benefits as it reduces the predictability of page
> +	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> +	  default granularity of shuffling on 4MB (MAX_ORDER) pages is
> +	  selected based on cache utilization benefits.
> +
> +	  While the randomization improves cache utilization it may
> +	  negatively impact workloads on platforms without a cache. For
> +	  this reason, by default, the randomization is enabled only
> +	  after runtime detection of a direct-mapped memory-side-cache.
> +	  Otherwise, the randomization may be force enabled with the
> +	  'page_alloc.shuffle' kernel command line parameter.
> +
> +	  Say Y if unsure.

Do we really need to make this a choice? Are any of the tiny systems
going to be NUMA? Why cannot we just make it depend on ACPI_NUMA?

> +config SHUFFLE_PAGE_ORDER
> +	depends on SHUFFLE_PAGE_ALLOCATOR
> +	int "Page allocator shuffle order"
> +	range 0 10
> +	default 10
> +	help
> +	  Specify the granularity at which shuffling (randomization) is
> +	  performed. By default this is set to MAX_ORDER-1 to minimize
> +	  runtime impact of randomization and with the expectation that
> +	  SLAB_FREELIST_RANDOM mitigates heap attacks on smaller
> +	  object granularities.
> +

and no, do not make this configurable here as already mentioned.
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cbb3618..3602f7a2eab4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -17,6 +17,7 @@
>  #include <linux/poison.h>
>  #include <linux/pfn.h>
>  #include <linux/debugfs.h>
> +#include <linux/shuffle.h>
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> @@ -1929,9 +1930,16 @@ static unsigned long __init free_low_memory_core_early(void)
>  	 *  low ram will be on Node1
>  	 */
>  	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
> -				NULL)
> +				NULL) {
> +		pg_data_t *pgdat;
> +
>  		count += __free_memory_core(start, end);
>  
> +		for_each_online_pgdat(pgdat)
> +			shuffle_free_memory(pgdat, PHYS_PFN(start),
> +					PHYS_PFN(end));
> +	}
> +
>  	return count;
>  }
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b9a667d36c55..7caffb9a91ab 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -23,6 +23,7 @@
>  #include <linux/highmem.h>
>  #include <linux/vmalloc.h>
>  #include <linux/ioport.h>
> +#include <linux/shuffle.h>
>  #include <linux/delay.h>
>  #include <linux/migrate.h>
>  #include <linux/page-isolation.h>
> @@ -895,6 +896,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  	zone->zone_pgdat->node_present_pages += onlined_pages;
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
> +	shuffle_zone(zone, pfn, zone_end_pfn(zone));
> +
>  	if (onlined_pages) {
>  		node_states_set_node(nid, &arg);
>  		if (need_zonelists_rebuild)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cde5dac6229a..2adcd6da8a07 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -61,6 +61,7 @@
>  #include <linux/sched/rt.h>
>  #include <linux/sched/mm.h>
>  #include <linux/page_owner.h>
> +#include <linux/shuffle.h>
>  #include <linux/kthread.h>
>  #include <linux/memcontrol.h>
>  #include <linux/ftrace.h>
> @@ -1634,6 +1635,8 @@ static int __init deferred_init_memmap(void *data)
>  	}
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> +	shuffle_zone(zone, first_init_pfn, zone_end_pfn(zone));
> +
>  	/* Sanity check that the next zone really is unpopulated */
>  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));

I would prefer if would have less placess to place the shuffling. Why
cannot we have a single place for the bootup and one for onlining part?
page_alloc_init_late sounds like a good place for the later. You can
miss some early allocations but are those of a big interest?

I haven't checked the actual shuffling algorithm, I will trust you on
that part ;)
-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A5220869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A5220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeIFKVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:21:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbeIFKVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:21:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72A6AB00F;
        Thu,  6 Sep 2018 05:47:36 +0000 (UTC)
Date:   Thu, 6 Sep 2018 07:47:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        dave.hansen@intel.com, akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Message-ID: <20180906054735.GJ14951@dhcp22.suse.cz>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905211328.3286.71674.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 14:13:28, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> On systems with a large amount of memory it can take a significant amount
> of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> value. I have seen it take over 2 minutes to initialize a system with
> over 12GB of RAM.
> 
> In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> the boot time returned to something much more reasonable as the
> arch_add_memory call completed in milliseconds versus seconds. However in
> doing that I had to disable all of the other VM debugging on the system.
> 
> Instead of keeping the value in CONFIG_DEBUG_VM I am adding a new CONFIG
> value called CONFIG_DEBUG_VM_PAGE_INIT_POISON that will control the page
> poisoning independent of the CONFIG_DEBUG_VM option.

As explained in other thread (please slow down when posting a new
version until the previous discussion reaches a consensus next time), I
really detest a new config. We have way too many of those. If you really
have to then make sure to describe _why_ it is needed. Sure
initialization takes some time and that is one-off overhead. So why does
it matter at all for somebody willing to pat runtime overhead all over
the MM code paths. In other words, why do you have to keep DEBUG_VM
enabled for workloads where the boot time matters so much that few
seconds matter?

> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  include/linux/page-flags.h |    8 ++++++++
>  lib/Kconfig.debug          |   14 ++++++++++++++
>  mm/memblock.c              |    5 ++---
>  mm/sparse.c                |    4 +---
>  4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 74bee8cecf4c..0e95ca63375a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -13,6 +13,7 @@
>  #include <linux/mm_types.h>
>  #include <generated/bounds.h>
>  #endif /* !__GENERATING_BOUNDS_H */
> +#include <linux/string.h>
>  
>  /*
>   * Various page->flags bits:
> @@ -162,6 +163,13 @@ static inline int PagePoisoned(const struct page *page)
>  	return page->flags == PAGE_POISON_PATTERN;
>  }
>  
> +static inline void page_init_poison(struct page *page, size_t size)
> +{
> +#ifdef CONFIG_DEBUG_VM_PAGE_INIT_POISON
> +	memset(page, PAGE_POISON_PATTERN, size);
> +#endif
> +}
> +
>  /*
>   * Page flags policies wrt compound pages
>   *
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 613316724c6a..3b1277c52fed 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -637,6 +637,20 @@ config DEBUG_VM_PGFLAGS
>  
>  	  If unsure, say N.
>  
> +config DEBUG_VM_PAGE_INIT_POISON
> +	bool "Enable early page metadata poisoning"
> +	default y
> +	depends on DEBUG_VM
> +	help
> +	  Seed the page metadata with a poison pattern to improve the
> +	  likelihood of detecting attempts to access the page prior to
> +	  initialization by the memory subsystem.
> +
> +	  This initialization can result in a longer boot time for systems
> +	  with a large amount of memory.
> +
> +	  If unsure, say Y.
> +
>  config ARCH_HAS_DEBUG_VIRTUAL
>  	bool
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 237944479d25..a85315083b5a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1444,10 +1444,9 @@ void * __init memblock_virt_alloc_try_nid_raw(
>  
>  	ptr = memblock_virt_alloc_internal(size, align,
>  					   min_addr, max_addr, nid);
> -#ifdef CONFIG_DEBUG_VM
>  	if (ptr && size > 0)
> -		memset(ptr, PAGE_POISON_PATTERN, size);
> -#endif
> +		page_init_poison(ptr, size);
> +
>  	return ptr;
>  }
>  
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 10b07eea9a6e..67ad061f7fb8 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -696,13 +696,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_DEBUG_VM
>  	/*
>  	 * Poison uninitialized struct pages in order to catch invalid flags
>  	 * combinations.
>  	 */
> -	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
> -#endif
> +	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
>  
>  	section_mark_present(ms);
>  	sparse_init_one_section(ms, section_nr, memmap, usemap);
> 

-- 
Michal Hocko
SUSE Labs

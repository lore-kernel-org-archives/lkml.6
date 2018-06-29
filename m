Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE89DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB324706
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OddJ7dYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AB324706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936279AbeF2UYd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:24:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2UYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6TROBHjoHp/xp7tUTbYToCo3/Cbs9Sl4CiFMVylqIMU=; b=OddJ7dYtFprPNe7hN36o7/TYZ
        am2nMCX9QGg9Z00VxHjBPwjEUvNm8n5fvMoo0jKJ+NTyh3Hy/4pCcN4Uf325oEwBCekYDcbP3pKs8
        LfX6k2B+5uOKrxFXrvJyOVWckA1TZ8YFtAGoCfhsVqjFjHdyz3ysYxZ+PPZ7tGi+PSu7oaKxh4M9D
        41xrU9WW+NZ1r/Y0tjglnWb8VlXZJX89BOmX3paBGtqedF4xMyFiD9vfIKSzqMJtAU7rg062uuCaF
        /WzjQqGCQvemFKCXYKGHFIUXorzVS1VS+nZwRRtzXcyEevMBRHfnypl40AkAdUC1kLF26zr5pXQ/J
        1SCH70meg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYzwU-0001DC-Sr; Fri, 29 Jun 2018 20:24:30 +0000
Subject: Re: [PATCH] mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on
 SPARSEMEM
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1530279308-24988-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e10d9623-3b66-2853-18c9-9d6eea273270@infradead.org>
Date:   Fri, 29 Jun 2018 13:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530279308-24988-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 06:35 AM, Mike Rapoport wrote:
> The deferred memory initialization relies on section definitions, e.g
> PAGES_PER_SECTION, that are only available when CONFIG_SPARSEMEM=y on most
> architectures.
> 
> Initially DEFERRED_STRUCT_PAGE_INIT depended on explicit
> ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT configuration option, but since the
> commit 2e3ca40f03bb13709df4 ("mm: relax deferred struct page requirements")
> this requirement was relaxed and now it is possible to enable
> DEFERRED_STRUCT_PAGE_INIT on architectures that support DISCONTINGMEM and
> NO_BOOTMEM which causes build failures.
> 
> For instance, setting SMP=y and DEFERRED_STRUCT_PAGE_INIT=y on arc causes
> the following build failure:
> 
>   CC      mm/page_alloc.o
> mm/page_alloc.c: In function 'update_defer_init':
> mm/page_alloc.c:321:14: error: 'PAGES_PER_SECTION'
> undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
>       (pfn & (PAGES_PER_SECTION - 1)) == 0) {
>               ^~~~~~~~~~~~~~~~~
>               USEC_PER_SEC
> mm/page_alloc.c:321:14: note: each undeclared
> identifier is reported only once for each function it appears in
> In file included from include/linux/cache.h:5:0,
>                  from include/linux/printk.h:9,
>                  from include/linux/kernel.h:14,
>                  from
> include/asm-generic/bug.h:18,
>                  from
> arch/arc/include/asm/bug.h:32,
>                  from include/linux/bug.h:5,
>                  from include/linux/mmdebug.h:5,
>                  from include/linux/mm.h:9,
>                  from mm/page_alloc.c:18:
> mm/page_alloc.c: In function 'deferred_grow_zone':
> mm/page_alloc.c:1624:52: error:
> 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean
> 'USEC_PER_SEC'?
>   unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
>                                                     ^
> include/uapi/linux/kernel.h:11:47: note: in
> definition of macro '__ALIGN_KERNEL_MASK'
>  #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
>                                                ^~~~
> include/linux/kernel.h:58:22: note: in expansion
> of macro '__ALIGN_KERNEL'
>  #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
>                       ^~~~~~~~~~~~~~
> mm/page_alloc.c:1624:34: note: in expansion of
> macro 'ALIGN'
>   unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
>                                   ^~~~~
> In file included from
> include/asm-generic/bug.h:18:0,
>                  from
> arch/arc/include/asm/bug.h:32,
>                  from include/linux/bug.h:5,
>                  from include/linux/mmdebug.h:5,
>                  from include/linux/mm.h:9,
>                  from mm/page_alloc.c:18:
> mm/page_alloc.c: In function
> 'free_area_init_node':
> mm/page_alloc.c:6379:50: error:
> 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean
> 'USEC_PER_SEC'?
>   pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
>                                                   ^
> include/linux/kernel.h:812:22: note: in definition
> of macro '__typecheck'
>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                       ^
> include/linux/kernel.h:836:24: note: in expansion
> of macro '__safe_cmp'
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> include/linux/kernel.h:904:27: note: in expansion
> of macro '__careful_cmp'
>  #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
>                            ^~~~~~~~~~~~~
> mm/page_alloc.c:6379:29: note: in expansion of
> macro 'min_t'
>   pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
>                              ^~~~~
> include/linux/kernel.h:836:2: error: first
> argument to '__builtin_choose_expr' not a constant
>   __builtin_choose_expr(__safe_cmp(x, y), \
>   ^
> include/linux/kernel.h:904:27: note: in expansion
> of macro '__careful_cmp'
>  #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
>                            ^~~~~~~~~~~~~
> mm/page_alloc.c:6379:29: note: in expansion of
> macro 'min_t'
>   pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
>                              ^~~~~
> scripts/Makefile.build:317: recipe for target
> 'mm/page_alloc.o' failed
> 
> Let's make the DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM as
> the systems that support DISCONTIGMEM do not seem to have that huge
> amounts of memory that would make DEFERRED_STRUCT_PAGE_INIT relevant.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Thanks, I was running into that problem also.

Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ce95491..94af022 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -635,7 +635,7 @@ config DEFERRED_STRUCT_PAGE_INIT
>  	bool "Defer initialisation of struct pages to kthreads"
>  	default n
>  	depends on NO_BOOTMEM
> -	depends on !FLATMEM
> +	depends on SPARSEMEM
>  	depends on !NEED_PER_CPU_KM
>  	help
>  	  Ordinarily all struct pages are initialised during early boot in a
> 


-- 
~Randy

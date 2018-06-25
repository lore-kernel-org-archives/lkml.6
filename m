Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A66425AED
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A66425AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeFYODu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933997AbeFYODt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABBEDAEFE;
        Mon, 25 Jun 2018 14:03:48 +0000 (UTC)
Date:   Mon, 25 Jun 2018 16:03:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h> and
 #ifdef
Message-ID: <20180625140346.GM28965@dhcp22.suse.cz>
References: <20180622210542.2025-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622210542.2025-1-malat@debian.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 23:05:41, Mathieu Malaterre wrote:
> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> introduced two new function definitions:
> 
>   memblock_virt_alloc_try_nid_nopanic()
>   memblock_virt_alloc_try_nid()
> 
> Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
> introduced the following function definition:
> 
>   memblock_virt_alloc_try_nid_raw()
> 
> This commit adds an include of header file <linux/bootmem.h> to provide
> the missing function prototypes. Silence the following gcc warning
> (W=1):
> 
>   mm/memblock.c:1334:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_raw' [-Wmissing-prototypes]
>   mm/memblock.c:1371:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_nopanic' [-Wmissing-prototypes]
>   mm/memblock.c:1407:15: warning: no previous prototype for `memblock_virt_alloc_try_nid' [-Wmissing-prototypes]
> 
> As seen in commit 6cc22dc08a24 ("revert "mm/memblock: add missing include
> <linux/bootmem.h>"") #ifdef blockers were missing which lead to compilation
> failure on mips/ia64 where CONFIG_NO_BOOTMEM=n.
> 
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I was not aware of -Wmissing-prototypes

> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4c98672bc3e2..f4b6766d7907 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -20,6 +20,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> +#include <linux/bootmem.h>
>  
>  #include <asm/sections.h>
>  #include <linux/io.h>
> @@ -1226,6 +1227,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
>  	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
>  }
>  
> +#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)

Why do you need CONFIG_HAVE_MEMBLOCK dependency?
mm/Makefile says
obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o

so we even do not compile this code for !HAVE_MEMBLOCK AFAICS.

>  /**
>   * memblock_virt_alloc_internal - allocate boot memory block
>   * @size: size of memory block to be allocated in bytes
> @@ -1433,6 +1435,7 @@ void * __init memblock_virt_alloc_try_nid(
>  	      (u64)max_addr);
>  	return NULL;
>  }
> +#endif
>  
>  /**
>   * __memblock_free_early - free boot memory block
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs

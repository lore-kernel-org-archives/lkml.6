Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3936125F63
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3936125F63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbeFYSHY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48775 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964807AbeFYSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:07:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C861CAB1E;
        Mon, 25 Jun 2018 18:07:18 +0000 (UTC)
Date:   Mon, 25 Jun 2018 20:07:17 +0200
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
Subject: Re: [PATCH v2] mm/memblock: add missing include <linux/bootmem.h>
Message-ID: <20180625180717.GS28965@dhcp22.suse.cz>
References: <20180622210542.2025-1-malat@debian.org>
 <20180625171513.31845-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171513.31845-1-malat@debian.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-06-18 19:15:12, Mathieu Malaterre wrote:
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
> It also adds #ifdef blockers to prevent compilation failure on mips/ia64
> where CONFIG_NO_BOOTMEM=n. Because Makefile already does:
> 
>   obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
> 
> The #ifdef has been simplified from:
> 
>   #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
> 
> to simply:
> 
>   #if defined(CONFIG_NO_BOOTMEM)

Well, I would apreciate an explanation why do we need NO_BOOTMEM guard
in the first place rather than why HAVE_MEMBLOCK is not needed.

> Suggested-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Anyway this looks better. I wish we can actually get rid of bootmem
allocator which would simplify this as well but that is another topic.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: Simplify #ifdef
> 
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 03d48d8835ba..611a970ac902 100644
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
> @@ -1224,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
>  	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
>  }
>  
> +#if defined(CONFIG_NO_BOOTMEM)
>  /**
>   * memblock_virt_alloc_internal - allocate boot memory block
>   * @size: size of memory block to be allocated in bytes
> @@ -1431,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
>  	      (u64)max_addr);
>  	return NULL;
>  }
> +#endif
>  
>  /**
>   * __memblock_free_early - free boot memory block
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4FCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74286206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74286206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIFNNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:13:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbeIFNNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26C04AE39;
        Thu,  6 Sep 2018 08:38:42 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:38:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 16/29] memblock: replace __alloc_bootmem_node with
 appropriate memblock_ API
Message-ID: <20180906083841.GA14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-17-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-17-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:31, Mike Rapoport wrote:
> Use memblock_alloc_try_nid whenever goal (i.e. mininal address is
> specified) and memblock_alloc_node otherwise.

I suspect you wanted to say (i.e. minimal address) is specified

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

One note below

> ---
>  arch/ia64/mm/discontig.c       |  6 ++++--
>  arch/ia64/mm/init.c            |  2 +-
>  arch/powerpc/kernel/setup_64.c |  6 ++++--
>  arch/sparc/kernel/setup_64.c   | 10 ++++------
>  arch/sparc/kernel/smp_64.c     |  4 ++--
>  5 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 1928d57..918dda9 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -451,8 +451,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
>  	if (bestnode == -1)
>  		bestnode = anynode;
>  
> -	ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
> -		PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
> +	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
> +				     __pa(MAX_DMA_ADDRESS),
> +				     BOOTMEM_ALLOC_ACCESSIBLE,
> +				     bestnode);
>  
>  	return ptr;
>  }
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index ffcc358..2169ca5 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -459,7 +459,7 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
>  		pte = pte_offset_kernel(pmd, address);
>  
>  		if (pte_none(*pte))
> -			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node))) >> PAGE_SHIFT,
> +			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
>  					     PAGE_KERNEL));

This doesn't seem to belong to the patch, right?

>  	}
>  	return 0;
-- 
Michal Hocko
SUSE Labs

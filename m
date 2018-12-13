Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88360C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C1A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C1A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeLMLL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:11:59 -0500
Received: from foss.arm.com ([217.140.101.70]:59360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeLMLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:11:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30A6A78;
        Thu, 13 Dec 2018 03:11:58 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82F5F3F575;
        Thu, 13 Dec 2018 03:11:58 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 482E61AE0D04; Thu, 13 Dec 2018 11:12:22 +0000 (GMT)
Date:   Thu, 13 Dec 2018 11:12:22 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20181213111221.GB31177@edgewater-inn.cambridge.arm.com>
References: <20181213170107.38bd04d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213170107.38bd04d6@canb.auug.org.au>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 05:01:07PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   arch/arm64/mm/mmu.c
> 
> between commit:
> 
>   4ab215061554 ("arm64: Add memory hotplug support")
> 
> from the arm64 tree and commit:
> 
>   232619fcc076 ("lib/ioremap: ensure break-before-make is used for huge p4d mappings")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/mm/mmu.c
> index da513a1facf4,cf9a26d3d7f5..000000000000
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@@ -1047,19 -1029,7 +1043,24 @@@ int pud_free_pmd_page(pud_t *pudp, unsi
>   	return 1;
>   }
>   
>  +#ifdef CONFIG_MEMORY_HOTPLUG
>  +int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  +		    bool want_memblock)
>  +{
>  +	int flags = 0;
>  +
>  +	if (rodata_full || debug_pagealloc_enabled())
>  +		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  +
>  +	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>  +			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
>  +
>  +	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>  +			   altmap, want_memblock);
>  +}
>  +#endif
> ++
> + int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
> + {
> + 	return 0;	/* Don't attempt a block mapping */
> + }

Looks good to me, thanks.

Will

Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A551B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544705996;
	bh=xKkoOCOSA26D9EssDh96TQ3hG5lvU/P6r/Im4gA55uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jsu+bxesXQTPaRadC2gj4pDYMCygYEVaTq5b60+UrafjfIA8CrrH0t7VTpZngaDVJ
	 /O/XutiIP8ExciZyiXeqPCu7Fiqni4jYEqdHd+xbHU05VeJLCpOx5rSEL4MQFxZ1xR
	 XNkzRSPe/e/oKzKdH2IFax9Lbz2mu+PU+9fywf00=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A551B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeLMM7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:59:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeLMM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:59:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9136DAF79;
        Thu, 13 Dec 2018 12:59:52 +0000 (UTC)
Date:   Thu, 13 Dec 2018 13:59:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181213125952.GA1286@dhcp22.suse.cz>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212172712.34019-2-zaslonko@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 18:27:12, Mikhail Zaslonko wrote:
> If memory end is not aligned with the sparse memory section boundary, the
> mapping of such a section is only partly initialized. This may lead to
> VM_BUG_ON due to uninitialized struct page access from
> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
> memory_hotplug sysfs handlers:
> 
> Here are the the panic examples:
>  CONFIG_DEBUG_VM=y
>  CONFIG_DEBUG_VM_PGFLAGS=y
> 
>  kernel parameter mem=2050M
>  --------------------------
>  page:000003d082008000 is uninitialized and poisoned
>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>  Call Trace:
>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>   [<00000000003e4194>] seq_read+0x204/0x480
>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>   [<00000000003b55b2>] vfs_read+0x82/0x138
>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>  Last Breaking-Event-Address:
>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
>  kernel parameter mem=3075M
>  --------------------------
>  page:000003d08300c000 is uninitialized and poisoned
>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>  Call Trace:
>  ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
>   [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>   [<00000000003e4194>] seq_read+0x204/0x480
>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>   [<00000000003b55b2>] vfs_read+0x82/0x138
>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>  Last Breaking-Event-Address:
>   [<000000000038596c>] is_mem_section_removable+0xb4/0x190
>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> Fix the problem by initializing the last memory section of each zone
> in memmap_init_zone() till the very end, even if it goes beyond the zone
> end.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: <stable@vger.kernel.org>

This has alwways been problem AFAIU. It just went unnoticed because we
have zeroed memmaps during allocation before f7f99100d8d9 ("mm: stop
zeroing memory during allocation in vmemmap") and so the above test
would simply skip these ranges as belonging to zone 0 or provided a
garbage.

So I guess we do care for post f7f99100d8d9 kernels mostly and therefore
Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")

Other than that looks good to me.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ec9cc407216..e2afdb2dc2c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5542,6 +5542,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			cond_resched();
>  		}
>  	}
> +#ifdef CONFIG_SPARSEMEM
> +	/*
> +	 * If the zone does not span the rest of the section then
> +	 * we should at least initialize those pages. Otherwise we
> +	 * could blow up on a poisoned page in some paths which depend
> +	 * on full sections being initialized (e.g. memory hotplug).
> +	 */
> +	while (end_pfn % PAGES_PER_SECTION) {
> +		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
> +		end_pfn++;
> +	}
> +#endif
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs

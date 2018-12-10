Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50064C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0620880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544448296;
	bh=6ZZDzH6gdVDTl7y3r2QRzljknKB05IFEXMej0qIWNcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FFJkSFPAsg9Pvdrdl18oquK9G3uvgjzUhAtXv5jh3G7Pfv5ketBIxjq7gHNCcz37J
	 TmS/0w/1X+GXm6CBWmrqXp8fO4Bulb4eveuW6R0CU/xGJonX8rfvHlDS2TOr23wEEw
	 Fn1H8Am3bbCqarr3gtTL5DC7E6UmVQGvwQkbKSN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED0620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeLJNYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:24:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLJNYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:24:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33371AE0B;
        Mon, 10 Dec 2018 13:24:52 +0000 (UTC)
Date:   Mon, 10 Dec 2018 14:24:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181210132451.GO1286@dhcp22.suse.cz>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210130712.30148-2-zaslonko@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 14:07:12, Mikhail Zaslonko wrote:
> If memory end is not aligned with the sparse memory section boundary, the
> mapping of such a section is only partly initialized.

It would be great to mention how you can end up in the situation like
this(a user provided memmap or a strange HW). 

> This may lead to
> VM_BUG_ON due to uninitialized struct page access from
> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
> memory_hotplug sysfs handlers:
> 
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
> Fix the problem by initializing the last memory section of the highest zone
> in memmap_init_zone() till the very end, even if it goes beyond the zone
> end.

Why do we need to restrict this to the highest zone? In other words, why
cannot we do what I was suggesting earlier [1]. What does prevent other
zones to have an incomplete section boundary?

[1] http://lkml.kernel.org/r/20181105183533.GQ4361@dhcp22.suse.cz

> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_alloc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ec9cc407216..41ef5508e5f1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5542,6 +5542,21 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			cond_resched();
>  		}
>  	}
> +#ifdef CONFIG_SPARSEMEM
> +	/*
> +	 * If there is no zone spanning the rest of the section
> +	 * then we should at least initialize those pages. Otherwise we
> +	 * could blow up on a poisoned page in some paths which depend
> +	 * on full sections being initialized (e.g. memory hotplug).
> +	 */
> +	if (end_pfn == max_pfn) {
> +		while (end_pfn % PAGES_PER_SECTION) {
> +			__init_single_page(pfn_to_page(end_pfn), end_pfn, zone,
> +					   nid);
> +			end_pfn++;
> +		}
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

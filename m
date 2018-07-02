Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61CBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7230B253E9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7230B253E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeGBQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:05:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752212AbeGBQFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:05:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A37C7AEC8;
        Mon,  2 Jul 2018 16:05:13 +0000 (UTC)
Date:   Mon, 2 Jul 2018 18:05:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, bhe@redhat.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/sparse: Make sparse_init_one_section void and remove
 check
Message-ID: <20180702160512.GF19043@dhcp22.suse.cz>
References: <20180702154325.12196-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702154325.12196-1-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 17:43:25, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> sparse_init_one_section() is being called from two sites:
> sparse_init() and sparse_add_one_section().
> The former calls it from a for_each_present_section_nr() loop,
> and the latter marks the section as present before calling it.
> This means that when sparse_init_one_section() gets called, we already know
> that the section is present.
> So there is no point to double check that in the function.
> 
> This removes the check and makes the function void.

Looks good.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/sparse.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b2848cc6e32a..f55e79fda03e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -264,19 +264,14 @@ struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pn
>  	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
>  }
>  
> -static int __meminit sparse_init_one_section(struct mem_section *ms,
> +static void __meminit sparse_init_one_section(struct mem_section *ms,
>  		unsigned long pnum, struct page *mem_map,
>  		unsigned long *pageblock_bitmap)
>  {
> -	if (!present_section(ms))
> -		return -EINVAL;
> -
>  	ms->section_mem_map &= ~SECTION_MAP_MASK;
>  	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
>  							SECTION_HAS_MEM_MAP;
>   	ms->pageblock_flags = pageblock_bitmap;
> -
> -	return 1;
>  }
>  
>  unsigned long usemap_size(void)
> @@ -801,12 +796,11 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
>  #endif
>  
>  	section_mark_present(ms);
> -
> -	ret = sparse_init_one_section(ms, section_nr, memmap, usemap);
> +	sparse_init_one_section(ms, section_nr, memmap, usemap);
>  
>  out:
>  	pgdat_resize_unlock(pgdat, &flags);
> -	if (ret <= 0) {
> +	if (ret < 0) {
>  		kfree(usemap);
>  		__kfree_section_memmap(memmap, altmap);
>  	}
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs

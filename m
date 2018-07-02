Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B051AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7F25427
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7F25427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGBP7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:59:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752184AbeGBP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:59:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51593AD0E;
        Mon,  2 Jul 2018 15:59:00 +0000 (UTC)
Date:   Mon, 2 Jul 2018 17:58:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH] mm: teach dump_page() to correctly output poisoned
 struct pages
Message-ID: <20180702155858.GE19043@dhcp22.suse.cz>
References: <20180702152745.27596-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702152745.27596-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 11:27:45, Pavel Tatashin wrote:
> If struct page is poisoned, and uninitialized access is detected via
> PF_POISONED_CHECK(page) dump_page() is called to output the page. But,
> the dump_page() itself accesses struct page to determine how to print
> it, and therefore gets into a recursive loop.
> 
> For example:
> dump_page()
>  __dump_page()
>   PageSlab(page)
>    PF_POISONED_CHECK(page)
>     VM_BUG_ON_PGFLAGS(PagePoisoned(page), page)
>      dump_page() recursion loop.

This deserves a big fat comment in __dump_page. Basically no Page$FOO
can be used on an HWPoison page.
 
> Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/debug.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 56e2d9125ea5..469b526e6abc 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -43,12 +43,20 @@ const struct trace_print_flags vmaflag_names[] = {
>  
>  void __dump_page(struct page *page, const char *reason)
>  {
> +	bool page_poisoned = PagePoisoned(page);
> +	int mapcount;
> +
> +	if (page_poisoned) {
> +		pr_emerg("page:%px is uninitialized and poisoned", page);
> +		goto hex_only;
> +	}
> +
>  	/*
>  	 * Avoid VM_BUG_ON() in page_mapcount().
>  	 * page->_mapcount space in struct page is used by sl[aou]b pages to
>  	 * encode own info.
>  	 */
> -	int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
> +	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>  
>  	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
>  		  page, page_ref_count(page), mapcount,
> @@ -60,6 +68,7 @@ void __dump_page(struct page *page, const char *reason)
>  
>  	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  
> +hex_only:
>  	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
> @@ -68,7 +77,7 @@ void __dump_page(struct page *page, const char *reason)
>  		pr_alert("page dumped because: %s\n", reason);
>  
>  #ifdef CONFIG_MEMCG
> -	if (page->mem_cgroup)
> +	if (!page_poisoned && page->mem_cgroup)
>  		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
>  #endif
>  }
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs

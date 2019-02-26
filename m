Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB28C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8941821848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551187546;
	bh=EXosUi4sTv30cQvuYy6W9gjDgE/Je6YxLKBnqXrWSvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O+Wrjp+etAhxOyo5EFZN+D2VirdlQxx8wl0uUuhDcShVfAz2NlFTjPVPgdo65RuC9
	 eTbv9GGLLSD6prrPLBI6JVWhKvvsRRKC3h1Inl8SsKrJvIKwPiPoo8cqzaUfyEh0aV
	 V5baw82AutPm247H0K7W5VhpMWcwsRDtzmQUTp2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBZNZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:25:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBZNZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:25:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87974ACB7;
        Tue, 26 Feb 2019 13:25:43 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:25:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: hwpoison: fix thp split handing in
 soft_offline_in_use_page()
Message-ID: <20190226132542.GB10588@dhcp22.suse.cz>
References: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Kirril for the THP side]

On Tue 26-02-19 19:18:00, zhong jiang wrote:
> From: zhongjiang <zhongjiang@huawei.com>
> 
> When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,
> we trigger the following VM_BUG_ON_PAGE():
> 
> Memory failure: 0x3755ff: non anonymous thp
> __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
> Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
> page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
> flags: 0x2fffff80000000()
> raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> ------------[ cut here ]------------
> kernel BUG at ./include/linux/mm.h:519!
> 
> soft_offline_in_use_page() passed refcount and page lock from tail page to
> head page, which is not needed because we can pass any subpage to
> split_huge_page().
> 
> Cc: <stable@vger.kernel.org>        [4.5+]
> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
> ---
>  mm/memory-failure.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9b8a24..6edc6db 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1823,19 +1823,17 @@ static int soft_offline_in_use_page(struct page *page, int flags)
>  	struct page *hpage = compound_head(page);
>  
>  	if (!PageHuge(page) && PageTransHuge(hpage)) {
> -		lock_page(hpage);
> -		if (!PageAnon(hpage) || unlikely(split_huge_page(hpage))) {
> -			unlock_page(hpage);
> -			if (!PageAnon(hpage))
> +		lock_page(page);
> +		if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> +			unlock_page(page);
> +			if (!PageAnon(page))
>  				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
>  			else
>  				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
> -			put_hwpoison_page(hpage);
> +			put_hwpoison_page(page);
>  			return -EBUSY;
>  		}
> -		unlock_page(hpage);
> -		get_hwpoison_page(page);
> -		put_hwpoison_page(hpage);
> +		unlock_page(page);
>  	}
>  
>  	/*
> -- 
> 1.7.12.4
> 

-- 
Michal Hocko
SUSE Labs

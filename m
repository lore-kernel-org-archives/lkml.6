Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53457C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342B218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549960414;
	bh=ANEJorn+eZueJIlUmODeIM0LaXedjnc9zZep9TBt1GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y9QVzY2lqx65VM7peff9NotGXUWMPnOoJdaZoe2oFPTjKP1kh/YKOtTlSYD0+Ip5L
	 rVyq8RmffEOA0pJArtzm+8MjIPZPD6/bl6pPb7KRHwidn9vc3q5GAu8VZjoYSxCXML
	 zuUzePsYr97XUBSNe4UEF7oeq5IDpJjjBYXEfoAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfBLIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:33:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbfBLIdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:33:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EC3EAF17;
        Tue, 12 Feb 2019 08:33:31 +0000 (UTC)
Date:   Tue, 12 Feb 2019 09:33:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190212083329.GN15609@dhcp22.suse.cz>
References: <20190208090604.975-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208090604.975-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-02-19 10:06:04, Oscar Salvador wrote:
> isolate_huge_page() expects we pass the head of hugetlb page to it:
> 
> bool isolate_huge_page(...)
> {
> 	...
> 	VM_BUG_ON_PAGE(!PageHead(page), page);
> 	...
> }
> 
> While I really cannot think of any situation where we end up with a
> non-head page between hands in do_migrate_range(), let us make sure
> the code is as sane as possible by explicitly passing the Head.
> Since we already got the pointer, it does not take us extra effort.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw.

> ---
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 656ff386ac15..d5f7afda67db 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1378,12 +1378,12 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		if (PageHuge(page)) {
>  			struct page *head = compound_head(page);
> -			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
>  			if (compound_order(head) > PFN_SECTION_SHIFT) {
>  				ret = -EBUSY;
>  				break;
>  			}

Why are we doing this, btw? 

> -			isolate_huge_page(page, &source);
> +			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
> +			isolate_huge_page(head, &source);
>  			continue;
>  		} else if (PageTransHuge(page))
>  			pfn = page_to_pfn(compound_head(page))
> -- 
> 2.13.7

-- 
Michal Hocko
SUSE Labs

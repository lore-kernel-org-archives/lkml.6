Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781372133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545060580;
	bh=MctUuQGw1g1AAjydr6NuO5oNM2KgLz0YGch/Kga5mvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzpUb8eCKOBNj0Gybf4LhQJYTYVwHlCHoFE7MunZaA4icMRMVy3FEMeKu7jfG+tSR
	 bbANrpMiEWAz7isJg0t4id1uDg8+i7Yu70h6KDz4JvoDatTkMlP+pBPpKYUYcgX3oe
	 F3pRjypk+r4FRlr/CX1VXJNrI9DmPpK7bKRJ8FOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbeLQP3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:29:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732671AbeLQP3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:29:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BE31AF86;
        Mon, 17 Dec 2018 15:29:37 +0000 (UTC)
Date:   Mon, 17 Dec 2018 16:29:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181217152936.GR30879@dhcp22.suse.cz>
References: <20181217150651.16176-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150651.16176-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 16:06:51, Oscar Salvador wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a6e7bfd18cde..18d41e85f672 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8038,11 +8038,12 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page)) {
> +			struct page *head = compound_head(page);
>  
> -			if (!hugepage_migration_supported(page_hstate(page)))
> +			if (!hugepage_migration_supported(page_hstate(head)))
>  				goto unmovable;

OK, this makes sense.

>  
> -			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
> +			iter = round_up(iter + 1, 1<<compound_order(head)) - 1;

but this less so. You surely do not want to move by the full hugetlb
page when you got a tail page, right? You could skip too much. You have
to consider page - head into the equation.

Btw. the reason we haven't seen before is that a) giga pages are rarely
used and b) normale hugepages should be properly aligned and they do not
span more mem sections. Maybe there is some obscure path to trigger this
for CMA but I do not see it.

>  			continue;
>  		}
>  
> -- 
> 2.13.7

-- 
Michal Hocko
SUSE Labs

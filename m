Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F4621720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbeLTOV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:21:29 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:18933 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbeLTOV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:21:29 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 3BC633CAB; Thu, 20 Dec 2018 15:21:27 +0100 (CET)
Date:   Thu, 20 Dec 2018 15:21:27 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220142124.r34fnuv6b33luj5a@d104.suse.de>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
 <20181220130606.GG9104@dhcp22.suse.cz>
 <20181220134132.6ynretwlndmyupml@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220134132.6ynretwlndmyupml@d104.suse.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 02:41:32PM +0100, Oscar Salvador wrote:
> On Thu, Dec 20, 2018 at 02:06:06PM +0100, Michal Hocko wrote:
> > You did want iter += skip_pages - 1 here right?
> 
> Bleh, yeah.
> I am taking vacation today so my brain has left me hours ago, sorry.
> Should be:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4812287e56a0..0634fbdef078 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8094,7 +8094,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>                                 goto unmovable;
>  
>                         skip_pages = (1 << compound_order(head)) - (page - head);
> -                       iter = round_up(iter + 1, skip_pages) - 1;
> +                       iter += skip_pages - 1;
>                         continue;
>                 }

On a second thought, I think it should not really matter.

AFAICS, we can have these scenarios:

1) the head page is the first page in the pabeblock
2) first page in the pageblock is not a head but part of a hugepage
3) the head is somewhere within the pageblock

For cases 1) and 3), iter will just get the right value and we will
break the loop afterwards.

In case 2), iter will be set to a value to skip over the remaining pages.

I am assuming that hugepages are allocated and packed together.

Note that I am not against the change, but I just wanted to see if there is
something I am missing.
-- 
Oscar Salvador
SUSE L3

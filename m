Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94825C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F85E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfBUVKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:10:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBUVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FA3681129;
        Thu, 21 Feb 2019 21:10:41 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A625D706;
        Thu, 21 Feb 2019 21:10:40 +0000 (UTC)
Date:   Thu, 21 Feb 2019 16:10:38 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange
 two lists of pages.
Message-ID: <20190221211038.GC5201@redhat.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215220856.29749-2-zi.yan@sent.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 21 Feb 2019 21:10:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:08:26PM -0800, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In stead of using two migrate_pages(), a single exchange_pages() would
> be sufficient and without allocating new pages.

So i believe it would be better to arrange the code differently instead
of having one function that special case combination, define function for
each one ie:
    exchange_anon_to_share()
    exchange_anon_to_anon()
    exchange_share_to_share()

Then you could define function to test if a page is in correct states:
    can_exchange_anon_page() // return true if page can be exchange
    can_exchange_share_page()

In fact both of this function can be factor out as common helpers with the
existing migrate code within migrate.c This way we would have one place
only where we need to handle all the special casing, test and exceptions.

Other than that i could not spot anything obviously wrong but i did not
spent enough time to check everything. Re-architecturing the code like
i propose above would make this a lot easier to review i believe.

Cheers,
Jérôme

> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/ksm.h |   5 +
>  mm/Makefile         |   1 +
>  mm/exchange.c       | 846 ++++++++++++++++++++++++++++++++++++++++++++
>  mm/internal.h       |   6 +
>  mm/ksm.c            |  35 ++
>  mm/migrate.c        |   4 +-
>  6 files changed, 895 insertions(+), 2 deletions(-)
>  create mode 100644 mm/exchange.c

[...]

> +	from_page_count = page_count(from_page);
> +	from_map_count = page_mapcount(from_page);
> +	to_page_count = page_count(to_page);
> +	to_map_count = page_mapcount(to_page);
> +	from_flags = from_page->flags;
> +	to_flags = to_page->flags;
> +	from_mapping = from_page->mapping;
> +	to_mapping = to_page->mapping;
> +	from_index = from_page->index;
> +	to_index = to_page->index;

Those are not use anywhere ...

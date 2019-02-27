Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B46C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A82183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfB0VvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:51:11 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:14869 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfB0VvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:51:11 -0500
Received: by suse.de (Postfix, from userid 1000)
        id E8E8843F0; Wed, 27 Feb 2019 22:51:09 +0100 (CET)
Date:   Wed, 27 Feb 2019 22:51:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190227215109.cpiaheyqs2qdbl7p@d104.suse.de>
References: <20190221094212.16906-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221094212.16906-1-osalvador@suse.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:42:12AM +0100, Oscar Salvador wrote:
> [1] https://lore.kernel.org/patchwork/patch/998796/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Any further comments on this?
I do have a "concern" I would like to sort out before dropping the RFC:

It is the fact that unless we have spare gigantic pages in other notes, the
offlining operation will loop forever (until the customer cancels the operation).
While I do not really like that, I do think that memory offlining should be done
with some sanity, and the administrator should know in advance if the system is going
to be able to keep up with the memory pressure, aka: make sure we got what we need in
order to make the offlining operation to succeed.
That translates to be sure that we have spare gigantic pages and other nodes
can take them.

Given said that, another thing I thought about is that we could check if we have
spare gigantic pages at has_unmovable_pages() time.
Something like checking "h->free_huge_pages - h->resv_huge_pages > 0", and if it
turns out that we do not have gigantic pages anywhere, just return as we have
non-movable pages.

But I would rather not convulate has_unmovable_pages() with such checks and "trust"
the administrator.

> ---
>  mm/memory_hotplug.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d5f7afda67db..04f6695b648c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  		if (!PageHuge(page))
>  			continue;
>  		head = compound_head(page);
> -		if (hugepage_migration_supported(page_hstate(head)) &&
> -		    page_huge_active(head))
> +		if (page_huge_active(head))
>  			return pfn;
>  		skip = (1 << compound_order(head)) - (page - head);
>  		pfn += skip - 1;
> @@ -1378,10 +1377,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		if (PageHuge(page)) {
>  			struct page *head = compound_head(page);
> -			if (compound_order(head) > PFN_SECTION_SHIFT) {
> -				ret = -EBUSY;
> -				break;
> -			}
>  			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
>  			isolate_huge_page(head, &source);
>  			continue;
> -- 
> 2.13.7
> 

-- 
Oscar Salvador
SUSE L3

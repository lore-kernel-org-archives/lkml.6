Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A820218E2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfBLNpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:45:51 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:15553 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfBLNpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:45:51 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 1FF22423F; Tue, 12 Feb 2019 14:45:49 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:45:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212083329.GN15609@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:33:29AM +0100, Michal Hocko wrote:
> >  
> >  		if (PageHuge(page)) {
> >  			struct page *head = compound_head(page);
> > -			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
> >  			if (compound_order(head) > PFN_SECTION_SHIFT) {
> >  				ret = -EBUSY;
> >  				break;
> >  			}
> 
> Why are we doing this, btw? 

I assume you are referring to:

> >                     if (compound_order(head) > PFN_SECTION_SHIFT) {
> >                             ret = -EBUSY;
> >                             break;
> >                     }

I thought it was in case we stumble upon a gigantic page, and commit
(c8721bbbdd36 mm: memory-hotplug: enable memory hotplug to handle hugepage)
confirms it.

But I am not really sure if the above condition would still hold on powerpc,
I wanted to check it but it is a bit more tricky than it is in x86_64 because
of the different hugetlb sizes.
Could it be that the above condition is not true, but still the order of that
hugetlb page goes beyond MAX_ORDER? It is something I have to check.

Anyway, I think that a safer way to check this would be using hstate_is_gigantic(),
which checks whether the order of the hstate goes beyond MAX_ORDER.
In the end, I think that all we care about is if we can get the pages to migrate
to via the buddy allocator, since gigantic pages need to use another method.

Actually, alloc_migrate_huge_page() checks for it:

<---
static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
		int nid, nodemask_t *nmask)
{

	if (hstate_is_gigantic(h))
		return NULL;
--->

Another thing is that AFAICS, as long as the memblock we try to offline contains
a gigantic page, it will not be able to be offlined.
Moreover, the -EBUSY we return in that case is not checked anywhere, although that
is not really an issue because scan_movable_pages will skip it in the next loop.

Now, this is more rambling than anything:
Maybe I am missing half of the picture, but I have been thinking for a while whether
we could do better when it comes to gigantic pages vs hotplug.
I think that we could try to migrate those in case any of the other nodes
have a spare pre-allocated gigantic page.

-- 
Oscar Salvador
SUSE L3

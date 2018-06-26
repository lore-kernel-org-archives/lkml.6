Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18398C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65D426C83
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65D426C83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935344AbeFZOo7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:44:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49443 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934936AbeFZOo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:44:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86597ABEA;
        Tue, 26 Jun 2018 14:44:57 +0000 (UTC)
Date:   Tue, 26 Jun 2018 16:44:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-ID: <20180626144456.GZ28965@dhcp22.suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
 <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-06-18 15:57:39, Vlastimil Babka wrote:
> On 06/22/2018 06:28 PM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There is no real reason to blow up just because the caller doesn't know
> > that __get_free_pages cannot return highmem pages. Simply fix that up
> > silently. Even if we have some confused users such a fixup will not be
> > harmful.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> > Hi Andrew,
> > previously posted [1] but it fell through cracks. Can we merge it now?
> > 
> > [1] http://lkml.kernel.org/r/20171129160446.jluzpv3n6mjc3fwv@dhcp22.suse.cz
> > 
> >  mm/page_alloc.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 1521100f1e63..5f56f662a52d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4402,18 +4402,14 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> >  EXPORT_SYMBOL(__alloc_pages_nodemask);
> >  
> >  /*
> > - * Common helper functions.
> > + * Common helper functions. Never use with __GFP_HIGHMEM because the returned
> > + * address cannot represent highmem pages. Use alloc_pages and then kmap if
> > + * you need to access high mem.
> >   */
> >  unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order)
> >  {
> >  	struct page *page;
> >  
> > -	/*
> > -	 * __get_free_pages() returns a virtual address, which cannot represent
> > -	 * a highmem page
> > -	 */
> > -	VM_BUG_ON((gfp_mask & __GFP_HIGHMEM) != 0);
> > -
> >  	page = alloc_pages(gfp_mask, order);
> 
> The previous version had also replaced the line above with:
> 
> +	page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
> 
> This one doesn't, yet you say "fix that up silently". Bug?

got lost somewhere on the way during the discussion. Thanks for spotting
that.

Andrew, could you add gfp_mask & ~__GFP_HIGHMEM please? Or should I
resubmit?

-- 
Michal Hocko
SUSE Labs

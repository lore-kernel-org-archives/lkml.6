Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2222C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252C267A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252C267A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeF0HeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:34:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeF0HeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:34:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AD9EABDD;
        Wed, 27 Jun 2018 07:34:21 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:34:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-ID: <20180627073420.GD32348@dhcp22.suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
 <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
 <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-06-18 10:04:16, Andrew Morton wrote:
> On Tue, 26 Jun 2018 15:57:39 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > On 06/22/2018 06:28 PM, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > There is no real reason to blow up just because the caller doesn't know
> > > that __get_free_pages cannot return highmem pages. Simply fix that up
> > > silently. Even if we have some confused users such a fixup will not be
> > > harmful.
> > > 
> >
> > ...
> >
> > >  /*
> > > - * Common helper functions.
> > > + * Common helper functions. Never use with __GFP_HIGHMEM because the returned
> > > + * address cannot represent highmem pages. Use alloc_pages and then kmap if
> > > + * you need to access high mem.
> > >   */
> > >  unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order)
> > >  {
> > >  	struct page *page;
> > >  
> > > -	/*
> > > -	 * __get_free_pages() returns a virtual address, which cannot represent
> > > -	 * a highmem page
> > > -	 */
> > > -	VM_BUG_ON((gfp_mask & __GFP_HIGHMEM) != 0);
> > > -
> > >  	page = alloc_pages(gfp_mask, order);
> > 
> > The previous version had also replaced the line above with:
> > 
> > +	page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
> > 
> > This one doesn't, yet you say "fix that up silently". Bug?
> > 
> 
> This reminds me what is irritating about the patch.  We're adding
> additional code to a somewhat fast path to handle something which we
> know never happens, thanks to the now-removed check.
> 
> This newly-added code might become functional in the future, if people
> add incorrect callers.  Callers whose incorrectness would have been
> revealed by the now-removed check!

That check depends on a debugging config option which is not enabled all
the time so how does this help in most production systems? More over it
is "blow up on incorrect use" kind of check. I am pretty sure Linus
would have some word about such error handling...

> So.. argh.
> 
> Really, the changelog isn't right.  There *is* a real reason to blow
> up.  Effectively the caller is attempting to obtain the virtual address
> of a highmem page without having kmapped it first.  That's an outright
> bug.

And as I've argued before the code would be wrong regardless. We would
leak the memory or worse touch somebody's else kmap without knowing
that.  So we have a choice between a mem leak, data corruption k or a
silent fixup. I would prefer the last option. And blowing up on a BUG
is not much better on something that is easily fixable. I am not really
convinced that & ~__GFP_HIGHMEM is something to lose sleep over.
 
> An alternative might be to just accept the bogus __GFP_HIGHMEM, let
> page_to_virt() return a crap address and wait for the user bug reports
> to come in when someone tries to run the offending code on a highmem
> machine.  That shouldn't take too long - the page allocator will prefer
> to return a highmem page in this case.

Well, I would be concerned about page_address returning an active kmap
much more.

> And adding a rule to the various static checkers should catch most
> offenders.

This all sounds like a heavy lifting for something that can be easily
fixed up. If we ever see the additional and with a mask as a problem we
can think about a more optimal solution.

-- 
Michal Hocko
SUSE Labs

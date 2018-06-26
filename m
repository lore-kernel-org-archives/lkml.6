Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC4826C91
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4826C91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFZRET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:04:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeFZRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:04:18 -0400
Received: from akpm-x1 (c-71-198-198-76.hsd1.ca.comcast.net [71.198.198.76])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75126BC8;
        Tue, 26 Jun 2018 17:04:17 +0000 (UTC)
Date:   Tue, 26 Jun 2018 10:04:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-Id: <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
In-Reply-To: <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
        <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 15:57:39 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 06/22/2018 06:28 PM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There is no real reason to blow up just because the caller doesn't know
> > that __get_free_pages cannot return highmem pages. Simply fix that up
> > silently. Even if we have some confused users such a fixup will not be
> > harmful.
> > 
>
> ...
>
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
> 

This reminds me what is irritating about the patch.  We're adding
additional code to a somewhat fast path to handle something which we
know never happens, thanks to the now-removed check.

This newly-added code might become functional in the future, if people
add incorrect callers.  Callers whose incorrectness would have been
revealed by the now-removed check!

So.. argh.

Really, the changelog isn't right.  There *is* a real reason to blow
up.  Effectively the caller is attempting to obtain the virtual address
of a highmem page without having kmapped it first.  That's an outright
bug.


An alternative might be to just accept the bogus __GFP_HIGHMEM, let
page_to_virt() return a crap address and wait for the user bug reports
to come in when someone tries to run the offending code on a highmem
machine.  That shouldn't take too long - the page allocator will prefer
to return a highmem page in this case.

And adding a rule to the various static checkers should catch most
offenders.

Or just leave the ode as it is now.

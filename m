Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D550C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14892173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHo5dniL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbfBRRw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:52:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfBRRw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g2UasSOVduo4Pn1t6looKIhYnzUquXamY1qe8zmaCUs=; b=EHo5dniLrM/vmG3M0pRQk566g
        4qKO4CXsRCLz5jjir8alD/8vEmVbKNo549TgKV64dx7kyjb2ivG7X+dX9m9bpeG0PDZCVKi+ZEh+y
        1+H8QLqSKkHnToZ8DnrlDK7AfXTR71F516hZ4X5ei0TlLZV2WbkrXhXP88a/y1G0ACwV4ivkKLtqb
        LZyqUCP4tC9i1O1dSCgvD+mrl0+0+nm/wKVi2GSRSk5QW0dJA+tUbDpJSdNP8bb4gXPA5xzIJKtKx
        H0/EquC/MBVd7elx6AnapGJ0MdBHBRjKQmSBx+9ygzNU+ImdcGwi+9nfMAXHYzvitGu8q5a/1ffkN
        dUzf7qjgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvn5d-0000Zt-4c; Mon, 18 Feb 2019 17:52:25 +0000
Date:   Mon, 18 Feb 2019 09:52:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange
 two lists of pages.
Message-ID: <20190218175224.GT12668@bombadil.infradead.org>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
 <20190217112943.GP12668@bombadil.infradead.org>
 <65A1FFA0-531C-4078-9704-3F44819C3C07@nvidia.com>
 <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
 <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:51:33AM -0800, Zi Yan wrote:
> On 18 Feb 2019, at 9:42, Vlastimil Babka wrote:
> > On 2/18/19 6:31 PM, Zi Yan wrote:
> > > The purpose of proposing exchange_pages() is to avoid allocating any
> > > new
> > > page,
> > > so that we would not trigger any potential page reclaim or memory
> > > compaction.
> > > Allocating a temporary page defeats the purpose.
> > 
> > Compaction can only happen for order > 0 temporary pages. Even if you
> > used
> > single order = 0 page to gradually exchange e.g. a THP, it should be
> > better than
> > u64. Allocating order = 0 should be a non-issue. If it's an issue, then
> > the
> > system is in a bad state and physically contiguous layout is a secondary
> > concern.
> 
> You are right if we only need to allocate one order-0 page. But this also
> means
> we can only exchange two pages at a time. We need to add a lock to make sure
> the temporary page is used exclusively or we need to keep allocating
> temporary pages
> when multiple exchange_pages() are happening at the same time.

You allocate one temporary page per thread that's doing an exchange_page().

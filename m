Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97507C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C874208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ASgBWw3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C874208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJPXIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:08:53 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:58740 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbeJPXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539703076;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=zisL8ov3KWgOHzFU/T/9Xg/6fw08V8Px6ZPEYvtNj7Q=;
        b=ASgBWw3jDOL8TKeDbOYwCa02AaGBGhDgP2fKf1E4yTa9bKQJ3iIzOzSbtYr2jU/S
        3ck7EIf6O34idAuZm1UnjdXoglEsVwUTqscN6OrikeyHgi9v/cfhJQM0H8mE5VkZF/s
        4iAP6DkaYQqOeSDvixJJulzERDJ1v2sTQO01f1gk=
Date:   Tue, 16 Oct 2018 15:17:56 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     David Rientjes <rientjes@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <alpine.DEB.2.21.1810151715220.21338@chino.kir.corp.google.com>
Message-ID: <010001667d7476a2-f91dcf12-5e90-4ade-97e8-9fd651f7bf17-000000@email.amazonses.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com> <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org> <0100016679e3c96f-c78df4e2-9ab8-48db-8796-271c4b439f16-000000@email.amazonses.com>
 <alpine.DEB.2.21.1810151715220.21338@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.16-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, David Rientjes wrote:

> On Mon, 15 Oct 2018, Christopher Lameter wrote:
>
> > > > If the amount of waste is the same at higher cachep->gfporder values,
> > > > there is no significant benefit to allocating higher order memory.  There
> > > > will be fewer calls to the page allocator, but each call will require
> > > > zone->lock and finding the page of best fit from the per-zone free areas.
> >
> > There is a benefit because the management overhead is halved.
> >
>
> It depends on (1) how difficult it is to allocate higher order memory and
> (2) the long term affects of preferring high order memory over order 0.

The overhead of the page allocator is orders of magnitudes bigger than
slab allocation. Higher order may be faster because the pcp overhead is
not there. It all depends. Please come up with some benchmarking to
substantiate these ideas.

>
> For (1), slab has no minimum order fallback like slub does so the
> allocation either succeeds at cachep->gfporder or it fails.  If memory
> fragmentation is such that order-1 memory is not possible, this is fixing
> an issue where the slab allocation would succeed but now fails
> unnecessarily.  If that order-1 memory is painful to allocate, we've
> reclaimed and compacted unnecessarily when order-0 pages are available
> from the pcp list.
>

Ok that sounds good but the performance impact is still an issue. Also we
agreed that the page allocator will provide allocations up to
COSTLY_ORDER without too much fuss. Other system components may fail if
these smaller order pages are not available.

> > Have a benchmark that shows this?
> >
>
> I'm not necessarily approaching this from a performance point of view, but
> rather as a means to reduce slab fragmentation when fallback to order-0
> memory, especially when completely legitimate, is prohibited.  From a
> performance standpoint, this will depend on separately on fragmentation
> and contention on zone->lock which both don't exist for order-0 memory
> until fallback is required and then the pcp are filled with up to
> batchcount pages.

Fragmentation is a performance issue and causes degradation of Linux MM
performance over time.  There are pretty complex mechanism that need to be
played against one another.

Come up with some metrics to get meaningful data that allows us to see the
impact.

I think what would be beneficial to have is a load that gradually
degrade as another process causes fragmentation. Any patch like the one
proposed should have an effect on the degree of fragmentation after a
certain time.

Having something like that could lead to a whole serial of optimizations.
Ideally we would like to have a MM subsystem that does not degrade as
today.

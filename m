Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D736EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D34208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="J5k3y8Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D34208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeJPG2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:28:20 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:47404 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbeJPG2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539643263;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=/NWRkm6PUxqN230FlS/SDuydCxSv361vgdrxuJLoTLQ=;
        b=J5k3y8JuzcKDs+XcVtidq0Aam+O6U/NajDXWOX6m/XJjfSLPZAEMbgDE6InTlh0j
        ZdttSP9wTwHe8/9FEb69kc3GUTAYBGHimRGPzogeFfJUZYVWFA2SoaL1IK6hnUf7QUF
        xSDkSmZxc8ArLbE6d7asPB5lu79MSz/W7upxWm2M=
Date:   Mon, 15 Oct 2018 22:41:03 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org>
Message-ID: <0100016679e3c96f-c78df4e2-9ab8-48db-8796-271c4b439f16-000000@email.amazonses.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com> <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.15-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Andrew Morton wrote:

> > If the amount of waste is the same at higher cachep->gfporder values,
> > there is no significant benefit to allocating higher order memory.  There
> > will be fewer calls to the page allocator, but each call will require
> > zone->lock and finding the page of best fit from the per-zone free areas.

There is a benefit because the management overhead is halved.

> > Instead, it is better to allocate order-0 memory if possible so that pages
> > can be returned from the per-cpu pagesets (pcp).

Have a benchmark that shows this?

>
> > There are two reasons to prefer this over allocating high order memory:
> >
> >  - allocating from the pcp lists does not require a per-zone lock, and
> >
> >  - this reduces stranding of MIGRATE_UNMOVABLE pageblocks on pcp lists
> >    that increases slab fragmentation across a zone.

The slab allocators generally buffer pages from the page allocator to
avoid this effect given the slowness of page allocator operations anyways.


> Confused.  Higher-order slab pages never go through the pcp lists, do
> they?  I'd have thought that by tending to increase the amount of
> order-0 pages which are used by slab, such stranding would be
> *increased*?

Potentially.


> > We are particularly interested in the second point to eliminate cases
> > where all other pages on a pageblock are movable (or free) and fallback to
> > pageblocks of other migratetypes from the per-zone free areas causes
> > high-order slab memory to be allocated from them rather than from free
> > MIGRATE_UNMOVABLE pages on the pcp.

Well does this actually do some good?

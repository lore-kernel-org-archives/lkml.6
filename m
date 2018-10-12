Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E4C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0A22087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0A22087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeJMFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:48:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:48:14 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A76C0D93;
        Fri, 12 Oct 2018 22:13:43 +0000 (UTC)
Date:   Fri, 12 Oct 2018 15:13:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
Message-Id: <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 14:24:57 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> The slab allocator has a heuristic that checks whether the internal
> fragmentation is satisfactory and, if not, increases cachep->gfporder to
> try to improve this.
> 
> If the amount of waste is the same at higher cachep->gfporder values,
> there is no significant benefit to allocating higher order memory.  There
> will be fewer calls to the page allocator, but each call will require
> zone->lock and finding the page of best fit from the per-zone free areas.
> 
> Instead, it is better to allocate order-0 memory if possible so that pages
> can be returned from the per-cpu pagesets (pcp).
> 
> There are two reasons to prefer this over allocating high order memory:
> 
>  - allocating from the pcp lists does not require a per-zone lock, and
> 
>  - this reduces stranding of MIGRATE_UNMOVABLE pageblocks on pcp lists
>    that increases slab fragmentation across a zone.

Confused.  Higher-order slab pages never go through the pcp lists, do
they?  I'd have thought that by tending to increase the amount of
order-0 pages which are used by slab, such stranding would be
*increased*?

> We are particularly interested in the second point to eliminate cases
> where all other pages on a pageblock are movable (or free) and fallback to
> pageblocks of other migratetypes from the per-zone free areas causes
> high-order slab memory to be allocated from them rather than from free
> MIGRATE_UNMOVABLE pages on the pcp.
> 
>  mm/slab.c | 15 +++++++++++++++

Do slub and slob also suffer from this effect?


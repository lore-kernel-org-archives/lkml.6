Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420192087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420192087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJRTVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:21:32 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:42170 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727461AbeJRTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:21:32 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 8B2261C2041
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:20:57 +0100 (IST)
Received: (qmail 19169 invoked from network); 18 Oct 2018 11:20:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Oct 2018 11:20:57 -0000
Date:   Thu, 18 Oct 2018 12:20:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 3/5] mm/rmqueue_bulk: alloc without touching
 individual page structure
Message-ID: <20181018112055.GN5819@techsingularity.net>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-4-aaron.lu@intel.com>
 <20181017112042.GK5819@techsingularity.net>
 <20181017142327.GB9167@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181017142327.GB9167@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:23:27PM +0800, Aaron Lu wrote:
> > RT has had problems with cpu_relax in the past but more importantly, as
> > this delay for parallel compactions and allocations of contig ranges,
> > we could be stuck here for very long periods of time with interrupts
> 
> The longest possible time is one CPU accessing pcp->batch number cold
> cachelines. Reason:
> When zone_wait_cluster_alloc() is called, we already held zone lock so
> no more allocations are possible. Waiting in_progress to become zero
> means waiting any CPU that increased in_progress to finish processing
> their allocated pages. Since they will at most allocate pcp->batch pages
> and worse case are all these page structres are cache cold, so the
> longest wait time is one CPU accessing pcp->batch number cold cache lines.
> 
> I have no idea if this time is too long though.
> 

But compact_zone calls zone_wait_and_disable_cluster_alloc so how is the
disabled time there bound by pcp->batch?

> > disabled. It gets even worse if it's from an interrupt context such as
> > jumbo frame allocation or a high-order slab allocation that is atomic.
> 
> My understanding is atomic allocation won't trigger compaction, no?
> 

No, they can't. I didn't check properly but be wary of any possibility
whereby interrupts can get delayed in zone_wait_cluster_alloc. I didn't
go back and check if it can -- partially because I'm more focused on the
lazy buddy aspect at the moment.

> > It may be necessary to consider instead minimising the number
> > of struct page update when merging to PCP and then either increasing the
> > size of the PCP or allowing it to exceed pcp->high for short periods of
> > time to batch the struct page updates.
> 
> I don't quite follow this part. It doesn't seem possible we can exceed
> pcp->high in allocation path, or are you talking about free path?
> 

I'm talking about the free path.

> And thanks a lot for the review!

My pleasure, hope it helps.

-- 
Mel Gorman
SUSE Labs

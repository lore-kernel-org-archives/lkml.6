Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D45ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA221477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEA221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJSQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:59:48 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:51946 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbeJSQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:59:48 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 40C281C23BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:54:37 +0100 (IST)
Received: (qmail 18509 invoked from network); 19 Oct 2018 08:54:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2018 08:54:37 -0000
Date:   Fri, 19 Oct 2018 09:54:35 +0100
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
Subject: Re: [RFC v4 PATCH 2/5] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20181019085435.GR5819@techsingularity.net>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-3-aaron.lu@intel.com>
 <20181017104427.GJ5819@techsingularity.net>
 <20181017131059.GA9167@intel.com>
 <20181017135807.GL5819@techsingularity.net>
 <20181017145904.GC9167@intel.com>
 <20181018111632.GM5819@techsingularity.net>
 <20181019055703.GA2401@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181019055703.GA2401@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 01:57:03PM +0800, Aaron Lu wrote:
> > 
> > I don't think this is the right way of thinking about it because it's
> > possible to have the system split in such a way so that the migration
> > scanner only encounters unmovable pages before it meets the free scanner
> > where unmerged buddies were in the higher portion of the address space.
> 
> Yes it is possible unmerged pages are in the higher portion.
> 
> My understanding is, when the two scanners meet, all unmerged pages will
> be either used by the free scanner as migrate targets or sent to merge
> by the migration scanner.
> 

It's not guaranteed if the lower portion of the address space consisted
entirely of pages that cannot migrate (because they are unmovable or because
migration failed due to pins). It's actually a fundamental limitation
of compaction that it can miss migration and compaction opportunities
due to how the scanners are implemented. It was designed that way to
avoid pageblocks being migrated unnecessarily back and forth but the
downside is missed opportunities.

> > You either need to keep unmerged buddies on a separate list or search
> > the order-0 free list for merge candidates prior to compaction.
> > 
> > > > It's needed to form them efficiently but excessive reclaim or writing 3
> > > > to drop_caches can also do it. Be careful of tying lazy buddy too
> > > > closely to compaction.
> > > 
> > > That's the current design of this patchset, do you see any immediate
> > > problem of this? Is it that you are worried about high-order allocation
> > > success rate using this design?
> > 
> > I've pointed out what I see are the design flaws but yes, in general, I'm
> > worried about the high order allocation success rate using this design,
> > the reliance on compaction and the fact that the primary motivation is
> > when THP is disabled.
> 
> When THP is in use, zone lock contention is pretty much nowhere :-)
> 
> I'll see what I can get with 'address space range' lock first and will
> come back to 'lazy buddy' if it doesn't work out. Thank you and
> Vlastimil for all the suggestions.

My pleasure.

-- 
Mel Gorman
SUSE Labs

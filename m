Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E39C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A941620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfAPQPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:15:41 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:43626 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbfAPQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:15:41 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id C09D69875F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:15:38 +0000 (UTC)
Received: (qmail 17082 invoked from network); 16 Jan 2019 16:15:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2019 16:15:38 -0000
Date:   Wed, 16 Jan 2019 16:15:37 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/25] mm, compaction: Keep migration source private to a
 single compaction instance
Message-ID: <20190116161537.GG27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-13-mgorman@techsingularity.net>
 <0d02b611-85a7-b161-1310-883c4b1594f8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0d02b611-85a7-b161-1310-883c4b1594f8@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:45:59PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:49 PM, Mel Gorman wrote:
> > Due to either a fast search of the free list or a linear scan, it is
> > possible for multiple compaction instances to pick the same pageblock
> > for migration.  This is lucky for one scanner and increased scanning for
> > all the others. It also allows a race between requests on which first
> > allocates the resulting free block.
> > 
> > This patch tests and updates the pageblock skip for the migration scanner
> > carefully. When isolating a block, it will check and skip if the block is
> > already in use. Once the zone lock is acquired, it will be rechecked so
> > that only one scanner can set the pageblock skip for exclusive use. Any
> > scanner contending will continue with a linear scan. The skip bit is
> > still set if no pages can be isolated in a range.
> 
> Also the skip bit will remain set even if pages *could* be isolated,

That's the point -- the pageblock is scanned by one compaction instance
and skipped by others.

> AFAICS there's no clearing after a block was finished with
> nr_isolated>0. Is it intended?

Yes, defer to a full reset later when the compaction scanners meet.
Tracing really indicated we spent a stupid amount of time scanning,
rescanning and competing for pageblocks within short intervals.

> > Migration scan rates are reduced by 52%.
> 
> Wonder how much of that is due to not clearing as pointed out above.
> Also interesting how free scanned was reduced so disproportionally.
> 

The amount of free scanning is related to the amount of migration
scanning. If migration sources are scanning, rescanning and competing
for the same pageblocks, it can result in unnecessary free scanning too.
It doesn't fully explain the drop but I didn't specifically try to quantify
it either as the free scanner is altered further in later patches.

-- 
Mel Gorman
SUSE Labs

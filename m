Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E031DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6420868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfAQTjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:39:13 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:46528 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbfAQTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:39:13 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 70C4B1C2E59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 19:39:11 +0000 (GMT)
Received: (qmail 1433 invoked from network); 17 Jan 2019 19:39:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2019 19:39:11 -0000
Date:   Thu, 17 Jan 2019 19:39:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/25] mm, compaction: Reduce unnecessary skipping of
 migration target scanner
Message-ID: <20190117193909.GO27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-21-mgorman@techsingularity.net>
 <8e310c2a-5f2e-ee99-24c5-10a71972699a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8e310c2a-5f2e-ee99-24c5-10a71972699a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:58:30PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > The fast isolation of pages can move the scanner faster than is necessary
> > depending on the contents of the free list. This patch will only allow
> > the fast isolation to initialise the scanner and advance it slowly. The
> > primary means of moving the scanner forward is via the linear scanner
> > to reduce the likelihood the migration source/target scanners meet
> > prematurely triggering a rescan.
> 
> Maybe I've seen enough code today and need to stop, but AFAICS the description
> here doesn't match the actual code changes? What I see are some cleanups, and a
> change in free scanner that will set pageblock skip bit after a pageblock has
> been scanned, even if there were pages isolated, while previously it would set
> the skip bit only if nothing was isolated.
> 

The first three hunks could have been split out but it wouldn't help
overall. Maybe a changelog rewrite will help;

mm, compaction: Reduce premature advancement of the migration target scanner

The fast isolation of free pages allows the cached PFN of the free
scanner to advance faster than necessary depending on the contents
of the free list. The key is that fast_isolate_freepages() can update
zone->compact_cached_free_pfn via isolate_freepages_block().  When the
fast search fails, the linear scan can start from a point that has skipped
valid migration targets, particularly pageblocks with just low-order
free pages. This can cause the migration source/target scanners to meet
prematurely causing a reset.

This patch starts by avoiding an update of the pageblock skip information
and cached PFN from isolate_freepages_block() and puts the responsibility
of updating that information in the callers. The fast scanner will update
the cached PFN if and only if it finds a block that is higher than the
existing cached PFN and sets the skip if the pageblock is full or nearly
full. The linear scanner will update skipped information and the cached
PFN only when a block is completely scanned. The total impact is that
the free scanner advances more slowly as it is primarily driven by the
linear scanner instead of the fast search.

Does that help?

-- 
Mel Gorman
SUSE Labs

Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D9EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4612086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfARJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:09:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfARJJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:09:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D4EDAC85;
        Fri, 18 Jan 2019 09:09:54 +0000 (UTC)
Subject: Re: [PATCH 20/25] mm, compaction: Reduce unnecessary skipping of
 migration target scanner
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-21-mgorman@techsingularity.net>
 <8e310c2a-5f2e-ee99-24c5-10a71972699a@suse.cz>
 <20190117193909.GO27437@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a4dcc5e-9c31-c3bb-e38a-5ef955ca409e@suse.cz>
Date:   Fri, 18 Jan 2019 10:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117193909.GO27437@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 8:39 PM, Mel Gorman wrote:
> On Thu, Jan 17, 2019 at 06:58:30PM +0100, Vlastimil Babka wrote:
>> On 1/4/19 1:50 PM, Mel Gorman wrote:
>> > The fast isolation of pages can move the scanner faster than is necessary
>> > depending on the contents of the free list. This patch will only allow
>> > the fast isolation to initialise the scanner and advance it slowly. The
>> > primary means of moving the scanner forward is via the linear scanner
>> > to reduce the likelihood the migration source/target scanners meet
>> > prematurely triggering a rescan.
>> 
>> Maybe I've seen enough code today and need to stop, but AFAICS the description
>> here doesn't match the actual code changes? What I see are some cleanups, and a
>> change in free scanner that will set pageblock skip bit after a pageblock has
>> been scanned, even if there were pages isolated, while previously it would set
>> the skip bit only if nothing was isolated.
>> 
> 
> The first three hunks could have been split out but it wouldn't help
> overall. Maybe a changelog rewrite will help;
> 
> mm, compaction: Reduce premature advancement of the migration target scanner
> 
> The fast isolation of free pages allows the cached PFN of the free
> scanner to advance faster than necessary depending on the contents
> of the free list. The key is that fast_isolate_freepages() can update
> zone->compact_cached_free_pfn via isolate_freepages_block().  When the
> fast search fails, the linear scan can start from a point that has skipped
> valid migration targets, particularly pageblocks with just low-order
> free pages. This can cause the migration source/target scanners to meet
> prematurely causing a reset.
> 
> This patch starts by avoiding an update of the pageblock skip information
> and cached PFN from isolate_freepages_block() and puts the responsibility
> of updating that information in the callers. The fast scanner will update
> the cached PFN if and only if it finds a block that is higher than the
> existing cached PFN and sets the skip if the pageblock is full or nearly
> full. The linear scanner will update skipped information and the cached
> PFN only when a block is completely scanned. The total impact is that
> the free scanner advances more slowly as it is primarily driven by the
> linear scanner instead of the fast search.
> 
> Does that help?

Yeah, now I get it, thanks!

Acked-by: Vlastimil Babka <vbabka@suse.cz>



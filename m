Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D63C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D89C20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfAQJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:29:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfAQJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:29:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2816AD70;
        Thu, 17 Jan 2019 09:29:01 +0000 (UTC)
Subject: Re: [PATCH 12/25] mm, compaction: Keep migration source private to a
 single compaction instance
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-13-mgorman@techsingularity.net>
 <0d02b611-85a7-b161-1310-883c4b1594f8@suse.cz>
 <20190116161537.GG27437@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ff6953a1-6cb4-8f5d-4bfa-f1e8f5dd4f7a@suse.cz>
Date:   Thu, 17 Jan 2019 10:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116161537.GG27437@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 5:15 PM, Mel Gorman wrote:
> On Wed, Jan 16, 2019 at 04:45:59PM +0100, Vlastimil Babka wrote:
>> On 1/4/19 1:49 PM, Mel Gorman wrote:
>> > Due to either a fast search of the free list or a linear scan, it is
>> > possible for multiple compaction instances to pick the same pageblock
>> > for migration.  This is lucky for one scanner and increased scanning for
>> > all the others. It also allows a race between requests on which first
>> > allocates the resulting free block.
>> > 
>> > This patch tests and updates the pageblock skip for the migration scanner
>> > carefully. When isolating a block, it will check and skip if the block is
>> > already in use. Once the zone lock is acquired, it will be rechecked so
>> > that only one scanner can set the pageblock skip for exclusive use. Any
>> > scanner contending will continue with a linear scan. The skip bit is
>> > still set if no pages can be isolated in a range.
>> 
>> Also the skip bit will remain set even if pages *could* be isolated,
> 
> That's the point -- the pageblock is scanned by one compaction instance
> and skipped by others.

OK, I understood wrongly that this is meant just to avoid races.

>> AFAICS there's no clearing after a block was finished with
>> nr_isolated>0. Is it intended?
> 
> Yes, defer to a full reset later when the compaction scanners meet.
> Tracing really indicated we spent a stupid amount of time scanning,
> rescanning and competing for pageblocks within short interval.

Right.

>> > Migration scan rates are reduced by 52%.
>> 
>> Wonder how much of that is due to not clearing as pointed out above.
>> Also interesting how free scanned was reduced so disproportionally.
>> 
> 
> The amount of free scanning is related to the amount of migration
> scanning. If migration sources are scanning, rescanning and competing
> for the same pageblocks, it can result in unnecessary free scanning too.
> It doesn't fully explain the drop but I didn't specifically try to quantify
> it either as the free scanner is altered further in later patches.

Perhaps lots of skipping in migration scanners mean that they progress faster
into the parts of zone that would otherwise be scanned by the free scanner, so
the free scanner has less work to do. But agree that it's moot to investigate
too much if there are further changes later.


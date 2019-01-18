Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BF42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfARI5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:57:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:37542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfARI5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:57:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBA63AC96;
        Fri, 18 Jan 2019 08:57:39 +0000 (UTC)
Subject: Re: [PATCH 15/25] mm, compaction: Finish pageblock scanning on
 contention
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-16-mgorman@techsingularity.net>
 <ab29ee0b-6b01-c57e-7d7d-de540f06ce07@suse.cz>
 <20190117171122.GK27437@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aa34f8da-a592-48b2-9e86-32a9433d55ce@suse.cz>
Date:   Fri, 18 Jan 2019 09:57:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117171122.GK27437@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 6:11 PM, Mel Gorman wrote:
> On Thu, Jan 17, 2019 at 05:38:36PM +0100, Vlastimil Babka wrote:
>> > rate but also by the fact that the scanners do not meet for longer when
>> > pageblocks are actually used. Overall this is justified and completing
>> > a pageblock scan is very important for later patches.
>> > 
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Some comments below.
>> 
> 
> Thanks
> 
>> > @@ -538,18 +535,8 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>> >  		 * recheck as well.
>> >  		 */
>> >  		if (!locked) {
>> > -			/*
>> > -			 * The zone lock must be held to isolate freepages.
>> > -			 * Unfortunately this is a very coarse lock and can be
>> > -			 * heavily contended if there are parallel allocations
>> > -			 * or parallel compactions. For async compaction do not
>> > -			 * spin on the lock and we acquire the lock as late as
>> > -			 * possible.
>> > -			 */
>> > -			locked = compact_trylock_irqsave(&cc->zone->lock,
>> > +			locked = compact_lock_irqsave(&cc->zone->lock,
>> >  								&flags, cc);
>> > -			if (!locked)
>> > -				break;
>> 
>> Seems a bit dangerous to continue compact_lock_irqsave() to return bool that
>> however now always returns true, and remove the safety checks that test the
>> result. Easy for somebody in the future to reintroduce some 'return false'
>> condition (even though the name now says lock and not trylock) and start
>> crashing. I would either change it to return void, or leave the checks in place.
>> 
> 
> I considered changing it from bool at the same time as "Rework
> compact_should_abort as compact_check_resched". It turned out to be a
> bit clumsy because the locked state must be explicitly updated in the
> caller then. e.g.
> 
> locked = compact_lock_irqsave(...)
> 
> becomes
> 
> compact_lock_irqsave(...)
> locked = true
> 
> I didn't think the result looked that great to be honest but maybe it's
> worth revisiting as a cleanup patch like "Rework compact_should_abort as
> compact_check_resched" on top.
> 
>> > 
>> > @@ -1411,12 +1395,8 @@ static void isolate_freepages(struct compact_control *cc)
>> >  		isolate_freepages_block(cc, &isolate_start_pfn, block_end_pfn,
>> >  					freelist, false);
>> >  
>> > -		/*
>> > -		 * If we isolated enough freepages, or aborted due to lock
>> > -		 * contention, terminate.
>> > -		 */
>> > -		if ((cc->nr_freepages >= cc->nr_migratepages)
>> > -							|| cc->contended) {
>> 
>> Does it really make sense to continue in the case of free scanner, when we know
>> we will just return back the extra pages in the end? release_freepages() will
>> update the cached pfns, but the pageblock skip bit will stay, so we just leave
>> those pages behind. Unless finishing the block is important for the later
>> patches (as changelog mentions) even in the case of free scanner, but then we
>> can just skip the rest of it, as truly scanning it can't really help anything?
>> 
> 
> Finishing is important for later patches is one factor but not the only
> factor. While we eventually return all pages, we do not know at this
> point in time how many free pages are needed. Remember the migration
> source isolates COMPACT_CLUSTER_MAX pages and then looks for migration
> targets.  If the source isolates 32 pages, free might isolate more from
> one pageblock but that's ok as the migration source may need more free
> pages in the immediate future. It's less wasteful than it looks at first
> glance (or second or even third glance).
> 
> However, if we isolated exactly enough targets, and the pageblock gets
> marked skipped, then each COMPACT_CLUSTER_MAX isolation from the target
> could potentially marge one new pageblock unnecessarily and increase
> scanning+resets overall. That would be bad.
> 
> There still can be waste because we do not know in advance exactly how
> many migration sources there will be -- sure, we could calculate it but
> that involves scanning the source pageblock twice which is wasteful.
> I did try estimating it based on the remaining number of pages in the
> pageblock but the additional complexity did not appear to help.
> 
> Does that make sense?

OK, thanks.


Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B3C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58442566D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58442566D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeFYJKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbeFYJJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:09:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD43EAB43;
        Mon, 25 Jun 2018 09:09:57 +0000 (UTC)
Date:   Mon, 25 Jun 2018 11:09:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180625090957.GF28965@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
 <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622090151.GS10465@dhcp22.suse.cz>
 <20180622090935.GT10465@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806220845190.8072@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622130524.GZ10465@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806221447050.2717@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806221447050.2717@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 14:57:10, Mikulas Patocka wrote:
> 
> 
> On Fri, 22 Jun 2018, Michal Hocko wrote:
> 
> > On Fri 22-06-18 08:52:09, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Fri, 22 Jun 2018, Michal Hocko wrote:
> > > 
> > > > On Fri 22-06-18 11:01:51, Michal Hocko wrote:
> > > > > On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
> > > > [...]
> > > > > > What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> > > > > > request comes from a block device driver or a filesystem), we should not 
> > > > > > sleep.
> > > > > 
> > > > > Why? How are you going to audit all the callers that the behavior makes
> > > > > sense and moreover how are you going to ensure that future usage will
> > > > > still make sense. The more subtle side effects gfp flags have the harder
> > > > > they are to maintain.
> > > > 
> > > > So just as an excercise. Try to explain the above semantic to users. We
> > > > currently have the following.
> > > > 
> > > >  * __GFP_NORETRY: The VM implementation will try only very lightweight
> > > >  *   memory direct reclaim to get some memory under memory pressure (thus
> > > >  *   it can sleep). It will avoid disruptive actions like OOM killer. The
> > > >  *   caller must handle the failure which is quite likely to happen under
> > > >  *   heavy memory pressure. The flag is suitable when failure can easily be
> > > >  *   handled at small cost, such as reduced throughput
> > > > 
> > > >  * __GFP_FS can call down to the low-level FS. Clearing the flag avoids the
> > > >  *   allocator recursing into the filesystem which might already be holding
> > > >  *   locks.
> > > > 
> > > > So how are you going to explain gfp & (__GFP_NORETRY | ~__GFP_FS)? What
> > > > is the actual semantic without explaining the whole reclaim or force
> > > > users to look into the code to understand that? What about GFP_NOIO |
> > > > __GFP_NORETRY? What does it mean to that "should not sleep". Do all
> > > > shrinkers have to follow that as well?
> > > 
> > > My reasoning was that there is broken code that uses __GFP_NORETRY and 
> > > assumes that it can't fail - so conditioning the change on !__GFP_FS would 
> > > minimize the diruption to the broken code.
> > > 
> > > Anyway - if you want to test only on __GFP_NORETRY (and fix those 16 
> > > broken cases that assume that __GFP_NORETRY can't fail), I'm OK with that.
> > 
> > As I've already said, this is a subtle change which is really hard to
> > reason about. Throttling on congestion has its meaning and reason. Look
> > at why we are doing that in the first place. You cannot simply say this
> 
> So - explain why is throttling needed. You support throttling, I don't, so 
> you have to explain it :)
> 
> > is ok based on your specific usecase. We do have means to achieve that.
> > It is explicit and thus it will be applied only where it makes sense.
> > You keep repeating that implicit behavior change for everybody is
> > better.
> 
> I don't want to change it for everybody. I want to change it for block 
> device drivers. I don't care what you do with non-block drivers.

Well, it is usually onus of the patch submitter to justify any change.
But let me be nice on you, for once. This throttling is triggered only
if we all the pages we have encountered during the reclaim attempt are
dirty and that means that we are rushing through the LRU list quicker
than flushers are able to clean. If we didn't throttle we could hit
stronger reclaim priorities (aka scan more to reclaim memory) and
reclaim more pages as a result.

> > I guess we will not agree on that part. I consider it a hack
> > rather than a systematic solution. I can easily imagine that we just
> > find out other call sites that would cause over reclaim or similar
> 
> If a __GFP_NORETRY allocation does overreclaim - it could be fixed by 
> returning NULL instead of doing overreclaim. The specification says that 
> callers must handle failure of __GFP_NORETRY allocations.
> 
> So yes - if you think that just skipping throttling on __GFP_NORETRY could 
> cause excessive CPU consumption trying to reclaim unreclaimable pages or 
> something like that - then you can add more points where the __GFP_NORETRY 
> is failed with NULL to avoid the excessive CPU consumption.

Which is exactly something I do not want to do. Spread __GFP_NORETRY all
over the reclaim code. Especially for something we already have means
for...
-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D64C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986021719
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986021719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeFYNxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:53:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755513AbeFYNxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 659144023132;
        Mon, 25 Jun 2018 13:53:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 433572166B5D;
        Mon, 25 Jun 2018 13:53:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5PDrZ5T013285;
        Mon, 25 Jun 2018 09:53:35 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5PDrYVS013281;
        Mon, 25 Jun 2018 09:53:34 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 25 Jun 2018 09:53:34 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180625090957.GF28965@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806250941380.11092@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com> <20180615130925.GI24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com> <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com> <20180622090151.GS10465@dhcp22.suse.cz> <20180622090935.GT10465@dhcp22.suse.cz> <alpine.LRH.2.02.1806220845190.8072@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622130524.GZ10465@dhcp22.suse.cz> <alpine.LRH.2.02.1806221447050.2717@file01.intranet.prod.int.rdu2.redhat.com> <20180625090957.GF28965@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 25 Jun 2018 13:53:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 25 Jun 2018 13:53:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

y

On Mon, 25 Jun 2018, Michal Hocko wrote:

> On Fri 22-06-18 14:57:10, Mikulas Patocka wrote:
> > 
> > 
> > On Fri, 22 Jun 2018, Michal Hocko wrote:
> > 
> > > On Fri 22-06-18 08:52:09, Mikulas Patocka wrote:
> > > > 
> > > > 
> > > > On Fri, 22 Jun 2018, Michal Hocko wrote:
> > > > 
> > > > > On Fri 22-06-18 11:01:51, Michal Hocko wrote:
> > > > > > On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
> > > > > [...]
> > > > > > > What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> > > > > > > request comes from a block device driver or a filesystem), we should not 
> > > > > > > sleep.
> > > > > > 
> > > > > > Why? How are you going to audit all the callers that the behavior makes
> > > > > > sense and moreover how are you going to ensure that future usage will
> > > > > > still make sense. The more subtle side effects gfp flags have the harder
> > > > > > they are to maintain.
> > > > > 
> > > > > So just as an excercise. Try to explain the above semantic to users. We
> > > > > currently have the following.
> > > > > 
> > > > >  * __GFP_NORETRY: The VM implementation will try only very lightweight
> > > > >  *   memory direct reclaim to get some memory under memory pressure (thus
> > > > >  *   it can sleep). It will avoid disruptive actions like OOM killer. The
> > > > >  *   caller must handle the failure which is quite likely to happen under
> > > > >  *   heavy memory pressure. The flag is suitable when failure can easily be
> > > > >  *   handled at small cost, such as reduced throughput
> > > > > 
> > > > >  * __GFP_FS can call down to the low-level FS. Clearing the flag avoids the
> > > > >  *   allocator recursing into the filesystem which might already be holding
> > > > >  *   locks.
> > > > > 
> > > > > So how are you going to explain gfp & (__GFP_NORETRY | ~__GFP_FS)? What
> > > > > is the actual semantic without explaining the whole reclaim or force
> > > > > users to look into the code to understand that? What about GFP_NOIO |
> > > > > __GFP_NORETRY? What does it mean to that "should not sleep". Do all
> > > > > shrinkers have to follow that as well?
> > > > 
> > > > My reasoning was that there is broken code that uses __GFP_NORETRY and 
> > > > assumes that it can't fail - so conditioning the change on !__GFP_FS would 
> > > > minimize the diruption to the broken code.
> > > > 
> > > > Anyway - if you want to test only on __GFP_NORETRY (and fix those 16 
> > > > broken cases that assume that __GFP_NORETRY can't fail), I'm OK with that.
> > > 
> > > As I've already said, this is a subtle change which is really hard to
> > > reason about. Throttling on congestion has its meaning and reason. Look
> > > at why we are doing that in the first place. You cannot simply say this
> > 
> > So - explain why is throttling needed. You support throttling, I don't, so 
> > you have to explain it :)
> > 
> > > is ok based on your specific usecase. We do have means to achieve that.
> > > It is explicit and thus it will be applied only where it makes sense.
> > > You keep repeating that implicit behavior change for everybody is
> > > better.
> > 
> > I don't want to change it for everybody. I want to change it for block 
> > device drivers. I don't care what you do with non-block drivers.
> 
> Well, it is usually onus of the patch submitter to justify any change.
> But let me be nice on you, for once. This throttling is triggered only
> if we all the pages we have encountered during the reclaim attempt are
> dirty and that means that we are rushing through the LRU list quicker
> than flushers are able to clean. If we didn't throttle we could hit
> stronger reclaim priorities (aka scan more to reclaim memory) and
> reclaim more pages as a result.

And the throttling in dm-bufio prevents kswapd from making forward 
progress, causing this situation...

> > I'm sure you'll come up with another creative excuse why GFP_NORETRY
> > allocations need incur deliberate 100ms delays in block device drivers.
>
> ... is not really productive. I've tried to explain why I am not _sure_ what
> possible side effects such a change might have and your hand waving
> didn't really convince me. MD is not the only user of the page
> allocator...

But you are just doing that now - you're just coming up with another great 
excuse why block device drivers need to sleep 100ms. The system stops to a 
crawl when block device requests take 100ms and you - instead of fixing it 
- are just arguing how is it needed.

> > > I guess we will not agree on that part. I consider it a hack
> > > rather than a systematic solution. I can easily imagine that we just
> > > find out other call sites that would cause over reclaim or similar
> > 
> > If a __GFP_NORETRY allocation does overreclaim - it could be fixed by 
> > returning NULL instead of doing overreclaim. The specification says that 
> > callers must handle failure of __GFP_NORETRY allocations.
> > 
> > So yes - if you think that just skipping throttling on __GFP_NORETRY could 
> > cause excessive CPU consumption trying to reclaim unreclaimable pages or 
> > something like that - then you can add more points where the __GFP_NORETRY 
> > is failed with NULL to avoid the excessive CPU consumption.
> 
> Which is exactly something I do not want to do. Spread __GFP_NORETRY all
> over the reclaim code. Especially for something we already have means
> for...

And so what do you want to do to prevent block drivers from sleeping?

Mikulas

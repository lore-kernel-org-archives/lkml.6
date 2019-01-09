Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE12C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150982183F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547028541;
	bh=JlUNL51OouCeDmPe3kPpWErOkSo3wlZchZn8tguNtxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=jtc0Hxc5lUbMmqedTUnGYgER5NWkAhJ8NaU7e4EvpADqXTgWt3JV7tvvZhpwsmCeL
	 XvUjqJmmpLv907CVA14KGNLox6XfglAp053huPCHxsKDLcGgeK7XanVOXYqUhHDGJx
	 xP1JG7mVmbqWtfg5BDOxGB1E5WhtX9D0/5mOu8xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfAIKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:09:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:42840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbfAIKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:09:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A306CAEEB;
        Wed,  9 Jan 2019 10:08:58 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:08:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <20190109043906.GF27534@dastard>
Message-ID: <nycvar.YFH.7.76.1901091050560.16954@cbobk.fhfr.pm>
References: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com> <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com> <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com> <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com> <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Dave Chinner wrote:

> FWIW, I just realised that the easiest, most reliable way to invalidate 
> the page cache over a file range is simply to do a O_DIRECT read on it. 

Neat, good catch indeed. Still, it's only the invalidation part, but the 
residency check is the crucial one.

> > Rationale has been provided by Daniel Gruss in this thread -- if the 
> > attacker is left with cache timing as the only available vector, he's 
> > going to be much more successful with mounting hardware cache timing 
> > attack anyway.
> 
> No, he said:
> 
> "Restricting mincore() is sufficient to fix the hardware-agnostic
> part."
> 
> That's not correct - preadv2(RWF_NOWAIT) is also hardware agnostic and 
> provides exactly the same information about the page cache as mincore.  

Yeah, preadv2(RWF_NOWAIT) is in the same teritory as mincore(), it has 
"just" been overlooked. I can't speak for Daniel, but I believe he might 
be ok with rephrasing the above as "Restricting mincore() and RWF_NOWAIT 
is sufficient ...".

> Timed read/mmap access loops for cache observation are also hardware 
> agnostic, and on fast SSD based storage will only be marginally slower 
> bandwidth than preadv2(RWF_NOWAIT).
> 
> Attackers will pick whatever leak vector we don't fix, so we either fix 
> them all (which I think is probably impossible without removing caching 
> altogether) 

We can't really fix the fact that it's possible to do the timing on the HW 
caches though.

> or we start thinking about how we need to isolate the page cache so that 
> information isn't shared across important security boundaries (e.g. page 
> cache contents are per-mount namespace).

Umm, sorry for being dense, but how would that help that particular attack 
scenario on a system that doesn't really employ any namespacing? (which I 
still believe is a majority of the systems out there, but I might have 
just missed the containers train long time ago :) ).

-- 
Jiri Kosina
SUSE Labs


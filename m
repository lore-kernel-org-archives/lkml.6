Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB01C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19FB2146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547001098;
	bh=q89M79KYgdBqtPKoe9QVpJ5dyRGJ/Nq0i/fyawQh0p4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=n86FYw92PPJTgdCyVp4kUUqeJQetmCarOpWJv8/FG6icgPZqmPJ414XWo/0scsZGB
	 raI51iV9pFFOdJ371O/crm7wOF5GfjnVmNrg84KBz0CX8XKM5BNgsyL1PDJj7jioPK
	 ZaNNLgXaLMIIx3Bbj7+6F3mnCRUBLjPNxzsTG76g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfAICbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:35052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728253AbfAICbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:31:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C8A2AEAD;
        Wed,  9 Jan 2019 02:31:36 +0000 (UTC)
Date:   Wed, 9 Jan 2019 03:31:35 +0100 (CET)
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
In-Reply-To: <20190109022430.GE27534@dastard>
Message-ID: <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
References: <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com> <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com> <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com> <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com> <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com> <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com> <20190109022430.GE27534@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Dave Chinner wrote:

> > But mincore is certainly the easiest interface, and the one that
> > doesn't require much effort or setup.
> 
> Off the top of my head, here's a few vectors for reading the page
> cache residency state without perturbing the page cache residency
> pattern:
> 	- mincore
> 	- preadv2(RWF_NOWAIT)
> 	- fadvise(POSIX_FADV_RANDOM); timed read(2) syscalls
> 	- madvise(MADV_RANDOM); timed read of first byte in each page

While I obviously agree that all those are creating pagecache sidechannel 
in principle, I think we really should mostly focus on the first two (with 
mincore() already having been covered).

Rationale has been provided by Daniel Gruss in this thread -- if the 
attacker is left with cache timing as the only available vector, he's 
going to be much more successful with mounting hardware cache timing 
attack anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs


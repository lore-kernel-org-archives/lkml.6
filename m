Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEGGu2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:50:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41807 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEGGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:50:25 -0400
X-Google-Smtp-Source: AB8JxZr/e6vwd9eWPiZ0xZhwrltXEZaLskGy9iAtxDin5BNgvNZriTWeYyyW7IpjY574PgMT5UebGg==
Date: Mon, 7 May 2018 08:50:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
Message-ID: <20180507065021.s63ndzpjq4pg4a74@gmail.com>
References: <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
 <20180505112817.ihrb726i37bwm4cj@tardis>
 <20180505132751.gwzu2vbzibr2risd@gmail.com>
 <20180505140340.uzfhoc42xvas4m72@tardis>
 <20180506121129.baacc4fxgr72rzex@gmail.com>
 <1525655045.499830.1362901928.0EBFEACA@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525655045.499830.1362901928.0EBFEACA@webmail.messagingengine.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Boqun Feng <boqun.feng@gmail.com> wrote:

> 
> 
> On Sun, May 6, 2018, at 8:11 PM, Ingo Molnar wrote:
> > 
> > * Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > > > The only change I made beyond a trivial build fix is that I also added the release 
> > > > atomics variants explicitly:
> > > > 
> > > > +#define atomic_cmpxchg_release(v, o, n) \
> > > > +	cmpxchg_release(&((v)->counter), (o), (n))
> > > > +#define atomic64_cmpxchg_release(v, o, n) \
> > > > +	cmpxchg_release(&((v)->counter), (o), (n))
> > > > 
> > > > It has passed a PowerPC cross-build test here, but no runtime tests.
> > > > 
> > > 
> > > Do you have the commit at any branch in tip tree? I could pull it and
> > > cross-build and check the assembly code of lib/atomic64_test.c, that way
> > > I could verify whether we mess something up.
> > > 
> > > > Does this patch look good to you?
> > > > 
> > > 
> > > Yep!
> > 
> > Great - I have pushed the commits out into the locking tree, they can be 
> > found in:
> > 
> >   git fetch git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 
> > locking/core
> > 
> 
> Thanks! My compile test told me that we need to remove the definitions of 
> atomic_xchg and atomic64_xchg in ppc's asm/atomic.h: they are now
> duplicate, and will prevent the generation of _release and _acquire in the
> new logic.
> 
> If you need a updated patch for this from me, I could send later today.
> (I don't have a  handy environment for patch sending now, so...)

That would be cool, thanks! My own cross-build testing didn't trigger that build 
failure.

> Other than this, the modification looks fine, the lib/atomic64_test.c
> generated the same asm before and after the patches.

Cool, thanks for checking!

Thanks,

	Ingo

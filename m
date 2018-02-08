Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBHQDx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:03:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHQDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:03:37 -0500
Date: Thu, 8 Feb 2018 16:03:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180208160341.GD17775@arm.com>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net>
 <20180208153030.GB17775@arm.com>
 <20180208154643.GB25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208154643.GB25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:46:43PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 08, 2018 at 03:30:31PM +0000, Will Deacon wrote:
> > On Thu, Feb 08, 2018 at 03:00:05PM +0100, Peter Zijlstra wrote:
> 
> > > Without this ordering I think it would be possible to loose has_blocked
> > > and not observe the CPU either.
> > 
> > I had a quick look at this, and I think you're right. This looks very much
> > like an 'R'-shaped test, which means it's smp_mb() all round otherwise Power
> > will go wrong. That also means the smp_mb__after_atomic() in
> > nohz_balance_enter_idle *cannot* be an smp_wmb(), so you might want a
> > comment stating that explicitly.
> 
> Thanks Will. BTW, where does that 'R' shape nomenclature come from?
> This is the first I've heard of it.

I don't know where it originates from, but the imfamous "test6.pdf" has it:

https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf

half way down the first page on the left. It says "needs sync+sync" which
is about as bad as it gets for Power (compare with "2+2w", which gets away
with lwsync+lwsync). See also:

http://materials.dagstuhl.de/files/16/16471/16471.DerekWilliams.Slides.pdf

for a light-hearted, yet technically accurate story about the latter.

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeENLFk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:05:40 -0400
Received: from foss.arm.com ([217.140.101.70]:40098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbeENLFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:05:37 -0400
Date: Mon, 14 May 2018 12:05:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180514110532.kihs5ilrs67kvq7e@lakrids.cambridge.arm.com>
References: <20180510130632.34497-1-mark.rutland@arm.com>
 <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
 <20180511162229.GK12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511162229.GK12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 06:22:29PM +0200, Peter Zijlstra wrote:
> On Fri, May 11, 2018 at 11:59:32AM +0100, Mark Rutland wrote:
> > READ_ONCE() and WRITE_ONCE() "helpfully" make a silent fallback to a
> > memcpy in this case, so we're broken today, regardless of this change.
> > 
> > I suspect that in practice we get single-copy-atomicity for the 32-bit
> > halves, and sessions likely produce less than 4GiB of ringbuffer data,
> > so failures would be rare.
> 
> This should not be a problem because of the 32bit adress space limit,
> which would necessarily limit us to the low word.

For the wrapped values, yes.

I thought that the head and tail values were meant to be free-running,
but I can't see where I got that idea from now that I've gone digging
again.

> Also note that in perf_output_put_handle(), where we write ->data_head,
> the store is from an 'unsigned long'. So on 32bit that will result in a
> zero high word. Similarly, in __perf_output_begin() we read ->data_tail
> into an unsigned long, which will discard the high word.

Ah, that's a fair point. So it's just compat userspace that this is
potentially borked for. ;)

> So userspace should always read (head) a zero high word, irrespective of
> a split store (2x32bit), and the kernel will disregard the high word on
> reading (tail), irrespective of what userspace put there.
> 
> This is all a bit subtle, and could probably use a comment, but it ought
> to work..

It would be nice to guarantee that we don't lose 32-bit atomicity by
virtue of {READ,WRITE}_ONCE() falling back to memcpy in this case, so
maybe we should wrap this in some helpers.

I'll see if I can come up with something which isn't hideous, or I might
just pretend I never stumbled across this. :)

Thanks,
Mark.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeEKQWi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:22:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60438 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeEKQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:22:35 -0400
Date: Fri, 11 May 2018 18:22:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180511162229.GK12217@hirez.programming.kicks-ass.net>
References: <20180510130632.34497-1-mark.rutland@arm.com>
 <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:59:32AM +0100, Mark Rutland wrote:
> READ_ONCE() and WRITE_ONCE() "helpfully" make a silent fallback to a
> memcpy in this case, so we're broken today, regardless of this change.
> 
> I suspect that in practice we get single-copy-atomicity for the 32-bit
> halves, and sessions likely produce less than 4GiB of ringbuffer data,
> so failures would be rare.

This should not be a problem because of the 32bit adress space limit,
which would necessarily limit us to the low word.

Also note that in perf_output_put_handle(), where we write ->data_head,
the store is from an 'unsigned long'. So on 32bit that will result in a
zero high word. Similarly, in __perf_output_begin() we read ->data_tail
into an unsigned long, which will discard the high word.

So userspace should always read (head) a zero high word, irrespective of
a split store (2x32bit), and the kernel will disregard the high word on
reading (tail), irrespective of what userspace put there.

This is all a bit subtle, and could probably use a comment, but it ought
to work..

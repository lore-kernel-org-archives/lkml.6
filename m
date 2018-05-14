Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeENPYd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:24:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932486AbeENPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:24:32 -0400
Date: Mon, 14 May 2018 17:24:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180514152428.GS12217@hirez.programming.kicks-ass.net>
References: <20180510130632.34497-1-mark.rutland@arm.com>
 <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
 <20180511162229.GK12217@hirez.programming.kicks-ass.net>
 <20180514110532.kihs5ilrs67kvq7e@lakrids.cambridge.arm.com>
 <20180514112815.GP12217@hirez.programming.kicks-ass.net>
 <20180514150213.GK12235@hirez.programming.kicks-ass.net>
 <20180514152022.z3hnkkj3rbcabtyy@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514152022.z3hnkkj3rbcabtyy@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:20:23PM +0100, Mark Rutland wrote:

> > @@ -10499,6 +10523,9 @@ SYSCALL_DEFINE5(perf_event_open,
> >  		goto err_cred;
> >  	}
> >  
> > +	if (in_compat_syscall())
> > +		event->event_caps |= PERF_EV_CAP_COMPAT;
> > +
> 
> After a native perf_event_open, you could pass the fd (or exec) to
> another task that was compat (or vice-versa), so this wouldn't work in
> that case (crazy as it may be).
> 
> I don't have a better suggestion at present, though.

As discussed on IRC, we could trigger off of the buffer size; if the
buffer is <4G the &= UINT_MAX is harmless, if the buffer is larger, you
have to be using a 64bit thingy anyway.

Flipping the overflow functions around on attach/detach to buffers is a
little more dodgy, but could be done I suppose.

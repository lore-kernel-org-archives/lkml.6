Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936117AbeEYN6v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934496AbeEYN6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:58:50 -0400
Date: Fri, 25 May 2018 15:58:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 01/12] perf/breakpoint: Split attribute parse and commit
Message-ID: <20180525135846.GC22082@lerouge>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org>
 <1526697950-7091-2-git-send-email-frederic@kernel.org>
 <87h8mxstou.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8mxstou.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:56:01AM +1000, Michael Ellerman wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 6e28d28..51320c2 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -424,19 +443,22 @@ static int validate_hw_breakpoint(struct perf_event *bp)
> >  
> >  int register_perf_hw_breakpoint(struct perf_event *bp)
> >  {
> > -	int ret;
> > +	struct arch_hw_breakpoint hw;
> > +	int err;
> >  
> > -	ret = reserve_bp_slot(bp);
> > -	if (ret)
> > -		return ret;
> > +	err = reserve_bp_slot(bp);
> > +	if (err)
> > +		return err;
> >  
> > -	ret = validate_hw_breakpoint(bp);
> > -
> > -	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
> > -	if (ret)
> > +	err = hw_breakpoint_parse(bp, &bp->attr, &hw);
> 
> Is there a good reason we pass bp and bp->attr? (I assume so)
> 
> That added to the confusion in the existing code I think.

Yes, on breakpoint creation (which is the above function) it's not needed
but breakpoint modification wants it as we need to pass the attr that are
to be validated, and those are not yet copied to the breakpoint at this
stage. This happens in the end of the series.

Thanks.

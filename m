Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbeEATUD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:20:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeEATUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:20:02 -0400
Date: Tue, 1 May 2018 21:19:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
References: <20171116161506.19691-1-npiggin@gmail.com>
 <20180501144620.1e832a09@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501144620.1e832a09@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 02:46:20PM -0400, Steven Rostedt wrote:
> On Fri, 17 Nov 2017 02:15:06 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > In local_irq_save and local_irq_restore, only call irq tracing when
> > the flag state acutally changes. It is not unexpected for the state
> > to go disable->disable.
> > 
> > This allows the irq tracing code to better track superfluous
> > enables and disables, and in future could issue warnings. For the
> > most part they are harmless, but they can indicate that the caller
> > has lost track of its irq state.
> 
> I missed this before (that was a busy time, I missed a lot of emails
> then :-/ ). 
> 
> Anyway, this makes sense.
> 
> Peter?

I'm confused. The patch calls the trace hooks less often, so how can it
then better track superfluous calls?

> > @@ -110,7 +110,8 @@ do {						\
> >  #define local_irq_save(flags)				\
> >  	do {						\
> >  		raw_local_irq_save(flags);		\
> > -		trace_hardirqs_off();			\
> > +		if (!raw_irqs_disabled_flags(flags))	\
> > +			trace_hardirqs_off();		\
> >  	} while (0)

Here we only call the trace hook when we actually did an ON->OFF change
and loose the call on OFF->OFF.

> > @@ -118,9 +119,11 @@ do {						\
> >  	do {						\
> >  		if (raw_irqs_disabled_flags(flags)) {	\
> >  			raw_local_irq_restore(flags);	\
> > -			trace_hardirqs_off();		\
> > +			if (!irqs_disabled())		\
> > +				trace_hardirqs_off();	\

Only call on ON->OFF, ignore OFF->OFF.

> >  		} else {				\
> > -			trace_hardirqs_on();		\
> > +			if (irqs_disabled())		\
> > +				trace_hardirqs_on();	\
> >  			raw_local_irq_restore(flags);	\
> >  		}					\
> >  	} while (0)

Only call on OFF->ON, ignore ON->ON.


Now, lockdep only minimally tracks these otherwise redundant operations;
see redundant_hardirqs_{on,off} counters, and loosing that doesn't seen
like a big issue.

But I'm confused how this helps track superfluous things, it looks like
it explicitly tracks _less_ superfluous transitions.

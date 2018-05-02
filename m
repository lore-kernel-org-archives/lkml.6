Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeEBAMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:12:31 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:47096 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEBAM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:12:28 -0400
X-Google-Smtp-Source: AB8JxZqlff30b32PIS2v4lQ05QDjCNLmZAu6VLONDVyPN6CjrNGFDfwUh83twOwBfVzajxRK6iKDOA==
Date: Wed, 2 May 2018 10:12:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180502101214.746650bc@roar.ozlabs.ibm.com>
In-Reply-To: <CAEi0qNkbjrdx8A4rfNCJd-1BGMUXZRbbLJEkZuVab+oprWhcDQ@mail.gmail.com>
References: <20171116161506.19691-1-npiggin@gmail.com>
        <20180501144620.1e832a09@gandalf.local.home>
        <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
        <20180501153840.7281022a@gandalf.local.home>
        <20180501194838.GK12217@hirez.programming.kicks-ass.net>
        <20180501160059.6df6aae4@gandalf.local.home>
        <CAEi0qNkbjrdx8A4rfNCJd-1BGMUXZRbbLJEkZuVab+oprWhcDQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 14:15:14 -0700
Joel Fernandes <joel.opensrc@gmail.com> wrote:

> On Tue, May 1, 2018 at 1:00 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 1 May 2018 21:48:38 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >  
> >> On Tue, May 01, 2018 at 03:38:40PM -0400, Steven Rostedt wrote:  
> >> > On Tue, 1 May 2018 21:19:51 +0200
> >> > Peter Zijlstra <peterz@infradead.org> wrote:  
> >>  
> >> > > Now, lockdep only minimally tracks these otherwise redundant operations;
> >> > > see redundant_hardirqs_{on,off} counters, and loosing that doesn't seen
> >> > > like a big issue.
> >> > >
> >> > > But I'm confused how this helps track superfluous things, it looks like
> >> > > it explicitly tracks _less_ superfluous transitions.  
> >> >
> >> > I think it is about triggering on OFF->OFF a warning, as that would
> >> > only happen if we have:
> >> >
> >> >     local_irq_save(flags);
> >> >     [..]
> >> >     local_irq_disable();
> >> >  
> >>
> >> Ahh, ok. Yes, that is easier to do with these changes. The alternative
> >> is to add more information to the tracehooks such that we can do the
> >> same internally, but whatever.
> >>
> >> Yeah, I'm fine with the proposed change, but maybe improve the Changelog
> >> a little for slow people like me :-)  
> >
> > Great!
> >
> > Nicholas,
> >
> > I know this is an old patch (from last November), but want to send it
> > again with a proper change log and signed off by?  
> 
> I actually wrote the exact same patch yesterday with changes Matsami
> suggested. However I decided not to send it, since it didn't have any
> performance improvement (which was the reason I wrote it).
> 
> Also with my recent set, I don't think it will help detect repeated
> calls to trace_hardirqs_off because we are handling that recursive
> case by using per-cpu variable and bailing out if there is a
> recursion, before even calling into lockdep.
> 
> I have mixed feelings about this patch, I am Ok with this patch but I
> suggest its sent with the follow-up patch that shows its use of this.
> And also appreciate if such a follow-up patch is rebased onto the IRQ
> tracepoint work: https://patchwork.kernel.org/patch/10373129/
> 
> What do you think?

I'll try to dig it up and resend. Thanks for the feedback on it.

Thanks,
Nick

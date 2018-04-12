Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeDLPWf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:22:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:9246 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753998AbeDLPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:22:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="42820533"
Message-ID: <1523546543.9119.5.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH 3/4] tracing: Add action comparisons when testing
 matching hist triggers
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date: Thu, 12 Apr 2018 10:22:23 -0500
In-Reply-To: <20180407211638.ca984867724d459031be3aa7@kernel.org>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
         <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
         <20180403001025.6dfed9403d50d20104e54458@kernel.org>
         <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
         <1522855023.32118.14.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180405125016.6460a0ab372061ecf49f471a@kernel.org>
         <1522971253.32118.47.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180406105309.b50ea1a21d2cbd9b0e39dbfd@kernel.org>
         <1523033249.32118.85.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180407211638.ca984867724d459031be3aa7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Sorry for the delay in replying - was off for a few days..

On Sat, 2018-04-07 at 21:16 +0900, Masami Hiramatsu wrote:
> On Fri, 06 Apr 2018 11:47:29 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > > > > Can you print out the error with which event we should see? e.g.
> > > > > 
> > > > >   ERROR: Variable already defined at sched_wakeup: ts0
> > > > > 
> > > > 
> > > > How about printing the event name along with the last command, for any
> > > > error? :
> > > > 
> > > >   ERROR: Variable already defined: ts0
> > > >     Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> > > 
> > > Hmm, is the Last command shows the last command on sched_wakeup ? or sched_switch??
> > > 
> > 
> > Just the last command that executed with an error - it's a global set by
> > the last command that failed, kind of like errno.
> > 
> > In this case, the last error was for the command listed, on the
> > sched_wakeup event.  Even if you see it by reading a different hist
> > file, the last error is still the same - we don't keep a last error for
> > each event.
> 
> OK, in that case, it may not be useful for my case.
> I need to know why the error happens and where should I see to solve it.
> 
> > 
> > > [...]
> > > > Before:
> > > > 
> > > >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > > 
> > > >   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > > > 
> > > > And other commands making us think we cleared everything out so the
> > > > below error is a surprise
> > > > 
> > > >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > >   -su: echo: write error: Invalid argument
> > > 
> > > No, my senario is different.
> > > 
> > > Your senario tries
> > > 1) define ts0 on sched_wakeup
> > > 2) remove ts0 from sched_switch (but silently failed)
> > > 3) re-define ts0 on sched_wakeup and get an error
> > > 
> > > In this case, user can dump sched_wakeup/trigger and see there is already ts0 defined.
> > > 
> > > My senario is a bit different
> > > 1) define ts0 on sched_wakeup
> > > 2) remove ts0 from sched_switch (but silently failed)
> > > 3) re-define ts0 on *sched_switch* and get an error
> > > 
> > > The 3rd operation failed on "sched_switch" not on "sched_wakeup". In this case we will totally lost where the ts0 defined.
> > > That's why I have asked you to show "where the ts0 is defined" at error line.
> > > 
> > 
> > Your scenario should work, which is why I assumed my scenario.  Anyway,
> > this I think corresponds to your scenario, which works for me:
> > 
> >   # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
> >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> >   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> >   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> Hmm, is it possible to redefine ts0 on different event??
> In that case, will ts0 be updated on both sched_switch and sched_wakeup?
> 

It's not really redefining ts0 - those are separate variables on two
different events that happen to have the same name (thus the need to
disambiguate when referencing them in later expressions).  And yes, they
are updated separately whenever the corresponding event occurs.

> > 
> > I also tried this, which works too:
> > 
> >   # echo '!wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
> >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> >   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> >   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> >   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> >   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > 
> > When I looked at the details of what you did in your script, it
> > corresponded to my scenario - the error you saw was because you didn't
> > remove the sched_wakeup trigger though you apparently thought you did,
> > and then tried to do it again (according to your script, the command
> > that failed was to sched_wakeup, and then you looked at sched_switch and
> > saw the error).
> 
> Ah, I got it! I mixed it up, sorry.
> 
> BTW, if I defied ts0 at sched_wakeup
> 
> ====
> [root@devbox ~]# echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
> [root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> ====
> 
> and do it again,
> 
> ====
> [root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> -bash: echo: write error: Invalid argument
> [root@devbox ~]# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist  
> # event histogram
> #
> # trigger info: hist:keys=pid:vals=hitcount:ts0=common_timestamp:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
> #
> 
> 
> Totals:
>     Hits: 0
>     Entries: 0
>     Dropped: 0
> 
> ERROR: Variable already defined: ts0
>   Last command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> ====
> 
> OK, I got this error message.
> However, if I write same command on sched_switch,
> 
> ====
> [root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> -bash: echo: write error: Invalid argument
> ====
> 
> This gets error because there is no "pid" argument in the event, but
> 
> ====
> [root@devbox ~]# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist# event histogram
> #
> # trigger info: hist:keys=pid:vals=hitcount:ts0=common_timestamp:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
> #
> 
> 
> Totals:
>     Hits: 0
>     Entries: 0
>     Dropped: 0
> [root@devbox ~]#
> ====
> 
> I can't see the corresponding error message...

Right, that's because I forgot to generate an error message for that.
The patchset I just posted adds an error message for that - thanks for
pointing it out.

Tom

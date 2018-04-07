Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeDGMQq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 08:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeDGMQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 08:16:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AD5217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 7 Apr 2018 21:16:38 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: Add action comparisons when testing
 matching hist triggers
Message-Id: <20180407211638.ca984867724d459031be3aa7@kernel.org>
In-Reply-To: <1523033249.32118.85.camel@tzanussi-mobl.amr.corp.intel.com>
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
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Apr 2018 11:47:29 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> > > > Can you print out the error with which event we should see? e.g.
> > > > 
> > > >   ERROR: Variable already defined at sched_wakeup: ts0
> > > > 
> > > 
> > > How about printing the event name along with the last command, for any
> > > error? :
> > > 
> > >   ERROR: Variable already defined: ts0
> > >     Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> > 
> > Hmm, is the Last command shows the last command on sched_wakeup ? or sched_switch??
> > 
> 
> Just the last command that executed with an error - it's a global set by
> the last command that failed, kind of like errno.
> 
> In this case, the last error was for the command listed, on the
> sched_wakeup event.  Even if you see it by reading a different hist
> file, the last error is still the same - we don't keep a last error for
> each event.

OK, in that case, it may not be useful for my case.
I need to know why the error happens and where should I see to solve it.

> 
> > [...]
> > > Before:
> > > 
> > >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > 
> > >   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > > 
> > > And other commands making us think we cleared everything out so the
> > > below error is a surprise
> > > 
> > >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > >   -su: echo: write error: Invalid argument
> > 
> > No, my senario is different.
> > 
> > Your senario tries
> > 1) define ts0 on sched_wakeup
> > 2) remove ts0 from sched_switch (but silently failed)
> > 3) re-define ts0 on sched_wakeup and get an error
> > 
> > In this case, user can dump sched_wakeup/trigger and see there is already ts0 defined.
> > 
> > My senario is a bit different
> > 1) define ts0 on sched_wakeup
> > 2) remove ts0 from sched_switch (but silently failed)
> > 3) re-define ts0 on *sched_switch* and get an error
> > 
> > The 3rd operation failed on "sched_switch" not on "sched_wakeup". In this case we will totally lost where the ts0 defined.
> > That's why I have asked you to show "where the ts0 is defined" at error line.
> > 
> 
> Your scenario should work, which is why I assumed my scenario.  Anyway,
> this I think corresponds to your scenario, which works for me:
> 
>   # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

Hmm, is it possible to redefine ts0 on different event??
In that case, will ts0 be updated on both sched_switch and sched_wakeup?

> 
> I also tried this, which works too:
> 
>   # echo '!wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> When I looked at the details of what you did in your script, it
> corresponded to my scenario - the error you saw was because you didn't
> remove the sched_wakeup trigger though you apparently thought you did,
> and then tried to do it again (according to your script, the command
> that failed was to sched_wakeup, and then you looked at sched_switch and
> saw the error).

Ah, I got it! I mixed it up, sorry.

BTW, if I defied ts0 at sched_wakeup

====
[root@devbox ~]# echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
[root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
====

and do it again,

====
[root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
-bash: echo: write error: Invalid argument
[root@devbox ~]# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist  
# event histogram
#
# trigger info: hist:keys=pid:vals=hitcount:ts0=common_timestamp:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
#


Totals:
    Hits: 0
    Entries: 0
    Dropped: 0

ERROR: Variable already defined: ts0
  Last command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
====

OK, I got this error message.
However, if I write same command on sched_switch,

====
[root@devbox ~]# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
-bash: echo: write error: Invalid argument
====

This gets error because there is no "pid" argument in the event, but

====
[root@devbox ~]# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist# event histogram
#
# trigger info: hist:keys=pid:vals=hitcount:ts0=common_timestamp:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
#


Totals:
    Hits: 0
    Entries: 0
    Dropped: 0
[root@devbox ~]#
====

I can't see the corresponding error message...

> 
> Anyway, here's the corresponding version that works if you add the
> trigger to sched_switch instead of twice to sched_wakeup:
> 
> Try adding to sched_wakeup, fails:
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>     -su: echo: 
>     write error: Invalid argument
> 
> Look at sched_switch instead of sched_wakeup, shows error was on sched_wakeup:
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
>     ERROR: Variable already defined: ts0
>     Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> 
> Look at sched_wakeup, sched_wakeup trigger exists and has the ts0 defined:
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>     hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
> 
> Let's add a trigger with ts0 to sched_switch:
> 
>   # echo 'hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> No error seen, and now we can see that both sched_switch and sched_wakeup have triggers with ts0:
> 
>   # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>     hist:keys=next_pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
>   # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>     hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
>  
> Now at this point, we have two triggers with the same variable name, ts0
> - if we try to use an unqualified ts0 in another trigger, we get an
> error:
> 
>   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>     -su: echo: write error: Invalid argument
>   # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
>   # event histogram
>   #
>   # trigger info: 
>     hist:keys=next_pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global if comm=="cyclictest" [active]
>   #
> 
> 
>   Totals:
>        Hits: 0
>        Entries: 0
>        Dropped: 0
> 
>   ERROR: Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ts0
>    Last command: [sched:sched_switch] keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"

Ah, I see. So ts0 is abbreviated name :) we have 2 different variables.


> So in order to set the trigger, we need to explicitly specify which ts0 to use:
> 
> # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-sched.sched_wakeup.$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> So we use the explicit sched.sched_wakeup.$ts0 to specify that we want
> to use the ts0 on sched_wakeup for the calculation.

got it.

> Note that the most common use case is to put the
> wakeup_lat=common_timestamp.usecs-$ts0 expression on a trigger with an
> onmatch() action, and onmatch() specifies the matching event, so there's
> no need to explicitly use the fully qualified sched.sched_wakeup.$ts0 in
> that case.  The above doesn't have onmatch(), and therefore has no way
> to disambiguate the name without specifying which event explicitly.

Cool :)

> > Anyway, I think it is a good chance to introduce <tracefs>/error_log file, since we have too many non-critical errors on operations. I feel that checking hist file by errors on trigger file is not a bit intuitive.
> > 
> > # cat /sys/kernel/debug/tracing/error_log
> > ERROR(events/sched/sched_switch/trigger): Variable already defined: ts0@sched:sched_wakeup
> >   Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> > 
> > This can be used from probe events too :) 
> > e.g.
> > 
> > ERROR(kprobe_events): Unsupported type: uint8
> >   Command: p vfs_read arg1=%di:uint8
> > 
> > Any thought?
> > 
> 
> I agree - I think that would make more sense than using the hist files
> for that purpose.  I'll work on adding this and getting rid of the hist
> file error mechanism.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>

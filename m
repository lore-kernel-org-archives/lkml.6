Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDEDuX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 23:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeDEDuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 23:50:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5194C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 5 Apr 2018 12:50:16 +0900
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
Message-Id: <20180405125016.6460a0ab372061ecf49f471a@kernel.org>
In-Reply-To: <1522855023.32118.14.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
        <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
        <20180403001025.6dfed9403d50d20104e54458@kernel.org>
        <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
        <1522855023.32118.14.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2018 10:17:03 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Wed, 2018-04-04 at 21:33 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Mon, 02 Apr 2018 12:09:33 -0500
> > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > 
> > > after:
> > > 
> > >   # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
> > >   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > >   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > >   # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > >   # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > >   # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > 
> > I ensured this sequence has no problem.
> > After above sequence, the trigger file shows
> > 
> > ======
> > # cat events/sched/sched_switch/trigger
> > hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global if next_comm=="cyclictest" [active]
> > hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest" [active]
> > hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest" [active]
> > hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048 if next_comm=="cyclictest" [active]
> > ======
> > 
> > So I clear the last one
> > 
> > ======
> > # echo '!hist:keys=next_pid if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
> > #
> > ======
> > 
> > OK, it should be removed. I can not see it anymore on the trigger file.
> > 
> > ======
> > # cat events/sched/sched_switch/trigger
> > hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global if next_comm=="cyclictest" [active]
> > hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest" [active]
> > hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest" [active]
> > ======
> > 
> > But when I missed to remove it again, it is accepted (is not an error?)
> > 
> > ======
> > # echo '!hist:keys=next_pid if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
> > #
> > ======
> 
> This is consistent with existing behavior, not only for the hist
> triggers but ftrace in general I think e.g.
> 
> # echo 'traceoff:1 if nr_rq > 1' >> /sys/kernel/debug/tracing/events/block/block_unplug/trigger
> # echo '!traceoff:1 if nr_rq > 1' >> /sys/kernel/debug/tracing/events/block/block_unplug/trigger
> # echo '!traceoff:1 if nr_rq > 1' >> /sys/kernel/debug/tracing/events/block/block_unplug/trigger
> 
> # echo 'try_to_wake_up:enable_event:sched:sched_switch:2' >> set_ftrace_filter
> # echo '!try_to_wake_up:enable_event:sched:sched_switch:2' >> set_ftrace_filter
> # echo '!try_to_wake_up:enable_event:sched:sched_switch:2' >> set_ftrace_filter
> 
> Neither produces an error trying to remove an already-removed trigger.
> Or are you thinking about something else?

Hmm, OK, it is ftrace's behavior.

> > Hmm... anyway, let's clear others too.
> > 
> > ======
> > # echo '!hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
> > # echo '!hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
> > # cat events/sched/sched_switch/trigger
> > # Available triggers:
> > # traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
> > ======
> > 
> > OK, it is cleared now.
> > 
> > Now I test it again.
> > 
> > ======
> > # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> events/sched/sched_wakeup/trigger
> > sh: write error: Invalid argument
> > ======
> > 
> > Oops, what's the error?
> > 
> > ======
> > # cat events/sched/sched_switch/hist
> > 
> > ERROR: Variable already defined: ts0
> >   Last command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
> > ======
> > 
> 
> Hmm, but ts0 is defined on sched_wakeup - you removed the triggers on
> sched_switch, but I didn't see where you removed the sched_wakeup
> trigger defining ts0... 

Ah, I confused that the sched_switch and sched_wakeup...

Can you print out the error with which event we should see? e.g.

  ERROR: Variable already defined at sched_wakeup: ts0

And this shows the good reason why we should reject removing
unexist trigger (with -ENOENT). If I find I can not remove
'hist:keys=pid:ts0=...' from sched_switch, it helps me to
notice my mistake.

> > Hmm, how can I undef ts0 and test it again?
> 
> You should be able to remove the sched_wakeup trigger defining ts0 and
> after doing that test again.  At least I was able to:
> 
> # echo '!hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> 
> events/sched/sched_wakeup/trigger
> 
> # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"'
> >> events/sched/sched_wakeup/trigger

OK, anyway this works good to me too.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

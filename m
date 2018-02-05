Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeBENyN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:54:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45652 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeBENyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:54:04 -0500
X-Google-Smtp-Source: AH8x226p9LxMQ3cU7wO1y7T1iAVHfspWYcsfUyAyCMOcDj7ArOkilmxSGuHGTTlSPyqx85p1behjbA==
Date: Mon, 5 Feb 2018 14:53:55 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Namhyung Kim <namhyung@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180205135355.GX19535@localhost.localdomain>
References: <20180202230458.840252014@goodmis.org>
 <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home>
 <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
 <20180203161732.4a65c66b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203161732.4a65c66b@gandalf.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 03/02/18 16:17, Steven Rostedt wrote:
> On Sat, 3 Feb 2018 12:52:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > It's a user space job.
> 
> BTW, I asked around at DevConf.cz, and nobody I talked with (besides
> Arnaldo), have used eBPF. The "path to hello world" is quite high. This
> interface is extremely simple to use, and one doesn't need to install
> LLVM or other tools to interface with it.

Yep. Managed to get this working in less than an hour. :)

With something like

# echo 'replenish_dl_entity(u64 dl_runtime[3] | u64 dl_deadline[4] | u64 dl_period[5] | s64 runtime[8] | u64 deadline[9])' > function_events
# echo 'sched:*' > set_event
# echo replenish_dl_entity >> set_event

you can get something like

--->8---
     [...]
     cpuhog-3556  [002] d..3   727.101815: sched_switch: prev_comm=cpuhog prev_pid=3556 prev_prio=-1 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120                                                                                                         
     <idle>-0     [002] d.s4   727.128139: sched_waking: comm=kworker/2:1 pid=53 prio=120 target_cpu=002                           
     <idle>-0     [002] dNs5   727.128150: sched_wakeup: comm=kworker/2:1 pid=53 prio=120 target_cpu=002                           
     <idle>-0     [002] d..3   727.128184: sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=kworker/2:1 next_pid=53 next_prio=120                                                                                                     
kworker/2:1-53    [002] d..3   727.128280: sched_stat_runtime: comm=kworker/2:1 pid=53 runtime=123827 [ns] vruntime=12389788162 [ns]                                                                                                                                       
kworker/2:1-53    [002] d..3   727.128288: sched_switch: prev_comm=kworker/2:1 prev_pid=53 prev_prio=120 prev_state=R+ ==> next_comm=swapper/2 next_pid=0 next_prio=120                                                                                                    
     <idle>-0     [002] d.h5   727.191609: enqueue_task_dl->replenish_dl_entity(dl_runtime=10000000, dl_deadline=100000000, dl_period=100000000, runtime=-218339, deadline=726823680456)                                                                                   
     <idle>-0     [002] d..3   727.191676: sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cpuhog next_pid=3556 next_prio=-1
     [...]
--->8---

Which is quite nice already IMHO.

> I used the analogy, that eBPF is like C, and this is like Bash. One is
> much easier to get "Hello World!" out than the other.
> 
> So personally, this is something I know I would use (note, I have
> never used eBPF either). But if I'm the only one to use this
> interface then I'll stop here (and not bother with the function graph
> return interface). If others think this would be helpful, I would ask
> them to speak up now.

First impression is that this is going to be definitely useful if

 - it's possibile to hook at function end (e.g., replenish_dl_entity above
   carries more useful information _after_ it did its job)
 - inside functions? not really sure it's actually going to be needed, but I
   was wondering if it's possible at all :); with tracepoints it's for example
   easy to collect detailed information about which branches has been taken etc.

I'm going to play with this more. Just wanted to give back a quick positive
feedback.

I'm also adding Arm folks to the discussion, as they (and I :) have been
asking to add tracepoints to scheduler code in the past [1].

Best,

- Juri

[1] https://marc.info/?l=linux-kernel&m=149068303518607

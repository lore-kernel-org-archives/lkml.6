Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDDMdo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeDDMdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:33:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB5121834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 4 Apr 2018 21:33:38 +0900
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
Message-Id: <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
In-Reply-To: <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
        <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
        <20180403001025.6dfed9403d50d20104e54458@kernel.org>
        <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 02 Apr 2018 12:09:33 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> after:
> 
>   # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
>   # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

I ensured this sequence has no problem.
After above sequence, the trigger file shows

======
# cat events/sched/sched_switch/trigger
hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global if next_comm=="cyclictest" [active]
hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest" [active]
hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest" [active]
hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048 if next_comm=="cyclictest" [active]
======

So I clear the last one

======
# echo '!hist:keys=next_pid if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
#
======

OK, it should be removed. I can not see it anymore on the trigger file.

======
# cat events/sched/sched_switch/trigger
hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global if next_comm=="cyclictest" [active]
hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest" [active]
hist:keys=next_pid:vals=hitcount:sort=hitcount:size=2048:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest" [active]
======

But when I missed to remove it again, it is accepted (is not an error?)

======
# echo '!hist:keys=next_pid if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
#
======

Hmm... anyway, let's clear others too.

======
# echo '!hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
# echo '!hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> events/sched/sched_switch/trigger
# cat events/sched/sched_switch/trigger
# Available triggers:
# traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
======

OK, it is cleared now.

Now I test it again.

======
# echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> events/sched/sched_wakeup/trigger
sh: write error: Invalid argument
======

Oops, what's the error?

======
# cat events/sched/sched_switch/hist

ERROR: Variable already defined: ts0
  Last command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
======

Hmm, how can I undef ts0 and test it again?
If I can not clean it, the testcase must fail on the 2nd time.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDBRJm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:09:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:57661 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeDBRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:09:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="40124085"
Message-ID: <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
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
Date: Mon, 02 Apr 2018 12:09:33 -0500
In-Reply-To: <20180403001025.6dfed9403d50d20104e54458@kernel.org>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
         <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
         <20180403001025.6dfed9403d50d20104e54458@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, 2018-04-03 at 00:10 +0900, Masami Hiramatsu wrote:
> On Wed, 28 Mar 2018 15:10:55 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Actions also need to be considered when checking for matching triggers
> > - triggers differing only by action should be allowed, but currently
> > aren't because the matching check ignores the action and erroneously
> > returns -EEXIST.
> 
> Hi Tom,
> 
> Could you show us the bad/good examples (maybe different onmatch() actions)?
> And if it is real bugfix, I would like to add a ftracetest testcase for this fix.
> 

Here's an example using onmatch() actions.  The first -EEXIST shouldn't
occur because the onmatch() is different in the second wakeup_latency()
param.  The second -EEXIST shouldn't occur because it's a different
action (in this case, it doesn't have an action, so shouldn't be seen
as being the same and therefore rejected).

In the after case, both are correctly accepted (and trying to add one of
them again returns -EEXIST as it should).

before:

  # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
-su: echo: write error: File exists
  # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
-su: echo: write error: File exists

after:

  # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

Thanks,

Tom

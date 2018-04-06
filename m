Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDFBxP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeDFBxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:53:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE6C217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 6 Apr 2018 10:53:09 +0900
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
Message-Id: <20180406105309.b50ea1a21d2cbd9b0e39dbfd@kernel.org>
In-Reply-To: <1522971253.32118.47.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
        <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
        <20180403001025.6dfed9403d50d20104e54458@kernel.org>
        <1522688973.3254.8.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180404213338.5bcd14994d8e0142b5bfefc6@kernel.org>
        <1522855023.32118.14.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180405125016.6460a0ab372061ecf49f471a@kernel.org>
        <1522971253.32118.47.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, 05 Apr 2018 18:34:13 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Thu, 2018-04-05 at 12:50 +0900, Masami Hiramatsu wrote:
> 
> [...]
> 
> > Can you print out the error with which event we should see? e.g.
> > 
> >   ERROR: Variable already defined at sched_wakeup: ts0
> > 
> 
> How about printing the event name along with the last command, for any
> error? :
> 
>   ERROR: Variable already defined: ts0
>     Last command: [sched:sched_wakeup] keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

Hmm, is the Last command shows the last command on sched_wakeup ? or sched_switch??

[...]
> Before:
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> 
>   # echo '!hist:keys=next_pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> And other commands making us think we cleared everything out so the
> below error is a surprise
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: Invalid argument

No, my senario is different.

Your senario tries
1) define ts0 on sched_wakeup
2) remove ts0 from sched_switch (but silently failed)
3) re-define ts0 on sched_wakeup and get an error

In this case, user can dump sched_wakeup/trigger and see there is already ts0 defined.

My senario is a bit different
1) define ts0 on sched_wakeup
2) remove ts0 from sched_switch (but silently failed)
3) re-define ts0 on *sched_switch* and get an error

The 3rd operation failed on "sched_switch" not on "sched_wakeup". In this case we will totally lost where the ts0 defined.
That's why I have asked you to show "where the ts0 is defined" at error line.

Anyway, I think it is a good chance to introduce <tracefs>/error_log file, since we have too many non-critical errors on operations. I feel that checking hist file by errors on trigger file is not a bit intuitive.

# cat /sys/kernel/debug/tracing/error_log
ERROR(events/sched/sched_switch/trigger): Variable already defined: ts0@sched:sched_wakeup
  Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"

This can be used from probe events too :) 
e.g.

ERROR(kprobe_events): Unsupported type: uint8
  Command: p vfs_read arg1=%di:uint8

Any thought?

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>

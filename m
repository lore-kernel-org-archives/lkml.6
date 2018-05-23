Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeEWONj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeEWONf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:13:35 -0400
Date: Wed, 23 May 2018 23:13:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-Id: <20180523231331.bf69453f05478e11b00451ab@kernel.org>
In-Reply-To: <20180516150201.246539183@goodmis.org>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 11:00:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a couple of tests that test the trace_marker histogram triggers.
> One does a straight histogram test, the other will create a synthetic event
> and test the latency between two different writes (using filters to
> differentiate between them).
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, would you plan to add simplar test case for the marker?
(like just write a marker and read trace log, and run a simple
 trigger, like taking a snapshot by marker)

Thanks,

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../trigger/trigger-trace-marker-hist.tc      | 49 ++++++++++++++
>  .../trigger/trigger-trace-marker-synthetic.tc | 66 +++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> new file mode 100644
> index 000000000000..2acbfe2c0c0c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: trace_marker trigger - test histogram trigger
> +# flags: instance
> +
> +do_reset() {
> +    reset_trigger
> +    echo > set_event
> +    clear_trace
> +}
> +
> +fail() { #msg
> +    do_reset
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -d events/ftrace/print ]; then
> +    echo "event trace_marker is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/ftrace/print/trigger ]; then
> +    echo "event trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/ftrace/print/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +do_reset
> +
> +echo "Test histogram trace_marker tigger"
> +
> +echo 'hist:keys=common_pid' > events/ftrace/print/trigger
> +for i in `seq 1 10` ; do echo "hello" > trace_marker; done
> +grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
> +    fail "hist trigger did not trigger correct times on trace_marker"
> +
> +do_reset
> +
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> new file mode 100644
> index 000000000000..3666dd6ab02a
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> @@ -0,0 +1,66 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: trace_marker trigger - test histogram with synthetic event
> +# flags:
> +
> +do_reset() {
> +    reset_trigger
> +    echo > set_event
> +    echo > synthetic_events
> +    clear_trace
> +}
> +
> +fail() { #msg
> +    do_reset
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f synthetic_events ]; then
> +    echo "synthetic events not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -d events/ftrace/print ]; then
> +    echo "event trace_marker is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/ftrace/print/trigger ]; then
> +    echo "event trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f events/ftrace/print/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +do_reset
> +
> +echo "Test histogram trace_marker to trace_marker latency histogram trigger"
> +
> +echo 'latency u64 lat' > synthetic_events
> +echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
> +echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
> +echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
> +echo -n "start" > trace_marker
> +echo -n "end" > trace_marker
> +
> +cnt=`grep 'hitcount: *1$' events/ftrace/print/hist | wc -l`
> +
> +if [ $cnt -ne 2 ]; then
> +    fail "hist trace_marker trigger did not trigger correctly"
> +fi
> +
> +grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
> +    fail "hist trigger did not trigger "
> +
> +do_reset
> +
> +exit 0
> -- 
> 2.17.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

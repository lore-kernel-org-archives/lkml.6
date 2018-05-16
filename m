Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeEPNHW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeEPNHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:07:21 -0400
Date: Wed, 16 May 2018 22:07:16 +0900
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
Subject: Re: [PATCH v2 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-Id: <20180516220716.60174e9edd8d9f970fcd37e1@kernel.org>
In-Reply-To: <20180514205959.230719465@goodmis.org>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.230719465@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 16:58:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a couple of tests that test the trace_marker histogram triggers.
> One does a straight histogram test, the other will create a synthetic event
> and test the latency between two different writes (using filters to
> differentiate between them).
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../trigger/trigger-trace-marker-synthetic.tc | 66 +++++++++++++++++++
>  .../test.d/trigger/trigger-trace-marker.tc    | 49 ++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
> new file mode 100644
> index 000000000000..8e7a043da7fb
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc

OK, since the synthetic event may need histogram support, so this testname is OK.


> @@ -0,0 +1,66 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test histogram with synthetic event
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

Ah, this is a great example how we can use this combination :D

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
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc
> new file mode 100644
> index 000000000000..48e7ac1ccbc1
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc

But this test actually kicks histogram, maybe trigger-trace-marker-hist.tc will be better, since we may need to add a simpler testcase just for checking whether trace-marker works with some actions (e.g. enable/disable other events).

Thank you,

> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test histogram trigger
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
> -- 
> 2.17.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

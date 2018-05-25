Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967703AbeEYSTs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967511AbeEYSTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:19:47 -0400
Date: Fri, 25 May 2018 14:19:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 14/14] tracing/selftest: Add test to test hist
 trigger between kernel event and trace_marker
Message-ID: <20180525141943.0a05e039@gandalf.local.home>
In-Reply-To: <20180525141506.65150cee@gandalf.local.home>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.411972764@goodmis.org>
        <20180523231559.fdc6c528b49ce9764a0ceda5@kernel.org>
        <20180525141506.65150cee@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 14:15:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> new file mode 100644
> index 000000000000..447df015c56f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: trace_marker trigger - test histogram with synthetic event
> +# flags:
> +

I forgot to update the description. Here's the new patch:

-- Steve

>From 9699fdb67ba8ea9981bd0af1802209b0011a86ab Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Mon, 14 May 2018 15:47:07 -0400
Subject: [PATCH] tracing/selftest: Add test to test hist trigger between
 kernel event and trace_marker

Add a test that tests a trigger that is initiated by a kernel event
(sched_waking) and compared to a write to the trace_marker.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-trace-marker-synthetic-kernel.tc       | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
new file mode 100644
index 000000000000..0a69c5d1cda8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_marker trigger - test histogram with synthetic event against kernel event
+# flags:
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    echo > synthetic_events
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic events not supported"
+    exit_unsupported
+fi
+
+if [ ! -d events/ftrace/print ]; then
+    echo "event trace_marker is not supported"
+    exit_unsupported
+fi
+
+if [ ! -d events/sched/sched_waking ]; then
+    echo "event sched_waking is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f events/ftrace/print/trigger ]; then
+    echo "event trigger is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f events/ftrace/print/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
+do_reset
+
+echo "Test histogram kernel event to trace_marker latency histogram trigger"
+
+echo 'latency u64 lat' > synthetic_events
+echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
+echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
+echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
+sleep 1
+echo "hello" > trace_marker
+
+grep 'hitcount: *1$' events/ftrace/print/hist > /dev/null || \
+    fail "hist trigger did not trigger correct times on trace_marker"
+
+grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
+    fail "hist trigger did not trigger "
+
+do_reset
+
+exit 0
-- 
2.13.6

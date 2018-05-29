Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936767AbeE2PZ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935089AbeE2PXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:35 -0400
Message-Id: <20180529152328.070206185@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 15/19] tracing/selftest: Add selftests to test trace_marker histogram
 triggers
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0015-tracing-selftest-Add-selftests-to-test-trace_marker-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a couple of tests that test the trace_marker histogram triggers.
One does a straight histogram test, the other will create a synthetic event
and test the latency between two different writes (using filters to
differentiate between them).

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/trigger-trace-marker-hist.tc      | 49 ++++++++++++++
 .../trigger/trigger-trace-marker-synthetic.tc | 66 +++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
new file mode 100644
index 000000000000..2acbfe2c0c0c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_marker trigger - test histogram trigger
+# flags: instance
+
+do_reset() {
+    reset_trigger
+    echo > set_event
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
+if [ ! -d events/ftrace/print ]; then
+    echo "event trace_marker is not supported"
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
+echo "Test histogram trace_marker tigger"
+
+echo 'hist:keys=common_pid' > events/ftrace/print/trigger
+for i in `seq 1 10` ; do echo "hello" > trace_marker; done
+grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
+    fail "hist trigger did not trigger correct times on trace_marker"
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
new file mode 100644
index 000000000000..3666dd6ab02a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -0,0 +1,66 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_marker trigger - test histogram with synthetic event
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
+echo "Test histogram trace_marker to trace_marker latency histogram trigger"
+
+echo 'latency u64 lat' > synthetic_events
+echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
+echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
+echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
+echo -n "start" > trace_marker
+echo -n "end" > trace_marker
+
+cnt=`grep 'hitcount: *1$' events/ftrace/print/hist | wc -l`
+
+if [ $cnt -ne 2 ]; then
+    fail "hist trace_marker trigger did not trigger correctly"
+fi
+
+grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
+    fail "hist trigger did not trigger "
+
+do_reset
+
+exit 0
-- 
2.17.0

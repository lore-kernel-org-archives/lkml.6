Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936694AbeE2PZY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935577AbeE2PXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:35 -0400
Message-Id: <20180529152328.213507301@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 16/19] tracing/selftest: Add test to test hist trigger between kernel event
 and trace_marker
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0016-tracing-selftest-Add-test-to-test-hist-trigger-betwe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test that tests a trigger that is initiated by a kernel event
(sched_waking) and compared to a write to the trace_marker.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-trace-marker-synthetic-kernel.tc  | 68 +++++++++++++++++++
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
2.17.0

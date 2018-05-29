Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936551AbeE2PZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935584AbeE2PXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:35 -0400
Message-Id: <20180529152328.491485013@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 17/19] tracing/selftest: Add test to test simple snapshot trigger for
 trace_marker
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0017-tracing-selftest-Add-test-to-test-simple-snapshot-tr.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Several complex trigger tests were added for trace_marker, but not a simple
one. This could be used to help diagnose a problem with the code by giving a
reference between how complex a trigger is that fails.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/trigger-trace-marker-snapshot.tc  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
new file mode 100644
index 000000000000..6748e8cb42d0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_marker trigger - test snapshot trigger
+# flags: instance
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    echo 0 > snapshot
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
+if [ ! -f snapshot ]; then
+    echo "snapshot is not supported"
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
+test_trace() {
+    file=$1
+    x=$2
+
+    cat $file | while read line; do
+	comment=`echo $line | sed -e 's/^#//'`
+	if [ "$line" != "$comment" ]; then
+	    continue
+	fi
+	echo "testing $line for >$x<"
+	match=`echo $line | sed -e "s/>$x<//"`
+	if [ "$line" == "$match" ]; then
+	    fail "$line does not have >$x< in it"
+	fi
+	let x=$x+2
+    done
+}
+
+do_reset
+
+echo "Test snapshot trace_marker tigger"
+
+echo 'snapshot' > events/ftrace/print/trigger
+
+# make sure the snapshot is allocated
+
+grep -q 'Snapshot is allocated' snapshot
+
+for i in `seq 1 10` ; do echo "hello >$i<" > trace_marker; done
+
+test_trace trace 1
+test_trace snapshot 2
+
+do_reset
+
+exit 0
-- 
2.17.0

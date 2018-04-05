Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeDEJ3i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeDEJ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:29:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7828F217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 2/2] selftests: ftrace: Add a testcase for multiple actions on trigger
Date: Thu,  5 Apr 2018 18:29:12 +0900
Message-Id: <152292055227.15769.6327959816123227152.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152292049091.15769.13306554953968999494.stgit@devbox>
References: <152292049091.15769.13306554953968999494.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for multiple actions with different
parameters on an event trigger, which has been fixed
by commit 192c283e93bd ("tracing: Add action comparisons
 when testing matching hist triggers").

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../inter-event/trigger-multi-actions-accept.tc    |   44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
new file mode 100644
index 000000000000..c193dce611a2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -0,0 +1,44 @@
+#!/bin/sh
+# description: event trigger - test multiple actions on hist trigger
+
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
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test multiple actions on hist trigger"
+echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
+TRIGGER1=events/sched/sched_wakeup/trigger
+TRIGGER2=events/sched/sched_switch/trigger
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' > $TRIGGER1
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> $TRIGGER2
+
+do_reset
+
+exit 0

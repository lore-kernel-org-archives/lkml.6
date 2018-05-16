Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEPPCl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbeEPPCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:02:02 -0400
Message-Id: <20180516150201.411972764@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 11:00:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH v3 14/14] tracing/selftest: Add test to test hist trigger between kernel event
 and trace_marker
References: <20180516150012.135869655@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0014-tracing-selftest-Add-test-to-test-hist-trigger-betwe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test that tests a trigger that is initiated by a kernel event
(sched_waking) and compared to a write to the trace_marker.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/trigger-trace-marker-synthetic.tc | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index 3666dd6ab02a..b06996ecd5e0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -31,6 +31,11 @@ if [ ! -d events/ftrace/print ]; then
     exit_unsupported
 fi
 
+if [ ! -d events/sched/sched_waking ]; then
+    echo "event sched_waking is not supported"
+    exit_unsupported
+fi
+
 if [ ! -f events/ftrace/print/trigger ]; then
     echo "event trigger is not supported"
     exit_unsupported
@@ -63,4 +68,21 @@ grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
 
 do_reset
 
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
 exit 0
-- 
2.17.0

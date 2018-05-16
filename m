Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEPPCE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeEPPCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:02:00 -0400
Message-Id: <20180516150012.135869655@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 11:00:12 -0400
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
Subject: [PATCH v3 00/14] tracing: Add triggers to trace_marker writes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few people have asked for this in the past, and I finally got around
to implementing it. What this does is to allow writes into trace_marker
to initiate a trigger.

The trace_marker event is described in:

 tracefs/events/ftrace/print

Thus the trigger file is added there:

 tracefs/events/ftrace/print/trigger

As there's already a "hist" file there, everything appears to work
just like any other trigger to an event. See the last patch for
documentation on how to use the triggers to a trace_marker write.

By the way, the patch:

  tracing: Prevent further users of zero size static arrays in trace events

May prevent your kernel from building if you include Xen. You will need
to add this patch to make it work (or include the git repo below).

 http://lkml.kernel.org/r/20180509144605.5a220327@gandalf.local.home


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: dded7b759602085b4bd2c5581f58f6b179912d89


Steven Rostedt (VMware) (14):
      tracing: Do not reference event data in post call triggers
      tracing: Add __find_event_file() to find event files without restrictions
      tracing: Have event_trace_init() called by trace_init_tracefs()
      tracing: Add brackets in ftrace event dynamic arrays
      tracing: Do not show filter file for ftrace internal events
      tracing: Add trigger file for trace_markers tracefs/ftrace/print
      tracing: Have zero size length in filter logic be full string
      tracing: Prevent further users of zero size static arrays in trace events
      tracing: Allow histogram triggers to access ftrace internal events
      tracing: Document trace_marker triggers
      ftrace/selftest: Have the reset_trigger code be a bit more careful
      ftrace/selftest: Fix reset_trigger() to handle triggers with filters
      tracing/selftest: Add selftests to test trace_marker histogram triggers
      tracing/selftest: Add test to test hist trigger between kernel event and trace_marker

----
Changes since v2:

 - typo fixes in documentation (Tom Zanussi)
 - Rename trigger-trace-marker{-hist} in selftest (Masami Hiramatsu)
 - Fix onmatch(sched.sched_waking) (Namhyung Kim)
 - Rename test to say trace_marker trigger from event trigger (Steven Rostedt)

 Diff from v2 below.

 Documentation/trace/events.rst                     |   6 +-
 Documentation/trace/ftrace.rst                     |   5 +
 Documentation/trace/histogram.txt                  | 546 ++++++++++++++++++++-
 include/linux/trace_events.h                       |   3 +-
 include/trace/trace_events.h                       |   1 +
 kernel/trace/trace.c                               |  19 +
 kernel/trace/trace.h                               |   9 +-
 kernel/trace/trace_entries.h                       |   6 +-
 kernel/trace/trace_events.c                        |  36 +-
 kernel/trace/trace_events_filter.c                 |  23 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/trace_export.c                        |   9 +-
 tools/testing/selftests/ftrace/test.d/functions    |  23 +-
 .../test.d/trigger/trigger-trace-marker-hist.tc    |  49 ++
 .../trigger/trigger-trace-marker-synthetic.tc      |  88 ++++
 16 files changed, 790 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc


diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index 8c871f0c0e33..ae2d4f9d0a62 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -2005,7 +2005,7 @@ and after it wakes up, something like this:
 
 static void traceputs(char *str)
 {
-	/* tracemark_fd is the trace_marker file descripto */
+	/* tracemark_fd is the trace_marker file descriptor */
 	if (tracemark_fd < 0)
 		return;
 	/* write the tracemark message */
@@ -2048,7 +2048,7 @@ Now running cyclictest with:
 
 Note, the -b 1000 is used just to make --tracemark available.
 
-The we can see the histogram created by this with:
+Then we can see the histogram created by this with:
 
  # cat events/synthetic/latency/hist
 # event histogram
@@ -2360,7 +2360,7 @@ kernel with trace_marker.
 
 The difference this time is that instead of using the trace_marker to start
 the latency, the sched_waking event is used, matching the common_pid for the
-trace_marker write with the pid that is being worken by sched_waking.
+trace_marker write with the pid that is being woken by sched_waking.
 
 After running cyclictest again with the same parameters, we now have:
 
@@ -2535,5 +2535,5 @@ Totals:
     Dropped: 0
 
 This doesn't tell us any information about how late cyclictest may have
-worken up, but it does show us a nice histogram of how long it took from
-the time that cyclictest was worken to the time it made it into user space.
+woken up, but it does show us a nice histogram of how long it took from
+the time that cyclictest was woken to the time it made it into user space.
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
similarity index 93%
rename from tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc
rename to tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index 48e7ac1ccbc1..2acbfe2c0c0c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: event trigger - test histogram trigger
+# description: trace_marker trigger - test histogram trigger
 # flags: instance
 
 do_reset() {
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index d8cfc36f228b..b06996ecd5e0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: event trigger - test histogram with synthetic event
+# description: trace_marker trigger - test histogram with synthetic event
 # flags:
 
 do_reset() {
@@ -72,7 +72,7 @@ echo "Test histogram kernel event to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
 echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
-echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat)' > events/ftrace/print/trigger
+echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
 echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
 sleep 1
 echo "hello" > trace_marker

Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12AFE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeFFOZB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeFFOY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:24:58 -0400
Date: Wed, 6 Jun 2018 10:24:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for v4.18
Message-ID: <20180606102455.42722f7f@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

One new feature was added to ftrace, which is the trace_marker now supports
triggers. For example:

  # cd /sys/kernel/debug/tracing
  # echo 'snapshot' > events/ftrace/print/trigger
  # echo 'cause snapshot' > trace_marker

The rest of the changes are various clean ups and also one stable fix that
was added late in the cycle.


Please pull the latest trace-v4.18 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18

Tag SHA1: d4b0a68285a96a2404cd5a8f36a9d228889a2bdf
Head SHA1: 591a033dc17ff6f684b6b6d1d7426e22d178194f


Andi Kleen (1):
      trace: Use -mcount-record for dynamic ftrace

Lee, Chun-Yi (1):
      tracepoints: Fix the descriptions of tracepoint_probe_register{_prio}

Mikulas Patocka (1):
      branch-check: fix long->int truncation when profiling branches

Steven Rostedt (VMware) (16):
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
      tracing/selftest: Add test to test simple snapshot trigger for trace_marker
      ring-buffer: Fix a bunch of typos in comments

Vasyl Gomonovych (1):
      ring-buffer: Fix typo in comment

Yisheng Xie (1):
      tracing: Use match_string() instead of open coding it in trace_set_options()

----
 Documentation/trace/events.rst                     |   6 +-
 Documentation/trace/ftrace.rst                     |   5 +
 Documentation/trace/histogram.txt                  | 545 ++++++++++++++++++++-
 include/linux/compiler.h                           |   2 +-
 include/linux/ring_buffer.h                        |   2 +-
 include/linux/trace_events.h                       |   3 +-
 include/trace/trace_events.h                       |   1 +
 kernel/trace/ring_buffer.c                         |  20 +-
 kernel/trace/trace.c                               |  34 +-
 kernel/trace/trace.h                               |   9 +-
 kernel/trace/trace_entries.h                       |   6 +-
 kernel/trace/trace_events.c                        |  36 +-
 kernel/trace/trace_events_filter.c                 |  23 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/trace_export.c                        |   9 +-
 kernel/tracepoint.c                                |   3 +-
 scripts/Makefile.build                             |   6 +
 tools/testing/selftests/ftrace/test.d/functions    |  23 +-
 .../test.d/trigger/trigger-trace-marker-hist.tc    |  49 ++
 .../trigger/trigger-trace-marker-snapshot.tc       |  74 +++
 .../trigger-trace-marker-synthetic-kernel.tc       |  68 +++
 .../trigger/trigger-trace-marker-synthetic.tc      |  66 +++
 23 files changed, 933 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
---------------------------
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index a5ea2cb0082b..1afae55dc55c 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -338,10 +338,14 @@ used for conditionally invoking triggers.
 
 The syntax for event triggers is roughly based on the syntax for
 set_ftrace_filter 'ftrace filter commands' (see the 'Filter commands'
-section of Documentation/trace/ftrace.txt), but there are major
+section of Documentation/trace/ftrace.rst), but there are major
 differences and the implementation isn't currently tied to it in any
 way, so beware about making generalizations between the two.
 
+Note: Writing into trace_marker (See Documentation/trace/ftrace.rst)
+     can also enable triggers that are written into
+     /sys/kernel/tracing/events/ftrace/print/trigger
+
 6.1 Expression syntax
 ---------------------
 
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 67d9c38e95eb..aad4776c0f5d 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -507,6 +507,11 @@ of ftrace. Here is a list of some of the key files:
 
 		trace_fd = open("trace_marker", WR_ONLY);
 
+	Note: Writing into the trace_marker file can also initiate triggers
+	      that are written into /sys/kernel/tracing/events/ftrace/print/trigger
+	      See "Event triggers" in Documentation/trace/events.rst and an
+              example in Documentation/trace/histogram.rst (Section 3.)
+
   trace_marker_raw:
 
 	This is similar to trace_marker above, but is meant for for binary data
diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index 6e05510afc28..b13771cb12c1 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1604,7 +1604,6 @@
         Entries: 7
         Dropped: 0
 
-
 2.2 Inter-event hist triggers
 -----------------------------
 
@@ -1993,3 +1992,547 @@ hist trigger specification.
           Hits: 12970
           Entries: 2
           Dropped: 0
+
+3. User space creating a trigger
+--------------------------------
+
+Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
+ring buffer. This can also act like an event, by writing into the trigger
+file located in /sys/kernel/tracing/events/ftrace/print/
+
+Modifying cyclictest to write into the trace_marker file before it sleeps
+and after it wakes up, something like this:
+
+static void traceputs(char *str)
+{
+	/* tracemark_fd is the trace_marker file descriptor */
+	if (tracemark_fd < 0)
+		return;
+	/* write the tracemark message */
+	write(tracemark_fd, str, strlen(str));
+}
+
+And later add something like:
+
+	traceputs("start");
+	clock_nanosleep(...);
+	traceputs("end");
+
+We can make a histogram from this:
+
+ # cd /sys/kernel/tracing
+ # echo 'latency u64 lat' > synthetic_events
+ # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
+ # echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
+ # echo 'hist:keys=lat,common_pid:sort=lat' > events/synthetic/latency/trigger
+
+The above created a synthetic event called "latency" and two histograms
+against the trace_marker, one gets triggered when "start" is written into the
+trace_marker file and the other when "end" is written. If the pids match, then
+it will call the "latency" synthetic event with the calculated latency as its
+parameter. Finally, a histogram is added to the latency synthetic event to
+record the calculated latency along with the pid.
+
+Now running cyclictest with:
+
+ # ./cyclictest -p80 -d0 -i250 -n -a -t --tracemark -b 1000
+
+ -p80  : run threads at priority 80
+ -d0   : have all threads run at the same interval
+ -i250 : start the interval at 250 microseconds (all threads will do this)
+ -n    : sleep with nanosleep
+ -a    : affine all threads to a separate CPU
+ -t    : one thread per available CPU
+ --tracemark : enable trace mark writing
+ -b 1000 : stop if any latency is greater than 1000 microseconds
+
+Note, the -b 1000 is used just to make --tracemark available.
+
+Then we can see the histogram created by this with:
+
+ # cat events/synthetic/latency/hist
+# event histogram
+#
+# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
+#
+
+{ lat:        107, common_pid:       2039 } hitcount:          1
+{ lat:        122, common_pid:       2041 } hitcount:          1
+{ lat:        166, common_pid:       2039 } hitcount:          1
+{ lat:        174, common_pid:       2039 } hitcount:          1
+{ lat:        194, common_pid:       2041 } hitcount:          1
+{ lat:        196, common_pid:       2036 } hitcount:          1
+{ lat:        197, common_pid:       2038 } hitcount:          1
+{ lat:        198, common_pid:       2039 } hitcount:          1
+{ lat:        199, common_pid:       2039 } hitcount:          1
+{ lat:        200, common_pid:       2041 } hitcount:          1
+{ lat:        201, common_pid:       2039 } hitcount:          2
+{ lat:        202, common_pid:       2038 } hitcount:          1
+{ lat:        202, common_pid:       2043 } hitcount:          1
+{ lat:        203, common_pid:       2039 } hitcount:          1
+{ lat:        203, common_pid:       2036 } hitcount:          1
+{ lat:        203, common_pid:       2041 } hitcount:          1
+{ lat:        206, common_pid:       2038 } hitcount:          2
+{ lat:        207, common_pid:       2039 } hitcount:          1
+{ lat:        207, common_pid:       2036 } hitcount:          1
+{ lat:        208, common_pid:       2040 } hitcount:          1
+{ lat:        209, common_pid:       2043 } hitcount:          1
+{ lat:        210, common_pid:       2039 } hitcount:          1
+{ lat:        211, common_pid:       2039 } hitcount:          4
+{ lat:        212, common_pid:       2043 } hitcount:          1
+{ lat:        212, common_pid:       2039 } hitcount:          2
+{ lat:        213, common_pid:       2039 } hitcount:          1
+{ lat:        214, common_pid:       2038 } hitcount:          1
+{ lat:        214, common_pid:       2039 } hitcount:          2
+{ lat:        214, common_pid:       2042 } hitcount:          1
+{ lat:        215, common_pid:       2039 } hitcount:          1
+{ lat:        217, common_pid:       2036 } hitcount:          1
+{ lat:        217, common_pid:       2040 } hitcount:          1
+{ lat:        217, common_pid:       2039 } hitcount:          1
+{ lat:        218, common_pid:       2039 } hitcount:          6
+{ lat:        219, common_pid:       2039 } hitcount:          9
+{ lat:        220, common_pid:       2039 } hitcount:         11
+{ lat:        221, common_pid:       2039 } hitcount:          5
+{ lat:        221, common_pid:       2042 } hitcount:          1
+{ lat:        222, common_pid:       2039 } hitcount:          7
+{ lat:        223, common_pid:       2036 } hitcount:          1
+{ lat:        223, common_pid:       2039 } hitcount:          3
+{ lat:        224, common_pid:       2039 } hitcount:          4
+{ lat:        224, common_pid:       2037 } hitcount:          1
+{ lat:        224, common_pid:       2036 } hitcount:          2
+{ lat:        225, common_pid:       2039 } hitcount:          5
+{ lat:        225, common_pid:       2042 } hitcount:          1
+{ lat:        226, common_pid:       2039 } hitcount:          7
+{ lat:        226, common_pid:       2036 } hitcount:          4
+{ lat:        227, common_pid:       2039 } hitcount:          6
+{ lat:        227, common_pid:       2036 } hitcount:         12
+{ lat:        227, common_pid:       2043 } hitcount:          1
+{ lat:        228, common_pid:       2039 } hitcount:          7
+{ lat:        228, common_pid:       2036 } hitcount:         14
+{ lat:        229, common_pid:       2039 } hitcount:          9
+{ lat:        229, common_pid:       2036 } hitcount:          8
+{ lat:        229, common_pid:       2038 } hitcount:          1
+{ lat:        230, common_pid:       2039 } hitcount:         11
+{ lat:        230, common_pid:       2036 } hitcount:          6
+{ lat:        230, common_pid:       2043 } hitcount:          1
+{ lat:        230, common_pid:       2042 } hitcount:          2
+{ lat:        231, common_pid:       2041 } hitcount:          1
+{ lat:        231, common_pid:       2036 } hitcount:          6
+{ lat:        231, common_pid:       2043 } hitcount:          1
+{ lat:        231, common_pid:       2039 } hitcount:          8
+{ lat:        232, common_pid:       2037 } hitcount:          1
+{ lat:        232, common_pid:       2039 } hitcount:          6
+{ lat:        232, common_pid:       2040 } hitcount:          2
+{ lat:        232, common_pid:       2036 } hitcount:          5
+{ lat:        232, common_pid:       2043 } hitcount:          1
+{ lat:        233, common_pid:       2036 } hitcount:          5
+{ lat:        233, common_pid:       2039 } hitcount:         11
+{ lat:        234, common_pid:       2039 } hitcount:          4
+{ lat:        234, common_pid:       2038 } hitcount:          2
+{ lat:        234, common_pid:       2043 } hitcount:          2
+{ lat:        234, common_pid:       2036 } hitcount:         11
+{ lat:        234, common_pid:       2040 } hitcount:          1
+{ lat:        235, common_pid:       2037 } hitcount:          2
+{ lat:        235, common_pid:       2036 } hitcount:          8
+{ lat:        235, common_pid:       2043 } hitcount:          2
+{ lat:        235, common_pid:       2039 } hitcount:          5
+{ lat:        235, common_pid:       2042 } hitcount:          2
+{ lat:        235, common_pid:       2040 } hitcount:          4
+{ lat:        235, common_pid:       2041 } hitcount:          1
+{ lat:        236, common_pid:       2036 } hitcount:          7
+{ lat:        236, common_pid:       2037 } hitcount:          1
+{ lat:        236, common_pid:       2041 } hitcount:          5
+{ lat:        236, common_pid:       2039 } hitcount:          3
+{ lat:        236, common_pid:       2043 } hitcount:          9
+{ lat:        236, common_pid:       2040 } hitcount:          7
+{ lat:        237, common_pid:       2037 } hitcount:          1
+{ lat:        237, common_pid:       2040 } hitcount:          1
+{ lat:        237, common_pid:       2036 } hitcount:          9
+{ lat:        237, common_pid:       2039 } hitcount:          3
+{ lat:        237, common_pid:       2043 } hitcount:          8
+{ lat:        237, common_pid:       2042 } hitcount:          2
+{ lat:        237, common_pid:       2041 } hitcount:          2
+{ lat:        238, common_pid:       2043 } hitcount:         10
+{ lat:        238, common_pid:       2040 } hitcount:          1
+{ lat:        238, common_pid:       2037 } hitcount:          9
+{ lat:        238, common_pid:       2038 } hitcount:          1
+{ lat:        238, common_pid:       2039 } hitcount:          1
+{ lat:        238, common_pid:       2042 } hitcount:          3
+{ lat:        238, common_pid:       2036 } hitcount:          7
+{ lat:        239, common_pid:       2041 } hitcount:          1
+{ lat:        239, common_pid:       2043 } hitcount:         11
+{ lat:        239, common_pid:       2037 } hitcount:         11
+{ lat:        239, common_pid:       2038 } hitcount:          6
+{ lat:        239, common_pid:       2036 } hitcount:          7
+{ lat:        239, common_pid:       2040 } hitcount:          1
+{ lat:        239, common_pid:       2042 } hitcount:          9
+{ lat:        240, common_pid:       2037 } hitcount:         29
+{ lat:        240, common_pid:       2043 } hitcount:         15
+{ lat:        240, common_pid:       2040 } hitcount:         44
+{ lat:        240, common_pid:       2039 } hitcount:          1
+{ lat:        240, common_pid:       2041 } hitcount:          2
+{ lat:        240, common_pid:       2038 } hitcount:          1
+{ lat:        240, common_pid:       2036 } hitcount:         10
+{ lat:        240, common_pid:       2042 } hitcount:         13
+{ lat:        241, common_pid:       2036 } hitcount:         21
+{ lat:        241, common_pid:       2041 } hitcount:         36
+{ lat:        241, common_pid:       2037 } hitcount:         34
+{ lat:        241, common_pid:       2042 } hitcount:         14
+{ lat:        241, common_pid:       2040 } hitcount:         94
+{ lat:        241, common_pid:       2039 } hitcount:         12
+{ lat:        241, common_pid:       2038 } hitcount:          2
+{ lat:        241, common_pid:       2043 } hitcount:         28
+{ lat:        242, common_pid:       2040 } hitcount:        109
+{ lat:        242, common_pid:       2041 } hitcount:        506
+{ lat:        242, common_pid:       2039 } hitcount:        155
+{ lat:        242, common_pid:       2042 } hitcount:         21
+{ lat:        242, common_pid:       2037 } hitcount:         52
+{ lat:        242, common_pid:       2043 } hitcount:         21
+{ lat:        242, common_pid:       2036 } hitcount:         16
+{ lat:        242, common_pid:       2038 } hitcount:        156
+{ lat:        243, common_pid:       2037 } hitcount:         46
+{ lat:        243, common_pid:       2039 } hitcount:         40
+{ lat:        243, common_pid:       2042 } hitcount:        119
+{ lat:        243, common_pid:       2041 } hitcount:        611
+{ lat:        243, common_pid:       2036 } hitcount:         69
+{ lat:        243, common_pid:       2038 } hitcount:        784
+{ lat:        243, common_pid:       2040 } hitcount:        323
+{ lat:        243, common_pid:       2043 } hitcount:         14
+{ lat:        244, common_pid:       2043 } hitcount:         35
+{ lat:        244, common_pid:       2042 } hitcount:        305
+{ lat:        244, common_pid:       2039 } hitcount:          8
+{ lat:        244, common_pid:       2040 } hitcount:       4515
+{ lat:        244, common_pid:       2038 } hitcount:        371
+{ lat:        244, common_pid:       2037 } hitcount:         31
+{ lat:        244, common_pid:       2036 } hitcount:        114
+{ lat:        244, common_pid:       2041 } hitcount:       3396
+{ lat:        245, common_pid:       2036 } hitcount:        700
+{ lat:        245, common_pid:       2041 } hitcount:       2772
+{ lat:        245, common_pid:       2037 } hitcount:        268
+{ lat:        245, common_pid:       2039 } hitcount:        472
+{ lat:        245, common_pid:       2038 } hitcount:       2758
+{ lat:        245, common_pid:       2042 } hitcount:       3833
+{ lat:        245, common_pid:       2040 } hitcount:       3105
+{ lat:        245, common_pid:       2043 } hitcount:        645
+{ lat:        246, common_pid:       2038 } hitcount:       3451
+{ lat:        246, common_pid:       2041 } hitcount:        142
+{ lat:        246, common_pid:       2037 } hitcount:       5101
+{ lat:        246, common_pid:       2040 } hitcount:         68
+{ lat:        246, common_pid:       2043 } hitcount:       5099
+{ lat:        246, common_pid:       2039 } hitcount:       5608
+{ lat:        246, common_pid:       2042 } hitcount:       3723
+{ lat:        246, common_pid:       2036 } hitcount:       4738
+{ lat:        247, common_pid:       2042 } hitcount:        312
+{ lat:        247, common_pid:       2043 } hitcount:       2385
+{ lat:        247, common_pid:       2041 } hitcount:        452
+{ lat:        247, common_pid:       2038 } hitcount:        792
+{ lat:        247, common_pid:       2040 } hitcount:         78
+{ lat:        247, common_pid:       2036 } hitcount:       2375
+{ lat:        247, common_pid:       2039 } hitcount:       1834
+{ lat:        247, common_pid:       2037 } hitcount:       2655
+{ lat:        248, common_pid:       2037 } hitcount:         36
+{ lat:        248, common_pid:       2042 } hitcount:         11
+{ lat:        248, common_pid:       2038 } hitcount:        122
+{ lat:        248, common_pid:       2036 } hitcount:        135
+{ lat:        248, common_pid:       2039 } hitcount:         26
+{ lat:        248, common_pid:       2041 } hitcount:        503
+{ lat:        248, common_pid:       2043 } hitcount:         66
+{ lat:        248, common_pid:       2040 } hitcount:         46
+{ lat:        249, common_pid:       2037 } hitcount:         29
+{ lat:        249, common_pid:       2038 } hitcount:          1
+{ lat:        249, common_pid:       2043 } hitcount:         29
+{ lat:        249, common_pid:       2039 } hitcount:          8
+{ lat:        249, common_pid:       2042 } hitcount:         56
+{ lat:        249, common_pid:       2040 } hitcount:         27
+{ lat:        249, common_pid:       2041 } hitcount:         11
+{ lat:        249, common_pid:       2036 } hitcount:         27
+{ lat:        250, common_pid:       2038 } hitcount:          1
+{ lat:        250, common_pid:       2036 } hitcount:         30
+{ lat:        250, common_pid:       2040 } hitcount:         19
+{ lat:        250, common_pid:       2043 } hitcount:         22
+{ lat:        250, common_pid:       2042 } hitcount:         20
+{ lat:        250, common_pid:       2041 } hitcount:          1
+{ lat:        250, common_pid:       2039 } hitcount:          6
+{ lat:        250, common_pid:       2037 } hitcount:         48
+{ lat:        251, common_pid:       2037 } hitcount:         43
+{ lat:        251, common_pid:       2039 } hitcount:          1
+{ lat:        251, common_pid:       2036 } hitcount:         12
+{ lat:        251, common_pid:       2042 } hitcount:          2
+{ lat:        251, common_pid:       2041 } hitcount:          1
+{ lat:        251, common_pid:       2043 } hitcount:         15
+{ lat:        251, common_pid:       2040 } hitcount:          3
+{ lat:        252, common_pid:       2040 } hitcount:          1
+{ lat:        252, common_pid:       2036 } hitcount:         12
+{ lat:        252, common_pid:       2037 } hitcount:         21
+{ lat:        252, common_pid:       2043 } hitcount:         14
+{ lat:        253, common_pid:       2037 } hitcount:         21
+{ lat:        253, common_pid:       2039 } hitcount:          2
+{ lat:        253, common_pid:       2036 } hitcount:          9
+{ lat:        253, common_pid:       2043 } hitcount:          6
+{ lat:        253, common_pid:       2040 } hitcount:          1
+{ lat:        254, common_pid:       2036 } hitcount:          8
+{ lat:        254, common_pid:       2043 } hitcount:          3
+{ lat:        254, common_pid:       2041 } hitcount:          1
+{ lat:        254, common_pid:       2042 } hitcount:          1
+{ lat:        254, common_pid:       2039 } hitcount:          1
+{ lat:        254, common_pid:       2037 } hitcount:         12
+{ lat:        255, common_pid:       2043 } hitcount:          1
+{ lat:        255, common_pid:       2037 } hitcount:          2
+{ lat:        255, common_pid:       2036 } hitcount:          2
+{ lat:        255, common_pid:       2039 } hitcount:          8
+{ lat:        256, common_pid:       2043 } hitcount:          1
+{ lat:        256, common_pid:       2036 } hitcount:          4
+{ lat:        256, common_pid:       2039 } hitcount:          6
+{ lat:        257, common_pid:       2039 } hitcount:          5
+{ lat:        257, common_pid:       2036 } hitcount:          4
+{ lat:        258, common_pid:       2039 } hitcount:          5
+{ lat:        258, common_pid:       2036 } hitcount:          2
+{ lat:        259, common_pid:       2036 } hitcount:          7
+{ lat:        259, common_pid:       2039 } hitcount:          7
+{ lat:        260, common_pid:       2036 } hitcount:          8
+{ lat:        260, common_pid:       2039 } hitcount:          6
+{ lat:        261, common_pid:       2036 } hitcount:          5
+{ lat:        261, common_pid:       2039 } hitcount:          7
+{ lat:        262, common_pid:       2039 } hitcount:          5
+{ lat:        262, common_pid:       2036 } hitcount:          5
+{ lat:        263, common_pid:       2039 } hitcount:          7
+{ lat:        263, common_pid:       2036 } hitcount:          7
+{ lat:        264, common_pid:       2039 } hitcount:          9
+{ lat:        264, common_pid:       2036 } hitcount:          9
+{ lat:        265, common_pid:       2036 } hitcount:          5
+{ lat:        265, common_pid:       2039 } hitcount:          1
+{ lat:        266, common_pid:       2036 } hitcount:          1
+{ lat:        266, common_pid:       2039 } hitcount:          3
+{ lat:        267, common_pid:       2036 } hitcount:          1
+{ lat:        267, common_pid:       2039 } hitcount:          3
+{ lat:        268, common_pid:       2036 } hitcount:          1
+{ lat:        268, common_pid:       2039 } hitcount:          6
+{ lat:        269, common_pid:       2036 } hitcount:          1
+{ lat:        269, common_pid:       2043 } hitcount:          1
+{ lat:        269, common_pid:       2039 } hitcount:          2
+{ lat:        270, common_pid:       2040 } hitcount:          1
+{ lat:        270, common_pid:       2039 } hitcount:          6
+{ lat:        271, common_pid:       2041 } hitcount:          1
+{ lat:        271, common_pid:       2039 } hitcount:          5
+{ lat:        272, common_pid:       2039 } hitcount:         10
+{ lat:        273, common_pid:       2039 } hitcount:          8
+{ lat:        274, common_pid:       2039 } hitcount:          2
+{ lat:        275, common_pid:       2039 } hitcount:          1
+{ lat:        276, common_pid:       2039 } hitcount:          2
+{ lat:        276, common_pid:       2037 } hitcount:          1
+{ lat:        276, common_pid:       2038 } hitcount:          1
+{ lat:        277, common_pid:       2039 } hitcount:          1
+{ lat:        277, common_pid:       2042 } hitcount:          1
+{ lat:        278, common_pid:       2039 } hitcount:          1
+{ lat:        279, common_pid:       2039 } hitcount:          4
+{ lat:        279, common_pid:       2043 } hitcount:          1
+{ lat:        280, common_pid:       2039 } hitcount:          3
+{ lat:        283, common_pid:       2036 } hitcount:          2
+{ lat:        284, common_pid:       2039 } hitcount:          1
+{ lat:        284, common_pid:       2043 } hitcount:          1
+{ lat:        288, common_pid:       2039 } hitcount:          1
+{ lat:        289, common_pid:       2039 } hitcount:          1
+{ lat:        300, common_pid:       2039 } hitcount:          1
+{ lat:        384, common_pid:       2039 } hitcount:          1
+
+Totals:
+    Hits: 67625
+    Entries: 278
+    Dropped: 0
+
+Note, the writes are around the sleep, so ideally they will all be of 250
+microseconds. If you are wondering how there are several that are under
+250 microseconds, that is because the way cyclictest works, is if one
+iteration comes in late, the next one will set the timer to wake up less that
+250. That is, if an iteration came in 50 microseconds late, the next wake up
+will be at 200 microseconds.
+
+But this could easily be done in userspace. To make this even more
+interesting, we can mix the histogram between events that happened in the
+kernel with trace_marker.
+
+ # cd /sys/kernel/tracing
+ # echo 'latency u64 lat' > synthetic_events
+ # echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
+ # echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat) if buf == "end"' > events/ftrace/print/trigger
+ # echo 'hist:keys=lat,common_pid:sort=lat' > events/synthetic/latency/trigger
+
+The difference this time is that instead of using the trace_marker to start
+the latency, the sched_waking event is used, matching the common_pid for the
+trace_marker write with the pid that is being woken by sched_waking.
+
+After running cyclictest again with the same parameters, we now have:
+
+ # cat events/synthetic/latency/hist
+# event histogram
+#
+# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
+#
+
+{ lat:          7, common_pid:       2302 } hitcount:        640
+{ lat:          7, common_pid:       2299 } hitcount:         42
+{ lat:          7, common_pid:       2303 } hitcount:         18
+{ lat:          7, common_pid:       2305 } hitcount:        166
+{ lat:          7, common_pid:       2306 } hitcount:          1
+{ lat:          7, common_pid:       2301 } hitcount:         91
+{ lat:          7, common_pid:       2300 } hitcount:         17
+{ lat:          8, common_pid:       2303 } hitcount:       8296
+{ lat:          8, common_pid:       2304 } hitcount:       6864
+{ lat:          8, common_pid:       2305 } hitcount:       9464
+{ lat:          8, common_pid:       2301 } hitcount:       9213
+{ lat:          8, common_pid:       2306 } hitcount:       6246
+{ lat:          8, common_pid:       2302 } hitcount:       8797
+{ lat:          8, common_pid:       2299 } hitcount:       8771
+{ lat:          8, common_pid:       2300 } hitcount:       8119
+{ lat:          9, common_pid:       2305 } hitcount:       1519
+{ lat:          9, common_pid:       2299 } hitcount:       2346
+{ lat:          9, common_pid:       2303 } hitcount:       2841
+{ lat:          9, common_pid:       2301 } hitcount:       1846
+{ lat:          9, common_pid:       2304 } hitcount:       3861
+{ lat:          9, common_pid:       2302 } hitcount:       1210
+{ lat:          9, common_pid:       2300 } hitcount:       2762
+{ lat:          9, common_pid:       2306 } hitcount:       4247
+{ lat:         10, common_pid:       2299 } hitcount:         16
+{ lat:         10, common_pid:       2306 } hitcount:        333
+{ lat:         10, common_pid:       2303 } hitcount:         16
+{ lat:         10, common_pid:       2304 } hitcount:        168
+{ lat:         10, common_pid:       2302 } hitcount:        240
+{ lat:         10, common_pid:       2301 } hitcount:         28
+{ lat:         10, common_pid:       2300 } hitcount:         95
+{ lat:         10, common_pid:       2305 } hitcount:         18
+{ lat:         11, common_pid:       2303 } hitcount:          5
+{ lat:         11, common_pid:       2305 } hitcount:          8
+{ lat:         11, common_pid:       2306 } hitcount:        221
+{ lat:         11, common_pid:       2302 } hitcount:         76
+{ lat:         11, common_pid:       2304 } hitcount:         26
+{ lat:         11, common_pid:       2300 } hitcount:        125
+{ lat:         11, common_pid:       2299 } hitcount:          2
+{ lat:         12, common_pid:       2305 } hitcount:          3
+{ lat:         12, common_pid:       2300 } hitcount:          6
+{ lat:         12, common_pid:       2306 } hitcount:         90
+{ lat:         12, common_pid:       2302 } hitcount:          4
+{ lat:         12, common_pid:       2303 } hitcount:          1
+{ lat:         12, common_pid:       2304 } hitcount:        122
+{ lat:         13, common_pid:       2300 } hitcount:         12
+{ lat:         13, common_pid:       2301 } hitcount:          1
+{ lat:         13, common_pid:       2306 } hitcount:         32
+{ lat:         13, common_pid:       2302 } hitcount:          5
+{ lat:         13, common_pid:       2305 } hitcount:          1
+{ lat:         13, common_pid:       2303 } hitcount:          1
+{ lat:         13, common_pid:       2304 } hitcount:         61
+{ lat:         14, common_pid:       2303 } hitcount:          4
+{ lat:         14, common_pid:       2306 } hitcount:          5
+{ lat:         14, common_pid:       2305 } hitcount:          4
+{ lat:         14, common_pid:       2304 } hitcount:         62
+{ lat:         14, common_pid:       2302 } hitcount:         19
+{ lat:         14, common_pid:       2300 } hitcount:         33
+{ lat:         14, common_pid:       2299 } hitcount:          1
+{ lat:         14, common_pid:       2301 } hitcount:          4
+{ lat:         15, common_pid:       2305 } hitcount:          1
+{ lat:         15, common_pid:       2302 } hitcount:         25
+{ lat:         15, common_pid:       2300 } hitcount:         11
+{ lat:         15, common_pid:       2299 } hitcount:          5
+{ lat:         15, common_pid:       2301 } hitcount:          1
+{ lat:         15, common_pid:       2304 } hitcount:          8
+{ lat:         15, common_pid:       2303 } hitcount:          1
+{ lat:         15, common_pid:       2306 } hitcount:          6
+{ lat:         16, common_pid:       2302 } hitcount:         31
+{ lat:         16, common_pid:       2306 } hitcount:          3
+{ lat:         16, common_pid:       2300 } hitcount:          5
+{ lat:         17, common_pid:       2302 } hitcount:          6
+{ lat:         17, common_pid:       2303 } hitcount:          1
+{ lat:         18, common_pid:       2304 } hitcount:          1
+{ lat:         18, common_pid:       2302 } hitcount:          8
+{ lat:         18, common_pid:       2299 } hitcount:          1
+{ lat:         18, common_pid:       2301 } hitcount:          1
+{ lat:         19, common_pid:       2303 } hitcount:          4
+{ lat:         19, common_pid:       2304 } hitcount:          5
+{ lat:         19, common_pid:       2302 } hitcount:          4
+{ lat:         19, common_pid:       2299 } hitcount:          3
+{ lat:         19, common_pid:       2306 } hitcount:          1
+{ lat:         19, common_pid:       2300 } hitcount:          4
+{ lat:         19, common_pid:       2305 } hitcount:          5
+{ lat:         20, common_pid:       2299 } hitcount:          2
+{ lat:         20, common_pid:       2302 } hitcount:          3
+{ lat:         20, common_pid:       2305 } hitcount:          1
+{ lat:         20, common_pid:       2300 } hitcount:          2
+{ lat:         20, common_pid:       2301 } hitcount:          2
+{ lat:         20, common_pid:       2303 } hitcount:          3
+{ lat:         21, common_pid:       2305 } hitcount:          1
+{ lat:         21, common_pid:       2299 } hitcount:          5
+{ lat:         21, common_pid:       2303 } hitcount:          4
+{ lat:         21, common_pid:       2302 } hitcount:          7
+{ lat:         21, common_pid:       2300 } hitcount:          1
+{ lat:         21, common_pid:       2301 } hitcount:          5
+{ lat:         21, common_pid:       2304 } hitcount:          2
+{ lat:         22, common_pid:       2302 } hitcount:          5
+{ lat:         22, common_pid:       2303 } hitcount:          1
+{ lat:         22, common_pid:       2306 } hitcount:          3
+{ lat:         22, common_pid:       2301 } hitcount:          2
+{ lat:         22, common_pid:       2300 } hitcount:          1
+{ lat:         22, common_pid:       2299 } hitcount:          1
+{ lat:         22, common_pid:       2305 } hitcount:          1
+{ lat:         22, common_pid:       2304 } hitcount:          1
+{ lat:         23, common_pid:       2299 } hitcount:          1
+{ lat:         23, common_pid:       2306 } hitcount:          2
+{ lat:         23, common_pid:       2302 } hitcount:          6
+{ lat:         24, common_pid:       2302 } hitcount:          3
+{ lat:         24, common_pid:       2300 } hitcount:          1
+{ lat:         24, common_pid:       2306 } hitcount:          2
+{ lat:         24, common_pid:       2305 } hitcount:          1
+{ lat:         24, common_pid:       2299 } hitcount:          1
+{ lat:         25, common_pid:       2300 } hitcount:          1
+{ lat:         25, common_pid:       2302 } hitcount:          4
+{ lat:         26, common_pid:       2302 } hitcount:          2
+{ lat:         27, common_pid:       2305 } hitcount:          1
+{ lat:         27, common_pid:       2300 } hitcount:          1
+{ lat:         27, common_pid:       2302 } hitcount:          3
+{ lat:         28, common_pid:       2306 } hitcount:          1
+{ lat:         28, common_pid:       2302 } hitcount:          4
+{ lat:         29, common_pid:       2302 } hitcount:          1
+{ lat:         29, common_pid:       2300 } hitcount:          2
+{ lat:         29, common_pid:       2306 } hitcount:          1
+{ lat:         29, common_pid:       2304 } hitcount:          1
+{ lat:         30, common_pid:       2302 } hitcount:          4
+{ lat:         31, common_pid:       2302 } hitcount:          6
+{ lat:         32, common_pid:       2302 } hitcount:          1
+{ lat:         33, common_pid:       2299 } hitcount:          1
+{ lat:         33, common_pid:       2302 } hitcount:          3
+{ lat:         34, common_pid:       2302 } hitcount:          2
+{ lat:         35, common_pid:       2302 } hitcount:          1
+{ lat:         35, common_pid:       2304 } hitcount:          1
+{ lat:         36, common_pid:       2302 } hitcount:          4
+{ lat:         37, common_pid:       2302 } hitcount:          6
+{ lat:         38, common_pid:       2302 } hitcount:          2
+{ lat:         39, common_pid:       2302 } hitcount:          2
+{ lat:         39, common_pid:       2304 } hitcount:          1
+{ lat:         40, common_pid:       2304 } hitcount:          2
+{ lat:         40, common_pid:       2302 } hitcount:          5
+{ lat:         41, common_pid:       2304 } hitcount:          1
+{ lat:         41, common_pid:       2302 } hitcount:          8
+{ lat:         42, common_pid:       2302 } hitcount:          6
+{ lat:         42, common_pid:       2304 } hitcount:          1
+{ lat:         43, common_pid:       2302 } hitcount:          3
+{ lat:         43, common_pid:       2304 } hitcount:          4
+{ lat:         44, common_pid:       2302 } hitcount:          6
+{ lat:         45, common_pid:       2302 } hitcount:          5
+{ lat:         46, common_pid:       2302 } hitcount:          5
+{ lat:         47, common_pid:       2302 } hitcount:          7
+{ lat:         48, common_pid:       2301 } hitcount:          1
+{ lat:         48, common_pid:       2302 } hitcount:          9
+{ lat:         49, common_pid:       2302 } hitcount:          3
+{ lat:         50, common_pid:       2302 } hitcount:          1
+{ lat:         50, common_pid:       2301 } hitcount:          1
+{ lat:         51, common_pid:       2302 } hitcount:          2
+{ lat:         51, common_pid:       2301 } hitcount:          1
+{ lat:         61, common_pid:       2302 } hitcount:          1
+{ lat:        110, common_pid:       2302 } hitcount:          1
+
+Totals:
+    Hits: 89565
+    Entries: 158
+    Dropped: 0
+
+This doesn't tell us any information about how late cyclictest may have
+woken up, but it does show us a nice histogram of how long it took from
+the time that cyclictest was woken to the time it made it into user space.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..42506e4d1f53 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -21,7 +21,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
 
 #define __branch_check__(x, expect, is_constant) ({			\
-			int ______r;					\
+			long ______r;					\
 			static struct ftrace_likely_data		\
 				__attribute__((__aligned__(4)))		\
 				__attribute__((section("_ftrace_annotated_branch"))) \
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index a0233edc0718..b72ebdff0b77 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -65,7 +65,7 @@ u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
- *   ben committed yet. If this is used, then ring_buffer_unlock_commit
+ *   been committed yet. If this is used, then ring_buffer_unlock_commit
  *   must not be called on the discarded event. This function
  *   will try to remove the event from the ring buffer completely
  *   if another event has not been written after it.
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2bde3eff564c..d1c442d9bd85 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -435,8 +435,7 @@ event_triggers_call(struct trace_event_file *file, void *rec,
 		    struct ring_buffer_event *event);
 extern void
 event_triggers_post_call(struct trace_event_file *file,
-			 enum event_trigger_type tt,
-			 void *rec, struct ring_buffer_event *event);
+			 enum event_trigger_type tt);
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index bfda803b0a09..4ecdfe2e3580 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -422,6 +422,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	do {								\
 		char *type_str = #type"["__stringify(len)"]";		\
 		BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);			\
+		BUILD_BUG_ON(len <= 0);					\
 		ret = trace_define_field(event_call, type_str, #item,	\
 				 offsetof(typeof(field), item),		\
 				 sizeof(field.item),			\
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c9cb9767d49b..6a46af21765c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -809,7 +809,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_normalize_time_stamp);
  *
  *  You can see, it is legitimate for the previous pointer of
  *  the head (or any page) not to point back to itself. But only
- *  temporarially.
+ *  temporarily.
  */
 
 #define RB_PAGE_NORMAL		0UL
@@ -906,7 +906,7 @@ static void rb_list_head_clear(struct list_head *list)
 }
 
 /*
- * rb_head_page_dactivate - clears head page ptr (for free list)
+ * rb_head_page_deactivate - clears head page ptr (for free list)
  */
 static void
 rb_head_page_deactivate(struct ring_buffer_per_cpu *cpu_buffer)
@@ -1780,7 +1780,7 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 
 		put_online_cpus();
 	} else {
-		/* Make sure this CPU has been intitialized */
+		/* Make sure this CPU has been initialized */
 		if (!cpumask_test_cpu(cpu_id, buffer->cpumask))
 			goto out;
 
@@ -2325,7 +2325,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/*
 	 * If we need to add a timestamp, then we
-	 * add it to the start of the resevered space.
+	 * add it to the start of the reserved space.
 	 */
 	if (unlikely(info->add_timestamp)) {
 		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
@@ -2681,7 +2681,7 @@ trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
  * ring_buffer_nest_start - Allow to trace while nested
  * @buffer: The ring buffer to modify
  *
- * The ring buffer has a safty mechanism to prevent recursion.
+ * The ring buffer has a safety mechanism to prevent recursion.
  * But there may be a case where a trace needs to be done while
  * tracing something else. In this case, calling this function
  * will allow this function to nest within a currently active
@@ -2699,7 +2699,7 @@ void ring_buffer_nest_start(struct ring_buffer *buffer)
 	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	cpu_buffer = buffer->buffers[cpu];
-	/* This is the shift value for the above recusive locking */
+	/* This is the shift value for the above recursive locking */
 	cpu_buffer->nest += NESTED_BITS;
 }
 
@@ -2718,7 +2718,7 @@ void ring_buffer_nest_end(struct ring_buffer *buffer)
 	/* disabled by ring_buffer_nest_start() */
 	cpu = raw_smp_processor_id();
 	cpu_buffer = buffer->buffers[cpu];
-	/* This is the shift value for the above recusive locking */
+	/* This is the shift value for the above recursive locking */
 	cpu_buffer->nest -= NESTED_BITS;
 	preempt_enable_notrace();
 }
@@ -2907,7 +2907,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
  * @buffer: the ring buffer to reserve from
  * @length: the length of the data to reserve (excluding event header)
  *
- * Returns a reseverd event on the ring buffer to copy directly to.
+ * Returns a reserved event on the ring buffer to copy directly to.
  * The user of this interface will need to get the body to write into
  * and can use the ring_buffer_event_data() interface.
  *
@@ -3009,7 +3009,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
  * This function lets the user discard an event in the ring buffer
  * and then that event will not be read later.
  *
- * This function only works if it is called before the the item has been
+ * This function only works if it is called before the item has been
  * committed. It will try to free the event from the ring buffer
  * if another event has not been added behind it.
  *
@@ -4127,7 +4127,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * through the buffer.  Memory is allocated, buffer recording
  * is disabled, and the iterator pointer is returned to the caller.
  *
- * Disabling buffer recordng prevents the reading from being
+ * Disabling buffer recording prevents the reading from being
  * corrupted. This is not a consuming read, so a producer is not
  * expected.
  *
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bcd93031d042..108ce3e1dc13 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4395,8 +4395,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 {
 	char *cmp;
 	int neg = 0;
-	int ret = -ENODEV;
-	int i;
+	int ret;
 	size_t orig_len = strlen(option);
 
 	cmp = strstrip(option);
@@ -4408,16 +4407,12 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	mutex_lock(&trace_types_lock);
 
-	for (i = 0; trace_options[i]; i++) {
-		if (strcmp(cmp, trace_options[i]) == 0) {
-			ret = set_tracer_flag(tr, 1 << i, !neg);
-			break;
-		}
-	}
-
+	ret = match_string(trace_options, -1, cmp);
 	/* If no option could be set, test the specific tracer options */
-	if (!trace_options[i])
+	if (ret < 0)
 		ret = set_tracer_option(tr, cmp, neg);
+	else
+		ret = set_tracer_flag(tr, 1 << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
 
@@ -6074,6 +6069,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	struct ring_buffer_event *event;
+	enum event_trigger_type tt = ETT_NONE;
 	struct ring_buffer *buffer;
 	struct print_entry *entry;
 	unsigned long irq_flags;
@@ -6122,6 +6118,12 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		written = cnt;
 	len = cnt;
 
+	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
+		/* do not add \n before testing triggers, but add \0 */
+		entry->buf[cnt] = '\0';
+		tt = event_triggers_call(tr->trace_marker_file, entry, event);
+	}
+
 	if (entry->buf[cnt - 1] != '\n') {
 		entry->buf[cnt] = '\n';
 		entry->buf[cnt + 1] = '\0';
@@ -6130,6 +6132,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
+	if (tt)
+		event_triggers_post_call(tr->trace_marker_file, tt);
+
 	if (written > 0)
 		*fpos += written;
 
@@ -7896,6 +7901,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
+	struct trace_event_file *file;
 	int cpu;
 
 	trace_create_file("available_tracers", 0444, d_tracer,
@@ -7928,6 +7934,12 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_marker", 0220, d_tracer,
 			  tr, &tracing_mark_fops);
 
+	file = __find_event_file(tr, "ftrace", "print");
+	if (file && file->dir)
+		trace_create_file("trigger", 0644, file->dir, file,
+				  &event_trigger_fops);
+	tr->trace_marker_file = file;
+
 	trace_create_file("trace_marker_raw", 0220, d_tracer,
 			  tr, &tracing_mark_raw_fops);
 
@@ -8111,6 +8123,8 @@ static __init int tracer_init_tracefs(void)
 	if (IS_ERR(d_tracer))
 		return 0;
 
+	event_trace_init();
+
 	init_tracer_tracefs(&global_trace, d_tracer);
 	ftrace_init_tracefs_toplevel(&global_trace, d_tracer);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 507954b4e058..630c5a24b2b2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -259,6 +259,7 @@ struct trace_array {
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
+	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	int			ref;
 #ifdef CONFIG_FUNCTION_TRACER
@@ -1334,7 +1335,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry, event);
+		event_triggers_post_call(file, tt);
 }
 
 /**
@@ -1367,7 +1368,7 @@ event_trigger_unlock_commit_regs(struct trace_event_file *file,
 						irq_flags, pc, regs);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry, event);
+		event_triggers_post_call(file, tt);
 }
 
 #define FILTER_PRED_INVALID	((unsigned short)-1)
@@ -1451,9 +1452,13 @@ trace_find_event_field(struct trace_event_call *call, char *name);
 extern void trace_event_enable_cmd_record(bool enable);
 extern void trace_event_enable_tgid_record(bool enable);
 
+extern int event_trace_init(void);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 
+extern struct trace_event_file *__find_event_file(struct trace_array *tr,
+						  const char *system,
+						  const char *event);
 extern struct trace_event_file *find_event_file(struct trace_array *tr,
 						const char *system,
 						const char *event);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index e3a658bac10f..1d67464ed95e 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -230,7 +230,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
 	FILTER_OTHER
 );
 
-FTRACE_ENTRY(print, print_entry,
+FTRACE_ENTRY_REG(print, print_entry,
 
 	TRACE_PRINT,
 
@@ -242,7 +242,9 @@ FTRACE_ENTRY(print, print_entry,
 	F_printk("%ps: %s",
 		 (void *)__entry->ip, __entry->buf),
 
-	FILTER_OTHER
+	FILTER_OTHER,
+
+	ftrace_event_register
 );
 
 FTRACE_ENTRY(raw_data, raw_data_entry,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 05c7172c6667..14ff4ff3caab 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2007,16 +2007,18 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 			return -1;
 		}
 	}
-	trace_create_file("filter", 0644, file->dir, file,
-			  &ftrace_event_filter_fops);
 
 	/*
 	 * Only event directories that can be enabled should have
-	 * triggers.
+	 * triggers or filters.
 	 */
-	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
+	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
+		trace_create_file("filter", 0644, file->dir, file,
+				  &ftrace_event_filter_fops);
+
 		trace_create_file("trigger", 0644, file->dir, file,
 				  &event_trigger_fops);
+	}
 
 #ifdef CONFIG_HIST_TRIGGERS
 	trace_create_file("hist", 0444, file->dir, file,
@@ -2473,8 +2475,9 @@ __trace_add_event_dirs(struct trace_array *tr)
 	}
 }
 
+/* Returns any file that matches the system and event */
 struct trace_event_file *
-find_event_file(struct trace_array *tr, const char *system,  const char *event)
+__find_event_file(struct trace_array *tr, const char *system, const char *event)
 {
 	struct trace_event_file *file;
 	struct trace_event_call *call;
@@ -2485,10 +2488,7 @@ find_event_file(struct trace_array *tr, const char *system,  const char *event)
 		call = file->event_call;
 		name = trace_event_name(call);
 
-		if (!name || !call->class || !call->class->reg)
-			continue;
-
-		if (call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)
+		if (!name || !call->class)
 			continue;
 
 		if (strcmp(event, name) == 0 &&
@@ -2498,6 +2498,20 @@ find_event_file(struct trace_array *tr, const char *system,  const char *event)
 	return NULL;
 }
 
+/* Returns valid trace event files that match system and event */
+struct trace_event_file *
+find_event_file(struct trace_array *tr, const char *system, const char *event)
+{
+	struct trace_event_file *file;
+
+	file = __find_event_file(tr, system, event);
+	if (!file || !file->event_call->class->reg ||
+	    file->event_call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)
+		return NULL;
+
+	return file;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
@@ -3132,7 +3146,7 @@ static __init int event_trace_enable_again(void)
 
 early_initcall(event_trace_enable_again);
 
-static __init int event_trace_init(void)
+__init int event_trace_init(void)
 {
 	struct trace_array *tr;
 	struct dentry *d_tracer;
@@ -3177,8 +3191,6 @@ void __init trace_event_init(void)
 	event_trace_enable();
 }
 
-fs_initcall(event_trace_init);
-
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 
 static DEFINE_SPINLOCK(test_spinlock);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 7d306b74230f..0171407d231f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -750,31 +750,32 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
  *
  * Note:
  * - @str might not be NULL-terminated if it's of type DYN_STRING
- *   or STATIC_STRING
+ *   or STATIC_STRING, unless @len is zero.
  */
 
 static int regex_match_full(char *str, struct regex *r, int len)
 {
-	if (strncmp(str, r->pattern, len) == 0)
-		return 1;
-	return 0;
+	/* len of zero means str is dynamic and ends with '\0' */
+	if (!len)
+		return strcmp(str, r->pattern) == 0;
+
+	return strncmp(str, r->pattern, len) == 0;
 }
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
-	if (len < r->len)
+	if (len && len < r->len)
 		return 0;
 
-	if (strncmp(str, r->pattern, r->len) == 0)
-		return 1;
-	return 0;
+	return strncmp(str, r->pattern, r->len) == 0;
 }
 
 static int regex_match_middle(char *str, struct regex *r, int len)
 {
-	if (strnstr(str, r->pattern, len))
-		return 1;
-	return 0;
+	if (!len)
+		return strstr(str, r->pattern) != NULL;
+
+	return strnstr(str, r->pattern, len) != NULL;
 }
 
 static int regex_match_end(char *str, struct regex *r, int len)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b9061ed59bbd..046c716a6536 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2865,7 +2865,7 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 {
 	struct trace_event_file *file;
 
-	file = find_event_file(tr, system, event_name);
+	file = __find_event_file(tr, system, event_name);
 	if (!file)
 		return ERR_PTR(-EINVAL);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 8b5bdcf64871..d18249683682 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -97,7 +97,6 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
  * event_triggers_post_call - Call 'post_triggers' for a trace event
  * @file: The trace_event_file associated with the event
  * @tt: enum event_trigger_type containing a set bit for each trigger to invoke
- * @rec: The trace entry for the event
  *
  * For each trigger associated with an event, invoke the trigger
  * function registered with the associated trigger command, if the
@@ -108,8 +107,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
  */
 void
 event_triggers_post_call(struct trace_event_file *file,
-			 enum event_trigger_type tt,
-			 void *rec, struct ring_buffer_event *event)
+			 enum event_trigger_type tt)
 {
 	struct event_trigger_data *data;
 
@@ -117,7 +115,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, rec, event);
+			data->ops->func(data, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 548e62eb5c46..45630a76ed3a 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -14,6 +14,13 @@
 
 #include "trace_output.h"
 
+/* Stub function for events with triggers */
+static int ftrace_event_register(struct trace_event_call *call,
+				 enum trace_reg type, void *data)
+{
+	return 0;
+}
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM	ftrace
 
@@ -117,7 +124,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
 
 #undef __dynamic_array
 #define __dynamic_array(type, item)					\
-	ret = trace_define_field(event_call, #type, #item,		\
+	ret = trace_define_field(event_call, #type "[]", #item,  \
 				 offsetof(typeof(field), item),		\
 				 0, is_signed_type(type), filter_type);\
 	if (ret)							\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1e37da2e0c25..6dc6356c3327 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -257,7 +257,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register -  Connect a probe to a tracepoint
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint with priority
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
@@ -290,7 +290,6 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
- * @prio: priority of this function over other registered functions
  *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8bdb1dc4072c..dcbca18011bb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -207,6 +207,11 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
+# gcc 5 supports generating the mcount tables directly
+ifneq ($(call cc-option,-mrecord-mcount,y),y)
+KBUILD_CFLAGS += -mrecord-mcount
+else
+# else do it all manually
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -259,6 +264,7 @@ ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 2a4f16fc9819..e4645d5e3126 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -15,14 +15,29 @@ reset_tracer() { # reset the current tracer
     echo nop > current_tracer
 }
 
-reset_trigger() { # reset all current setting triggers
-    grep -v ^# events/*/*/trigger |
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
-	echo "!$cmd" > `echo $line | cut -f1 -d:`
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
     done
 }
 
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
 reset_events_filter() { # reset all current setting filters
     grep -v ^none events/*/*/filter |
     while read line; do
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

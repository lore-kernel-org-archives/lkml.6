Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeEKTya (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbeEKTxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:43 -0400
Message-Id: <20180511195341.465655800@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Subject: [RFC][PATCH 10/10] tracing: Document trace_marker triggers
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0010-tracing-Document-trace_marker-triggers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add documentation and an example on how to use trace_marker triggers.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/events.rst    |   6 +-
 Documentation/trace/ftrace.rst    |   5 +
 Documentation/trace/histogram.txt | 546 +++++++++++++++++++++++++++++-
 3 files changed, 555 insertions(+), 2 deletions(-)

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
index 6e05510afc28..8c871f0c0e33 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1604,7 +1604,6 @@
         Entries: 7
         Dropped: 0
 
-
 2.2 Inter-event hist triggers
 -----------------------------
 
@@ -1993,3 +1992,548 @@ hist trigger specification.
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
+	/* tracemark_fd is the trace_marker file descripto */
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
+The we can see the histogram created by this with:
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
+ # echo '!hist:keys=common_pid:vals=hitcount:lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_switch).latency($lat) if buf == "end"' > events/ftrace/print/trigger
+ # echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat) if buf == "end"' > events/ftrace/print/trigger
+ # echo 'hist:keys=lat,common_pid:sort=lat' > events/synthetic/latency/trigger
+
+The difference this time is that instead of using the trace_marker to start
+the latency, the sched_waking event is used, matching the common_pid for the
+trace_marker write with the pid that is being worken by sched_waking.
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
+worken up, but it does show us a nice histogram of how long it took from
+the time that cyclictest was worken to the time it made it into user space.
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeCXQ0q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:26:46 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:53240 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752167AbeCXQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:26:44 -0400
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, mschiffer@universe-factory.net
Subject: [PATCH] ftrace: fix stddev calculation in function profiler (again)
Date: Sat, 24 Mar 2018 17:26:38 +0100
Message-Id: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is well-known that it is not possible to accurately calculate variances
just by accumulating squared samples; in fact, such an approach can even
result in negative numbers. An earlier attempt to fix the calculation
referred to Welford's method, but did not implement it correctly, leading
to meeaningless output like the following:

  nf_conntrack_proto_fini     50    373.523 us    7.470 us    3234315951 us

Welford's method uses one do_div() in the tracing path; this cannot be
avoided. The average time is added to struct ftrace_profile, so only a
single division is required. I also considered the following alternatives:

1) Only keeping the avg field and removing the aggregated time would
greatly lead to severe rounding errors in calculating the total time based
on counter and avg.

2) Calculating both the old and the new average in profile_graph_return()
instead of storing it in struct ftrace_profile would require a second
division.

3) I managed to transform Welford's equations in a way that uses the total
time instead of the average and requires only a single division.
Unfortunately, the divisor is counter^3 in this case, easily overflowing
even 64bit integers.

Ruling out the above alternatives, I chose the present approach to fix the
issue.

Fixes: e330b3bcd831 ("tracing: Show sample std dev in function profiling")
Fixes: 52d85d763086 ("ftrace: Fix stddev calculation in function profiler")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 kernel/trace/ftrace.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eac9ce2c57a2..16dce67b855a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -460,7 +460,8 @@ struct ftrace_profile {
 	unsigned long			counter;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned long long		time;
-	unsigned long long		time_squared;
+	unsigned long long		avg;
+	unsigned long long		stddev;
 #endif
 };
 
@@ -580,7 +581,6 @@ static int function_stat_show(struct seq_file *m, void *v)
 	int ret = 0;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	static struct trace_seq s;
-	unsigned long long avg;
 	unsigned long long stddev;
 #endif
 	mutex_lock(&ftrace_profile_lock);
@@ -592,9 +592,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	}
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	avg = rec->time;
-	do_div(avg, rec->counter);
-	if (tracing_thresh && (avg < tracing_thresh))
+	if (tracing_thresh && (rec->avg < tracing_thresh))
 		goto out;
 #endif
 
@@ -608,24 +606,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 	if (rec->counter <= 1)
 		stddev = 0;
 	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
-		stddev = rec->counter * rec->time_squared -
-			 rec->time * rec->time;
+		stddev = rec->stddev;
 
 		/*
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
+		do_div(stddev, 1000 * (rec->counter - 1));
 	}
 
 	trace_seq_init(&s);
 	trace_print_graph_duration(rec->time, &s);
 	trace_seq_puts(&s, "    ");
-	trace_print_graph_duration(avg, &s);
+	trace_print_graph_duration(rec->avg, &s);
 	trace_seq_puts(&s, "    ");
 	trace_print_graph_duration(stddev, &s);
 	trace_print_seq(m, &s);
@@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 
 	rec = ftrace_find_profiled_func(stat, trace->func);
 	if (rec) {
+		unsigned long long avg, delta1, delta2;
+
 		rec->time += calltime;
-		rec->time_squared += calltime * calltime;
+
+		/* Apply Welford's method */
+		delta1 = calltime - rec->avg;
+
+		avg = rec->time;
+		do_div(avg, rec->counter);
+		rec->avg = avg;
+
+		delta2 = calltime - rec->avg;
+
+		rec->stddev += delta1 * delta2;
 	}
 
  out:
-- 
2.16.2

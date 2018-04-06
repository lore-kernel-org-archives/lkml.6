Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeDFNDv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0544A21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.911262004@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 08/18] tracing: Add action comparisons when testing matching hist triggers
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0008-tracing-Add-action-comparisons-when-testing-matching.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Actions also need to be considered when checking for matching triggers
- triggers differing only by action should be allowed, but currently
aren't because the matching check ignores the action and erroneously
returns -EEXIST.

Add and call an actions_match() function to address that.

Here's an example using onmatch() actions.  The first -EEXIST shouldn't
occur because the onmatch() is different in the second wakeup_latency()
param.  The second -EEXIST shouldn't occur because it's a different
action (in this case, it doesn't have an action, so shouldn't be seen
as being the same and therefore rejected).

In the after case, both are correctly accepted (and trying to add one of
them again returns -EEXIST as it should).

before:

  # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
-su: echo: write error: File exists
  # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
-su: echo: write error: File exists

after:

  # echo 'wakeup_latency u64 lat; pid_t pid' >> /sys/kernel/debug/tracing/synthetic_events
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

Link: http://lkml.kernel.org/r/a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d867502a56ba..6114939f065a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4364,6 +4364,53 @@ static void print_onmatch_spec(struct seq_file *m,
 	seq_puts(m, ")");
 }
 
+static bool actions_match(struct hist_trigger_data *hist_data,
+			  struct hist_trigger_data *hist_data_test)
+{
+	unsigned int i, j;
+
+	if (hist_data->n_actions != hist_data_test->n_actions)
+		return false;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+		struct action_data *data_test = hist_data_test->actions[i];
+
+		if (data->fn != data_test->fn)
+			return false;
+
+		if (data->n_params != data_test->n_params)
+			return false;
+
+		for (j = 0; j < data->n_params; j++) {
+			if (strcmp(data->params[j], data_test->params[j]) != 0)
+				return false;
+		}
+
+		if (data->fn == action_trace) {
+			if (strcmp(data->onmatch.synth_event_name,
+				   data_test->onmatch.synth_event_name) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event_system,
+				   data_test->onmatch.match_event_system) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event,
+				   data_test->onmatch.match_event) != 0)
+				return false;
+		} else if (data->fn == onmax_save) {
+			if (strcmp(data->onmax.var_str,
+				   data_test->onmax.var_str) != 0)
+				return false;
+			if (strcmp(data->onmax.fn_name,
+				   data_test->onmax.fn_name) != 0)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+
 static void print_actions_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data)
 {
@@ -5174,6 +5221,9 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	    (strcmp(data->filter_str, data_test->filter_str) != 0))
 		return false;
 
+	if (!actions_match(hist_data, hist_data_test))
+		return false;
+
 	return true;
 }
 
-- 
2.15.1

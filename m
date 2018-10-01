Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7432C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D582089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcQIbfmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D582089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJAW5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbeJAW5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:57:19 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B35C2146D;
        Mon,  1 Oct 2018 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538410725;
        bh=SEqvg+loV7g9G5DTOWydgHXVMQYEOXLrAkOp3ZE3utE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=rcQIbfmPq8p0abVZ3XmeknDyJdF9lYN4yBaxarBWofJMWFDRDiIxEZruUuXUS00UN
         Ms8rY3O3yyjdCrjg9/y0gnmBbhirbKuREgRoaO1AMP1PF2VqoTWpblobv+jGaXQgSQ
         /TtnDG1Yr6XC2akQT5We8Ob7oUOBnxhumQXj1ZDY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v5 7/8] tracing: Add hist trigger onchange() handler
Date:   Mon,  1 Oct 2018 11:18:07 -0500
Message-Id: <0a17743dc24db781ebe72dcae1306ea5d9a0f7ef.1538403550.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1538403550.git.tom.zanussi@linux.intel.com>
References: <cover.1538403550.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1538403550.git.tom.zanussi@linux.intel.com>
References: <cover.1538403550.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add support for a hist:onchange($var) handler, similar to the onmax()
handler but triggering whenever there's any change in $var, not just a
max.

Also, add a testcase for it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst                  | 97 ++++++++++++++++++++++
 kernel/trace/trace_events_hist.c                   | 68 ++++++++++++---
 .../inter-event/trigger-onchange-action-hist.tc    | 43 ++++++++++
 3 files changed, 195 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index ce715dc0ec2c..e73a840a3598 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -2109,6 +2109,103 @@ hist trigger specification.
       <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
      <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
 
+  - onchange(var).save(field,..	.)
+
+    The 'onchange(var).save(field,...)' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that the trace event fields specified as the
+    onchange.save() params will be saved if 'var' changes for that
+    hist trigger entry.  This allows context from the event that
+    changed the value to be saved for later reference.  When the
+    histogram is displayed, additional fields displaying the saved
+    values will be printed.
+
+  - onchange(var).snapshot()
+
+    The 'onchange(var).snapshot()' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that a global snapshot of the trace buffer will
+    be saved in the tracing/snapshot file if 'var' changes for any
+    hist trigger entry.
+
+    Note that in this case the changed value is a global variable
+    associated withe current trace instance.  The key of the specific
+    trace event that caused the value to change and the global value
+    itself are displayed, along with a message stating that a snapshot
+    has been taken and where to find it.  The user can use the key
+    information displayed to locate the corresponding bucket in the
+    histogram for even more detail.
+
+    As an example the below defines a hist trigger on the tcp_probe
+    event, keyed on dport.  Whenever a tcp_probe event occurs, the
+    cwnd field is checked against the current value stored in the
+    $cwnd variable.  If the value has changed, a snapshot is taken.
+    As part of the setup, all the scheduler and tcp events are also
+    enabled, which are the events that will show up in the snapshot
+    when it is taken at some point:
+
+    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+
+    # echo 'hist:keys=dport:cwnd=snd_cwnd: \
+            onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+	    onchange($cwnd).snapshot()' >> \
+	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+
+    When the histogram is displayed, for each bucket the tracked value
+    and the saved values corresponding to that value are displayed
+    following the rest of the fields.
+
+    If a snaphot was taken, there is also a message indicating that,
+    along with the value and event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
+      { dport:       1521 } hitcount:          8
+	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
+
+      { dport:         80 } hitcount:         23
+	changed:         10  snd_wnd:      28960  srtt:      19604  rcv_wnd:      29312
+
+      { dport:       9001 } hitcount:        172
+	changed:         10  snd_wnd:      48384  srtt:     260444  rcv_wnd:      55168
+
+      { dport:        443 } hitcount:        211
+	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
+
+    Snapshot taken (see tracing/snapshot).  Details:
+        triggering value { onchange($cwnd) }:         10
+        triggered by event with key: { dport:         80 }
+
+    Totals:
+        Hits: 414
+        Entries: 4
+        Dropped: 0
+
+    In the above case, the event that triggered the snapshot has the
+    key with dport == 80.  If you look at the bucket that has 80 as
+    the key, you'll find the additional values save()'d along with the
+    changed value for that bucket, which should be the same as the
+    global changed value (since that was the same value that triggered
+    the global snapshot).
+
+    And finally, looking at the snapshot data should show at or near
+    the end the event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/snapshot
+
+       gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
+     kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
+       gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
+       kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
+       kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
+            <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
+
 3. User space creating a trigger
 --------------------------------
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8d6e9fde0826..90f1a0cf34c0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -331,6 +331,7 @@ typedef u64 (*get_track_val_fn_t) (struct hist_trigger_data *hist_data,
 enum handler_id {
 	HANDLER_ONMATCH = 1,
 	HANDLER_ONMAX,
+	HANDLER_ONCHANGE,
 };
 
 enum action_id {
@@ -1886,7 +1887,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 		return ret;
 
 	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
-	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+	    (strncmp(str, "onmax(", strlen("onmax(")) == 0) ||
+	    (strncmp(str, "onchange(", strlen("onchange(")) == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -3346,6 +3348,14 @@ static bool check_track_val_max(u64 track_val, u64 var_val)
 	return true;
 }
 
+static bool check_track_val_changed(u64 track_val, u64 var_val)
+{
+	if (var_val == track_val)
+		return false;
+
+	return true;
+}
+
 static u64 get_track_val_local(struct hist_trigger_data *hist_data,
 			       struct tracing_map_elt *elt,
 			       struct action_data *data)
@@ -3520,6 +3530,8 @@ static void track_data_print(struct seq_file *m,
 
 	if (data->handler == HANDLER_ONMAX)
 		seq_printf(m, "\n\tmax: %10llu", track_val);
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_printf(m, "\n\tchanged: %10llu", track_val);
 
 	if (data->action == ACTION_SNAPSHOT)
 		return;
@@ -3550,10 +3562,10 @@ static void ontrack_save(struct hist_trigger_data *hist_data,
 		update_save_vars(hist_data, elt, rbe, rec);
 }
 
-static void onmax_snapshot(struct hist_trigger_data *hist_data,
-			   struct tracing_map_elt *elt, void *rec,
-			   struct ring_buffer_event *rbe,
-			   struct action_data *data, u64 *var_ref_vals)
+static void ontrack_snapshot(struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt, void *rec,
+			     struct ring_buffer_event *rbe,
+			     struct action_data *data, u64 *var_ref_vals)
 {
 	update_track_val(hist_data, elt, data, var_ref_vals);
 }
@@ -3614,14 +3626,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 
 	track_data_var_str = data->track_data.var_str;
 	if (track_data_var_str[0] != '$') {
-		hist_err("For onmax(x), x must be a variable: ", track_data_var_str);
+		hist_err("For onmax(x) or onchange(x), x must be a variable: ", track_data_var_str);
 		return -EINVAL;
 	}
 	track_data_var_str++;
 
 	var_field = find_target_event_var(hist_data, NULL, NULL, track_data_var_str);
 	if (!var_field) {
-		hist_err("Couldn't find onmax variable: ", track_data_var_str);
+		hist_err("Couldn't find onmax or onchange variable: ", track_data_var_str);
 		return -EINVAL;
 	}
 
@@ -3648,6 +3660,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(track_var);
 		goto out;
 	}
+
+	if (data->handler == HANDLER_ONCHANGE)
+		track_var = create_var(hist_data, file, "__change", sizeof(u64), "u64");
+	if (IS_ERR(track_var)) {
+		hist_err("Couldn't create onchange variable: ", "__change");
+		ret = PTR_ERR(track_var);
+		goto out;
+	}
 	data->track_data.track_var = track_var;
 
 	ret = action_create(hist_data, data);
@@ -3727,6 +3747,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3750,6 +3772,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3759,7 +3783,7 @@ static int action_parse(char *str, struct action_data *data,
 		data->track_data.save_val = save_track_val_snapshot;
 		data->track_data.get_val = get_track_val_snapshot;
 
-		data->fn = onmax_snapshot;
+		data->fn = ontrack_snapshot;
 
 		data->action = ACTION_SNAPSHOT;
 	} else {
@@ -3773,6 +3797,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 
 		data->track_data.save_val = save_track_val_local;
 		data->track_data.get_val = get_track_val_local;
@@ -4638,7 +4664,8 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 
 		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->handler == HANDLER_ONMAX)
+		else if (data->handler == HANDLER_ONMAX ||
+			 data->handler == HANDLER_ONCHANGE)
 			track_data_destroy(hist_data, data);
 		else
 			kfree(data);
@@ -4673,6 +4700,15 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				ret = PTR_ERR(data);
 				break;
 			}
+		} else if (strncmp(str, "onchange(", strlen("onchange(")) == 0) {
+			char *action_str = str + strlen("onchange(");
+
+			data = track_data_parse(hist_data, action_str,
+						HANDLER_ONCHANGE);
+			if (IS_ERR(data)) {
+				ret = PTR_ERR(data);
+				break;
+			}
 		} else {
 			ret = -EINVAL;
 			break;
@@ -4697,7 +4733,8 @@ static int create_actions(struct hist_trigger_data *hist_data)
 			ret = onmatch_create(hist_data, data);
 			if (ret)
 				return ret;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			ret = track_data_create(hist_data, data);
 			if (ret)
 				return ret;
@@ -4725,7 +4762,8 @@ static void print_actions(struct seq_file *m,
 			continue;
 		}
 
-		if (data->handler == HANDLER_ONMAX)
+		if (data->handler == HANDLER_ONMAX ||
+		    data->handler == HANDLER_ONCHANGE)
 			track_data_print(m, hist_data, elt, data);
 	}
 }
@@ -4757,6 +4795,8 @@ static void print_track_data_spec(struct seq_file *m,
 {
 	if (data->handler == HANDLER_ONMAX)
 		seq_puts(m, ":onmax(");
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_puts(m, ":onchange(");
 	seq_printf(m, "%s", data->track_data.var_str);
 	seq_printf(m, ").%s(", data->action_name);
 
@@ -4814,7 +4854,8 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 			if (strcmp(data->match_data.event,
 				   data_test->match_data.event) != 0)
 				return false;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			if (strcmp(data->track_data.var_str,
 				   data_test->track_data.var_str) != 0)
 				return false;
@@ -4835,7 +4876,8 @@ static void print_actions_spec(struct seq_file *m,
 
 		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
-		else if (data->handler == HANDLER_ONMAX)
+		else if (data->handler == HANDLER_ONMAX ||
+			 data->handler == HANDLER_ONCHANGE)
 			print_track_data_spec(m, hist_data, data);
 	}
 }
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
new file mode 100644
index 000000000000..585f77f064f2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -0,0 +1,43 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onchange action
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
+echo "Test onchange action"
+
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+ping localhost -c 3
+nice -n 1 ping localhost -c 3
+
+if ! grep -q "changed:" events/sched/sched_waking/hist; then
+    fail "Failed to create onchange action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
-- 
2.14.1


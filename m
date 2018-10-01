Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC42145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaqVbDL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDC42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJAW5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeJAW5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:57:18 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1272213A2;
        Mon,  1 Oct 2018 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538410723;
        bh=LSNt/oGW3v1p6Cgu5jATvDJfBjAaivum4UwQqCqGv3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OaqVbDL6H6GD/W0YHYuUWjQDaR1dt9SUUX34QviuZOP/ZOy/bXsZX3HYEelT+rymb
         1pgk45hV8Q0AlaQOwdzfkD9XQ7uYSfQLrT1hcOoloDZFaL9gsWcDeOQeGXEm+4mqmU
         /SsK1lvOEmd1+67QV5e2vQ2atUwr3ZwrSCT/nMAM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v5 6/8] tracing: Add snapshot action
Date:   Mon,  1 Oct 2018 11:18:06 -0500
Message-Id: <4b4fe3dd97c1005aae363b66651a8feafe590f17.1538403550.git.tom.zanussi@linux.intel.com>
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

Add support for hist:handlerXXX($var).snapshot(), which will take a
snapshot of the current trace buffer whenever handlerXXX is hit.

As a first user, this also adds snapshot() action support for the
onmax() handler i.e. hist:onmax($var).snapshot().

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 109 ++++++++++++++
 kernel/trace/trace_events_hist.c  | 290 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 391 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 5ac724baea7d..ce715dc0ec2c 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -2000,6 +2000,115 @@ hist trigger specification.
             Entries: 2
             Dropped: 0
 
+  - onmax(var).snapshot()
+
+    The 'onmax(var).snapshot()' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    exceeds the current maximum contained in that variable.
+
+    The end result is that a global snapshot of the trace buffer will
+    be saved in the tracing/snapshot file if 'var' exceeds the current
+    maximum for any hist trigger entry.
+
+    Note that in this case the maximum is a global maximum for the
+    current trace instance, which is the maximum across all buckets of
+    the histogram.  The key of the specific trace event that caused
+    the global maximum and the global maximum itself are displayed,
+    along with a message stating that a snapshot has been taken and
+    where to find it.  The user can use the key information displayed
+    to locate the corresponding bucket in the histogram for even more
+    detail.
+
+    As an example the below defines a couple of hist triggers, one for
+    sched_waking and another for sched_switch, keyed on pid.  Whenever
+    a sched_waking event occurs, the timestamp is saved in the entry
+    corresponding to the current pid, and when the scheduler switches
+    back to that pid, the timestamp difference is calculated.  If the
+    resulting latency, stored in wakeup_lat, exceeds the current
+    maximum latency, a snapshot is taken.  As part of the setup, all
+    the scheduler events are also enabled, which are the events that
+    will show up in the snapshot when it is taken at some point:
+
+    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+
+    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+            onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
+	    prev_comm):onmax($wakeup_lat).snapshot() \
+	    if next_comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    When the histogram is displayed, for each bucket the max value
+    and the saved values corresponding to the max are displayed
+    following the rest of the fields.
+
+    If a snaphot was taken, there is also a message indicating that,
+    along with the value and event that triggered the global maximum:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+      { next_pid:       2101 } hitcount:        200
+	max:         52  next_prio:        120  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
+
+      { next_pid:       2103 } hitcount:       1326
+	max:        572  next_prio:         19  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+
+      { next_pid:       2102 } hitcount:       1982 \
+	max:         74  next_prio:         19  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
+
+    Snapshot taken (see tracing/snapshot).  Details:
+	triggering value { onmax($wakeup_lat) }:        572	\
+	triggered by event with key: { next_pid:       2103 }
+
+    Totals:
+        Hits: 3508
+        Entries: 3
+        Dropped: 0
+
+    In the above case, the event that triggered the global maximum has
+    the key with next_pid == 2103.  If you look at the bucket that has
+    2103 as the key, you'll find the additional values save()'d along
+    with the local maximum for that bucket, which should be the same
+    as the global maximum (since that was the same value that
+    triggered the global snapshot).
+
+    And finally, looking at the snapshot data should show at or near
+    the end the event that triggered the snapshot (in this case you
+    can verify the timestamps between the sched_waking and
+    sched_switch events, which should match the time displayed in the
+    global maximum):
+
+    # cat /sys/kernel/debug/tracing/snapshot
+
+     <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+     <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+     <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+     <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
+     <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+     <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+     <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+     <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
+ gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
+     <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
+     <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
+     <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
+     <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
+  rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
+  rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
+      <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
+      <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
+     <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
+
 3. User space creating a trigger
 --------------------------------
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ec462cb7672..8d6e9fde0826 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -336,12 +336,14 @@ enum handler_id {
 enum action_id {
 	ACTION_SAVE = 1,
 	ACTION_TRACE,
+	ACTION_SNAPSHOT,
 };
 
 struct action_data {
 	enum handler_id		handler;
 	enum action_id		action;
 	char			*action_name;
+	void			*key;
 	action_fn_t		fn;
 
 	unsigned int		n_params;
@@ -366,10 +368,85 @@ struct action_data {
 			check_track_val_fn_t	check_val;
 			save_track_val_fn_t	save_val;
 			get_track_val_fn_t	get_val;
+
+			struct cond_snapshot	cond_snapshot;
 		} track_data;
 	};
 };
 
+struct track_data {
+	u64				track_val;
+
+	unsigned int			key_len;
+	void				*key;
+	struct tracing_map_elt		elt;
+	struct tracing_map_elt		*cur_elt;
+
+	struct action_data		*action_data;
+	struct hist_trigger_data	*hist_data;
+};
+
+struct hist_elt_data {
+	char *comm;
+	u64 *var_ref_vals;
+	char *field_var_str[SYNTH_FIELDS_MAX];
+};
+
+static void track_data_free(struct track_data *track_data)
+{
+	struct hist_elt_data *elt_data;
+
+	if (!track_data)
+		return;
+
+	kfree(track_data->key);
+
+	elt_data = track_data->elt.private_data;
+	if (elt_data) {
+		kfree(elt_data->comm);
+		kfree(elt_data);
+	}
+
+	kfree(track_data);
+}
+
+static struct track_data *track_data_alloc(unsigned int key_len,
+					   struct action_data *action_data,
+					   struct hist_trigger_data *hist_data)
+{
+	struct track_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
+	unsigned int size = TASK_COMM_LEN;
+	struct hist_elt_data *elt_data;
+
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->key = kzalloc(key_len, GFP_KERNEL);
+	if (!data->key) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	data->key_len = key_len;
+	data->action_data = action_data;
+	data->hist_data = hist_data;
+
+	elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+	data->elt.private_data = elt_data;
+
+	elt_data->comm = kzalloc(size, GFP_KERNEL);
+	if (!elt_data->comm) {
+		track_data_free(data);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return data;
+}
+
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
@@ -1624,12 +1701,6 @@ static struct hist_field *find_event_var(struct hist_trigger_data *hist_data,
 	return hist_field;
 }
 
-struct hist_elt_data {
-	char *comm;
-	u64 *var_ref_vals;
-	char *field_var_str[SYNTH_FIELDS_MAX];
-};
-
 static u64 hist_field_var_ref(struct hist_field *hist_field,
 			      struct tracing_map_elt *elt,
 			      struct ring_buffer_event *rbe,
@@ -3319,6 +3390,126 @@ static bool update_track_val(struct hist_trigger_data *hist_data,
 					 track_var_idx, var_val);
 }
 
+static void cond_snapshot_save_track_data(struct track_data *old_data,
+					  struct track_data *data)
+{
+	struct hist_elt_data *elt_data, *old_elt_data;
+	struct tracing_map_elt *elt;
+
+	old_data->track_val = data->track_val;
+
+	memcpy(old_data->key, data->key, old_data->key_len);
+	elt = data->cur_elt;
+	elt_data = elt->private_data;
+	old_elt_data = old_data->elt.private_data;
+
+	if (elt_data->comm)
+		memcpy(old_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+}
+
+static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
+{
+	/* called with tr->max_lock held */
+	struct track_data *old_data = tr->cond_snapshot->cond_data;
+	struct track_data *data = cond_data;
+	struct action_data *action_data = old_data->action_data;
+	bool updated;
+
+	if (!old_data)
+		return false;
+
+	updated = action_data->track_data.check_val(old_data->track_val, data->track_val);
+	if (!updated)
+		return false;
+
+	cond_snapshot_save_track_data(old_data, data);
+
+	return true;
+}
+
+static u64 get_track_val_snapshot(struct hist_trigger_data *hist_data,
+				  struct tracing_map_elt *elt,
+				  struct action_data *data)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
+
+	track_data = tracing_cond_snapshot_data(file->tr);
+	if (WARN_ON(!track_data))
+		return 0;
+
+	return track_data->track_val;
+}
+
+static bool save_track_val_snapshot(struct hist_trigger_data *hist_data,
+				    struct tracing_map_elt *elt,
+				    struct action_data *data,
+				    unsigned int track_var_idx, u64 var_val)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
+	bool ret = false;
+
+	track_data = data->track_data.cond_snapshot.cond_data;
+	track_data->track_val = var_val;
+	memcpy(track_data->key, data->key, track_data->key_len);
+	track_data->cur_elt = elt;
+
+	tracing_snapshot_cond(file->tr, track_data);
+
+	return ret;
+}
+
+static void hist_trigger_print_key(struct seq_file *m,
+				   struct hist_trigger_data *hist_data,
+				   void *key,
+				   struct tracing_map_elt *elt);
+
+static struct action_data *snapshot_action(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	if (!hist_data->n_actions)
+		return NULL;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->action == ACTION_SNAPSHOT)
+			return data;
+	}
+
+	return NULL;
+}
+
+static void track_data_snapshot_print(struct seq_file *m,
+				      struct hist_trigger_data *hist_data)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
+	struct action_data *action;
+
+	track_data = tracing_cond_snapshot_data(file->tr);
+	if (!track_data)
+		return;
+
+	if (!track_data->track_val)
+		return;
+
+	action = snapshot_action(hist_data);
+	if (!action)
+		return;
+
+	seq_puts(m, "\nSnapshot taken (see tracing/snapshot).  Details:\n");
+	seq_printf(m, "\ttriggering value { %s(%s) }: %10llu",
+		   action->handler == HANDLER_ONMAX ? "onmax" : "onchange",
+		   action->track_data.var_str, track_data->track_val);
+
+	seq_puts(m, "\ttriggered by event with key: ");
+	hist_trigger_print_key(m, hist_data, track_data->key, &track_data->elt);
+	seq_putc(m, '\n');
+}
+
 static void track_data_print(struct seq_file *m,
 			     struct hist_trigger_data *hist_data,
 			     struct tracing_map_elt *elt,
@@ -3330,6 +3521,9 @@ static void track_data_print(struct seq_file *m,
 	if (data->handler == HANDLER_ONMAX)
 		seq_printf(m, "\n\tmax: %10llu", track_val);
 
+	if (data->action == ACTION_SNAPSHOT)
+		return;
+
 	for (i = 0; i < hist_data->n_save_vars; i++) {
 		struct hist_field *save_val = hist_data->save_vars[i]->val;
 		struct hist_field *save_var = hist_data->save_vars[i]->var;
@@ -3356,6 +3550,14 @@ static void ontrack_save(struct hist_trigger_data *hist_data,
 		update_save_vars(hist_data, elt, rbe, rec);
 }
 
+static void onmax_snapshot(struct hist_trigger_data *hist_data,
+			   struct tracing_map_elt *elt, void *rec,
+			   struct ring_buffer_event *rbe,
+			   struct action_data *data, u64 *var_ref_vals)
+{
+	update_track_val(hist_data, elt, data, var_ref_vals);
+}
+
 static void action_data_destroy(struct action_data *data)
 {
 	unsigned int i;
@@ -3378,9 +3580,20 @@ static void action_data_destroy(struct action_data *data)
 static void track_data_destroy(struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
+	struct trace_event_file *file = hist_data->event_file;
+
 	destroy_hist_field(data->track_data.track_var, 0);
 	destroy_hist_field(data->track_data.var_ref, 0);
 
+	if (data->action == ACTION_SNAPSHOT) {
+		struct track_data *track_data;
+
+		track_data = tracing_cond_snapshot_data(file->tr);
+		tracing_snapshot_cond_disable(file->tr);
+		track_data_free(track_data);
+		track_data_free(data->track_data.cond_snapshot.cond_data);
+	}
+
 	kfree(data->track_data.var_str);
 
 	action_data_destroy(data);
@@ -3526,6 +3739,29 @@ static int action_parse(char *str, struct action_data *data,
 		data->fn = ontrack_save;
 
 		data->action = ACTION_SAVE;
+	} else if (strncmp(action_name, "snapshot", strlen("snapshot")) == 0) {
+		char *params = strsep(&str, ")");
+
+		if (!str) {
+			hist_err("action parsing: No closing paren found: %s", params);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (handler == HANDLER_ONMAX)
+			data->track_data.check_val = check_track_val_max;
+		else {
+			hist_err("action parsing: Handler doesn't support action: ", action_name);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		data->track_data.save_val = save_track_val_snapshot;
+		data->track_data.get_val = get_track_val_snapshot;
+
+		data->fn = onmax_snapshot;
+
+		data->action = ACTION_SNAPSHOT;
 	} else {
 		char *params = strsep(&str, ")");
 
@@ -3842,6 +4078,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 static int action_create(struct hist_trigger_data *hist_data,
 			 struct action_data *data)
 {
+	struct trace_event_file *file = hist_data->event_file;
+	struct track_data *track_data;
 	struct field_var *field_var;
 	unsigned int i;
 	char *param;
@@ -3852,6 +4090,32 @@ static int action_create(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	if (data->action == ACTION_SNAPSHOT) {
+		ret = tracing_alloc_snapshot_instance(file->tr);
+		if (ret)
+			goto out;
+
+		data->track_data.cond_snapshot.cond_data = track_data_alloc(hist_data->key_size, NULL, NULL);
+		if (IS_ERR(data->track_data.cond_snapshot.cond_data)) {
+			ret = PTR_ERR(data->track_data.cond_snapshot.cond_data);
+			goto out;
+		}
+
+		track_data = track_data_alloc(hist_data->key_size, data,
+					      hist_data);
+		if (IS_ERR(track_data)) {
+			ret = PTR_ERR(track_data);
+			goto out;
+		}
+
+		ret = tracing_snapshot_cond_enable(file->tr, track_data,
+						   cond_snapshot_update);
+		if (ret)
+			track_data_free(track_data);
+
+		goto out;
+	}
+
 	if (data->action == ACTION_SAVE) {
 		if (hist_data->n_save_vars) {
 			ret = -EINVAL;
@@ -4450,11 +4714,17 @@ static void print_actions(struct seq_file *m,
 			  struct hist_trigger_data *hist_data,
 			  struct tracing_map_elt *elt)
 {
+	struct action_data *snapshot_action = NULL;
 	unsigned int i;
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
+		if (data->action == ACTION_SNAPSHOT) {
+			snapshot_action = data; /* we can only have one */
+			continue;
+		}
+
 		if (data->handler == HANDLER_ONMAX)
 			track_data_print(m, hist_data, elt, data);
 	}
@@ -4760,13 +5030,15 @@ static inline void add_to_key(char *compound_key, void *key,
 static void
 hist_trigger_actions(struct hist_trigger_data *hist_data,
 		     struct tracing_map_elt *elt, void *rec,
-		     struct ring_buffer_event *rbe, u64 *var_ref_vals)
+		     struct ring_buffer_event *rbe, u64 *var_ref_vals,
+		     void *key)
 {
 	struct action_data *data;
 	unsigned int i;
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		data = hist_data->actions[i];
+		data->key = key;
 		data->fn(hist_data, elt, rec, rbe, data, var_ref_vals);
 	}
 }
@@ -4828,7 +5100,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
+		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals, key);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5005,6 +5277,8 @@ static void hist_trigger_show(struct seq_file *m,
 	if (n_entries < 0)
 		n_entries = 0;
 
+	track_data_snapshot_print(m, hist_data);
+
 	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
 		   (u64)atomic64_read(&hist_data->map->hits),
 		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
-- 
2.14.1


Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD430C67838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A9D21477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toa0aJ87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A9D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJLEbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbeJLEbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:31:34 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A8F2077C;
        Thu, 11 Oct 2018 21:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539291753;
        bh=qHTLpaPkEarerCxyFgXzVnwe9sHkhP1qUHqTceK5auo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Toa0aJ87XLQjW3HNuUTQehoHCc+q9ehpnyzh9jvZ4jbArpSs2vJDpRA0LETLhSpYl
         482BDteWksIU4qebY3Ajjzzn1Bku0NyE+tVbQ/hBdfLMep+HHtRGP8OvF/JmFSYdcg
         UJOs7An78POMxMqYfxEH5uOItWBCj0JRZiMiybSQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v6 08/15] tracing: Add hist trigger snapshot() action
Date:   Thu, 11 Oct 2018 16:02:05 -0500
Message-Id: <619464a186fe9f5b2805f48d9a7c94ad8b1e9a6e.1539288364.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
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
 kernel/trace/trace.c             |   1 +
 kernel/trace/trace_events_hist.c | 290 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 283 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 56df8b61e860..8047841b4346 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4880,6 +4880,7 @@ static const char readme_msg[] =
 	"\t    The available actions are:\n\n"
 	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
+	"\t        snapshot()                           - snapshot the trace buffer\n"
 #endif
 ;
 
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


Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E07258DD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTRgxx+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E07258DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeGBUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753312AbeGBUWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:22:40 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4A425A2E;
        Mon,  2 Jul 2018 20:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530562959;
        bh=3+C5L8OWEYJaubJLL04Osr7SlWNsDMOyxBzlr0SvWEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gTRgxx+AaZ7B+/i5uL1WX3XRPQsM83z3WE724Sw1aNNAmFFXOYGw4Jd7j+zdNP3OP
         DNdDnK7+wuD1zi3sGcNNlNU1wF7DUFQmP2MOb36OWEfXYhMEAv/25ZLRI8Tq05fPcZ
         ZRJ4EqqdCraCMtiG7k/rUB8L1iiuCOVQU6qqQk0I=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 3/7] tracing: Generalize hist trigger onmax and save action
Date:   Mon,  2 Jul 2018 15:22:22 -0500
Message-Id: <6a2ee0a6c6d5c0d32488ff6b2cc069b4d35c1eb7.1530561352.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The action refactor code allowed actions and handlers to be separated,
but the existing onmax handler and save action code is still not
flexible enough to handle arbitrary coupling.  This change generalizes
them and in the process makes additional handlers and actions easier
to implement.

The onmax action can be broken up and thought of as two separate
components - a variable to be tracked (the parameter given to the
onmax($var_to_track) function) and an invisible variable created to
save the ongoing result of doing something with that variable, such as
saving the max value of that variable so far seen.

Separating it out like this and renaming it appropriately allows us to
use the same code for similar tracking functions such as
onchange($var_to_track), which would just track the last value seen
rather than the max seen so far, which is useful in some situations.

Additionally, because different handlers and actions may want to save
and access data differently e.g. save and retrieve tracking values as
local variables vs something more global, save_val() and get_val()
interface functions are introduced and max-specific implementations
are used instead.

The same goes for the code that checks whether a maximum has been hit
- a generic check_val() interface and max-checking implementation is
used instead, which allows future patches to make use of he same code
using their own implemetations of similar functionality.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 213 +++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 74 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 61a3a8ca2f76..f54dc8782d91 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -328,6 +328,15 @@ typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
 			     struct ring_buffer_event *rbe,
 			     struct action_data *data, u64 *var_ref_vals);
 
+typedef bool (*check_track_val_fn_t) (u64 track_val, u64 var_val);
+typedef bool (*save_track_val_fn_t) (struct hist_trigger_data *hist_data,
+				     struct tracing_map_elt *elt,
+				     struct action_data *data,
+				     unsigned int track_var_idx, u64 var_val);
+typedef u64 (*get_track_val_fn_t) (struct hist_trigger_data *hist_data,
+				   struct tracing_map_elt *elt,
+				   struct action_data *data);
+
 enum handler_id {
 	HANDLER_ONMATCH = 1,
 	HANDLER_ONMAX,
@@ -358,14 +367,18 @@ struct action_data {
 
 		struct {
 			char			*var_str;
-			unsigned int		max_var_ref_idx;
-			struct hist_field	*max_var;
-			struct hist_field	*var;
-		} onmax;
+			struct hist_field	*var_ref;
+			unsigned int		var_ref_idx;
+
+			struct hist_field	*track_var;
+
+			check_track_val_fn_t	check_val;
+			save_track_val_fn_t	save_val;
+			get_track_val_fn_t	get_val;
+		} track_data;
 	};
 };
 
-
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
@@ -3122,10 +3135,10 @@ static void update_field_vars(struct hist_trigger_data *hist_data,
 			    hist_data->n_field_vars, 0);
 }
 
-static void update_max_vars(struct hist_trigger_data *hist_data,
-			    struct tracing_map_elt *elt,
-			    struct ring_buffer_event *rbe,
-			    void *rec)
+static void update_save_vars(struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt,
+			     struct ring_buffer_event *rbe,
+			     void *rec)
 {
 	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
 			    hist_data->n_save_vars, hist_data->n_field_var_str);
@@ -3263,15 +3276,68 @@ create_target_field_var(struct hist_trigger_data *target_hist_data,
 	return create_field_var(target_hist_data, file, var_name);
 }
 
-static void onmax_print(struct seq_file *m,
-			struct hist_trigger_data *hist_data,
-			struct tracing_map_elt *elt,
-			struct action_data *data)
+static bool check_track_val_max(u64 track_val, u64 var_val)
+{
+	if (var_val <= track_val)
+		return false;
+
+	return true;
+}
+
+static u64 get_track_val_local(struct hist_trigger_data *hist_data,
+			       struct tracing_map_elt *elt,
+			       struct action_data *data)
+{
+	unsigned int track_var_idx = data->track_data.track_var->var.idx;
+	u64 track_val;
+
+	track_val = tracing_map_read_var(elt, track_var_idx);
+
+	return track_val;
+}
+
+static bool save_track_val_local(struct hist_trigger_data *hist_data,
+				 struct tracing_map_elt *elt,
+				 struct action_data *data,
+				 unsigned int track_var_idx, u64 var_val)
+{
+	bool ret = false;
+	u64 track_val;
+
+	track_val = tracing_map_read_var(elt, track_var_idx);
+
+	if (data->track_data.check_val(track_val, var_val)) {
+		tracing_map_set_var(elt, track_var_idx, var_val);
+		ret = true;
+	}
+
+	return ret;
+}
+
+static bool update_track_val(struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt,
+			     struct action_data *data, u64 *var_ref_vals)
+{
+	unsigned int track_var_idx = data->track_data.track_var->var.idx;
+	unsigned int track_var_ref_idx = data->track_data.var_ref_idx;
+	u64 var_val;
+
+	var_val = var_ref_vals[track_var_ref_idx];
+
+	return data->track_data.save_val(hist_data, elt, data,
+					 track_var_idx, var_val);
+}
+
+static void track_data_print(struct seq_file *m,
+			     struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt,
+			     struct action_data *data)
 {
-	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
+	u64 track_val = data->track_data.get_val(hist_data, elt, data);
+	unsigned int i, save_var_idx;
 
 	if (data->handler == HANDLER_ONMAX)
-		seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+		seq_printf(m, "\n\tmax: %10llu", track_val);
 
 	for (i = 0; i < hist_data->n_save_vars; i++) {
 		struct hist_field *save_val = hist_data->save_vars[i]->val;
@@ -3290,66 +3356,58 @@ static void onmax_print(struct seq_file *m,
 	}
 }
 
-static void onmax_save(struct hist_trigger_data *hist_data,
-		       struct tracing_map_elt *elt, void *rec,
-		       struct ring_buffer_event *rbe,
-		       struct action_data *data, u64 *var_ref_vals)
+static void ontrack_save(struct hist_trigger_data *hist_data,
+			 struct tracing_map_elt *elt, void *rec,
+			 struct ring_buffer_event *rbe,
+			 struct action_data *data, u64 *var_ref_vals)
 {
-	unsigned int max_idx = data->onmax.max_var->var.idx;
-	unsigned int max_var_ref_idx = data->onmax.max_var_ref_idx;
-
-	u64 var_val, max_val;
-
-	var_val = var_ref_vals[max_var_ref_idx];
-	max_val = tracing_map_read_var(elt, max_idx);
-
-	if (var_val <= max_val)
-		return;
-
-	tracing_map_set_var(elt, max_idx, var_val);
-
-	update_max_vars(hist_data, elt, rbe, rec);
+	if (update_track_val(hist_data, elt, data, var_ref_vals))
+		update_save_vars(hist_data, elt, rbe, rec);
 }
 
-static void onmax_destroy(struct action_data *data)
+static void track_data_destroy(struct hist_trigger_data *hist_data,
+			       struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
+	destroy_hist_field(data->track_data.track_var, 0);
+	destroy_hist_field(data->track_data.var_ref, 0);
 
-	kfree(data->onmax.var_str);
+	kfree(data->track_data.var_str);
 	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
+	if (data->synth_event)
+		data->synth_event->ref--;
+
 	kfree(data);
 }
 
 static int action_create(struct hist_trigger_data *hist_data,
 			 struct action_data *data);
 
-static int onmax_create(struct hist_trigger_data *hist_data,
-			struct action_data *data)
+static int track_data_create(struct hist_trigger_data *hist_data,
+			     struct action_data *data)
 {
-	struct hist_field *var_field, *ref_field, *max_var = NULL;
+	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
 	unsigned int var_ref_idx = hist_data->n_var_refs;
-	char *onmax_var_str;
+	char *track_data_var_str;
 	unsigned long flags;
 	int ret = 0;
 
-	onmax_var_str = data->onmax.var_str;
-	if (onmax_var_str[0] != '$') {
-		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
+	track_data_var_str = data->track_data.var_str;
+	if (track_data_var_str[0] != '$') {
+		hist_err("For onmax(x), x must be a variable: ", track_data_var_str);
 		return -EINVAL;
 	}
-	onmax_var_str++;
+	track_data_var_str++;
 
-	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
+	var_field = find_target_event_var(hist_data, NULL, NULL, track_data_var_str);
 	if (!var_field) {
-		hist_err("onmax: Couldn't find onmax variable: ", onmax_var_str);
+		hist_err("Couldn't find onmax variable: ", track_data_var_str);
 		return -EINVAL;
 	}
 
@@ -3365,18 +3423,18 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	}
 	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
 	ref_field->var_ref_idx = hist_data->n_var_refs++;
-	data->onmax.var = ref_field;
+	data->track_data.var_ref = ref_field;
 
-	data->onmax.max_var_ref_idx = var_ref_idx;
+	data->track_data.var_ref_idx = var_ref_idx;
 
 	if (data->handler == HANDLER_ONMAX)
-		max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
-	if (IS_ERR(max_var)) {
-		hist_err("onmax: Couldn't create onmax variable: ", "max");
-		ret = PTR_ERR(max_var);
+		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
+	if (IS_ERR(track_var)) {
+		hist_err("Couldn't create onmax variable: ", "__max");
+		ret = PTR_ERR(track_var);
 		goto out;
 	}
-	data->onmax.max_var = max_var;
+	data->track_data.track_var = track_var;
 
 	ret = action_create(hist_data, data);
  out:
@@ -3453,8 +3511,13 @@ static int action_parse(char *str, struct action_data *data,
 		if (ret)
 			goto out;
 
-		if (handler == HANDLER_ONMAX)
-			data->fn = onmax_save;
+		if (handler == HANDLER_ONMAX) {
+			data->fn = ontrack_save;
+			data->track_data.check_val = check_track_val_max;
+		}
+
+		data->track_data.save_val = save_track_val_local;
+		data->track_data.get_val = get_track_val_local;
 
 		data->action = ACTION_SAVE;
 	} else {
@@ -3481,24 +3544,25 @@ static int action_parse(char *str, struct action_data *data,
 	return ret;
 }
 
-static struct action_data *onmax_parse(char *str, enum handler_id handler)
+static struct action_data *track_data_parse(struct hist_trigger_data *hist_data,
+					    char *str, enum handler_id handler)
 {
 	struct action_data *data;
-	char *onmax_var_str;
 	int ret = -EINVAL;
+	char *var_str;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	onmax_var_str = strsep(&str, ")");
-	if (!onmax_var_str || !str) {
+	var_str = strsep(&str, ")");
+	if (!var_str || !str) {
 		ret = -EINVAL;
 		goto free;
 	}
 
-	data->onmax.var_str = kstrdup(onmax_var_str, GFP_KERNEL);
-	if (!data->onmax.var_str) {
+	data->track_data.var_str = kstrdup(var_str, GFP_KERNEL);
+	if (!data->track_data.var_str) {
 		ret = -ENOMEM;
 		goto free;
 	}
@@ -3511,7 +3575,7 @@ static struct action_data *onmax_parse(char *str, enum handler_id handler)
  out:
 	return data;
  free:
-	onmax_destroy(data);
+	track_data_destroy(hist_data, data);
 	data = ERR_PTR(ret);
 	goto out;
 }
@@ -4313,7 +4377,7 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
 		else if (data->handler == HANDLER_ONMAX)
-			onmax_destroy(data);
+			track_data_destroy(hist_data, data);
 		else
 			kfree(data);
 	}
@@ -4341,7 +4405,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
 			char *action_str = str + strlen("onmax(");
 
-			data = onmax_parse(action_str, HANDLER_ONMAX);
+			data = track_data_parse(hist_data, action_str,
+						HANDLER_ONMAX);
 			if (IS_ERR(data)) {
 				ret = PTR_ERR(data);
 				break;
@@ -4371,7 +4436,7 @@ static int create_actions(struct hist_trigger_data *hist_data)
 			if (ret)
 				return ret;
 		} else if (data->handler == HANDLER_ONMAX) {
-			ret = onmax_create(hist_data, data);
+			ret = track_data_create(hist_data, data);
 			if (ret)
 				return ret;
 		} else {
@@ -4393,19 +4458,19 @@ static void print_actions(struct seq_file *m,
 		struct action_data *data = hist_data->actions[i];
 
 		if (data->handler == HANDLER_ONMAX)
-			onmax_print(m, hist_data, elt, data);
+			track_data_print(m, hist_data, elt, data);
 	}
 }
 
-static void print_onmax_spec(struct seq_file *m,
-			     struct hist_trigger_data *hist_data,
-			     struct action_data *data)
+static void print_track_data_spec(struct seq_file *m,
+				  struct hist_trigger_data *hist_data,
+				  struct action_data *data)
 {
 	unsigned int i;
 
 	if (data->handler == HANDLER_ONMAX)
 		seq_puts(m, ":onmax(");
-	seq_printf(m, "%s", data->onmax.var_str);
+	seq_printf(m, "%s", data->track_data.var_str);
 	seq_printf(m, ").%s(", data->action_name);
 
 	if (data->action == ACTION_SAVE) {
@@ -4477,8 +4542,8 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 				   data_test->match_data.event) != 0)
 				return false;
 		} else if (data->handler == HANDLER_ONMAX) {
-			if (strcmp(data->onmax.var_str,
-				   data_test->onmax.var_str) != 0)
+			if (strcmp(data->track_data.var_str,
+				   data_test->track_data.var_str) != 0)
 				return false;
 		}
 	}
@@ -4498,7 +4563,7 @@ static void print_actions_spec(struct seq_file *m,
 		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
 		else if (data->handler == HANDLER_ONMAX)
-			print_onmax_spec(m, hist_data, data);
+			print_track_data_spec(m, hist_data, data);
 	}
 }
 
-- 
2.14.1


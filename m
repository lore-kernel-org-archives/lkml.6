Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA65C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6949208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfG+ZoQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6949208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeHIQ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeHIQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:59:56 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A91921EA0;
        Thu,  9 Aug 2018 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533825285;
        bh=pYxQ0JpwMbcx1CqBAXTP4PgNJN34jmiYVz1L5uhIUwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=qfG+ZoQAhADFiwWMRZbGaI7ErzVI8zVzVpp4AHaWvqtEtaD03oDAmeSXbkZq8gvBQ
         TK35MBGOkIVzhMT5i0+LyNI6uHYexlJF2YjaI3LmRs1X49Y1U+ir1ZZYwfby3bjYox
         GEc+dJk/SdZz5ozX8oGXvR8C341c1yVNw3x0Zy8A=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v3 1/7] tracing: Refactor hist trigger action code
Date:   Thu,  9 Aug 2018 09:34:11 -0500
Message-Id: <9d8aaf30dc0c8d48885b0936a038ddd770a55caa.1533753152.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1533753152.git.tom.zanussi@linux.intel.com>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533753152.git.tom.zanussi@linux.intel.com>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The hist trigger action code currently implements two essentially
hard-coded pairs of 'actions' - onmax(), which tracks a variable and
saves some event fields when a max is hit, and onmatch(), which is
hard-coded to generate a synthetic event.

These hardcoded pairs (track max/save fields and detect match/generate
synthetic event) should really be decoupled into separate components
that can then be arbitrarily combined.  The first component of each
pair (track max/detect match) is called a 'handler' in the new code,
while the second component (save fields/generate synthetic event) is
called an 'action' in this scheme.

This change refactors the action code to reflect this split by adding
two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
actions, ACTION_SAVE and ACTION_TRACE.

The new code combines them to produce the existing ONMATCH/TRACE and
ONMAX/SAVE functionality, but doesn't implement the other combinations
now possible.  Future patches will expand these to further useful
cases, such as ONMAX/TRACE, as well as add additional handlers and
actions such as ONCHANGE and SNAPSHOT.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 402 +++++++++++++++++++++++----------------
 1 file changed, 239 insertions(+), 163 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index aae18af94c94..de7d6aca4def 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -296,9 +296,9 @@ struct hist_trigger_data {
 	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_var_hists;
 
-	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
-	unsigned int			n_max_vars;
-	unsigned int			n_max_var_str;
+	struct field_var		*save_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_save_vars;
+	unsigned int			n_save_var_str;
 };
 
 struct synth_field {
@@ -328,8 +328,22 @@ typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
 			     struct ring_buffer_event *rbe,
 			     struct action_data *data, u64 *var_ref_vals);
 
+enum handler_id {
+	HANDLER_ONMATCH = 1,
+	HANDLER_ONMAX,
+};
+
+enum action_id {
+	ACTION_SAVE = 1,
+	ACTION_TRACE,
+};
+
 struct action_data {
+	enum handler_id		handler;
+	enum action_id		action;
+	char			*action_name;
 	action_fn_t		fn;
+
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
@@ -338,13 +352,11 @@ struct action_data {
 			unsigned int		var_ref_idx;
 			char			*match_event;
 			char			*match_event_system;
-			char			*synth_event_name;
 			struct synth_event	*synth_event;
 		} onmatch;
 
 		struct {
 			char			*var_str;
-			char			*fn_name;
 			unsigned int		max_var_ref_idx;
 			struct hist_field	*max_var;
 			struct hist_field	*var;
@@ -1560,7 +1572,7 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
+		if (data->handler == HANDLER_ONMATCH) {
 			char *system = data->onmatch.match_event_system;
 			char *event_name = data->onmatch.match_event;
 
@@ -1992,7 +2004,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str;
 
 	size = STR_VAR_LEN_MAX;
 
@@ -2934,7 +2946,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err_event("onmatch: Too many field variables defined: ",
+		hist_err_event("trace action: Too many field variables defined: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -2942,7 +2954,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err_event("onmatch: Event file not found: ",
+		hist_err_event("trace action: Event file not found: ",
 			       subsys_name, event_name, field_name);
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
@@ -2956,7 +2968,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err_event("onmatch: Matching event histogram not found: ",
+		hist_err_event("trace action: Matching event histogram not found: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3018,7 +3030,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't create histogram for field: ",
+		hist_err_event("trace action: Couldn't create histogram for field: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(ret);
 	}
@@ -3031,7 +3043,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't find synthetic variable: ",
+		hist_err_event("trace action: Couldn't find synthetic variable: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3114,8 +3126,8 @@ static void update_max_vars(struct hist_trigger_data *hist_data,
 			    struct ring_buffer_event *rbe,
 			    void *rec)
 {
-	__update_field_vars(elt, rbe, rec, hist_data->max_vars,
-			    hist_data->n_max_vars, hist_data->n_field_var_str);
+	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
+			    hist_data->n_save_vars, hist_data->n_field_var_str);
 }
 
 static struct hist_field *create_var(struct hist_trigger_data *hist_data,
@@ -3257,11 +3269,12 @@ static void onmax_print(struct seq_file *m,
 {
 	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
 
-	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+	if (data->handler == HANDLER_ONMAX)
+		seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
 
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		struct hist_field *save_val = hist_data->max_vars[i]->val;
-		struct hist_field *save_var = hist_data->max_vars[i]->var;
+	for (i = 0; i < hist_data->n_save_vars; i++) {
+		struct hist_field *save_val = hist_data->save_vars[i]->val;
+		struct hist_field *save_var = hist_data->save_vars[i]->var;
 		u64 val;
 
 		save_var_idx = save_var->var.idx;
@@ -3305,7 +3318,7 @@ static void onmax_destroy(struct action_data *data)
 	destroy_hist_field(data->onmax.var, 0);
 
 	kfree(data->onmax.var_str);
-	kfree(data->onmax.fn_name);
+	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
@@ -3313,16 +3326,17 @@ static void onmax_destroy(struct action_data *data)
 	kfree(data);
 }
 
+static int action_create(struct hist_trigger_data *hist_data,
+			 struct action_data *data);
+
 static int onmax_create(struct hist_trigger_data *hist_data,
 			struct action_data *data)
 {
+	struct hist_field *var_field, *ref_field, *max_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
-	struct hist_field *var_field, *ref_field, *max_var;
 	unsigned int var_ref_idx = hist_data->n_var_refs;
-	struct field_var *field_var;
-	char *onmax_var_str, *param;
+	char *onmax_var_str;
 	unsigned long flags;
-	unsigned int i;
 	int ret = 0;
 
 	onmax_var_str = data->onmax.var_str;
@@ -3352,9 +3366,10 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->onmax.var = ref_field;
 
-	data->fn = onmax_save;
 	data->onmax.max_var_ref_idx = var_ref_idx;
-	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
+
+	if (data->handler == HANDLER_ONMAX)
+		max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
 	if (IS_ERR(max_var)) {
 		hist_err("onmax: Couldn't create onmax variable: ", "max");
 		ret = PTR_ERR(max_var);
@@ -3362,27 +3377,7 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	}
 	data->onmax.max_var = max_var;
 
-	for (i = 0; i < data->n_params; i++) {
-		param = kstrdup(data->params[i], GFP_KERNEL);
-		if (!param) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		field_var = create_target_field_var(hist_data, NULL, NULL, param);
-		if (IS_ERR(field_var)) {
-			hist_err("onmax: Couldn't create field variable: ", param);
-			ret = PTR_ERR(field_var);
-			kfree(param);
-			goto out;
-		}
-
-		hist_data->max_vars[hist_data->n_max_vars++] = field_var;
-		if (field_var->val->flags & HIST_FIELD_FL_STRING)
-			hist_data->n_max_var_str++;
-
-		kfree(param);
-	}
+	ret = action_create(hist_data, data);
  out:
 	return ret;
 }
@@ -3393,11 +3388,14 @@ static int parse_action_params(char *params, struct action_data *data)
 	int ret = 0;
 
 	while (params) {
-		if (data->n_params >= SYNTH_FIELDS_MAX)
+		if (data->n_params >= SYNTH_FIELDS_MAX) {
+			hist_err("Too many action params", "");
 			goto out;
+		}
 
 		param = strsep(&params, ",");
 		if (!param) {
+			hist_err("No action param found", "");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3421,10 +3419,69 @@ static int parse_action_params(char *params, struct action_data *data)
 	return ret;
 }
 
-static struct action_data *onmax_parse(char *str)
+static int action_parse(char *str, struct action_data *data,
+			enum handler_id handler)
+{
+	char *action_name;
+	int ret = 0;
+
+	strsep(&str, ".");
+	if (!str) {
+		hist_err("action parsing: No action found", "");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	action_name = strsep(&str, "(");
+	if (!action_name || !str) {
+		hist_err("action parsing: No action found", "");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (strncmp(action_name, "save", strlen("save")) == 0) {
+		char *params = strsep(&str, ")");
+
+		if (!params) {
+			hist_err("action parsing: No params found for %s", "save");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = parse_action_params(params, data);
+		if (ret)
+			goto out;
+
+		if (handler == HANDLER_ONMAX)
+			data->fn = onmax_save;
+
+		data->action = ACTION_SAVE;
+	} else {
+		char *params = strsep(&str, ")");
+
+		if (params) {
+			ret = parse_action_params(params, data);
+			if (ret)
+				goto out;
+		}
+
+		data->fn = action_trace;
+		data->action = ACTION_TRACE;
+	}
+
+	data->action_name = kstrdup(action_name, GFP_KERNEL);
+	if (!data->action_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+ out:
+	return ret;
+}
+
+static struct action_data *onmax_parse(char *str, enum handler_id handler)
 {
-	char *onmax_fn_name, *onmax_var_str;
 	struct action_data *data;
+	char *onmax_var_str;
 	int ret = -EINVAL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -3443,33 +3500,11 @@ static struct action_data *onmax_parse(char *str)
 		goto free;
 	}
 
-	strsep(&str, ".");
-	if (!str)
-		goto free;
-
-	onmax_fn_name = strsep(&str, "(");
-	if (!onmax_fn_name || !str)
-		goto free;
-
-	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
-		char *params = strsep(&str, ")");
-
-		if (!params) {
-			ret = -EINVAL;
-			goto free;
-		}
-
-		ret = parse_action_params(params, data);
-		if (ret)
-			goto free;
-	} else
+	ret = action_parse(str, data, handler);
+	if (ret)
 		goto free;
 
-	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
-	if (!data->onmax.fn_name) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	data->handler = handler;
  out:
 	return data;
  free:
@@ -3486,7 +3521,7 @@ static void onmatch_destroy(struct action_data *data)
 
 	kfree(data->onmatch.match_event);
 	kfree(data->onmatch.match_event_system);
-	kfree(data->onmatch.synth_event_name);
+	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
@@ -3563,8 +3598,9 @@ static int check_synth_field(struct synth_event *event,
 }
 
 static struct hist_field *
-onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
-		 char *system, char *event, char *var)
+trace_action_find_var(struct hist_trigger_data *hist_data,
+		      struct action_data *data,
+		      char *system, char *event, char *var)
 {
 	struct hist_field *hist_field;
 
@@ -3572,7 +3608,7 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
-		if (!system) {
+		if (!system && data->handler == HANDLER_ONMATCH) {
 			system = data->onmatch.match_event_system;
 			event = data->onmatch.match_event;
 		}
@@ -3581,15 +3617,15 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 	}
 
 	if (!hist_field)
-		hist_err_event("onmatch: Couldn't find onmatch param: $", system, event, var);
+		hist_err_event("trace action: Couldn't find param: $", system, event, var);
 
 	return hist_field;
 }
 
 static struct hist_field *
-onmatch_create_field_var(struct hist_trigger_data *hist_data,
-			 struct action_data *data, char *system,
-			 char *event, char *var)
+trace_action_create_field_var(struct hist_trigger_data *hist_data,
+			      struct action_data *data, char *system,
+			      char *event, char *var)
 {
 	struct hist_field *hist_field = NULL;
 	struct field_var *field_var;
@@ -3612,7 +3648,7 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 		 * looking for fields on the onmatch(system.event.xxx)
 		 * event.
 		 */
-		if (!system) {
+		if (!system && data->handler == HANDLER_ONMATCH) {
 			system = data->onmatch.match_event_system;
 			event = data->onmatch.match_event;
 		}
@@ -3636,9 +3672,8 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 	goto out;
 }
 
-static int onmatch_create(struct hist_trigger_data *hist_data,
-			  struct trace_event_file *file,
-			  struct action_data *data)
+static int trace_action_create(struct hist_trigger_data *hist_data,
+			       struct action_data *data)
 {
 	char *event_name, *param, *system = NULL;
 	struct hist_field *hist_field, *var_ref;
@@ -3648,12 +3683,14 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	int ret = 0;
 
 	mutex_lock(&synth_event_mutex);
-	event = find_synth_event(data->onmatch.synth_event_name);
+
+	event = find_synth_event(data->action_name);
 	if (!event) {
-		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
+		hist_err("trace action: Couldn't find synthetic event: ", data->action_name);
 		mutex_unlock(&synth_event_mutex);
 		return -EINVAL;
 	}
+
 	event->ref++;
 	mutex_unlock(&synth_event_mutex);
 
@@ -3682,13 +3719,15 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (param[0] == '$')
-			hist_field = onmatch_find_var(hist_data, data, system,
-						      event_name, param);
+			hist_field = trace_action_find_var(hist_data, data,
+							   system, event_name,
+							   param);
 		else
-			hist_field = onmatch_create_field_var(hist_data, data,
-							      system,
-							      event_name,
-							      param);
+			hist_field = trace_action_create_field_var(hist_data,
+								   data,
+								   system,
+								   event_name,
+								   param);
 
 		if (!hist_field) {
 			kfree(p);
@@ -3710,7 +3749,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
+		hist_err_event("trace action: Param type doesn't match synthetic event field type: ",
 			       system, event_name, param);
 		kfree(p);
 		ret = -EINVAL;
@@ -3718,12 +3757,11 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		hist_err("trace action: Param count doesn't match synthetic event field count: ", event->name);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	data->fn = action_trace;
 	data->onmatch.synth_event = event;
 	data->onmatch.var_ref_idx = var_ref_idx;
  out:
@@ -3736,10 +3774,60 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	goto out;
 }
 
+static int action_create(struct hist_trigger_data *hist_data,
+			 struct action_data *data)
+{
+	struct field_var *field_var;
+	unsigned int i;
+	char *param;
+	int ret = 0;
+
+	if (data->action == ACTION_TRACE) {
+		ret = trace_action_create(hist_data, data);
+		goto out;
+	}
+
+	if (data->action == ACTION_SAVE) {
+		if (hist_data->n_save_vars) {
+			ret = -EINVAL;
+			hist_err("save action: Can't have more than one save() action per hist", "");
+			goto out;
+		}
+
+		for (i = 0; i < data->n_params; i++) {
+			param = kstrdup(data->params[i], GFP_KERNEL);
+			if (!param) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			field_var = create_target_field_var(hist_data, NULL, NULL, param);
+			if (IS_ERR(field_var)) {
+				hist_err("save action: Couldn't create field variable: ", param);
+				ret = PTR_ERR(field_var);
+				kfree(param);
+				goto out;
+			}
+
+			hist_data->save_vars[hist_data->n_save_vars++] = field_var;
+			if (field_var->val->flags & HIST_FIELD_FL_STRING)
+				hist_data->n_save_var_str++;
+			kfree(param);
+		}
+	}
+ out:
+	return ret;
+}
+
+static int onmatch_create(struct hist_trigger_data *hist_data,
+			  struct action_data *data)
+{
+	return action_create(hist_data, data);
+}
+
 static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 {
 	char *match_event, *match_event_system;
-	char *synth_event_name, *params;
 	struct action_data *data;
 	int ret = -EINVAL;
 
@@ -3777,33 +3865,11 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	strsep(&str, ".");
-	if (!str) {
-		hist_err("onmatch: Missing . after onmatch(): ", str);
-		goto free;
-	}
-
-	synth_event_name = strsep(&str, "(");
-	if (!synth_event_name || !str) {
-		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
-		goto free;
-	}
-
-	data->onmatch.synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
-	if (!data->onmatch.synth_event_name) {
-		ret = -ENOMEM;
-		goto free;
-	}
-
-	params = strsep(&str, ")");
-	if (!params || !str || (str && strlen(str))) {
-		hist_err("onmatch: Missing closing paramlist paren: ", params);
-		goto free;
-	}
-
-	ret = parse_action_params(params, data);
+	ret = action_parse(str, data, HANDLER_ONMATCH);
 	if (ret)
 		goto free;
+
+	data->handler = HANDLER_ONMATCH;
  out:
 	return data;
  free:
@@ -4241,9 +4307,9 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->fn == onmax_save)
+		else if (data->handler == HANDLER_ONMAX)
 			onmax_destroy(data);
 		else
 			kfree(data);
@@ -4269,16 +4335,14 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = action_trace;
 		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
 			char *action_str = str + strlen("onmax(");
 
-			data = onmax_parse(action_str);
+			data = onmax_parse(action_str, HANDLER_ONMAX);
 			if (IS_ERR(data)) {
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = onmax_save;
 		} else {
 			ret = -EINVAL;
 			break;
@@ -4290,8 +4354,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	return ret;
 }
 
-static int create_actions(struct hist_trigger_data *hist_data,
-			  struct trace_event_file *file)
+static int create_actions(struct hist_trigger_data *hist_data)
 {
 	struct action_data *data;
 	unsigned int i;
@@ -4300,14 +4363,17 @@ static int create_actions(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
-			ret = onmatch_create(hist_data, file, data);
+		if (data->handler == HANDLER_ONMATCH) {
+			ret = onmatch_create(hist_data, data);
 			if (ret)
 				return ret;
-		} else if (data->fn == onmax_save) {
+		} else if (data->handler == HANDLER_ONMAX) {
 			ret = onmax_create(hist_data, data);
 			if (ret)
 				return ret;
+		} else {
+			ret = -EINVAL;
+			break;
 		}
 	}
 
@@ -4323,26 +4389,43 @@ static void print_actions(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == onmax_save)
+		if (data->handler == HANDLER_ONMAX)
 			onmax_print(m, hist_data, elt, data);
 	}
 }
 
+static void print_action_spec(struct seq_file *m,
+			      struct hist_trigger_data *hist_data,
+			      struct action_data *data)
+{
+	unsigned int i;
+
+	if (data->action == ACTION_SAVE) {
+		for (i = 0; i < hist_data->n_save_vars; i++) {
+			seq_printf(m, "%s", hist_data->save_vars[i]->var->var.name);
+			if (i < hist_data->n_save_vars - 1)
+				seq_puts(m, ",");
+		}
+	} else if (data->action == ACTION_TRACE) {
+		for (i = 0; i < data->n_params; i++) {
+			if (i)
+				seq_puts(m, ",");
+			seq_printf(m, "%s", data->params[i]);
+		}
+	}
+}
+
 static void print_onmax_spec(struct seq_file *m,
 			     struct hist_trigger_data *hist_data,
 			     struct action_data *data)
 {
-	unsigned int i;
-
-	seq_puts(m, ":onmax(");
+	if (data->handler == HANDLER_ONMAX)
+		seq_puts(m, ":onmax(");
 	seq_printf(m, "%s", data->onmax.var_str);
-	seq_printf(m, ").%s(", data->onmax.fn_name);
+	seq_printf(m, ").%s(", data->action_name);
+
+	print_action_spec(m, hist_data, data);
 
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
-		if (i < hist_data->n_max_vars - 1)
-			seq_puts(m, ",");
-	}
 	seq_puts(m, ")");
 }
 
@@ -4350,18 +4433,12 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	unsigned int i;
-
 	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
 		   data->onmatch.match_event);
 
-	seq_printf(m, "%s(", data->onmatch.synth_event->name);
+	seq_printf(m, "%s(", data->action_name);
 
-	for (i = 0; i < data->n_params; i++) {
-		if (i)
-			seq_puts(m, ",");
-		seq_printf(m, "%s", data->params[i]);
-	}
+	print_action_spec(m, hist_data, data);
 
 	seq_puts(m, ")");
 }
@@ -4378,7 +4455,9 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
 
-		if (data->fn != data_test->fn)
+		if (data->handler != data_test->handler)
+			return false;
+		if (data->action != data_test->action)
 			return false;
 
 		if (data->n_params != data_test->n_params)
@@ -4389,23 +4468,20 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 				return false;
 		}
 
-		if (data->fn == action_trace) {
-			if (strcmp(data->onmatch.synth_event_name,
-				   data_test->onmatch.synth_event_name) != 0)
-				return false;
+		if (strcmp(data->action_name, data_test->action_name) != 0)
+			return false;
+
+		if (data->handler == HANDLER_ONMATCH) {
 			if (strcmp(data->onmatch.match_event_system,
 				   data_test->onmatch.match_event_system) != 0)
 				return false;
 			if (strcmp(data->onmatch.match_event,
 				   data_test->onmatch.match_event) != 0)
 				return false;
-		} else if (data->fn == onmax_save) {
+		} else if (data->handler == HANDLER_ONMAX) {
 			if (strcmp(data->onmax.var_str,
 				   data_test->onmax.var_str) != 0)
 				return false;
-			if (strcmp(data->onmax.fn_name,
-				   data_test->onmax.fn_name) != 0)
-				return false;
 		}
 	}
 
@@ -4421,9 +4497,9 @@ static void print_actions_spec(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
-		else if (data->fn == onmax_save)
+		else if (data->handler == HANDLER_ONMAX)
 			print_onmax_spec(m, hist_data, data);
 	}
 }
@@ -5600,7 +5676,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (has_hist_vars(hist_data))
 		save_hist_vars(hist_data);
 
-	ret = create_actions(hist_data, file);
+	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
-- 
2.14.1


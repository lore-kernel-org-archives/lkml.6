Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeDLPNr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:13:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:42207 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754128AbeDLPNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="32178226"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 4/6] tracing: Use trace event error_log with hist triggers
Date: Thu, 12 Apr 2018 10:13:19 -0500
Message-Id: <69acf74eaaa7feeab830720a294324b39dd0d311.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hist_err() and hist_err_event() with event_log_err() from the
new trace event error_log mechanism.

Also add a couple related helper functions and remove most of the old
hist_err()-related code.

With this change, users no longer read the hist files for hist trigger
error information, but instead look at the tracing/events/error_log
for the same information.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 161 ++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 95 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4a42df4..08424ff 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -355,7 +355,26 @@ struct action_data {
 
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char last_hist_cmd_event[MAX_FILTER_STR_VAL];
-static char hist_err_str[MAX_FILTER_STR_VAL];
+
+#define log_err(fmt, ...)			\
+	event_log_err(last_hist_cmd_event, last_hist_cmd, fmt, ##__VA_ARGS__)
+
+static char *fqvar(char *system, char *event_name, char *var_name, bool ref)
+{
+	static char fqvar[MAX_FILTER_STR_VAL];
+	char *fmt = ref ? "%s.%s.$%s" : "%s.%s.%s";
+
+	if (system && event_name && var_name) {
+		fmt = ref ? "%s.%s.$%s" : "%s.%s.%s";
+		snprintf(fqvar, MAX_FILTER_STR_VAL, fmt, system, event_name);
+	} else if (var_name) {
+		fmt = ref ? "$%s" : "%s";
+		snprintf(fqvar, MAX_FILTER_STR_VAL, fmt, var_name);
+	} else
+		return NULL;
+
+	return fqvar;
+}
 
 static void last_cmd_set(struct trace_event_file *file, char *str)
 {
@@ -382,55 +401,12 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 		snprintf(last_hist_cmd_event, MAX_FILTER_STR_VAL, "%s:%s", system, name);
 }
 
-static void hist_err(char *str, char *var)
-{
-	int maxlen = MAX_FILTER_STR_VAL - 1;
-
-	if (!str)
-		return;
-
-	if (strlen(hist_err_str))
-		return;
-
-	if (!var)
-		var = "";
-
-	if (strlen(hist_err_str) + strlen(str) + strlen(var) > maxlen)
-		return;
-
-	strcat(hist_err_str, str);
-	strcat(hist_err_str, var);
-}
-
-static void hist_err_event(char *str, char *system, char *event, char *var)
-{
-	char err[MAX_FILTER_STR_VAL];
-
-	if (system && var)
-		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s.%s", system, event, var);
-	else if (system)
-		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
-	else
-		strncpy(err, var, MAX_FILTER_STR_VAL);
-
-	hist_err(str, err);
-}
-
 static void hist_err_clear(void)
 {
-	hist_err_str[0] = '\0';
 	last_hist_cmd[0] = '\0';
 	last_hist_cmd_event[0] = '\0';
 }
 
-static bool have_hist_err(void)
-{
-	if (strlen(hist_err_str))
-		return true;
-
-	return false;
-}
-
 static LIST_HEAD(synth_event_list);
 static DEFINE_MUTEX(synth_event_mutex);
 
@@ -1539,7 +1515,7 @@ static struct trace_event_file *find_var_file(struct trace_array *tr,
 
 		if (find_var_field(var_hist_data, var_name)) {
 			if (found) {
-				hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+				log_err("Variable name not unique, need to use fully qualified name (%s) for variable: ", fqvar(system, event_name, var_name, true));
 				return NULL;
 			}
 
@@ -1590,7 +1566,7 @@ static struct hist_field *find_file_var(struct trace_event_file *file,
 			hist_field = find_file_var(file, var_name);
 			if (hist_field) {
 				if (found) {
-					hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+					log_err("Variable name not unique, need to use fully qualified name (%s) for variable: ", fqvar(system, event_name, var_name, true));
 					return ERR_PTR(-EINVAL);
 				}
 
@@ -1887,7 +1863,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 		char *assignment;
 
 		if (attrs->n_assignments == TRACING_MAP_VARS_MAX) {
-			hist_err("Too many variables defined: ", str);
+			log_err("Too many variables defined: %s", str);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2451,8 +2427,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 		ref_field = create_var_ref(var_field, system, event_name);
 
 	if (!ref_field)
-		hist_err_event("Couldn't find variable: $",
-			       system, event_name, var_name);
+		log_err("Couldn't find variable: %s", fqvar(system, event_name, var_name, true));
 
 	return ref_field;
 }
@@ -2613,7 +2588,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	/* we support only -(xxx) i.e. explicit parens required */
 
 	if (level > 3) {
-		hist_err("Too many subexpressions (3 max): ", str);
+		log_err("Too many subexpressions (3 max): %s", str);
 		ret = -EINVAL;
 		goto free;
 	}
@@ -2696,7 +2671,7 @@ static int check_expr_operands(struct hist_field *operand1,
 
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
 	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS)) {
-		hist_err("Timestamp units in expression don't match", NULL);
+		log_err("Timestamp units in expression don't match");
 		return -EINVAL;
 	}
 
@@ -2714,7 +2689,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	char *sep, *operand1_str;
 
 	if (level > 3) {
-		hist_err("Too many subexpressions (3 max): ", str);
+		log_err("Too many subexpressions (3 max): %s", str);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -2952,16 +2927,16 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err_event("onmatch: Too many field variables defined: ",
-			       subsys_name, event_name, field_name);
+		log_err("onmatch: Too many field variables defined: %s",
+			fqvar(subsys_name, event_name, field_name, false));
 		return ERR_PTR(-EINVAL);
 	}
 
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err_event("onmatch: Event file not found: ",
-			       subsys_name, event_name, field_name);
+		log_err("onmatch: Event file not found: %s",
+			fqvar(subsys_name, event_name, field_name, false));
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
 	}
@@ -2974,8 +2949,8 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err_event("onmatch: Matching event histogram not found: ",
-			       subsys_name, event_name, field_name);
+		log_err("onmatch: Matching event histogram not found: %s",
+			fqvar(subsys_name, event_name, field_name, false));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3036,8 +3011,8 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't create histogram for field: ",
-			       subsys_name, event_name, field_name);
+		log_err("onmatch: Couldn't create histogram for field: %s",
+			fqvar(subsys_name, event_name, field_name, false));
 		return ERR_PTR(ret);
 	}
 
@@ -3049,8 +3024,8 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't find synthetic variable: ",
-			       subsys_name, event_name, field_name);
+		log_err("onmatch: Couldn't find synthetic variable: %s",
+			fqvar(subsys_name, event_name, field_name, false));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3187,21 +3162,21 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	int ret = 0;
 
 	if (hist_data->n_field_vars >= SYNTH_FIELDS_MAX) {
-		hist_err("Too many field variables defined: ", field_name);
+		log_err("Too many field variables defined: %s", field_name);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	val = parse_atom(hist_data, file, field_name, &flags, NULL);
 	if (IS_ERR(val)) {
-		hist_err("Couldn't parse field variable: ", field_name);
+		log_err("Couldn't parse field variable: %s", field_name);
 		ret = PTR_ERR(val);
 		goto err;
 	}
 
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
-		hist_err("Couldn't create or find variable: ", field_name);
+		log_err("Couldn't create or find variable: %s", field_name);
 		kfree(val);
 		ret = PTR_ERR(var);
 		goto err;
@@ -3345,14 +3320,14 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 
 	onmax_var_str = data->onmax.var_str;
 	if (onmax_var_str[0] != '$') {
-		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
+		log_err("onmax: For onmax(x), x must be a variable: %s", onmax_var_str);
 		return -EINVAL;
 	}
 	onmax_var_str++;
 
 	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
 	if (!var_field) {
-		hist_err("onmax: Couldn't find onmax variable: ", onmax_var_str);
+		log_err("onmax: Couldn't find onmax variable: %s", onmax_var_str);
 		return -EINVAL;
 	}
 
@@ -3374,7 +3349,7 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	data->onmax.max_var_ref_idx = var_ref_idx;
 	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
 	if (IS_ERR(max_var)) {
-		hist_err("onmax: Couldn't create onmax variable: ", "max");
+		log_err("onmax: Couldn't create onmax variable: max");
 		ret = PTR_ERR(max_var);
 		goto out;
 	}
@@ -3389,7 +3364,7 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 
 		field_var = create_target_field_var(hist_data, NULL, NULL, param);
 		if (IS_ERR(field_var)) {
-			hist_err("onmax: Couldn't create field variable: ", param);
+			log_err("onmax: Couldn't create field variable: %s", param);
 			ret = PTR_ERR(field_var);
 			kfree(param);
 			goto out;
@@ -3422,7 +3397,7 @@ static int parse_action_params(char *params, struct action_data *data)
 
 		param = strstrip(param);
 		if (strlen(param) < 2) {
-			hist_err("Invalid action param: ", param);
+			log_err("Invalid action param: %s", param);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3599,7 +3574,8 @@ static int check_synth_field(struct synth_event *event,
 	}
 
 	if (!hist_field)
-		hist_err_event("onmatch: Couldn't find onmatch param: $", system, event, var);
+		log_err("onmatch: Couldn't find onmatch param: %s",
+			fqvar(system, event, var, true));
 
 	return hist_field;
 }
@@ -3668,7 +3644,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	mutex_lock(&synth_event_mutex);
 	event = find_synth_event(data->onmatch.synth_event_name);
 	if (!event) {
-		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
+		log_err("onmatch: Couldn't find synthetic event: %s", data->onmatch.synth_event_name);
 		mutex_unlock(&synth_event_mutex);
 		return -EINVAL;
 	}
@@ -3728,15 +3704,15 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
-			       system, event_name, param);
+		log_err("onmatch: Param type doesn't match synthetic event field type: %s",
+			fqvar(system, event_name, param, false));
 		kfree(p);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		log_err("onmatch: Param count doesn't match synthetic event field count: %s", event->name);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -3767,19 +3743,19 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 
 	match_event = strsep(&str, ")");
 	if (!match_event || !str) {
-		hist_err("onmatch: Missing closing paren: ", match_event);
+		log_err("onmatch: Missing closing paren: %s", match_event);
 		goto free;
 	}
 
 	match_event_system = strsep(&match_event, ".");
 	if (!match_event) {
-		hist_err("onmatch: Missing subsystem for match event: ", match_event_system);
+		log_err("onmatch: Missing subsystem for match event: %s", match_event_system);
 		goto free;
 	}
 
 	if (IS_ERR(event_file(tr, match_event_system, match_event))) {
-		hist_err_event("onmatch: Invalid subsystem or event name: ",
-			       match_event_system, match_event, NULL);
+		log_err("onmatch: Invalid subsystem or event name: %s.%s",
+			match_event_system, match_event);
 		goto free;
 	}
 
@@ -3797,13 +3773,13 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 
 	strsep(&str, ".");
 	if (!str) {
-		hist_err("onmatch: Missing . after onmatch(): ", str);
+		log_err("onmatch: Missing . after onmatch(): %s", str);
 		goto free;
 	}
 
 	synth_event_name = strsep(&str, "(");
 	if (!synth_event_name || !str) {
-		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
+		log_err("onmatch: Missing opening paramlist paren: %s", synth_event_name);
 		goto free;
 	}
 
@@ -3815,7 +3791,7 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 
 	params = strsep(&str, ")");
 	if (!params || !str || (str && strlen(str))) {
-		hist_err("onmatch: Missing closing paramlist paren: ", params);
+		log_err("onmatch: Missing closing paramlist paren: %s", params);
 		goto free;
 	}
 
@@ -3894,7 +3870,7 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 		return -EINVAL;
 
 	if (find_var(hist_data, file, var_name) && !hist_data->remove) {
-		hist_err("Variable already defined: ", var_name);
+		log_err("Variable already defined: %s", var_name);
 		return -EINVAL;
 	}
 
@@ -3975,7 +3951,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-			hist_err("Using variable references as keys not supported: ", field_str);
+			log_err("Using variable references as keys not supported: %s", field_str);
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
@@ -4089,13 +4065,13 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			var_name = strsep(&field_str, "=");
 			if (!var_name || !field_str) {
-				hist_err("Malformed assignment: ", var_name);
+				log_err("Malformed assignment: %s", var_name);
 				ret = -EINVAL;
 				goto free;
 			}
 
 			if (n_vars == TRACING_MAP_VARS_MAX) {
-				hist_err("Too many variables defined: ", var_name);
+				log_err("Too many variables defined: %s", var_name);
 				ret = -EINVAL;
 				goto free;
 			}
@@ -4894,11 +4870,6 @@ static int hist_show(struct seq_file *m, void *v)
 			hist_trigger_show(m, data, n++);
 	}
 
-	if (have_hist_err()) {
-		seq_printf(m, "\nERROR: %s\n", hist_err_str);
-		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
-	}
-
  out_unlock:
 	mutex_unlock(&event_mutex);
 
@@ -5270,7 +5241,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		if (named_data) {
 			if (!hist_trigger_match(data, named_data, named_data,
 						true)) {
-				hist_err("Named hist trigger doesn't match existing named trigger (includes variables): ", hist_data->attrs->name);
+				log_err("Named hist trigger doesn't match existing named trigger (includes variables): %s", hist_data->attrs->name);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -5291,7 +5262,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			else if (hist_data->attrs->clear)
 				hist_clear(test);
 			else {
-				hist_err("Hist trigger already exists", NULL);
+				log_err("Hist trigger already exists");
 				ret = -EEXIST;
 			}
 			goto out;
@@ -5299,7 +5270,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	}
  new:
 	if (hist_data->attrs->cont || hist_data->attrs->clear) {
-		hist_err("Can't clear or continue a nonexistent hist trigger", NULL);
+		log_err("Can't clear or continue a nonexistent hist trigger");
 		ret = -ENOENT;
 		goto out;
 	}
@@ -5324,7 +5295,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 
 		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
 		if (ret) {
-			hist_err("Couldn't set trace_clock: ", clock);
+			log_err("Couldn't set trace_clock: %s", clock);
 			goto out;
 		}
 
-- 
1.9.3

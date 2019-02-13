Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7386222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081907;
	bh=yVJMhe/OwrXcZmEvvWkuGj3hS3rnt633e/6qOpqIwjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=N6ofe/GMzkUddbrpRoD/XOUiSBhFdGL5bElmYTIGLvU6u0hF8mL73qblaWdDwD8Sc
	 TyNfvD84gkaFFUYQeYstVA5RHjRZJiHVfx/dIFLLAYg+HnzHIE0PI9WeLMbAduzd+X
	 R5+3t9WPPvOXuQbucJz27KVou+YrMni5zMvRCPIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404908AbfBMSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393681AbfBMSSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:18:09 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2030222CF;
        Wed, 13 Feb 2019 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081887;
        bh=yVJMhe/OwrXcZmEvvWkuGj3hS3rnt633e/6qOpqIwjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PBW2xzpbm/UvMcyQjoP20vDZJ0t6UiEh2U7jUxcBRDDv9/R8MVYfgVYkUVOttNYVT
         RHC9xv5cGv0zVVxoR5osNqlTfPL1Aa1rNFnKTG7XpuoV4H36wmoh2GxXBKvAOKirLl
         S/Rh8jxpS1SXqHUTAOA54EqSm3JiJcuf0/0I56BU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 3/5] tracing: Use tracing error_log with hist triggers
Date:   Wed, 13 Feb 2019 12:17:54 -0600
Message-Id: <4349843aec6ea715f79068b557c3e02a74162bb1.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Replace hist_err() and hist_err_event() with tracing_log_err() from
the new tracing error_log mechanism.

Also add a couple related helper functions and remove most of the old
hist_err()-related code.

With this change, users no longer read the hist files for hist trigger
error information, but instead look at tracing/error_log for the same
information.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 206 ++++++++++++++++++++-------------------
 1 file changed, 104 insertions(+), 102 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 3e8addebc7be..b19af8f94522 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -22,6 +22,57 @@
 
 #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
 
+#define ERRORS								\
+	C(NONE,			"No error"),				\
+	C(DUPLICATE_VAR,	"Variable already defined"),		\
+	C(VAR_NOT_UNIQUE,	"Variable name not unique, need to use fully qualified name (subsys.event.var) for variable"), \
+	C(TOO_MANY_VARS,	"Too many variables defined"),		\
+	C(MALFORMED_ASSIGNMENT,	"Malformed assignment"),		\
+	C(NAMED_MISMATCH,	"Named hist trigger doesn't match existing named trigger (includes variables)"), \
+	C(TRIGGER_EEXIST,	"Hist trigger already exists"),		\
+	C(TRIGGER_ENOENT_CLEAR,	"Can't clear or continue a nonexistent hist trigger"), \
+	C(SET_CLOCK_FAIL,	"Couldn't set trace_clock"),		\
+	C(BAD_FIELD_MODIFIER,	"Invalid field modifier"),		\
+	C(TOO_MANY_SUBEXPR,	"Too many subexpressions (3 max)"),	\
+	C(TIMESTAMP_MISMATCH,	"Timestamp units in expression don't match"), \
+	C(TOO_MANY_FIELD_VARS,	"Too many field variables defined"),	\
+	C(EVENT_FILE_NOT_FOUND,	"Event file not found"),		\
+	C(HIST_NOT_FOUND,	"Matching event histogram not found"),	\
+	C(HIST_CREATE_FAIL,	"Couldn't create histogram for field"),	\
+	C(SYNTH_VAR_NOT_FOUND,	"Couldn't find synthetic variable"),	\
+	C(SYNTH_EVENT_NOT_FOUND,"Couldn't find synthetic event"),	\
+	C(SYNTH_TYPE_MISMATCH,	"Param type doesn't match synthetic event field type"), \
+	C(SYNTH_COUNT_MISMATCH,	"Param count doesn't match synthetic event field count"), \
+	C(FIELD_VAR_PARSE_FAIL,	"Couldn't parse field variable"),	\
+	C(VAR_CREATE_FIND_FAIL,	"Couldn't create or find variable"),	\
+	C(ONX_NOT_VAR,		"For onmax(x) or onchange(x), x must be a variable"), \
+	C(ONX_VAR_NOT_FOUND,	"Couldn't find onmax or onchange variable"), \
+	C(ONX_VAR_CREATE_FAIL,	"Couldn't create onmax or onchange variable"), \
+	C(FIELD_VAR_CREATE_FAIL,"Couldn't create field variable"),	\
+	C(TOO_MANY_PARAMS,	"Too many action params"),		\
+	C(PARAM_NOT_FOUND,	"Couldn't find param"),			\
+	C(INVALID_PARAM,	"Invalid action param"),		\
+	C(ACTION_NOT_FOUND,	"No action found"),			\
+	C(NO_SAVE_PARAMS,	"No params found for save()"),		\
+	C(TOO_MANY_SAVE_ACTIONS,"Can't have more than one save() action per hist"), \
+	C(ACTION_MISMATCH,	"Handler doesn't support action"),	\
+	C(NO_CLOSING_PAREN,	"No closing paren found"),		\
+	C(SUBSYS_NOT_FOUND,	"Missing subsystem"),			\
+	C(INVALID_SUBSYS_EVENT,	"Invalid subsystem or event name"),	\
+	C(INVALID_REF_KEY,	"Using variable references as keys not supported"), \
+	C(VAR_NOT_FOUND,	"Couldn't find variable"),		\
+	C(FIELD_NOT_FOUND,	"Couldn't find field"),
+
+#undef C
+#define C(a, b)		HIST_ERR_##a
+
+enum { ERRORS };
+
+#undef C
+#define C(a, b)		b
+
+static const char *err_text[] = { ERRORS };
+
 struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
@@ -539,7 +590,10 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 static char last_cmd[MAX_FILTER_STR_VAL];
 static char last_cmd_loc[MAX_FILTER_STR_VAL];
 
-static char hist_err_str[MAX_FILTER_STR_VAL];
+static int errpos(char *str)
+{
+	return err_pos(last_cmd, str);
+}
 
 static void last_cmd_set(struct trace_event_file *file, char *str)
 {
@@ -566,55 +620,17 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
 }
 
-static void hist_err(char *str, char *var)
+static void hist_err(u8 err_type, u8 err_pos)
 {
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
-		strscpy(err, var, MAX_FILTER_STR_VAL);
-
-	hist_err(str, err);
+	tracing_log_err(last_cmd_loc, last_cmd, err_text, err_type, err_pos);
 }
 
 static void hist_err_clear(void)
 {
-	hist_err_str[0] = '\0';
 	last_cmd[0] = '\0';
 	last_cmd_loc[0] = '\0';
 }
 
-static bool have_hist_err(void)
-{
-	if (strlen(hist_err_str))
-		return true;
-
-	return false;
-}
-
 struct synth_trace_event {
 	struct trace_entry	ent;
 	u64			fields[];
@@ -1741,7 +1757,7 @@ static struct trace_event_file *find_var_file(struct trace_array *tr,
 
 		if (find_var_field(var_hist_data, var_name)) {
 			if (found) {
-				hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+				hist_err(HIST_ERR_VAR_NOT_UNIQUE, errpos(var_name));
 				return NULL;
 			}
 
@@ -1792,7 +1808,7 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 			hist_field = find_file_var(file, var_name);
 			if (hist_field) {
 				if (found) {
-					hist_err_event("Variable name not unique, need to use fully qualified name (subsys.event.var) for variable: ", system, event_name, var_name);
+					hist_err(HIST_ERR_VAR_NOT_UNIQUE, errpos(var_name));
 					return ERR_PTR(-EINVAL);
 				}
 
@@ -2024,7 +2040,6 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 		attrs->n_actions++;
 		ret = 0;
 	}
-
 	return ret;
 }
 
@@ -2084,7 +2099,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 		char *assignment;
 
 		if (attrs->n_assignments == TRACING_MAP_VARS_MAX) {
-			hist_err("Too many variables defined: ", str);
+			hist_err(HIST_ERR_TOO_MANY_VARS, errpos(str));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2682,8 +2697,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 					   system, event_name);
 
 	if (!ref_field)
-		hist_err_event("Couldn't find variable: $",
-			       system, event_name, var_name);
+		hist_err(HIST_ERR_VAR_NOT_FOUND, errpos(var_name));
 
 	return ref_field;
 }
@@ -2717,7 +2731,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
-			hist_err("Invalid field modifier: ", modifier);
+			hist_err(HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2733,7 +2747,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
-			hist_err("Couldn't find field: ", field_name);
+			hist_err(HIST_ERR_FIELD_NOT_FOUND, errpos(field_name));
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2844,7 +2858,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	/* we support only -(xxx) i.e. explicit parens required */
 
 	if (level > 3) {
-		hist_err("Too many subexpressions (3 max): ", str);
+		hist_err(HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		ret = -EINVAL;
 		goto free;
 	}
@@ -2927,7 +2941,7 @@ static int check_expr_operands(struct hist_field *operand1,
 
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
 	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS)) {
-		hist_err("Timestamp units in expression don't match", NULL);
+		hist_err(HIST_ERR_TIMESTAMP_MISMATCH, 0);
 		return -EINVAL;
 	}
 
@@ -2945,7 +2959,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	char *sep, *operand1_str;
 
 	if (level > 3) {
-		hist_err("Too many subexpressions (3 max): ", str);
+		hist_err(HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3183,16 +3197,14 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err_event("trace action: Too many field variables defined: ",
-			       subsys_name, event_name, field_name);
+		hist_err(HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err_event("trace action: Event file not found: ",
-			       subsys_name, event_name, field_name);
+		hist_err(HIST_ERR_EVENT_FILE_NOT_FOUND, errpos(field_name));
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
 	}
@@ -3205,8 +3217,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err_event("trace action: Matching event histogram not found: ",
-			       subsys_name, event_name, field_name);
+		hist_err(HIST_ERR_HIST_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3267,8 +3278,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("trace action: Couldn't create histogram for field: ",
-			       subsys_name, event_name, field_name);
+		hist_err(HIST_ERR_HIST_CREATE_FAIL, errpos(field_name));
 		return ERR_PTR(ret);
 	}
 
@@ -3280,8 +3290,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("trace action: Couldn't find synthetic variable: ",
-			       subsys_name, event_name, field_name);
+		hist_err(HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3418,21 +3427,21 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	int ret = 0;
 
 	if (hist_data->n_field_vars >= SYNTH_FIELDS_MAX) {
-		hist_err("Too many field variables defined: ", field_name);
+		hist_err(HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
 		ret = -EINVAL;
 		goto err;
 	}
 
 	val = parse_atom(hist_data, file, field_name, &flags, NULL);
 	if (IS_ERR(val)) {
-		hist_err("Couldn't parse field variable: ", field_name);
+		hist_err(HIST_ERR_FIELD_VAR_PARSE_FAIL, errpos(field_name));
 		ret = PTR_ERR(val);
 		goto err;
 	}
 
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
-		hist_err("Couldn't create or find variable: ", field_name);
+		hist_err(HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
 		kfree(val);
 		ret = PTR_ERR(var);
 		goto err;
@@ -3765,14 +3774,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 
 	track_data_var_str = data->track_data.var_str;
 	if (track_data_var_str[0] != '$') {
-		hist_err("For onmax(x) or onchange(x), x must be a variable: ", track_data_var_str);
+		hist_err(HIST_ERR_ONX_NOT_VAR, errpos(track_data_var_str));
 		return -EINVAL;
 	}
 	track_data_var_str++;
 
 	var_field = find_target_event_var(hist_data, NULL, NULL, track_data_var_str);
 	if (!var_field) {
-		hist_err("Couldn't find onmax or onchange variable: ", track_data_var_str);
+		hist_err(HIST_ERR_ONX_VAR_NOT_FOUND, errpos(track_data_var_str));
 		return -EINVAL;
 	}
 
@@ -3785,7 +3794,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	if (data->handler == HANDLER_ONMAX)
 		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-		hist_err("Couldn't create onmax variable: ", "__max");
+		hist_err(HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
 		ret = PTR_ERR(track_var);
 		goto out;
 	}
@@ -3793,7 +3802,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	if (data->handler == HANDLER_ONCHANGE)
 		track_var = create_var(hist_data, file, "__change", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-		hist_err("Couldn't create onchange variable: ", "__change");
+		hist_err(HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
 		ret = PTR_ERR(track_var);
 		goto out;
 	}
@@ -3812,20 +3821,20 @@ static int parse_action_params(char *params, struct action_data *data)
 
 	while (params) {
 		if (data->n_params >= SYNTH_FIELDS_MAX) {
-			hist_err("Too many action params", "");
+			hist_err(HIST_ERR_TOO_MANY_PARAMS, 0);
 			goto out;
 		}
 
 		param = strsep(&params, ",");
 		if (!param) {
-			hist_err("No action param found", "");
+			hist_err(HIST_ERR_PARAM_NOT_FOUND, 0);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		param = strstrip(param);
 		if (strlen(param) < 2) {
-			hist_err("Invalid action param: ", param);
+			hist_err(HIST_ERR_INVALID_PARAM, errpos(param));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3857,14 +3866,14 @@ static int action_parse(char *str, struct action_data *data,
 
 	strsep(&str, ".");
 	if (!str) {
-		hist_err("action parsing: No action found", "");
+		hist_err(HIST_ERR_ACTION_NOT_FOUND, 0);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	action_name = strsep(&str, "(");
 	if (!action_name || !str) {
-		hist_err("action parsing: No action found", "");
+		hist_err(HIST_ERR_ACTION_NOT_FOUND, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3873,7 +3882,7 @@ static int action_parse(char *str, struct action_data *data,
 		char *params = strsep(&str, ")");
 
 		if (!params) {
-			hist_err("action parsing: No params found for %s", "save");
+			hist_err(HIST_ERR_NO_SAVE_PARAMS, 0);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3887,7 +3896,7 @@ static int action_parse(char *str, struct action_data *data,
 		else if (handler == HANDLER_ONCHANGE)
 			data->track_data.check_val = check_track_val_changed;
 		else {
-			hist_err("action parsing: Handler doesn't support action: ", action_name);
+			hist_err(HIST_ERR_ACTION_MISMATCH, errpos(action_name));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3899,7 +3908,7 @@ static int action_parse(char *str, struct action_data *data,
 		char *params = strsep(&str, ")");
 
 		if (!str) {
-			hist_err("action parsing: No closing paren found: %s", params);
+			hist_err(HIST_ERR_NO_CLOSING_PAREN, errpos(params));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3909,7 +3918,7 @@ static int action_parse(char *str, struct action_data *data,
 		else if (handler == HANDLER_ONCHANGE)
 			data->track_data.check_val = check_track_val_changed;
 		else {
-			hist_err("action parsing: Handler doesn't support action: ", action_name);
+			hist_err(HIST_ERR_ACTION_MISMATCH, errpos(action_name));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4062,7 +4071,7 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	}
 
 	if (!hist_field)
-		hist_err_event("trace action: Couldn't find param: $", system, event, var);
+		hist_err(HIST_ERR_PARAM_NOT_FOUND, errpos(var));
 
 	return hist_field;
 }
@@ -4137,7 +4146,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 	event = find_synth_event(synth_event_name);
 	if (!event) {
-		hist_err("trace action: Couldn't find synthetic event: ", synth_event_name);
+		hist_err(HIST_ERR_SYNTH_EVENT_NOT_FOUND, errpos(synth_event_name));
 		return -EINVAL;
 	}
 
@@ -4198,15 +4207,14 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err_event("trace action: Param type doesn't match synthetic event field type: ",
-			       system, event_name, param);
+		hist_err(HIST_ERR_SYNTH_TYPE_MISMATCH, errpos(param));
 		kfree(p);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err("trace action: Param count doesn't match synthetic event field count: ", event->name);
+		hist_err(HIST_ERR_SYNTH_COUNT_MISMATCH, errpos(event->name));
 		ret = -EINVAL;
 		goto err;
 	}
@@ -4252,7 +4260,7 @@ static int action_create(struct hist_trigger_data *hist_data,
 	if (data->action == ACTION_SAVE) {
 		if (hist_data->n_save_vars) {
 			ret = -EEXIST;
-			hist_err("save action: Can't have more than one save() action per hist", "");
+			hist_err(HIST_ERR_TOO_MANY_SAVE_ACTIONS, 0);
 			goto out;
 		}
 
@@ -4265,7 +4273,7 @@ static int action_create(struct hist_trigger_data *hist_data,
 
 			field_var = create_target_field_var(hist_data, NULL, NULL, param);
 			if (IS_ERR(field_var)) {
-				hist_err("save action: Couldn't create field variable: ", param);
+				hist_err(HIST_ERR_FIELD_VAR_CREATE_FAIL, errpos(param));
 				ret = PTR_ERR(field_var);
 				kfree(param);
 				goto out;
@@ -4299,19 +4307,18 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 
 	match_event = strsep(&str, ")");
 	if (!match_event || !str) {
-		hist_err("onmatch: Missing closing paren: ", match_event);
+		hist_err(HIST_ERR_NO_CLOSING_PAREN, errpos(match_event));
 		goto free;
 	}
 
 	match_event_system = strsep(&match_event, ".");
 	if (!match_event) {
-		hist_err("onmatch: Missing subsystem for match event: ", match_event_system);
+		hist_err(HIST_ERR_SUBSYS_NOT_FOUND, errpos(match_event_system));
 		goto free;
 	}
 
 	if (IS_ERR(event_file(tr, match_event_system, match_event))) {
-		hist_err_event("onmatch: Invalid subsystem or event name: ",
-			       match_event_system, match_event, NULL);
+		hist_err(HIST_ERR_INVALID_SUBSYS_EVENT, errpos(match_event));
 		goto free;
 	}
 
@@ -4402,7 +4409,7 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 		return -EINVAL;
 
 	if (find_var(hist_data, file, var_name) && !hist_data->remove) {
-		hist_err("Variable already defined: ", var_name);
+		hist_err(HIST_ERR_DUPLICATE_VAR, errpos(var_name));
 		return -EINVAL;
 	}
 
@@ -4483,7 +4490,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-			hist_err("Using variable references as keys not supported: ", field_str);
+			hist_err(HIST_ERR_INVALID_REF_KEY, errpos(field_str));
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
@@ -4597,13 +4604,13 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			var_name = strsep(&field_str, "=");
 			if (!var_name || !field_str) {
-				hist_err("Malformed assignment: ", var_name);
+				hist_err(HIST_ERR_MALFORMED_ASSIGNMENT, errpos(var_name));
 				ret = -EINVAL;
 				goto free;
 			}
 
 			if (n_vars == TRACING_MAP_VARS_MAX) {
-				hist_err("Too many variables defined: ", var_name);
+				hist_err(HIST_ERR_TOO_MANY_VARS, errpos(var_name));
 				ret = -EINVAL;
 				goto free;
 			}
@@ -5460,11 +5467,6 @@ static int hist_show(struct seq_file *m, void *v)
 			hist_trigger_show(m, data, n++);
 	}
 
-	if (have_hist_err()) {
-		seq_printf(m, "\n%s: error: \n", hist_err_str);
-		seq_printf(m, "  Last command: %s\n", last_cmd);
-	}
-
  out_unlock:
 	mutex_unlock(&event_mutex);
 
@@ -5836,7 +5838,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		if (named_data) {
 			if (!hist_trigger_match(data, named_data, named_data,
 						true)) {
-				hist_err("Named hist trigger doesn't match existing named trigger (includes variables): ", hist_data->attrs->name);
+				hist_err(HIST_ERR_NAMED_MISMATCH, errpos(hist_data->attrs->name));
 				ret = -EINVAL;
 				goto out;
 			}
@@ -5857,7 +5859,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			else if (hist_data->attrs->clear)
 				hist_clear(test);
 			else {
-				hist_err("Hist trigger already exists", NULL);
+				hist_err(HIST_ERR_TRIGGER_EEXIST, 0);
 				ret = -EEXIST;
 			}
 			goto out;
@@ -5865,7 +5867,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	}
  new:
 	if (hist_data->attrs->cont || hist_data->attrs->clear) {
-		hist_err("Can't clear or continue a nonexistent hist trigger", NULL);
+		hist_err(HIST_ERR_TRIGGER_ENOENT_CLEAR, 0);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -5890,7 +5892,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 
 		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
 		if (ret) {
-			hist_err("Couldn't set trace_clock: ", clock);
+			hist_err(HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
 			goto out;
 		}
 
-- 
2.14.1


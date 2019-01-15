Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72675C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3670B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547589990;
	bh=KppqNc77V6wunJeAZwvtm5EINzmd5/iNQxABoCe0O68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=KvtcuoW/g/Td+L5fjaAJ31mEzsRRWxLQuxcv0NWAOt60u7Ql1tcEM6ZNuM/P21ZzL
	 tw2YapjoCnEDLzBNvk5mKiEOyMwELrtjjwTsNzl7sFnNEtQA3JIbYO8e8s1slCfzZr
	 cq32o9RVcHgN19cW2d2pYzORTuKEp2oZ9KxFKRbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfAOWG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390945AbfAOWGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:06:25 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B1820883;
        Tue, 15 Jan 2019 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547589984;
        bh=KppqNc77V6wunJeAZwvtm5EINzmd5/iNQxABoCe0O68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=a1eNCuSxLCALr3jnUuMaVGHNd677X4EeprzgVEKu8inBQXEYCYyqaFuBZ4bouVjHH
         RwT56osxB9zGlJglh8bgRer+LjKVswocsffdY5dqmYh7TVYu7PXMU5bS3FPSAObi6o
         dTbyF21YBxF/0iaRaCg0AXoRBkC8G9sVMJx9ocn8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v12 09/16] tracing: Add hist trigger onchange() handler
Date:   Tue, 15 Jan 2019 16:05:53 -0600
Message-Id: <139e92988e631f57e4ad26f1e06db92f1811bf74.1547589128.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1547589128.git.tom.zanussi@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1547589128.git.tom.zanussi@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add support for a hist:onchange($var) handler, similar to the onmax()
handler but triggering whenever there's any change in $var, not just a
max.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c             |  3 ++-
 kernel/trace/trace_events_hist.c | 58 ++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fcc0f1a963e3..917677a9bcaa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4896,7 +4896,8 @@ static const char readme_msg[] =
 	"\t        <handler>.<action>\n\n"
 	"\t    The available handlers are:\n\n"
 	"\t        onmatch(matching.event)  - invoke on addition or update\n"
-	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
+	"\t        onmax(var)               - invoke if var exceeds current max\n"
+	"\t        onchange(var)            - invoke action if var changes\n\n"
 	"\t    The available actions are:\n\n"
 	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 568729d7c599..c3358ad63052 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -398,6 +398,7 @@ typedef u64 (*get_track_val_fn_t) (struct hist_trigger_data *hist_data,
 enum handler_id {
 	HANDLER_ONMATCH = 1,
 	HANDLER_ONMAX,
+	HANDLER_ONCHANGE,
 };
 
 enum action_id {
@@ -1996,7 +1997,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 		return ret;
 
 	if ((str_has_prefix(str, "onmatch(")) ||
-	    (str_has_prefix(str, "onmax("))) {
+	    (str_has_prefix(str, "onmax(")) ||
+	    (str_has_prefix(str, "onchange("))) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -3488,6 +3490,14 @@ static bool check_track_val_max(u64 track_val, u64 var_val)
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
@@ -3664,6 +3674,8 @@ static void track_data_print(struct seq_file *m,
 
 	if (data->handler == HANDLER_ONMAX)
 		seq_printf(m, "\n\tmax: %10llu", track_val);
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_printf(m, "\n\tchanged: %10llu", track_val);
 
 	if (data->action == ACTION_SNAPSHOT)
 		return;
@@ -3750,14 +3762,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 
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
 
@@ -3774,6 +3786,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
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
@@ -3853,6 +3873,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3877,6 +3899,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3900,6 +3924,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 
 		if (handler != HANDLER_ONMATCH) {
 			data->track_data.save_val = save_track_val_local;
@@ -4743,7 +4769,8 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 
 		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->handler == HANDLER_ONMAX)
+		else if (data->handler == HANDLER_ONMAX ||
+			 data->handler == HANDLER_ONCHANGE)
 			track_data_destroy(hist_data, data);
 		else
 			kfree(data);
@@ -4779,6 +4806,15 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				ret = PTR_ERR(data);
 				break;
 			}
+		} else if ((len = str_has_prefix(str, "onchange("))) {
+			char *action_str = str + len;
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
@@ -4803,7 +4839,8 @@ static int create_actions(struct hist_trigger_data *hist_data)
 			ret = onmatch_create(hist_data, data);
 			if (ret)
 				break;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			ret = track_data_create(hist_data, data);
 			if (ret)
 				break;
@@ -4831,7 +4868,8 @@ static void print_actions(struct seq_file *m,
 			continue;
 		}
 
-		if (data->handler == HANDLER_ONMAX)
+		if (data->handler == HANDLER_ONMAX ||
+		    data->handler == HANDLER_ONCHANGE)
 			track_data_print(m, hist_data, elt, data);
 	}
 }
@@ -4863,6 +4901,8 @@ static void print_track_data_spec(struct seq_file *m,
 {
 	if (data->handler == HANDLER_ONMAX)
 		seq_puts(m, ":onmax(");
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_puts(m, ":onchange(");
 	seq_printf(m, "%s", data->track_data.var_str);
 	seq_printf(m, ").%s(", data->action_name);
 
@@ -4920,7 +4960,8 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 			if (strcmp(data->match_data.event,
 				   data_test->match_data.event) != 0)
 				return false;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			if (strcmp(data->track_data.var_str,
 				   data_test->track_data.var_str) != 0)
 				return false;
@@ -4941,7 +4982,8 @@ static void print_actions_spec(struct seq_file *m,
 
 		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
-		else if (data->handler == HANDLER_ONMAX)
+		else if (data->handler == HANDLER_ONMAX ||
+			 data->handler == HANDLER_ONCHANGE)
 			print_track_data_spec(m, hist_data, data);
 	}
 }
-- 
2.14.1


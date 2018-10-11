Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E3C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BBD20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2IeZiVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BBD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJLEbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJLEbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:31:39 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54EE821476;
        Thu, 11 Oct 2018 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539291758;
        bh=cSFHHK+bG8Tr3DWJZ/o/cAD8y9nBlwQGO6mOK+tOLhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Z2IeZiVQRzVFFty+l+d9AhgKN11rLz5kgTnZM7GVDpaMUOg1GweFmpv0IP8uvSlSZ
         vxYw555AlFDOoTvCQIqwVhdgkGMcdryytyz2eH6Lvn2wclP+ahjgnJ6O3JwQxfxD1l
         4AXAYSazZMBwTdeYW5ECsZ5BTeqjcXGX8z3xQ1R0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v6 11/15] tracing: Add hist trigger onchange() handler
Date:   Thu, 11 Oct 2018 16:02:08 -0500
Message-Id: <6d464c2788cec8c2e80e93d1027f3f7d0f8404d1.1539288364.git.tom.zanussi@linux.intel.com>
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

Add support for a hist:onchange($var) handler, similar to the onmax()
handler but triggering whenever there's any change in $var, not just a
max.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c             |  3 +-
 kernel/trace/trace_events_hist.c | 68 ++++++++++++++++++++++++++++++++--------
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8047841b4346..b1158d26880e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4876,7 +4876,8 @@ static const char readme_msg[] =
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
-- 
2.14.1


Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4537FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14596222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550101401;
	bh=YVrOmjkGmozTiyMhVwFpP5LWI0B6ANC7TTfRZL5jqsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=j3HPYKXFsxkk6TYf5gFDc0pn/myQ9Y5po959b9zHGVR8OglpXk9j5pkX4/cfAzn6H
	 pk7C/2hWR0XUwScrflb52IUP8lo2hUyDz0igKM7c3h+GEv7iVN5CJLwUO4lF4lQ2hy
	 fpymlbSL8gSPNNDEDD+qI4eyN4gNTUV7vNQyxsY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbfBMXnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393122AbfBMXnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:43:18 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D83222D3;
        Wed, 13 Feb 2019 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550101396;
        bh=YVrOmjkGmozTiyMhVwFpP5LWI0B6ANC7TTfRZL5jqsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nUoyPQdZko7jXl0gbOrGauxgcLcOz58RzAN+Vsqyl3Arke/MRSgQODquZrxl6QFjt
         BVa4Bl2zcsV54HMjaP8MCFJlA1Z8ir54Eml5wJel5s10bUxbO/S3NcKLsbGYKhQHbb
         8mwZcBjv3Dx/rysx/oCn+N4tV5uBsbFwFpGX1cxs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v15 08/15] tracing: Add hist trigger onchange() handler
Date:   Wed, 13 Feb 2019 17:42:48 -0600
Message-Id: <dfbc7e4ada242603e9ec3f049b5ad076a07dfd03.1550100284.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
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
index afcf8100a6b3..76742db70ba0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4915,7 +4915,8 @@ static const char readme_msg[] =
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
index 7f2d420ebb35..f9eee15877b7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -391,6 +391,7 @@ typedef bool (*check_track_val_fn_t) (u64 track_val, u64 var_val);
 enum handler_id {
 	HANDLER_ONMATCH = 1,
 	HANDLER_ONMAX,
+	HANDLER_ONCHANGE,
 };
 
 enum action_id {
@@ -1989,7 +1990,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 		return ret;
 
 	if ((str_has_prefix(str, "onmatch(")) ||
-	    (str_has_prefix(str, "onmax("))) {
+	    (str_has_prefix(str, "onmax(")) ||
+	    (str_has_prefix(str, "onchange("))) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -3481,6 +3483,14 @@ static bool check_track_val_max(u64 track_val, u64 var_val)
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
 static u64 get_track_val(struct hist_trigger_data *hist_data,
 			 struct tracing_map_elt *elt,
 			 struct action_data *data)
@@ -3640,6 +3650,8 @@ static void track_data_print(struct seq_file *m,
 
 	if (data->handler == HANDLER_ONMAX)
 		seq_printf(m, "\n\tmax: %10llu", track_val);
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_printf(m, "\n\tchanged: %10llu", track_val);
 
 	if (data->action == ACTION_SNAPSHOT)
 		return;
@@ -3727,14 +3739,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 
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
 
@@ -3751,6 +3763,14 @@ static int track_data_create(struct hist_trigger_data *hist_data,
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
@@ -3830,6 +3850,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3850,6 +3872,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 		else {
 			hist_err("action parsing: Handler doesn't support action: ", action_name);
 			ret = -EINVAL;
@@ -3870,6 +3894,8 @@ static int action_parse(char *str, struct action_data *data,
 
 		if (handler == HANDLER_ONMAX)
 			data->track_data.check_val = check_track_val_max;
+		else if (handler == HANDLER_ONCHANGE)
+			data->track_data.check_val = check_track_val_changed;
 
 		if (handler != HANDLER_ONMATCH) {
 			data->track_data.save_data = action_trace;
@@ -4700,7 +4726,8 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 
 		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->handler == HANDLER_ONMAX)
+		else if (data->handler == HANDLER_ONMAX ||
+			 data->handler == HANDLER_ONCHANGE)
 			track_data_destroy(hist_data, data);
 		else
 			kfree(data);
@@ -4736,6 +4763,15 @@ static int parse_actions(struct hist_trigger_data *hist_data)
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
@@ -4760,7 +4796,8 @@ static int create_actions(struct hist_trigger_data *hist_data)
 			ret = onmatch_create(hist_data, data);
 			if (ret)
 				break;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			ret = track_data_create(hist_data, data);
 			if (ret)
 				break;
@@ -4785,7 +4822,8 @@ static void print_actions(struct seq_file *m,
 		if (data->action == ACTION_SNAPSHOT)
 			continue;
 
-		if (data->handler == HANDLER_ONMAX)
+		if (data->handler == HANDLER_ONMAX ||
+		    data->handler == HANDLER_ONCHANGE)
 			track_data_print(m, hist_data, elt, data);
 	}
 }
@@ -4817,6 +4855,8 @@ static void print_track_data_spec(struct seq_file *m,
 {
 	if (data->handler == HANDLER_ONMAX)
 		seq_puts(m, ":onmax(");
+	else if (data->handler == HANDLER_ONCHANGE)
+		seq_puts(m, ":onchange(");
 	seq_printf(m, "%s", data->track_data.var_str);
 	seq_printf(m, ").%s(", data->action_name);
 
@@ -4874,7 +4914,8 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 			if (strcmp(data->match_data.event,
 				   data_test->match_data.event) != 0)
 				return false;
-		} else if (data->handler == HANDLER_ONMAX) {
+		} else if (data->handler == HANDLER_ONMAX ||
+			   data->handler == HANDLER_ONCHANGE) {
 			if (strcmp(data->track_data.var_str,
 				   data_test->track_data.var_str) != 0)
 				return false;
@@ -4895,7 +4936,8 @@ static void print_actions_spec(struct seq_file *m,
 
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


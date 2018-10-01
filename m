Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30640C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF80521471
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="esihYGjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF80521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJAW5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeJAW5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:57:11 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3C22146D;
        Mon,  1 Oct 2018 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538410717;
        bh=Tk7+g9wp+6tcbshh/gyhWjZV/TnQXmziQzKOBm7itGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=esihYGjbIzyP70UQFN0rKRtcXnCkndNyPP8eb5JW/GBOE5fOdcNb8O8Gi7peQGHzp
         YJg3rwBOYphOEwd5wf07I/vqQnpzh/0+OwQKIVa5JFalT8tRAuX3YBghAQvlzm1RAs
         8FQchCLF4CCOfcMfmBwGsJPhHYkGJonk/hSJ3hek=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v5 2/8] tracing: Split up onmatch action data
Date:   Mon,  1 Oct 2018 11:18:02 -0500
Message-Id: <c269b90ecbefb1eee98f53a87354fb54a3fd925b.1538403550.git.tom.zanussi@linux.intel.com>
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

Currently, the onmatch action data binds the onmatch action to data
related to synthetic event generation.  Since we want to allow the
onmatch handler to potentially invoke a different action, and because
we expect other handlers to generate synthetic events, we need to
separate the data related to these two functions.

Also rename the onmatch data to something more descriptive, and create
and use common action data destroy function.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 91 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 450f2d602291..2eaed37b744f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -338,13 +338,14 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	unsigned int		var_ref_idx;
+	struct synth_event	*synth_event;
+
 	union {
 		struct {
-			unsigned int		var_ref_idx;
-			char			*match_event;
-			char			*match_event_system;
-			struct synth_event	*synth_event;
-		} onmatch;
+			char			*event;
+			char			*event_system;
+		} match_data;
 
 		struct {
 			char			*var_str;
@@ -992,9 +993,9 @@ static void action_trace(struct hist_trigger_data *hist_data,
 			 struct ring_buffer_event *rbe,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->onmatch.synth_event;
+	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
@@ -1564,8 +1565,8 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 		struct action_data *data = hist_data->actions[i];
 
 		if (data->handler == HANDLER_ONMATCH) {
-			char *system = data->onmatch.match_event_system;
-			char *event_name = data->onmatch.match_event;
+			char *system = data->match_data.event_system;
+			char *event_name = data->match_data.event;
 
 			file = find_var_file(tr, system, event_name, var_name);
 			if (!file)
@@ -3301,20 +3302,33 @@ static void onmax_save(struct hist_trigger_data *hist_data,
 	update_max_vars(hist_data, elt, rbe, rec);
 }
 
-static void onmax_destroy(struct action_data *data)
+static void action_data_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
+	mutex_lock(&synth_event_mutex);
 
-	kfree(data->onmax.var_str);
 	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
+	if (data->synth_event)
+		data->synth_event->ref--;
+
 	kfree(data);
+
+	mutex_unlock(&synth_event_mutex);
+}
+
+static void onmax_destroy(struct action_data *data)
+{
+	destroy_hist_field(data->onmax.max_var, 0);
+	destroy_hist_field(data->onmax.var, 0);
+
+	kfree(data->onmax.var_str);
+
+	action_data_destroy(data);
 }
 
 static int action_create(struct hist_trigger_data *hist_data,
@@ -3506,23 +3520,10 @@ static struct action_data *onmax_parse(char *str, enum handler_id handler)
 
 static void onmatch_destroy(struct action_data *data)
 {
-	unsigned int i;
-
-	mutex_lock(&synth_event_mutex);
-
-	kfree(data->onmatch.match_event);
-	kfree(data->onmatch.match_event_system);
-	kfree(data->action_name);
+	kfree(data->match_data.event);
+	kfree(data->match_data.event_system);
 
-	for (i = 0; i < data->n_params; i++)
-		kfree(data->params[i]);
-
-	if (data->onmatch.synth_event)
-		data->onmatch.synth_event->ref--;
-
-	kfree(data);
-
-	mutex_unlock(&synth_event_mutex);
+	action_data_destroy(data);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3600,8 +3601,8 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		hist_field = find_event_var(hist_data, system, event, var);
@@ -3640,8 +3641,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 		 * event.
 		 */
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		/*
@@ -3753,8 +3754,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 		goto err;
 	}
 
-	data->onmatch.synth_event = event;
-	data->onmatch.var_ref_idx = var_ref_idx;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
@@ -3844,14 +3845,14 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	data->onmatch.match_event = kstrdup(match_event, GFP_KERNEL);
-	if (!data->onmatch.match_event) {
+	data->match_data.event = kstrdup(match_event, GFP_KERNEL);
+	if (!data->match_data.event) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	data->onmatch.match_event_system = kstrdup(match_event_system, GFP_KERNEL);
-	if (!data->onmatch.match_event_system) {
+	data->match_data.event_system = kstrdup(match_event_system, GFP_KERNEL);
+	if (!data->match_data.event_system) {
 		ret = -ENOMEM;
 		goto free;
 	}
@@ -4424,8 +4425,8 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
-		   data->onmatch.match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->match_data.event_system,
+		   data->match_data.event);
 
 	seq_printf(m, "%s(", data->action_name);
 
@@ -4463,11 +4464,11 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 			return false;
 
 		if (data->handler == HANDLER_ONMATCH) {
-			if (strcmp(data->onmatch.match_event_system,
-				   data_test->onmatch.match_event_system) != 0)
+			if (strcmp(data->match_data.event_system,
+				   data_test->match_data.event_system) != 0)
 				return false;
-			if (strcmp(data->onmatch.match_event,
-				   data_test->onmatch.match_event) != 0)
+			if (strcmp(data->match_data.event,
+				   data_test->match_data.event) != 0)
 				return false;
 		} else if (data->handler == HANDLER_ONMAX) {
 			if (strcmp(data->onmax.var_str,
-- 
2.14.1


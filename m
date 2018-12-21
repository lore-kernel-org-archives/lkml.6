Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5770FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE012087F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409838;
	bh=042WTKXwfF+19qFGvkBlksqzNTJS5WDtErEsd+0tqCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=1VkeY1w1iOKFquD/9IBqMjObSVTj23+b3d+FFVL8wVllH/X9WRyZEpm/0hzcWGCiu
	 U2dE8o1KcOhFbC3u6bIpa8v92CPzYPX52dJZNFd50haU21f1kKD6p/QpVEisVcVwnS
	 qtLgOyMsBwYrFsd6OYhy2n0CKvC06xynqR1QdIGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeLUQ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389393AbeLUQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:29:27 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880552087F;
        Fri, 21 Dec 2018 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409766;
        bh=042WTKXwfF+19qFGvkBlksqzNTJS5WDtErEsd+0tqCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KoEB2A2axOerK5UNN6MiWWnWJeA5Ga5BPO3jTgM5NjQHfpOmM9QBbOJxuSAynygYQ
         6X4Ow+1Y57wcs5HXNsrJkACiVj8Tmw/Cu9+YhR8h/eT4ygeGVqzj/Ct/z66Awv2u/R
         vCgrtbU2GPXLom+dJlq25KSn9UD5CFKHrV/q2OAs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v10 03/15] tracing: Split up onmatch action data
Date:   Fri, 21 Dec 2018 10:29:02 -0600
Message-Id: <2944df55fdc493a673b6ed54c2efacbfc1c2f3f8.1545408962.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
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
 kernel/trace/trace.c             |  12 ++++-
 kernel/trace/trace_events_hist.c | 103 ++++++++++++++++++++-------------------
 2 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5afcfecb4bc2..532c0355c7f4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4698,6 +4698,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
@@ -4739,7 +4740,16 @@ static const char readme_msg[] =
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
 	"\t    already-attached hist trigger.  The syntax is analagous to\n"
-	"\t    the enable_event and disable_event triggers.\n"
+	"\t    the enable_event and disable_event triggers.\n\n"
+	"\t    Hist trigger handlers and actions are executed whenever a\n"
+	"\t    a histogram entry is added or updated.  They take the form:\n\n"
+	"\t        <handler>.<action>\n\n"
+	"\t    The available handlers are:\n\n"
+	"\t        onmatch(matching.event)  - invoke on addition or update\n"
+	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
+	"\t    The available actions are:\n\n"
+	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        save(field,...)                      - save current event fields\n"
 #endif
 ;
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 61438a4bedb4..6fe84d579e0e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -405,21 +405,22 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	/*
+	 * When a histogram trigger is hit, the values of any
+	 * references to variables, including variables being passed
+	 * as parameters to synthetic events, are collected into a
+	 * var_ref_vals array.  This var_ref_idx is the index of the
+	 * first param in the array to be passed to the synthetic
+	 * event invocation.
+	 */
+	unsigned int		var_ref_idx;
+	struct synth_event	*synth_event;
+
 	union {
 		struct {
-			/*
-			 * When a histogram trigger is hit, the values of any
-			 * references to variables, including variables being passed
-			 * as parameters to synthetic events, are collected into a
-			 * var_ref_vals array.  This var_ref_idx is the index of the
-			 * first param in the array to be passed to the synthetic
-			 * event invocation.
-			 */
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
@@ -1093,9 +1094,9 @@ static void action_trace(struct hist_trigger_data *hist_data,
 			 struct ring_buffer_event *rbe,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->onmatch.synth_event;
+	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
@@ -1657,8 +1658,8 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 		struct action_data *data = hist_data->actions[i];
 
 		if (data->handler == HANDLER_ONMATCH) {
-			char *system = data->onmatch.match_event_system;
-			char *event_name = data->onmatch.match_event;
+			char *system = data->match_data.event_system;
+			char *event_name = data->match_data.event;
 
 			file = find_var_file(tr, system, event_name, var_name);
 			if (!file)
@@ -3425,22 +3426,33 @@ static void onmax_save(struct hist_trigger_data *hist_data,
 	update_max_vars(hist_data, elt, rbe, rec);
 }
 
-static void onmax_destroy(struct action_data *data)
+static void action_data_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
+	lockdep_assert_held(&event_mutex);
 
-	kfree(data->onmax.var_str);
 	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
+	if (data->synth_event)
+		data->synth_event->ref--;
+
 	kfree(data);
 }
 
+static void onmax_destroy(struct action_data *data)
+{
+	destroy_hist_field(data->onmax.max_var, 0);
+	destroy_hist_field(data->onmax.var, 0);
+
+	kfree(data->onmax.var_str);
+
+	action_data_destroy(data);
+}
+
 static int action_create(struct hist_trigger_data *hist_data,
 			 struct action_data *data);
 
@@ -3620,21 +3632,10 @@ static struct action_data *onmax_parse(char *str, enum handler_id handler)
 
 static void onmatch_destroy(struct action_data *data)
 {
-	unsigned int i;
-
-	lockdep_assert_held(&event_mutex);
+	kfree(data->match_data.event);
+	kfree(data->match_data.event_system);
 
-	kfree(data->onmatch.match_event);
-	kfree(data->onmatch.match_event_system);
-	kfree(data->action_name);
-
-	for (i = 0; i < data->n_params; i++)
-		kfree(data->params[i]);
-
-	if (data->onmatch.synth_event)
-		data->onmatch.synth_event->ref--;
-
-	kfree(data);
+	action_data_destroy(data);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3695,8 +3696,8 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		hist_field = find_event_var(hist_data, system, event, var);
@@ -3735,8 +3736,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 		 * event.
 		 */
 		if (!system && data->handler == HANDLER_ONMATCH) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		/*
@@ -3846,8 +3847,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 		goto err;
 	}
 
-	data->onmatch.synth_event = event;
-	data->onmatch.var_ref_idx = var_ref_idx;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
@@ -3933,14 +3934,14 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
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
@@ -4510,8 +4511,8 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
-		   data->onmatch.match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->match_data.event_system,
+		   data->match_data.event);
 
 	seq_printf(m, "%s(", data->action_name);
 
@@ -4549,11 +4550,11 @@ static bool actions_match(struct hist_trigger_data *hist_data,
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


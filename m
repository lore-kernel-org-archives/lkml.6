Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DBC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114D0217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547589993;
	bh=tIK31tCSDcveR9j3TT+L4y2X1DasYk4/j0xiVueXIag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=G4HOc95Vb7rbiW9Bv2PY97WeECmytQ4bLD78J0H+bkv7eoWFSosWVTZAAcufVKOzU
	 EGrxW/RjqODUhfa5YzzSk42+CvVckCccwx3DGHu8AsrBIQZydNSq86St+JRyxeba5W
	 rhTG0U+AnW6LX3fBTgT4wWK8dDc94OGtabh9GcgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390990AbfAOWGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390967AbfAOWG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:06:29 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B560C2177B;
        Tue, 15 Jan 2019 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547589987;
        bh=tIK31tCSDcveR9j3TT+L4y2X1DasYk4/j0xiVueXIag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=1O2Uep2gakX3lxyYlIhI8W03xPmuX7OZ0j2hrBU3Uwhl4W0acsv3wUIeSGbWy8VPy
         VesTHtg5j1g/IDX3YVJcNwbIdqpFBd6ZWoqW4lNKvF5v3uQk2cLFFoVx6XeRxaousS
         RuDdpoHghyph75Spk03EhfeG4BqbjESRJCFdbyu4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v12 11/16] tracing: Add alternative synthetic event trace action syntax
Date:   Tue, 15 Jan 2019 16:05:55 -0600
Message-Id: <70751e76268faae1527f61c824690bebe46a1e88.1547589128.git.tom.zanussi@linux.intel.com>
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

Add a 'trace(synthetic_event_name, params)' alternative to
synthetic_event_name(params).

Currently, the syntax used for generating synthetic events is to
invoke synthetic_event_name(params) i.e. use the synthetic event name
as a function call.

Users requested a new form that more explicitly shows that the
synthetic event is in effect being traced.  In this version, a new
'trace()' keyword is used, and the synthetic event name is passed in
as the first argument.

In addition, for the sake of consistency with other actions, change
the documention to emphasize the trace() form over the function-call
form, which remains documented as equivalent.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 54 +++++++++++++++++++++++++++------------
 kernel/trace/trace.c              |  2 +-
 kernel/trace/trace_events_hist.c  | 42 +++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 79476c906b1a..0ea59d45aef1 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1873,31 +1873,45 @@ The available handlers are:
 
 The available actions are:
 
-  - <synthetic_event_name>(param list)         - generate synthetic event
+  - trace(<synthetic_event_name>,param list)   - generate synthetic event
   - save(field,...)                            - save current event fields
   - snapshot()                                 - snapshot the trace buffer
 
 The following commonly-used handler.action pairs are available:
 
-  - onmatch(matching.event).<synthetic_event_name>(param list)
+  - onmatch(matching.event).trace(<synthetic_event_name>,param list)
 
-    The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
-    trigger action is invoked whenever an event matches and the
-    histogram entry would be added or updated.  It causes the named
-    synthetic event to be generated with the values given in the
+    The 'onmatch(matching.event).trace(<synthetic_event_name>,param
+    list)' hist trigger action is invoked whenever an event matches
+    and the histogram entry would be added or updated.  It causes the
+    named synthetic event to be generated with the values given in the
     'param list'.  The result is the generation of a synthetic event
     that consists of the values contained in those variables at the
-    time the invoking event was hit.
-
-    The 'param list' consists of one or more parameters which may be
-    either variables or fields defined on either the 'matching.event'
-    or the target event.  The variables or fields specified in the
-    param list may be either fully-qualified or unqualified.  If a
-    variable is specified as unqualified, it must be unique between
-    the two events.  A field name used as a param can be unqualified
-    if it refers to the target event, but must be fully qualified if
-    it refers to the matching event.  A fully-qualified name is of the
-    form 'system.event_name.$var_name' or 'system.event_name.field'.
+    time the invoking event was hit.  For example, if the synthetic
+    event name is 'wakeup_latency', a wakeup_latency event is
+    generated using onmatch(event).trace(wakeup_latency,arg1,arg2).
+
+    There is also an equivalent alternative form available for
+    generating synthetic events.  In this form, the synthetic event
+    name is used as if it were a function name.  For example, using
+    the 'wakeup_latency' synthetic event name again, the
+    wakeup_latency event would be generated by invoking it as if it
+    were a function call, with the event field values passed in as
+    arguments: onmatch(event).wakeup_latency(arg1,arg2).  The syntax
+    for this form is:
+
+      onmatch(matching.event).<synthetic_event_name>(param list)
+
+    In either case, the 'param list' consists of one or more
+    parameters which may be either variables or fields defined on
+    either the 'matching.event' or the target event.  The variables or
+    fields specified in the param list may be either fully-qualified
+    or unqualified.  If a variable is specified as unqualified, it
+    must be unique between the two events.  A field name used as a
+    param can be unqualified if it refers to the target event, but
+    must be fully qualified if it refers to the matching event.  A
+    fully-qualified name is of the form 'system.event_name.$var_name'
+    or 'system.event_name.field'.
 
     The 'matching.event' specification is simply the fully qualified
     event name of the event that matches the target event for the
@@ -1928,6 +1942,12 @@ The following commonly-used handler.action pairs are available:
               wakeup_new_test($testpid) if comm=="cyclictest"' >> \
               /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
+    Or, equivalently, using the 'trace' keyword syntax:
+
+    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
+            trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+
     Creating and displaying a histogram based on those events is now
     just a matter of using the fields and new synthetic event in the
     tracing/events/synthetic directory, as usual::
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 917677a9bcaa..8c220d97c214 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4899,7 +4899,7 @@ static const char readme_msg[] =
 	"\t        onmax(var)               - invoke if var exceeds current max\n"
 	"\t        onchange(var)            - invoke action if var changes\n\n"
 	"\t    The available actions are:\n\n"
-	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
 	"\t        snapshot()                           - snapshot the trace buffer\n"
 #endif
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c3358ad63052..0622a2e27b11 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -427,6 +427,8 @@ struct action_data {
 	 */
 	unsigned int		var_ref_idx;
 	struct synth_event	*synth_event;
+	bool			use_trace_keyword;
+	char			*synth_event_name;
 
 	union {
 		struct {
@@ -3724,6 +3726,8 @@ static void action_data_destroy(struct action_data *data)
 	if (data->synth_event)
 		data->synth_event->ref--;
 
+	kfree(data->synth_event_name);
+
 	kfree(data);
 }
 
@@ -3804,6 +3808,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 static int parse_action_params(char *params, struct action_data *data)
 {
 	char *param, *saved_param;
+	bool first_param = true;
 	int ret = 0;
 
 	while (params) {
@@ -3832,6 +3837,13 @@ static int parse_action_params(char *params, struct action_data *data)
 			goto out;
 		}
 
+		if (first_param && data->use_trace_keyword) {
+			data->synth_event_name = saved_param;
+			first_param = false;
+			continue;
+		}
+		first_param = false;
+
 		data->params[data->n_params++] = saved_param;
 	}
  out:
@@ -3916,6 +3928,9 @@ static int action_parse(char *str, struct action_data *data,
 	} else {
 		char *params = strsep(&str, ")");
 
+		if (str_has_prefix(action_name, "trace"))
+			data->use_trace_keyword = true;
+
 		if (params) {
 			ret = parse_action_params(params, data);
 			if (ret)
@@ -4120,13 +4135,19 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 	unsigned int i, var_ref_idx;
 	unsigned int field_pos = 0;
 	struct synth_event *event;
+	char *synth_event_name;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
 
-	event = find_synth_event(data->action_name);
+	if (data->use_trace_keyword)
+		synth_event_name = data->synth_event_name;
+	else
+		synth_event_name = data->action_name;
+
+	event = find_synth_event(synth_event_name);
 	if (!event) {
-		hist_err("trace action: Couldn't find synthetic event: ", data->action_name);
+		hist_err("trace action: Couldn't find synthetic event: ", synth_event_name);
 		return -EINVAL;
 	}
 
@@ -4887,8 +4908,10 @@ static void print_action_spec(struct seq_file *m,
 				seq_puts(m, ",");
 		}
 	} else if (data->action == ACTION_TRACE) {
+		if (data->use_trace_keyword)
+			seq_printf(m, "%s", data->synth_event_name);
 		for (i = 0; i < data->n_params; i++) {
-			if (i)
+			if (i || data->use_trace_keyword)
 				seq_puts(m, ",");
 			seq_printf(m, "%s", data->params[i]);
 		}
@@ -4936,6 +4959,7 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
+		char *action_name, *action_name_test;
 
 		if (data->handler != data_test->handler)
 			return false;
@@ -4950,7 +4974,17 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 				return false;
 		}
 
-		if (strcmp(data->action_name, data_test->action_name) != 0)
+		if (data->use_trace_keyword)
+			action_name = data->synth_event_name;
+		else
+			action_name = data->action_name;
+
+		if (data_test->use_trace_keyword)
+			action_name_test = data_test->synth_event_name;
+		else
+			action_name_test = data_test->action_name;
+
+		if (strcmp(action_name, action_name_test) != 0)
 			return false;
 
 		if (data->handler == HANDLER_ONMATCH) {
-- 
2.14.1


Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36627C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D021848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfBTSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfBTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302CC21916;
        Wed, 20 Feb 2019 18:38:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWky-0006l3-03; Wed, 20 Feb 2019 13:38:08 -0500
Message-Id: <20190220183807.887663710@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:38:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 23/29] tracing: Add alternative synthetic event trace action syntax
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Link: http://lkml.kernel.org/r/d082773e50232a001480cf837679a1e01c1a2eb7.1550100284.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 54 +++++++++++++++++++++----------
 kernel/trace/trace.c              |  2 +-
 kernel/trace/trace_events_hist.c  | 42 +++++++++++++++++++++---
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
index be6779f963c6..0460cc0f28fd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4918,7 +4918,7 @@ static const char readme_msg[] =
 	"\t        onmax(var)               - invoke if var exceeds current max\n"
 	"\t        onchange(var)            - invoke action if var changes\n\n"
 	"\t    The available actions are:\n\n"
-	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
 #ifdef CONFIG_TRACER_SNAPSHOT
 	"\t        snapshot()                           - snapshot the trace buffer\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2f3323ca9d24..66386ba1425f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -419,6 +419,8 @@ struct action_data {
 	 */
 	unsigned int		var_ref_idx;
 	struct synth_event	*synth_event;
+	bool			use_trace_keyword;
+	char			*synth_event_name;
 
 	union {
 		struct {
@@ -3700,6 +3702,8 @@ static void action_data_destroy(struct action_data *data)
 	if (data->synth_event)
 		data->synth_event->ref--;
 
+	kfree(data->synth_event_name);
+
 	kfree(data);
 }
 
@@ -3781,6 +3785,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 static int parse_action_params(char *params, struct action_data *data)
 {
 	char *param, *saved_param;
+	bool first_param = true;
 	int ret = 0;
 
 	while (params) {
@@ -3809,6 +3814,13 @@ static int parse_action_params(char *params, struct action_data *data)
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
@@ -3886,6 +3898,9 @@ static int action_parse(char *str, struct action_data *data,
 	} else {
 		char *params = strsep(&str, ")");
 
+		if (str_has_prefix(action_name, "trace"))
+			data->use_trace_keyword = true;
+
 		if (params) {
 			ret = parse_action_params(params, data);
 			if (ret)
@@ -4088,13 +4103,19 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
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
 
@@ -4841,8 +4862,10 @@ static void print_action_spec(struct seq_file *m,
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
@@ -4890,6 +4913,7 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
+		char *action_name, *action_name_test;
 
 		if (data->handler != data_test->handler)
 			return false;
@@ -4904,7 +4928,17 @@ static bool actions_match(struct hist_trigger_data *hist_data,
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
2.20.1



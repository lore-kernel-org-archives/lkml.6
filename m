Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801A218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165305;
	bh=JomGQJrWzMQ6RNm8pmAiWtNvsXQFJ6ZL517kmraB744=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=PNA0fCuMpecrRCHBdJa7HjAuKuScgizu3m8KFPtKnchvVW72BJuN1HI+6Ua2u2YJP
	 6OEaxhsQf5lKws8GryUy1nHzh6BP2mFuBgtdNzPHe4DfQm/85TTAm9zMb4Sy9A1vCj
	 wqynMEGldrV3S82TdQIXTWnVbkCN7Kg04zWI3w4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeLRUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeLRUe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:34:59 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CC721871;
        Tue, 18 Dec 2018 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165298;
        bh=JomGQJrWzMQ6RNm8pmAiWtNvsXQFJ6ZL517kmraB744=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nUaax0ls0+AbiMCh7rI5+/BibpFZvseIwFypgETfy+I2kUBUBEXWIQVQWwk6pkhYq
         bzRBQZXc62VUTPi/SdMc+13TLqBAJYXvTxatAoIWf+duRXhrJb+jYc/8z0Ybi9Iezt
         Wzv1ECFCJYD6qOVS7IAGMVHmLNgaFS7VViKfPMgk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v9 10/15] tracing: Add alternative synthetic event trace action syntax
Date:   Tue, 18 Dec 2018 14:34:09 -0600
Message-Id: <66f236230fd2b78a4073785bfa510474438e09d7.1545161056.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545161056.git.tom.zanussi@linux.intel.com>
References: <cover.1545161056.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161056.git.tom.zanussi@linux.intel.com>
References: <cover.1545161056.git.tom.zanussi@linux.intel.com>
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

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 21 ++++++++++++++++++++
 kernel/trace/trace.c              |  1 +
 kernel/trace/trace_events_hist.c  | 42 +++++++++++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 79476c906b1a..4939bad1c1cd 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1874,6 +1874,7 @@ The available handlers are:
 The available actions are:
 
   - <synthetic_event_name>(param list)         - generate synthetic event
+  - trace(<synthetic_event_name>,(param list)) - generate synthetic event
   - save(field,...)                            - save current event fields
   - snapshot()                                 - snapshot the trace buffer
 
@@ -1881,6 +1882,10 @@ The following commonly-used handler.action pairs are available:
 
   - onmatch(matching.event).<synthetic_event_name>(param list)
 
+    or
+
+  - onmatch(matching.event).trace(<synthetic_event_name>,(param list))
+
     The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
     trigger action is invoked whenever an event matches and the
     histogram entry would be added or updated.  It causes the named
@@ -1889,6 +1894,16 @@ The following commonly-used handler.action pairs are available:
     that consists of the values contained in those variables at the
     time the invoking event was hit.
 
+    There are two equivalent forms available for generating synthetic
+    events.  In the first form, the synthetic event name is used as if
+    it were a function name.  For example, if the synthetic event name
+    is 'wakeup_latency', the wakeup_latency event would be generated
+    by invoking it as if it were a function call, with the event field
+    values passed in as arguments: wakeup_latency(arg1,arg2).  The
+    second form simply uses the 'trace' keyword as the function name
+    and passes in the synthetic event name as the first argument,
+    followed by the field values: trace(wakeup_latency,arg1,arg2).
+
     The 'param list' consists of one or more parameters which may be
     either variables or fields defined on either the 'matching.event'
     or the target event.  The variables or fields specified in the
@@ -1928,6 +1943,12 @@ The following commonly-used handler.action pairs are available:
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
index f3f54b268b5a..c593cf378636 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4898,6 +4898,7 @@ static const char readme_msg[] =
 	"\t        onchange(var)            - invoke action if var changes\n\n"
 	"\t    The available actions are:\n\n"
 	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        trace(<synthetic_event>,(param list))- generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
 	"\t        snapshot()                           - snapshot the trace buffer\n"
 #endif
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5203c4809c9d..b11db6f95bd6 100644
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
@@ -3728,6 +3730,8 @@ static void action_data_destroy(struct action_data *data)
 	if (data->synth_event)
 		data->synth_event->ref--;
 
+	kfree(data->synth_event_name);
+
 	kfree(data);
 }
 
@@ -3808,6 +3812,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 static int parse_action_params(char *params, struct action_data *data)
 {
 	char *param, *saved_param;
+	bool first_param = true;
 	int ret = 0;
 
 	while (params) {
@@ -3836,6 +3841,13 @@ static int parse_action_params(char *params, struct action_data *data)
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
@@ -3920,6 +3932,9 @@ static int action_parse(char *str, struct action_data *data,
 	} else {
 		char *params = strsep(&str, ")");
 
+		if (strncmp(action_name, "trace", sizeof("trace") - 1) == 0)
+			data->use_trace_keyword = true;
+
 		if (params) {
 			ret = parse_action_params(params, data);
 			if (ret)
@@ -4124,13 +4139,19 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
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
 
@@ -4890,8 +4911,10 @@ static void print_action_spec(struct seq_file *m,
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
@@ -4939,6 +4962,7 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
+		char *action_name, *action_name_test;
 
 		if (data->handler != data_test->handler)
 			return false;
@@ -4953,7 +4977,17 @@ static bool actions_match(struct hist_trigger_data *hist_data,
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


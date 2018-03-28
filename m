Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeC1ULP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:11:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:61122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753533AbeC1ULM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:11:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="43008348"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 3/4] tracing: Add action comparisons when testing matching hist triggers
Date: Wed, 28 Mar 2018 15:10:55 -0500
Message-Id: <a7fd668b87ec10736c8f016ac4279c8480d50c2b.1522256721.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions also need to be considered when checking for matching triggers
- triggers differing only by action should be allowed, but currently
aren't because the matching check ignores the action and erroneously
returns -EEXIST.

Add and call an actions_match() function to address that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 468e43f..ae84470 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4363,6 +4363,53 @@ static void print_onmatch_spec(struct seq_file *m,
 	seq_puts(m, ")");
 }
 
+static bool actions_match(struct hist_trigger_data *hist_data,
+			  struct hist_trigger_data *hist_data_test)
+{
+	unsigned int i, j;
+
+	if (hist_data->n_actions != hist_data_test->n_actions)
+		return false;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+		struct action_data *data_test = hist_data_test->actions[i];
+
+		if (data->fn != data_test->fn)
+			return false;
+
+		if (data->n_params != data_test->n_params)
+			return false;
+
+		for (j = 0; j < data->n_params; j++) {
+			if (strcmp(data->params[j], data_test->params[j]) != 0)
+				return false;
+		}
+
+		if (data->fn == action_trace) {
+			if (strcmp(data->onmatch.synth_event_name,
+				   data_test->onmatch.synth_event_name) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event_system,
+				   data_test->onmatch.match_event_system) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event,
+				   data_test->onmatch.match_event) != 0)
+				return false;
+		} else if (data->fn == onmax_save) {
+			if (strcmp(data->onmax.var_str,
+				   data_test->onmax.var_str) != 0)
+				return false;
+			if (strcmp(data->onmax.fn_name,
+				   data_test->onmax.fn_name) != 0)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+
 static void print_actions_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data)
 {
@@ -5173,6 +5220,9 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	    (strcmp(data->filter_str, data_test->filter_str) != 0))
 		return false;
 
+	if (!actions_match(hist_data, hist_data_test))
+		return false;
+
 	return true;
 }
 
-- 
1.9.3

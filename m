Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeDLPPk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:15:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:19745 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754133AbeDLPNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="36745796"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 3/6] tracing: Save the last hist command's associated event name
Date: Thu, 12 Apr 2018 10:13:18 -0500
Message-Id: <1b0ae2e2fb4275fa2ea47df816888c573a87526c.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for making use of the new trace event error log, save
the subsystem and event name associated with the last hist command -
it will be passed as the location param in the event_log_err() calls.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66c87be..4a42df4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -354,14 +354,32 @@ struct action_data {
 
 
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
+static char last_hist_cmd_event[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(struct trace_event_file *file, char *str)
 {
+	const char *system = NULL, *name = NULL;
+	struct trace_event_call *call;
+
 	if (!str)
 		return;
 
 	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
+
+	if (file) {
+		call = file->event_call;
+
+		system = call->class->system;
+		if (system) {
+			name = trace_event_name(call);
+			if (!name)
+				system = NULL;
+		}
+	}
+
+	if (system)
+		snprintf(last_hist_cmd_event, MAX_FILTER_STR_VAL, "%s:%s", system, name);
 }
 
 static void hist_err(char *str, char *var)
@@ -401,6 +419,8 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 static void hist_err_clear(void)
 {
 	hist_err_str[0] = '\0';
+	last_hist_cmd[0] = '\0';
+	last_hist_cmd_event[0] = '\0';
 }
 
 static bool have_hist_err(void)
@@ -5478,8 +5498,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	int ret = 0;
 
 	if (glob && strlen(glob)) {
-		last_cmd_set(param);
 		hist_err_clear();
+		last_cmd_set(file, param);
 	}
 
 	if (!param)
-- 
1.9.3

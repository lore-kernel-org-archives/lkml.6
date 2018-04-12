Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbeDLPPW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:15:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:48714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753051AbeDLPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="41494310"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 5/6] tracing: Add field parsing trace event errors for hist triggers
Date: Thu, 12 Apr 2018 10:13:20 -0500
Message-Id: <6182020d231aa51485e7fc12441527d3709cad06.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log errors to the tracing/events/error_log for nonexistent fields and
modifiers specified in hist triggers.

Also screen out variable references, which shouldn't be looked up as
fields.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 08424ff..d223fd6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2461,6 +2461,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
+			log_err("Invalid field modifier: %s", modifier);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2476,6 +2477,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			log_err("Couldn't find field: %s", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2553,6 +2555,11 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	} else
 		str = s;
 
+	if (is_var_ref(str)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	field = parse_field(hist_data, file, str, flags);
 	if (IS_ERR(field)) {
 		ret = PTR_ERR(field);
-- 
1.9.3

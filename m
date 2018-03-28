Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbeC1ULJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:11:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:61115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753249AbeC1ULG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:11:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="32220615"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 1/4] tracing: Fix display of hist trigger expressions containing timestamps
Date: Wed, 28 Mar 2018 15:10:53 -0500
Message-Id: <92746b06be67499c2a6217bd55395b350ad18fad.1522256721.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When displaying hist triggers, variable references that have the
timestamp field flag set are erroneously displayed as common_timestamp
rather than the variable reference.  Additionally, timestamp
expressions are displayed in the same way.  Fix this by forcing the
timestamp flag handling to follow variable reference and expression
handling.

Before:

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs:...

After:

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0.usecs:...

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4f02764..fb81447 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1686,8 +1686,6 @@ static const char *hist_field_name(struct hist_field *field,
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
 		 field->flags & HIST_FIELD_FL_ALIAS)
 		field_name = hist_field_name(field->operands[0], ++level);
-	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-		field_name = "common_timestamp";
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
@@ -1703,7 +1701,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = full_name;
 		} else
 			field_name = field->name;
-	}
+	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "common_timestamp";
 
 	if (field_name == NULL)
 		field_name = "";
@@ -4857,23 +4856,15 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	if (hist_field->var.name)
 		seq_printf(m, "%s=", hist_field->var.name);
 
-	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
-		seq_puts(m, "common_timestamp");
-	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "cpu");
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
 			seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
-	}
-
-	if (hist_field->flags) {
-		const char *flags_str = get_hist_field_flags(hist_field);
-
-		if (flags_str)
-			seq_printf(m, ".%s", flags_str);
-	}
+	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
+		seq_puts(m, "common_timestamp");
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
1.9.3

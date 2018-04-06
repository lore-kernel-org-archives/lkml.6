Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeDFNDx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE1121836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.595506711@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 06/18] tracing: Fix display of hist trigger expressions containing
 timestamps
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-tracing-Fix-display-of-hist-trigger-expressions-cont.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

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

Link: http://lkml.kernel.org/r/92746b06be67499c2a6217bd55395b350ad18fad.1522256721.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a02bc09d765a..4f4792f4c83f 100644
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
@@ -4858,23 +4857,15 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
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
2.15.1

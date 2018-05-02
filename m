Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeEBUBf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEBUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:00:43 -0400
Message-Id: <20180502200041.951723821@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/7] tracing: Add field parsing hist error for hist triggers
References: <20180502200003.592877274@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-tracing-Add-field-parsing-hist-error-for-hist-trigge.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

If the user specifies a nonexistent field for a hist trigger, the
current code correctly flags that as an error, but doesn't tell the
user what happened.

Fix this by invoking hist_err() with an appropriate message when
nonexistent fields are specified.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
  ERROR: Couldn't find field: pid
    Last command: keys=pid:ts0=common_timestamp.usecs

Link: http://lkml.kernel.org/r/fdc8746969d16906120f162b99dd71c741e0b62c.1524790601.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66c87be4ebb2..f231fa2a3dcd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2481,6 +2481,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			hist_err("Couldn't find field: ", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
2.17.0

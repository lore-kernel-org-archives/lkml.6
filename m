Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeDFNDw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D445A2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.755822418@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 07/18] tracing: Dont add flag strings when displaying variable references
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0007-tracing-Don-t-add-flag-strings-when-displaying-varia.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Variable references should never have flags appended when displayed -
prevent that from happening.

Before:

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0.usecs:...

After:

  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:...

Link: http://lkml.kernel.org/r/913318a5610ef6b24af2522575f671fa6ee19b6b.1522256721.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4f4792f4c83f..d867502a56ba 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2052,7 +2052,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 	strcat(expr, hist_field_name(field, 0));
 
-	if (field->flags) {
+	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
-- 
2.15.1

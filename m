Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeDFNDt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F562217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130113.244713720@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 10/18] tracing: Uninitialized variable in create_tracing_map_fields()
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0010-tracing-Uninitialized-variable-in-create_tracing_map.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Smatch complains that idx can be used uninitialized when we check if
(idx < 0).  It has to be the first iteration through the loop and the
HIST_FIELD_FL_STACKTRACE bit has to be clear and the HIST_FIELD_FL_VAR
bit has to be set to reach the bug.

Link: http://lkml.kernel.org/r/20180328114815.GC29050@mwanda

Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 15ea11c29a51..0d7b3ffbecc2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4458,7 +4458,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	struct tracing_map *map = hist_data->map;
 	struct ftrace_event_field *field;
 	struct hist_field *hist_field;
-	int i, idx;
+	int i, idx = 0;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-- 
2.15.1

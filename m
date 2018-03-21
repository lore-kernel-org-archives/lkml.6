Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCUC1T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbeCUCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C0A2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022125.860357600@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 16/46] tracing: Account for variables in named trigger compatibility
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0016-tracing-Account-for-variables-in-named-trigger-compa.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Named triggers must also have the same set of variables in order to be
considered compatible - update the trigger match test to account for
that.

The reason for this requirement is that named triggers with variables
are meant to allow one or more events to set the same variable.

Link: http://lkml.kernel.org/r/a17eae6328a99917f9d5c66129c9fcd355279ee9.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8f43f24bf49c..ba326260c034 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1610,7 +1610,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 		sort_key = &hist_data->sort_keys[i];
 		idx = sort_key->field_idx;
 
-		if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
+		if (WARN_ON(idx >= HIST_FIELDS_MAX))
 			return -EINVAL;
 
 		if (i > 0)
@@ -1798,6 +1798,11 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->is_signed != key_field_test->is_signed)
 			return false;
+		if (!!key_field->var.name != !!key_field_test->var.name)
+			return false;
+		if (key_field->var.name &&
+		    strcmp(key_field->var.name, key_field_test->var.name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
-- 
2.15.1

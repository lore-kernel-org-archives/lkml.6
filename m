Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCUCVo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeCUCVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA66217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022125.290784423@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 13/46] tracing: Add hist_data member to hist_field
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0013-tracing-Add-hist_data-member-to-hist_field.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Allow hist_data access via hist_field.  Some users of hist_fields
require or will require more access to the associated hist_data.

Link: http://lkml.kernel.org/r/d04cd0768f5228ebb4ac0ba4a847bc4d14d4826f.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a793f8c04830..77ebe6b410ba 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -39,6 +39,7 @@ struct hist_field {
 	unsigned int			offset;
 	unsigned int                    is_signed;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
+	struct hist_trigger_data	*hist_data;
 };
 
 static u64 hist_field_none(struct hist_field *field, void *event,
@@ -420,7 +421,8 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	kfree(hist_field);
 }
 
-static struct hist_field *create_hist_field(struct ftrace_event_field *field,
+static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
+					    struct ftrace_event_field *field,
 					    unsigned long flags)
 {
 	struct hist_field *hist_field;
@@ -432,6 +434,8 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->hist_data = hist_data;
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		goto out;
@@ -445,7 +449,7 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (flags & HIST_FIELD_FL_LOG2) {
 		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
-		hist_field->operands[0] = create_hist_field(field, fl);
+		hist_field->operands[0] = create_hist_field(hist_data, field, fl);
 		hist_field->size = hist_field->operands[0]->size;
 		goto out;
 	}
@@ -498,7 +502,7 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
-		create_hist_field(NULL, HIST_FIELD_FL_HITCOUNT);
+		create_hist_field(hist_data, NULL, HIST_FIELD_FL_HITCOUNT);
 	if (!hist_data->fields[HITCOUNT_IDX])
 		return -ENOMEM;
 
@@ -544,7 +548,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags);
+	hist_data->fields[val_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[val_idx]) {
 		ret = -ENOMEM;
 		goto out;
@@ -654,7 +658,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags);
+	hist_data->fields[key_idx] = create_hist_field(hist_data, field, flags);
 	if (!hist_data->fields[key_idx]) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.15.1

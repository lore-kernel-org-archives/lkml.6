Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeCUC3S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeCUCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEB421839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022124.372464155@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 09/46] tracing: Add ring buffer event param to hist field functions
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0009-tracing-Add-ring-buffer-event-param-to-hist-field-fu.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Some events such as timestamps require access to a ring_buffer_event
struct; add a param so that hist field functions can access that.

Link: http://lkml.kernel.org/r/2ff4af18e72b6002eb86b26b2a7f39cef7d1dfe4.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 63a19123cf47..37f5acefdc6c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -26,7 +26,8 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
+				struct ring_buffer_event *rbe);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 
@@ -40,24 +41,28 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event)
+static u64 hist_field_none(struct hist_field *field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event)
+static u64 hist_field_counter(struct hist_field *field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event)
+static u64 hist_field_string(struct hist_field *hist_field, void *event,
+			     struct ring_buffer_event *rbe)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
+				struct ring_buffer_event *rbe)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -66,24 +71,28 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
+			      struct ring_buffer_event *rbe)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event)
+static u64 hist_field_log2(struct hist_field *hist_field, void *event,
+			   struct ring_buffer_event *rbe)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event);
+	u64 val = operand->fn(operand, event, rbe);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
 #define DEFINE_HIST_FIELD_FN(type)					\
-static u64 hist_field_##type(struct hist_field *hist_field, void *event)\
+	static u64 hist_field_##type(struct hist_field *hist_field,	\
+				     void *event,			\
+				     struct ring_buffer_event *rbe)	\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -871,8 +880,8 @@ create_hist_data(unsigned int map_bits,
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt,
-				    void *rec)
+				    struct tracing_map_elt *elt, void *rec,
+				    struct ring_buffer_event *rbe)
 {
 	struct hist_field *hist_field;
 	unsigned int i;
@@ -880,7 +889,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec);
+		hist_val = hist_field->fn(hist_field, rec, rbe);
 		tracing_map_update_sum(elt, i, hist_val);
 	}
 }
@@ -910,7 +919,7 @@ static inline void add_to_key(char *compound_key, void *key,
 }
 
 static void event_hist_trigger(struct event_trigger_data *data, void *rec,
-			       struct ring_buffer_event *event)
+			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
@@ -939,7 +948,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec);
+			field_contents = key_field->fn(key_field, rec, rbe);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -956,7 +965,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 	elt = tracing_map_insert(hist_data->map, key);
 	if (elt)
-		hist_trigger_elt_update(hist_data, elt, rec);
+		hist_trigger_elt_update(hist_data, elt, rec, rbe);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
-- 
2.15.1

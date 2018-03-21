Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeCUC1B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751966AbeCUCVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C46F2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022126.908390211@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 20/46] tracing: Pass tracing_map_elt to hist_field accessor functions
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0020-tracing-Pass-tracing_map_elt-to-hist_field-accessor-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Some accessor functions, such as for variable references, require
access to a corrsponding tracing_map_elt.

Add a tracing_map_elt param to the function signature and update the
accessor functions accordingly.

Link: http://lkml.kernel.org/r/e0f292b068e9e4948da1d5af21b5ae0efa9b5717.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 91 +++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f072ed3122c8..7a54ab50176b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -26,8 +26,10 @@
 
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event,
-				struct ring_buffer_event *rbe);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event);
 
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
@@ -59,28 +61,36 @@ struct hist_field {
 	char				*name;
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_none(struct hist_field *field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event,
-			      struct ring_buffer_event *rbe)
+static u64 hist_field_counter(struct hist_field *field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event,
-			     struct ring_buffer_event *rbe)
+static u64 hist_field_string(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct ring_buffer_event *rbe,
+			     void *event)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
+static u64 hist_field_dynstring(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -89,54 +99,64 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event,
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event,
-			      struct ring_buffer_event *rbe)
+static u64 hist_field_pstring(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_log2(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, event, rbe);
+	u64 val = operand->fn(operand, elt, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
-static u64 hist_field_plus(struct hist_field *hist_field, void *event,
-			   struct ring_buffer_event *rbe)
+static u64 hist_field_plus(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, event, rbe);
-	u64 val2 = operand2->fn(operand2, event, rbe);
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
 
 	return val1 + val2;
 }
 
-static u64 hist_field_minus(struct hist_field *hist_field, void *event,
-			    struct ring_buffer_event *rbe)
+static u64 hist_field_minus(struct hist_field *hist_field,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *event)
 {
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, event, rbe);
-	u64 val2 = operand2->fn(operand2, event, rbe);
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
 
 	return val1 - val2;
 }
 
-static u64 hist_field_unary_minus(struct hist_field *hist_field, void *event,
-				  struct ring_buffer_event *rbe)
+static u64 hist_field_unary_minus(struct hist_field *hist_field,
+				  struct tracing_map_elt *elt,
+				  struct ring_buffer_event *rbe,
+				  void *event)
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	s64 sval = (s64)operand->fn(operand, event, rbe);
+	s64 sval = (s64)operand->fn(operand, elt, rbe, event);
 	u64 val = (u64)-sval;
 
 	return val;
@@ -144,8 +164,9 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field, void *event,
 
 #define DEFINE_HIST_FIELD_FN(type)					\
 	static u64 hist_field_##type(struct hist_field *hist_field,	\
-				     void *event,			\
-				     struct ring_buffer_event *rbe)	\
+				     struct tracing_map_elt *elt,	\
+				     struct ring_buffer_event *rbe,	\
+				     void *event)			\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -233,8 +254,10 @@ struct hist_trigger_data {
 	bool				remove;
 };
 
-static u64 hist_field_timestamp(struct hist_field *hist_field, void *event,
-				struct ring_buffer_event *rbe)
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
@@ -1570,7 +1593,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec, rbe);
+		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
@@ -1582,7 +1605,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 	for_each_hist_key_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_val = hist_field->fn(hist_field, rec, rbe);
+			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
 		}
@@ -1620,9 +1643,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	bool use_compound_key = (hist_data->n_keys > 1);
 	unsigned long entries[HIST_STACKTRACE_DEPTH];
 	char compound_key[HIST_KEY_SIZE_MAX];
+	struct tracing_map_elt *elt = NULL;
 	struct stack_trace stacktrace;
 	struct hist_field *key_field;
-	struct tracing_map_elt *elt;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -1643,7 +1666,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec, rbe);
+			field_contents = key_field->fn(key_field, elt, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
-- 
2.15.1

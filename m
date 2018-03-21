Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCUC04 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbeCUCVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E0521848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022127.111788344@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 21/46] tracing: Add hist_field type field
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0021-tracing-Add-hist_field-type-field.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Future support for synthetic events requires hist_field 'type'
information, so add a field for that.

Also, make other hist_field attribute usage consistent (size,
is_signed, etc).

Link: http://lkml.kernel.org/r/3fd12a2e86316b05151ba0d7c68268e780af2c9d.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7a54ab50176b..e30bd86bee8e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -54,6 +54,7 @@ struct hist_field {
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
+	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
 	struct hist_var			var;
@@ -717,6 +718,7 @@ static void destroy_hist_field(struct hist_field *hist_field,
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
+	kfree(hist_field->type);
 
 	kfree(hist_field);
 }
@@ -742,6 +744,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -755,12 +761,18 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn = hist_field_log2;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
+		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_TIMESTAMP) {
 		hist_field->fn = hist_field_timestamp;
 		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -770,6 +782,11 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (is_string_field(field)) {
 		flags |= HIST_FIELD_FL_STRING;
 
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
 		if (field->filter_type == FILTER_STATIC_STRING)
 			hist_field->fn = hist_field_string;
 		else if (field->filter_type == FILTER_DYN_STRING)
@@ -777,6 +794,12 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		else
 			hist_field->fn = hist_field_pstring;
 	} else {
+		hist_field->size = field->size;
+		hist_field->is_signed = field->is_signed;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
 		hist_field->fn = select_value_fn(field->size,
 						 field->is_signed);
 		if (!hist_field->fn) {
@@ -949,6 +972,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	return expr;
  free:
@@ -1042,6 +1070,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[1] = operand2;
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	switch (field_op) {
 	case FIELD_OP_MINUS:
-- 
2.15.1

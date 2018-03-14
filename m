Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCNQzJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbeCNQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:55:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394612077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180314165504.195911651@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 12:54:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 2/3 v2] tracing: Clean up and document pred_funcs_##type creation and use
References: <20180314165401.530128930@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-tracing-Clean-up-and-document-pred_funcs_-type-creat.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The pred_funcs_##type arrays consist of five functions that are assigned
based on the ops. The array must be in the same order of the ops each
function represents. The PRED_FUNC_START macro denotes the op enum that
starts the op that maps to the pred_funcs_##type arrays. This is all very
subtle and prone to bugs if the code is changed.

Add comments describing how PRED_FUNC_START and pred_funcs_##type array is
used, and also a PRED_FUNC_MAX that is the maximum number of functions in
the arrays.

Clean up select_comparison_fn() that assigns the predicates to the
pred_funcs_##type array function as well as add protection in case an op is
passed in that does not map correctly to the array.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 46 ++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a2ef393b3bb2..9d383f4383dc 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -65,6 +65,13 @@ struct filter_op {
 
 static struct filter_op filter_ops[] = { OPS };
 
+/*
+ * pred functions are OP_LT, OP_LE, OP_GT, OP_GE, and OP_BAND
+ * pred_funcs_##type below must match the order of them above.
+ */
+#define PRED_FUNC_START			OP_LT
+#define PRED_FUNC_MAX			(OP_BAND - PRED_FUNC_START)
+
 #define ERRORS								\
 	C( NONE,	 	"No error"),				\
 	C( INVALID_OP,		"Invalid operator"),			\
@@ -172,8 +179,6 @@ static const filter_pred_fn_t pred_funcs_##type[] = {			\
 	filter_pred_BAND_##type,					\
 };
 
-#define PRED_FUNC_START			OP_LT
-
 #define DEFINE_EQUALITY_PRED(size)					\
 static int filter_pred_##size(struct filter_pred *pred, void *event)	\
 {									\
@@ -946,39 +951,52 @@ static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
 					    int field_size, int field_is_signed)
 {
 	filter_pred_fn_t fn = NULL;
+	int pred_func_index = -1;
+
+	switch (op) {
+	case OP_EQ:
+	case OP_NE:
+		break;
+	default:
+		if (WARN_ON_ONCE(op < PRED_FUNC_START))
+			return NULL;
+		pred_func_index = op - PRED_FUNC_START;
+		if (WARN_ON_ONCE(pred_func_index > PRED_FUNC_MAX))
+			return NULL;
+	}
 
 	switch (field_size) {
 	case 8:
-		if (op == OP_EQ || op == OP_NE)
+		if (pred_func_index < 0)
 			fn = filter_pred_64;
 		else if (field_is_signed)
-			fn = pred_funcs_s64[op - PRED_FUNC_START];
+			fn = pred_funcs_s64[pred_func_index];
 		else
-			fn = pred_funcs_u64[op - PRED_FUNC_START];
+			fn = pred_funcs_u64[pred_func_index];
 		break;
 	case 4:
-		if (op == OP_EQ || op == OP_NE)
+		if (pred_func_index < 0)
 			fn = filter_pred_32;
 		else if (field_is_signed)
-			fn = pred_funcs_s32[op - PRED_FUNC_START];
+			fn = pred_funcs_s32[pred_func_index];
 		else
-			fn = pred_funcs_u32[op - PRED_FUNC_START];
+			fn = pred_funcs_u32[pred_func_index];
 		break;
 	case 2:
-		if (op == OP_EQ || op == OP_NE)
+		if (pred_func_index < 0)
 			fn = filter_pred_16;
 		else if (field_is_signed)
-			fn = pred_funcs_s16[op - PRED_FUNC_START];
+			fn = pred_funcs_s16[pred_func_index];
 		else
-			fn = pred_funcs_u16[op - PRED_FUNC_START];
+			fn = pred_funcs_u16[pred_func_index];
 		break;
 	case 1:
-		if (op == OP_EQ || op == OP_NE)
+		if (pred_func_index < 0)
 			fn = filter_pred_8;
 		else if (field_is_signed)
-			fn = pred_funcs_s8[op - PRED_FUNC_START];
+			fn = pred_funcs_s8[pred_func_index];
 		else
-			fn = pred_funcs_u8[op - PRED_FUNC_START];
+			fn = pred_funcs_u8[pred_func_index];
 		break;
 	}
 
-- 
2.15.1

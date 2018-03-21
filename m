Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCUCWk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752076AbeCUCVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E2221861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.650317203@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 44/46] tracing: Combine enum and arrays into single macro in filter code
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0044-tracing-Combine-enum-and-arrays-into-single-macro-in.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of having a separate enum that is the index into another array, like
a string array, make a single macro that combines them into a single list,
and then the two can not get out of sync. This makes it easier to add and
remove items.

The macro trick is:

 #define DOGS				\
  C( JACK,     "Jack Russell")		\
  C( ITALIAN,  "Italian Greyhound")	\
  C( GERMAN,   "German Shepherd")

 #undef C
 #define C(a, b) a

 enum { DOGS };

 #undef C
 #define C(a, b) b

 static char dogs[] = { DOGS };

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 112 ++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 64 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c3c6eee1e4df..a2ef393b3bb2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -33,22 +33,26 @@
 	"# Only events with the given fields will be affected.\n"	\
 	"# If no events are modified, an error message will be displayed here"
 
-enum filter_op_ids
-{
-	OP_OR,
-	OP_AND,
-	OP_GLOB,
-	OP_NE,
-	OP_EQ,
-	OP_LT,
-	OP_LE,
-	OP_GT,
-	OP_GE,
-	OP_BAND,
-	OP_NOT,
-	OP_NONE,
-	OP_OPEN_PAREN,
-};
+#define OPS					\
+	C( OP_OR,	"||",		1 ),	\
+	C( OP_AND,	"&&",		2 ),	\
+	C( OP_GLOB,	"~",		4 ),	\
+	C( OP_NE,	"!=",		4 ),	\
+	C( OP_EQ,	"==",		4 ),	\
+	C( OP_LT,	"<",		5 ),	\
+	C( OP_LE,	"<=",		5 ),	\
+	C( OP_GT,	">",		5 ),	\
+	C( OP_GE,	">=",		5 ),	\
+	C( OP_BAND,	"&",		6 ),	\
+	C( OP_NOT,	"!",		6 ),	\
+	C( OP_NONE,	"OP_NONE",	0 ),	\
+	C( OP_OPEN_PAREN, "(",		0 ),	\
+	C( OP_MAX,	NULL,		0 )
+
+#undef C
+#define C(a, b, c)	a
+
+enum filter_op_ids { OPS };
 
 struct filter_op {
 	int id;
@@ -56,56 +60,36 @@ struct filter_op {
 	int precedence;
 };
 
-/* Order must be the same as enum filter_op_ids above */
-static struct filter_op filter_ops[] = {
-	{ OP_OR,	"||",		1 },
-	{ OP_AND,	"&&",		2 },
-	{ OP_GLOB,	"~",		4 },
-	{ OP_NE,	"!=",		4 },
-	{ OP_EQ,	"==",		4 },
-	{ OP_LT,	"<",		5 },
-	{ OP_LE,	"<=",		5 },
-	{ OP_GT,	">",		5 },
-	{ OP_GE,	">=",		5 },
-	{ OP_BAND,	"&",		6 },
-	{ OP_NOT,	"!",		6 },
-	{ OP_NONE,	"OP_NONE",	0 },
-	{ OP_OPEN_PAREN, "(",		0 },
-};
+#undef C
+#define C(a, b, c)	{ a, b, c }
 
-enum {
-	FILT_ERR_NONE,
-	FILT_ERR_INVALID_OP,
-	FILT_ERR_UNBALANCED_PAREN,
-	FILT_ERR_TOO_MANY_OPERANDS,
-	FILT_ERR_OPERAND_TOO_LONG,
-	FILT_ERR_FIELD_NOT_FOUND,
-	FILT_ERR_ILLEGAL_FIELD_OP,
-	FILT_ERR_ILLEGAL_INTVAL,
-	FILT_ERR_BAD_SUBSYS_FILTER,
-	FILT_ERR_TOO_MANY_PREDS,
-	FILT_ERR_MISSING_FIELD,
-	FILT_ERR_INVALID_FILTER,
-	FILT_ERR_IP_FIELD_ONLY,
-	FILT_ERR_ILLEGAL_NOT_OP,
-};
+static struct filter_op filter_ops[] = { OPS };
 
-static char *err_text[] = {
-	"No error",
-	"Invalid operator",
-	"Unbalanced parens",
-	"Too many operands",
-	"Operand too long",
-	"Field not found",
-	"Illegal operation for field type",
-	"Illegal integer value",
-	"Couldn't find or set field in one of a subsystem's events",
-	"Too many terms in predicate expression",
-	"Missing field name and/or value",
-	"Meaningless filter expression",
-	"Only 'ip' field is supported for function trace",
-	"Illegal use of '!'",
-};
+#define ERRORS								\
+	C( NONE,	 	"No error"),				\
+	C( INVALID_OP,		"Invalid operator"),			\
+	C( UNBALANCED_PAREN,	"Unbalanced parens"),			\
+	C( TOO_MANY_OPERANDS,	"Too many operands"),			\
+	C( OPERAND_TOO_LONG,	"Operand too long"),			\
+	C( FIELD_NOT_FOUND,	"Field not found"),			\
+	C( ILLEGAL_FIELD_OP,	"Illegal operation for field type"),	\
+	C( ILLEGAL_INTVAL,	"Illegal integer value"),		\
+	C( BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
+	C( TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
+	C( MISSING_FIELD,	"Missing field name and/or value"),	\
+	C( INVALID_FILTER,	"Meaningless filter expression"),	\
+	C( IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
+	C( ILLEGAL_NOT_OP,	"Illegal use of '!'"),
+
+#undef C
+#define C(a, b)		FILT_ERR_##a
+
+enum { ERRORS };
+
+#undef C
+#define C(a, b)		b
+
+static char *err_text[] = { ERRORS };
 
 struct opstack_op {
 	enum filter_op_ids op;
-- 
2.15.1

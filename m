Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCUCWL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeCUCVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DFF21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.991412191@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: [for-next][PATCH 46/46] tracing: Rewrite filter logic to be simpler and faster
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0046-tracing-Rewrite-filter-logic-to-be-simpler-and-faste.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Al Viro reviewed the filter logic of ftrace trace events and found it to be
very troubling. It creates a binary tree based on the logic operators and
walks it during tracing. He sent myself and Tom Zanussi a long explanation
(and formal proof) of how to do the string parsing better and end up with a
program array that can be simply iterated to come up with the correct
results.

I took his ideas and his pseudo code and rewrote the filter logic based on
them. In doing so, I was able to remove a lot of code, and have a much more
condensed filter logic in the process. I wrote a very long comment
describing the methadology that Al proposed in my own words. For more info
on how this works, read the comment above predicate_parse().

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h               |   15 +-
 kernel/trace/trace_events_filter.c | 2311 ++++++++++++++++--------------------
 2 files changed, 1054 insertions(+), 1272 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9de3e2a2f042..6fb46a06c9dc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1216,12 +1216,11 @@ struct ftrace_event_field {
 	int			is_signed;
 };
 
+struct prog_entry;
+
 struct event_filter {
-	int			n_preds;	/* Number assigned */
-	int			a_preds;	/* allocated */
-	struct filter_pred __rcu	*preds;
-	struct filter_pred __rcu	*root;
-	char				*filter_string;
+	struct prog_entry __rcu	*prog;
+	char			*filter_string;
 };
 
 struct event_subsystem {
@@ -1413,12 +1412,8 @@ struct filter_pred {
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
 	int 			offset;
-	int 			not;
+	int			not;
 	int 			op;
-	unsigned short		index;
-	unsigned short		parent;
-	unsigned short		left;
-	unsigned short		right;
 };
 
 static inline bool is_string_field(struct ftrace_event_field *field)
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9d383f4383dc..703a416aa5c2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -33,60 +33,52 @@
 	"# Only events with the given fields will be affected.\n"	\
 	"# If no events are modified, an error message will be displayed here"
 
+/* Due to token parsing '<=' must be before '<' and '>=' must be before '>' */
 #define OPS					\
-	C( OP_OR,	"||",		1 ),	\
-	C( OP_AND,	"&&",		2 ),	\
-	C( OP_GLOB,	"~",		4 ),	\
-	C( OP_NE,	"!=",		4 ),	\
-	C( OP_EQ,	"==",		4 ),	\
-	C( OP_LT,	"<",		5 ),	\
-	C( OP_LE,	"<=",		5 ),	\
-	C( OP_GT,	">",		5 ),	\
-	C( OP_GE,	">=",		5 ),	\
-	C( OP_BAND,	"&",		6 ),	\
-	C( OP_NOT,	"!",		6 ),	\
-	C( OP_NONE,	"OP_NONE",	0 ),	\
-	C( OP_OPEN_PAREN, "(",		0 ),	\
-	C( OP_MAX,	NULL,		0 )
+	C( OP_GLOB,	"~"  ),			\
+	C( OP_NE,	"!=" ),			\
+	C( OP_EQ,	"==" ),			\
+	C( OP_LE,	"<=" ),			\
+	C( OP_LT,	"<"  ),			\
+	C( OP_GE,	">=" ),			\
+	C( OP_GT,	">"  ),			\
+	C( OP_BAND,	"&"  ),			\
+	C( OP_MAX,	NULL )
 
 #undef C
-#define C(a, b, c)	a
+#define C(a, b)	a
 
 enum filter_op_ids { OPS };
 
-struct filter_op {
-	int id;
-	char *string;
-	int precedence;
-};
-
 #undef C
-#define C(a, b, c)	{ a, b, c }
+#define C(a, b)	b
 
-static struct filter_op filter_ops[] = { OPS };
+static const char * ops[] = { OPS };
 
 /*
- * pred functions are OP_LT, OP_LE, OP_GT, OP_GE, and OP_BAND
+ * pred functions are OP_LE, OP_LT, OP_GE, OP_GT, and OP_BAND
  * pred_funcs_##type below must match the order of them above.
  */
-#define PRED_FUNC_START			OP_LT
+#define PRED_FUNC_START			OP_LE
 #define PRED_FUNC_MAX			(OP_BAND - PRED_FUNC_START)
 
 #define ERRORS								\
-	C( NONE,	 	"No error"),				\
-	C( INVALID_OP,		"Invalid operator"),			\
-	C( UNBALANCED_PAREN,	"Unbalanced parens"),			\
-	C( TOO_MANY_OPERANDS,	"Too many operands"),			\
-	C( OPERAND_TOO_LONG,	"Operand too long"),			\
-	C( FIELD_NOT_FOUND,	"Field not found"),			\
-	C( ILLEGAL_FIELD_OP,	"Illegal operation for field type"),	\
-	C( ILLEGAL_INTVAL,	"Illegal integer value"),		\
-	C( BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
-	C( TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
-	C( MISSING_FIELD,	"Missing field name and/or value"),	\
-	C( INVALID_FILTER,	"Meaningless filter expression"),	\
-	C( IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
-	C( ILLEGAL_NOT_OP,	"Illegal use of '!'"),
+	C(NONE,			"No error"),				\
+	C(INVALID_OP,		"Invalid operator"),			\
+	C(TOO_MANY_OPEN,	"Too many '('"),			\
+	C(TOO_MANY_CLOSE,	"Too few '('"),				\
+	C(MISSING_QUOTE,	"Missing matching quote"),		\
+	C(OPERAND_TOO_LONG,	"Operand too long"),			\
+	C(EXPECT_STRING,	"Expecting string field"),		\
+	C(EXPECT_DIGIT,		"Expecting numeric field"),		\
+	C(ILLEGAL_FIELD_OP,	"Illegal operation for field type"),	\
+	C(FIELD_NOT_FOUND,	"Field not found"),			\
+	C(ILLEGAL_INTVAL,	"Illegal integer value"),		\
+	C(BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
+	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
+	C(INVALID_FILTER,	"Meaningless filter expression"),	\
+	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
+	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"),
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -98,84 +90,535 @@ enum { ERRORS };
 
 static char *err_text[] = { ERRORS };
 
-struct opstack_op {
-	enum filter_op_ids op;
-	struct list_head list;
-};
+/* Called after a '!' character but "!=" and "!~" are not "not"s */
+static bool is_not(const char *str)
+{
+	switch (str[1]) {
+	case '=':
+	case '~':
+		return false;
+	}
+	return true;
+}
 
-struct postfix_elt {
-	enum filter_op_ids op;
-	char *operand;
-	struct list_head list;
+/**
+ * prog_entry - a singe entry in the filter program
+ * @target:	     Index to jump to on a branch (actually one minus the index)
+ * @when_to_branch:  The value of the result of the predicate to do a branch
+ * @pred:	     The predicate to execute.
+ */
+struct prog_entry {
+	int			target;
+	int			when_to_branch;
+	struct filter_pred	*pred;
 };
 
-struct filter_parse_state {
-	struct filter_op *ops;
-	struct list_head opstack;
-	struct list_head postfix;
+/**
+ * update_preds- assign a program entry a label target
+ * @prog: The program array
+ * @N: The index of the current entry in @prog
+ * @when_to_branch: What to assign a program entry for its branch condition
+ *
+ * The program entry at @N has a target that points to the index of a program
+ * entry that can have its target and when_to_branch fields updated.
+ * Update the current program entry denoted by index @N target field to be
+ * that of the updated entry. This will denote the entry to update if
+ * we are processing an "||" after an "&&"
+ */
+static void update_preds(struct prog_entry *prog, int N, int invert)
+{
+	int t, s;
+
+	t = prog[N].target;
+	s = prog[t].target;
+	prog[t].when_to_branch = invert;
+	prog[t].target = N;
+	prog[N].target = s;
+}
+
+struct filter_parse_error {
 	int lasterr;
 	int lasterr_pos;
-
-	struct {
-		char *string;
-		unsigned int cnt;
-		unsigned int tail;
-	} infix;
-
-	struct {
-		char string[MAX_FILTER_STR_VAL];
-		int pos;
-		unsigned int tail;
-	} operand;
 };
 
-struct pred_stack {
-	struct filter_pred	**preds;
-	int			index;
+static void parse_error(struct filter_parse_error *pe, int err, int pos)
+{
+	pe->lasterr = err;
+	pe->lasterr_pos = pos;
+}
+
+typedef int (*parse_pred_fn)(const char *str, void *data, int pos,
+			     struct filter_parse_error *pe,
+			     struct filter_pred **pred);
+
+enum {
+	INVERT		= 1,
+	PROCESS_AND	= 2,
+	PROCESS_OR	= 4,
 };
 
-/* If not of not match is equal to not of not, then it is a match */
+/*
+ * Without going into a formal proof, this explains the method that is used in
+ * parsing the logical expressions.
+ *
+ * For example, if we have: "a && !(!b || (c && g)) || d || e && !f"
+ * The first pass will convert it into the following program:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto l4;
+ * n4: r=g; r=!r; l4: if (r) goto l5;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto l7;
+ * n7: r=f; r=!r; l7: if (!r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * To do this, we use a data structure to represent each of the above
+ * predicate and conditions that has:
+ *
+ *  predicate, when_to_branch, invert, target
+ *
+ * The "predicate" will hold the function to determine the result "r".
+ * The "when_to_branch" denotes what "r" should be if a branch is to be taken
+ * "&&" would contain "!r" or (0) and "||" would contain "r" or (1).
+ * The "invert" holds whether the value should be reversed before testing.
+ * The "target" contains the label "l#" to jump to.
+ *
+ * A stack is created to hold values when parentheses are used.
+ *
+ * To simplify the logic, the labels will start at 0 and not 1.
+ *
+ * The possible invert values are 1 and 0. The number of "!"s that are in scope
+ * before the predicate determines the invert value, if the number is odd then
+ * the invert value is 1 and 0 otherwise. This means the invert value only
+ * needs to be toggled when a new "!" is introduced compared to what is stored
+ * on the stack, where parentheses were used.
+ *
+ * The top of the stack and "invert" are initialized to zero.
+ *
+ * ** FIRST PASS **
+ *
+ * #1 A loop through all the tokens is done:
+ *
+ * #2 If the token is an "(", the stack is push, and the current stack value
+ *    gets the current invert value, and the loop continues to the next token.
+ *    The top of the stack saves the "invert" value to keep track of what
+ *    the current inversion is. As "!(a && !b || c)" would require all
+ *    predicates being affected separately by the "!" before the parentheses.
+ *    And that would end up being equivalent to "(!a || b) && !c"
+ *
+ * #3 If the token is an "!", the current "invert" value gets inverted, and
+ *    the loop continues. Note, if the next token is a predicate, then
+ *    this "invert" value is only valid for the current program entry,
+ *    and does not affect other predicates later on.
+ *
+ * The only other acceptable token is the predicate string.
+ *
+ * #4 A new entry into the program is added saving: the predicate and the
+ *    current value of "invert". The target is currently assigned to the
+ *    previous program index (this will not be its final value).
+ *
+ * #5 We now enter another loop and look at the next token. The only valid
+ *    tokens are ")", "&&", "||" or end of the input string "\0".
+ *
+ * #6 The invert variable is reset to the current value saved on the top of
+ *    the stack.
+ *
+ * #7 The top of the stack holds not only the current invert value, but also
+ *    if a "&&" or "||" needs to be processed. Note, the "&&" takes higher
+ *    precedence than "||". That is "a && b || c && d" is equivalent to
+ *    "(a && b) || (c && d)". Thus the first thing to do is to see if "&&" needs
+ *    to be processed. This is the case if an "&&" was the last token. If it was
+ *    then we call update_preds(). This takes the program, the current index in
+ *    the program, and the current value of "invert".  More will be described
+ *    below about this function.
+ *
+ * #8 If the next token is "&&" then we set a flag in the top of the stack
+ *    that denotes that "&&" needs to be processed, break out of this loop
+ *    and continue with the outer loop.
+ *
+ * #9 Otherwise, if a "||" needs to be processed then update_preds() is called.
+ *    This is called with the program, the current index in the program, but
+ *    this time with an inverted value of "invert" (that is !invert). This is
+ *    because the value taken will become the "when_to_branch" value of the
+ *    program.
+ *    Note, this is called when the next token is not an "&&". As stated before,
+ *    "&&" takes higher precedence, and "||" should not be processed yet if the
+ *    next logical operation is "&&".
+ *
+ * #10 If the next token is "||" then we set a flag in the top of the stack
+ *     that denotes that "||" needs to be processed, break out of this loop
+ *     and continue with the outer loop.
+ *
+ * #11 If this is the end of the input string "\0" then we break out of both
+ *     loops.
+ *
+ * #12 Otherwise, the next token is ")", where we pop the stack and continue
+ *     this inner loop.
+ *
+ * Now to discuss the update_pred() function, as that is key to the setting up
+ * of the program. Remember the "target" of the program is initialized to the
+ * previous index and not the "l" label. The target holds the index into the
+ * program that gets affected by the operand. Thus if we have something like
+ *  "a || b && c", when we process "a" the target will be "-1" (undefined).
+ * When we process "b", its target is "0", which is the index of "a", as that's
+ * the predicate that is affected by "||". But because the next token after "b"
+ * is "&&" we don't call update_preds(). Instead continue to "c". As the
+ * next token after "c" is not "&&" but the end of input, we first process the
+ * "&&" by calling update_preds() for the "&&" then we process the "||" by
+ * callin updates_preds() with the values for processing "||".
+ *
+ * What does that mean? What update_preds() does is to first save the "target"
+ * of the program entry indexed by the current program entry's "target"
+ * (remember the "target" is initialized to previous program entry), and then
+ * sets that "target" to the current index which represents the label "l#".
+ * That entry's "when_to_branch" is set to the value passed in (the "invert"
+ * or "!invert"). Then it sets the current program entry's target to the saved
+ * "target" value (the old value of the program that had its "target" updated
+ * to the label).
+ *
+ * Looking back at "a || b && c", we have the following steps:
+ *  "a"  - prog[0] = { "a", X, -1 } // pred, when_to_branch, target
+ *  "||" - flag that we need to process "||"; continue outer loop
+ *  "b"  - prog[1] = { "b", X, 0 }
+ *  "&&" - flag that we need to process "&&"; continue outer loop
+ * (Notice we did not process "||")
+ *  "c"  - prog[2] = { "c", X, 1 }
+ *  update_preds(prog, 2, 0); // invert = 0 as we are processing "&&"
+ *    t = prog[2].target; // t = 1
+ *    s = prog[t].target; // s = 0
+ *    prog[t].target = 2; // Set target to "l2"
+ *    prog[t].when_to_branch = 0;
+ *    prog[2].target = s;
+ * update_preds(prog, 2, 1); // invert = 1 as we are now processing "||"
+ *    t = prog[2].target; // t = 0
+ *    s = prog[t].target; // s = -1
+ *    prog[t].target = 2; // Set target to "l2"
+ *    prog[t].when_to_branch = 1;
+ *    prog[2].target = s;
+ *
+ * #13 Which brings us to the final step of the first pass, which is to set
+ *     the last program entry's when_to_branch and target, which will be
+ *     when_to_branch = 0; target = N; ( the label after the program entry after
+ *     the last program entry processed above).
+ *
+ * If we denote "TRUE" to be the entry after the last program entry processed,
+ * and "FALSE" the program entry after that, we are now done with the first
+ * pass.
+ *
+ * Making the above "a || b && c" have a progam of:
+ *  prog[0] = { "a", 1, 2 }
+ *  prog[1] = { "b", 0, 2 }
+ *  prog[2] = { "c", 0, 3 }
+ *
+ * Which translates into:
+ * n0: r = a; l0: if (r) goto l2;
+ * n1: r = b; l1: if (!r) goto l2;
+ * n2: r = c; l2: if (!r) goto l3;  // Which is the same as "goto F;"
+ * T: return TRUE; l3:
+ * F: return FALSE
+ *
+ * Although, after the first pass, the program is correct, it is
+ * inefficient. The simple sample of "a || b && c" could be easily been
+ * converted into:
+ * n0: r = a; if (r) goto T
+ * n1: r = b; if (!r) goto F
+ * n2: r = c; if (!r) goto F
+ * T: return TRUE;
+ * F: return FALSE;
+ *
+ * The First Pass is over the input string. The next too passes are over
+ * the program itself.
+ *
+ * ** SECOND PASS **
+ *
+ * Which brings us to the second pass. If a jump to a label has the
+ * same condition as that label, it can instead jump to its target.
+ * The original example of "a && !(!b || (c && g)) || d || e && !f"
+ * where the first pass gives us:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto l4;
+ * n4: r=g; r=!r; l4: if (r) goto l5;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto l7;
+ * n7: r=f; r=!r; l7: if (!r) goto F:
+ * T: return TRUE;
+ * F: return FALSE
+ *
+ * We can see that "l3: if (r) goto l4;" and at l4, we have "if (r) goto l5;".
+ * And "l5: if (r) goto T", we could optimize this by converting l3 and l4
+ * to go directly to T. To accomplish this, we start from the last
+ * entry in the program and work our way back. If the target of the entry
+ * has the same "when_to_branch" then we could use that entry's target.
+ * Doing this, the above would end up as:
+ *
+ * n1: r=a;       l1: if (!r) goto l4;
+ * n2: r=b;       l2: if (!r) goto l4;
+ * n3: r=c; r=!r; l3: if (r) goto T;
+ * n4: r=g; r=!r; l4: if (r) goto T;
+ * n5: r=d;       l5: if (r) goto T;
+ * n6: r=e;       l6: if (!r) goto F;
+ * n7: r=f; r=!r; l7: if (!r) goto F;
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * In that same pass, if the "when_to_branch" doesn't match, we can simply
+ * go to the program entry after the label. That is, "l2: if (!r) goto l4;"
+ * where "l4: if (r) goto T;", then we can convert l2 to be:
+ * "l2: if (!r) goto n5;".
+ *
+ * This will have the second pass give us:
+ * n1: r=a;       l1: if (!r) goto n5;
+ * n2: r=b;       l2: if (!r) goto n5;
+ * n3: r=c; r=!r; l3: if (r) goto T;
+ * n4: r=g; r=!r; l4: if (r) goto T;
+ * n5: r=d;       l5: if (r) goto T
+ * n6: r=e;       l6: if (!r) goto F;
+ * n7: r=f; r=!r; l7: if (!r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * Notice, all the "l#" labels are no longer used, and they can now
+ * be discarded.
+ *
+ * ** THIRD PASS **
+ *
+ * For the third pass we deal with the inverts. As they simply just
+ * make the "when_to_branch" get inverted, a simple loop over the
+ * program to that does: "when_to_branch ^= invert;" will do the
+ * job, leaving us with:
+ * n1: r=a; if (!r) goto n5;
+ * n2: r=b; if (!r) goto n5;
+ * n3: r=c: if (!r) goto T;
+ * n4: r=g; if (!r) goto T;
+ * n5: r=d; if (r) goto T
+ * n6: r=e; if (!r) goto F;
+ * n7: r=f; if (r) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * As "r = a; if (!r) goto n5;" is obviously the same as
+ * "if (!a) goto n5;" without doing anything we can interperate the
+ * program as:
+ * n1: if (!a) goto n5;
+ * n2: if (!b) goto n5;
+ * n3: if (!c) goto T;
+ * n4: if (!g) goto T;
+ * n5: if (d) goto T
+ * n6: if (!e) goto F;
+ * n7: if (f) goto F
+ * T: return TRUE
+ * F: return FALSE
+ *
+ * Since the inverts are discarded at the end, there's no reason to store
+ * them in the program array (and waste memory). A separate array to hold
+ * the inverts is used and freed at the end.
+ */
+static struct prog_entry *
+predicate_parse(const char *str, int nr_parens, int nr_preds,
+		parse_pred_fn parse_pred, void *data,
+		struct filter_parse_error *pe)
+{
+	struct prog_entry *prog_stack;
+	struct prog_entry *prog;
+	const char *ptr = str;
+	char *inverts = NULL;
+	int *op_stack;
+	int *top;
+	int invert = 0;
+	int ret = -ENOMEM;
+	int len;
+	int N = 0;
+	int i;
+
+	nr_preds += 2; /* For TRUE and FALSE */
+
+	op_stack = kmalloc(sizeof(*op_stack) * nr_parens, GFP_KERNEL);
+	if (!op_stack)
+		return ERR_PTR(-ENOMEM);
+	prog_stack = kmalloc(sizeof(*prog_stack) * nr_preds, GFP_KERNEL);
+	if (!prog_stack) {
+		parse_error(pe, -ENOMEM, 0);
+		goto out_free;
+	}
+	inverts = kmalloc(sizeof(*inverts) * nr_preds, GFP_KERNEL);
+	if (!inverts) {
+		parse_error(pe, -ENOMEM, 0);
+		goto out_free;
+	}
+
+	top = op_stack;
+	prog = prog_stack;
+	*top = 0;
+
+	/* First pass */
+	while (*ptr) {						/* #1 */
+		const char *next = ptr++;
+
+		if (isspace(*next))
+			continue;
+
+		switch (*next) {
+		case '(':					/* #2 */
+			if (top - op_stack > nr_parens)
+				return ERR_PTR(-EINVAL);
+			*(++top) = invert;
+			continue;
+		case '!':					/* #3 */
+			if (!is_not(next))
+				break;
+			invert = !invert;
+			continue;
+		}
+
+		if (N >= nr_preds) {
+			parse_error(pe, FILT_ERR_TOO_MANY_PREDS, next - str);
+			goto out_free;
+		}
+
+		inverts[N] = invert;				/* #4 */
+		prog[N].target = N-1;
+
+		len = parse_pred(next, data, ptr - str, pe, &prog[N].pred);
+		if (len < 0) {
+			ret = len;
+			goto out_free;
+		}
+		ptr = next + len;
+
+		N++;
+
+		ret = -1;
+		while (1) {					/* #5 */
+			next = ptr++;
+			if (isspace(*next))
+				continue;
+
+			switch (*next) {
+			case ')':
+			case '\0':
+				break;
+			case '&':
+			case '|':
+				if (next[1] == next[0]) {
+					ptr++;
+					break;
+				}
+			default:
+				parse_error(pe, FILT_ERR_TOO_MANY_PREDS,
+					    next - str);
+				goto out_free;
+			}
+
+			invert = *top & INVERT;
+
+			if (*top & PROCESS_AND) {		/* #7 */
+				update_preds(prog, N - 1, invert);
+				*top &= ~PROCESS_AND;
+			}
+			if (*next == '&') {			/* #8 */
+				*top |= PROCESS_AND;
+				break;
+			}
+			if (*top & PROCESS_OR) {		/* #9 */
+				update_preds(prog, N - 1, !invert);
+				*top &= ~PROCESS_OR;
+			}
+			if (*next == '|') {			/* #10 */
+				*top |= PROCESS_OR;
+				break;
+			}
+			if (!*next)				/* #11 */
+				goto out;
+
+			if (top == op_stack) {
+				ret = -1;
+				/* Too few '(' */
+				parse_error(pe, FILT_ERR_TOO_MANY_CLOSE, ptr - str);
+				goto out_free;
+			}
+			top--;					/* #12 */
+		}
+	}
+ out:
+	if (top != op_stack) {
+		/* Too many '(' */
+		parse_error(pe, FILT_ERR_TOO_MANY_OPEN, ptr - str);
+		goto out_free;
+	}
+
+	prog[N].pred = NULL;					/* #13 */
+	prog[N].target = 1;		/* TRUE */
+	prog[N+1].pred = NULL;
+	prog[N+1].target = 0;		/* FALSE */
+	prog[N-1].target = N;
+	prog[N-1].when_to_branch = false;
+
+	/* Second Pass */
+	for (i = N-1 ; i--; ) {
+		int target = prog[i].target;
+		if (prog[i].when_to_branch == prog[target].when_to_branch)
+			prog[i].target = prog[target].target;
+	}
+
+	/* Third Pass */
+	for (i = 0; i < N; i++) {
+		invert = inverts[i] ^ prog[i].when_to_branch;
+		prog[i].when_to_branch = invert;
+		/* Make sure the program always moves forward */
+		if (WARN_ON(prog[i].target <= i)) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	return prog;
+out_free:
+	kfree(op_stack);
+	kfree(prog_stack);
+	kfree(inverts);
+	return ERR_PTR(ret);
+}
+
 #define DEFINE_COMPARISON_PRED(type)					\
 static int filter_pred_LT_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr < val);					\
-	return !!match == !pred->not;					\
+	return *addr < val;						\
 }									\
 static int filter_pred_LE_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr <= val);					\
-	return !!match == !pred->not;					\
+	return *addr <= val;						\
 }									\
 static int filter_pred_GT_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr > val);					\
-	return !!match == !pred->not;					\
+	return *addr > val;					\
 }									\
 static int filter_pred_GE_##type(struct filter_pred *pred, void *event)	\
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = (*addr >= val);					\
-	return !!match == !pred->not;					\
+	return *addr >= val;						\
 }									\
 static int filter_pred_BAND_##type(struct filter_pred *pred, void *event) \
 {									\
 	type *addr = (type *)(event + pred->offset);			\
 	type val = (type)pred->val;					\
-	int match = !!(*addr & val);					\
-	return match == !pred->not;					\
+	return !!(*addr & val);						\
 }									\
 static const filter_pred_fn_t pred_funcs_##type[] = {			\
-	filter_pred_LT_##type,						\
 	filter_pred_LE_##type,						\
-	filter_pred_GT_##type,						\
+	filter_pred_LT_##type,						\
 	filter_pred_GE_##type,						\
+	filter_pred_GT_##type,						\
 	filter_pred_BAND_##type,					\
 };
 
@@ -261,44 +704,36 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 static int filter_pred_cpu(struct filter_pred *pred, void *event)
 {
 	int cpu, cmp;
-	int match = 0;
 
 	cpu = raw_smp_processor_id();
 	cmp = pred->val;
 
 	switch (pred->op) {
 	case OP_EQ:
-		match = cpu == cmp;
-		break;
+		return cpu == cmp;
+	case OP_NE:
+		return cpu != cmp;
 	case OP_LT:
-		match = cpu < cmp;
-		break;
+		return cpu < cmp;
 	case OP_LE:
-		match = cpu <= cmp;
-		break;
+		return cpu <= cmp;
 	case OP_GT:
-		match = cpu > cmp;
-		break;
+		return cpu > cmp;
 	case OP_GE:
-		match = cpu >= cmp;
-		break;
+		return cpu >= cmp;
 	default:
-		break;
+		return 0;
 	}
-
-	return !!match == !pred->not;
 }
 
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
-	int cmp, match;
+	int cmp;
 
 	cmp = pred->regex.match(current->comm, &pred->regex,
-				pred->regex.field_len);
-	match = cmp ^ pred->not;
-
-	return match;
+				TASK_COMM_LEN);
+	return cmp ^ pred->not;
 }
 
 static int filter_pred_none(struct filter_pred *pred, void *event)
@@ -355,6 +790,7 @@ static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
 		return 1;
 	return 0;
 }
+
 /**
  * filter_parse_regex - parse a basic regex
  * @buff:   the raw regex
@@ -415,10 +851,9 @@ static void filter_build_regex(struct filter_pred *pred)
 	struct regex *r = &pred->regex;
 	char *search;
 	enum regex_type type = MATCH_FULL;
-	int not = 0;
 
 	if (pred->op == OP_GLOB) {
-		type = filter_parse_regex(r->pattern, r->len, &search, &not);
+		type = filter_parse_regex(r->pattern, r->len, &search, &pred->not);
 		r->len = strlen(search);
 		memmove(r->pattern, search, r->len+1);
 	}
@@ -440,210 +875,32 @@ static void filter_build_regex(struct filter_pred *pred)
 		r->match = regex_match_glob;
 		break;
 	}
-
-	pred->not ^= not;
-}
-
-enum move_type {
-	MOVE_DOWN,
-	MOVE_UP_FROM_LEFT,
-	MOVE_UP_FROM_RIGHT
-};
-
-static struct filter_pred *
-get_pred_parent(struct filter_pred *pred, struct filter_pred *preds,
-		int index, enum move_type *move)
-{
-	if (pred->parent & FILTER_PRED_IS_RIGHT)
-		*move = MOVE_UP_FROM_RIGHT;
-	else
-		*move = MOVE_UP_FROM_LEFT;
-	pred = &preds[pred->parent & ~FILTER_PRED_IS_RIGHT];
-
-	return pred;
-}
-
-enum walk_return {
-	WALK_PRED_ABORT,
-	WALK_PRED_PARENT,
-	WALK_PRED_DEFAULT,
-};
-
-typedef int (*filter_pred_walkcb_t) (enum move_type move,
-				     struct filter_pred *pred,
-				     int *err, void *data);
-
-static int walk_pred_tree(struct filter_pred *preds,
-			  struct filter_pred *root,
-			  filter_pred_walkcb_t cb, void *data)
-{
-	struct filter_pred *pred = root;
-	enum move_type move = MOVE_DOWN;
-	int done = 0;
-
-	if  (!preds)
-		return -EINVAL;
-
-	do {
-		int err = 0, ret;
-
-		ret = cb(move, pred, &err, data);
-		if (ret == WALK_PRED_ABORT)
-			return err;
-		if (ret == WALK_PRED_PARENT)
-			goto get_parent;
-
-		switch (move) {
-		case MOVE_DOWN:
-			if (pred->left != FILTER_PRED_INVALID) {
-				pred = &preds[pred->left];
-				continue;
-			}
-			goto get_parent;
-		case MOVE_UP_FROM_LEFT:
-			pred = &preds[pred->right];
-			move = MOVE_DOWN;
-			continue;
-		case MOVE_UP_FROM_RIGHT:
- get_parent:
-			if (pred == root)
-				break;
-			pred = get_pred_parent(pred, preds,
-					       pred->parent,
-					       &move);
-			continue;
-		}
-		done = 1;
-	} while (!done);
-
-	/* We are fine. */
-	return 0;
-}
-
-/*
- * A series of AND or ORs where found together. Instead of
- * climbing up and down the tree branches, an array of the
- * ops were made in order of checks. We can just move across
- * the array and short circuit if needed.
- */
-static int process_ops(struct filter_pred *preds,
-		       struct filter_pred *op, void *rec)
-{
-	struct filter_pred *pred;
-	int match = 0;
-	int type;
-	int i;
-
-	/*
-	 * Micro-optimization: We set type to true if op
-	 * is an OR and false otherwise (AND). Then we
-	 * just need to test if the match is equal to
-	 * the type, and if it is, we can short circuit the
-	 * rest of the checks:
-	 *
-	 * if ((match && op->op == OP_OR) ||
-	 *     (!match && op->op == OP_AND))
-	 *	  return match;
-	 */
-	type = op->op == OP_OR;
-
-	for (i = 0; i < op->val; i++) {
-		pred = &preds[op->ops[i]];
-		if (!WARN_ON_ONCE(!pred->fn))
-			match = pred->fn(pred, rec);
-		if (!!match == type)
-			break;
-	}
-	/* If not of not match is equal to not of not, then it is a match */
-	return !!match == !op->not;
-}
-
-struct filter_match_preds_data {
-	struct filter_pred *preds;
-	int match;
-	void *rec;
-};
-
-static int filter_match_preds_cb(enum move_type move, struct filter_pred *pred,
-				 int *err, void *data)
-{
-	struct filter_match_preds_data *d = data;
-
-	*err = 0;
-	switch (move) {
-	case MOVE_DOWN:
-		/* only AND and OR have children */
-		if (pred->left != FILTER_PRED_INVALID) {
-			/* If ops is set, then it was folded. */
-			if (!pred->ops)
-				return WALK_PRED_DEFAULT;
-			/* We can treat folded ops as a leaf node */
-			d->match = process_ops(d->preds, pred, d->rec);
-		} else {
-			if (!WARN_ON_ONCE(!pred->fn))
-				d->match = pred->fn(pred, d->rec);
-		}
-
-		return WALK_PRED_PARENT;
-	case MOVE_UP_FROM_LEFT:
-		/*
-		 * Check for short circuits.
-		 *
-		 * Optimization: !!match == (pred->op == OP_OR)
-		 *   is the same as:
-		 * if ((match && pred->op == OP_OR) ||
-		 *     (!match && pred->op == OP_AND))
-		 */
-		if (!!d->match == (pred->op == OP_OR))
-			return WALK_PRED_PARENT;
-		break;
-	case MOVE_UP_FROM_RIGHT:
-		break;
-	}
-
-	return WALK_PRED_DEFAULT;
 }
 
 /* return 1 if event matches, 0 otherwise (discard) */
 int filter_match_preds(struct event_filter *filter, void *rec)
 {
-	struct filter_pred *preds;
-	struct filter_pred *root;
-	struct filter_match_preds_data data = {
-		/* match is currently meaningless */
-		.match = -1,
-		.rec   = rec,
-	};
-	int n_preds, ret;
+	struct prog_entry *prog;
+	int i;
 
 	/* no filter is considered a match */
 	if (!filter)
 		return 1;
 
-	n_preds = filter->n_preds;
-	if (!n_preds)
+	prog = rcu_dereference_sched(filter->prog);
+	if (!prog)
 		return 1;
 
-	/*
-	 * n_preds, root and filter->preds are protect with preemption disabled.
-	 */
-	root = rcu_dereference_sched(filter->root);
-	if (!root)
-		return 1;
-
-	data.preds = preds = rcu_dereference_sched(filter->preds);
-	ret = walk_pred_tree(preds, root, filter_match_preds_cb, &data);
-	WARN_ON(ret);
-	return data.match;
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
+		int match = pred->fn(pred, rec);
+		if (match == prog[i].when_to_branch)
+			i = prog[i].target;
+	}
+	return prog[i].target;
 }
 EXPORT_SYMBOL_GPL(filter_match_preds);
 
-static void parse_error(struct filter_parse_state *ps, int err, int pos)
-{
-	ps->lasterr = err;
-	ps->lasterr_pos = pos;
-}
-
 static void remove_filter_string(struct event_filter *filter)
 {
 	if (!filter)
@@ -653,11 +910,11 @@ static void remove_filter_string(struct event_filter *filter)
 	filter->filter_string = NULL;
 }
 
-static void append_filter_err(struct filter_parse_state *ps,
+static void append_filter_err(struct filter_parse_error *pe,
 			      struct event_filter *filter)
 {
 	struct trace_seq *s;
-	int pos = ps->lasterr_pos;
+	int pos = pe->lasterr_pos;
 	char *buf;
 	int len;
 
@@ -671,11 +928,19 @@ static void append_filter_err(struct filter_parse_state *ps,
 
 	len = strlen(filter->filter_string);
 	if (pos > len)
-		len = pos;
+		pos = len;
+
+	/* indexing is off by one */
+	if (pos)
+		pos++;
 
 	trace_seq_puts(s, filter->filter_string);
-	trace_seq_printf(s, "\n%*s", pos, "^");
-	trace_seq_printf(s, "\nparse_error: %s\n", err_text[ps->lasterr]);
+	if (pe->lasterr > 0) {
+		trace_seq_printf(s, "\n%*s", pos, "^");
+		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+	} else {
+		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+	}
 	trace_seq_putc(s, 0);
 	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
 	if (buf) {
@@ -715,108 +980,18 @@ void print_subsystem_event_filter(struct event_subsystem *system,
 	mutex_unlock(&event_mutex);
 }
 
-static int __alloc_pred_stack(struct pred_stack *stack, int n_preds)
-{
-	stack->preds = kcalloc(n_preds + 1, sizeof(*stack->preds), GFP_KERNEL);
-	if (!stack->preds)
-		return -ENOMEM;
-	stack->index = n_preds;
-	return 0;
-}
-
-static void __free_pred_stack(struct pred_stack *stack)
-{
-	kfree(stack->preds);
-	stack->index = 0;
-}
-
-static int __push_pred_stack(struct pred_stack *stack,
-			     struct filter_pred *pred)
-{
-	int index = stack->index;
-
-	if (WARN_ON(index == 0))
-		return -ENOSPC;
-
-	stack->preds[--index] = pred;
-	stack->index = index;
-	return 0;
-}
-
-static struct filter_pred *
-__pop_pred_stack(struct pred_stack *stack)
-{
-	struct filter_pred *pred;
-	int index = stack->index;
-
-	pred = stack->preds[index++];
-	if (!pred)
-		return NULL;
-
-	stack->index = index;
-	return pred;
-}
-
-static int filter_set_pred(struct event_filter *filter,
-			   int idx,
-			   struct pred_stack *stack,
-			   struct filter_pred *src)
-{
-	struct filter_pred *dest = &filter->preds[idx];
-	struct filter_pred *left;
-	struct filter_pred *right;
-
-	*dest = *src;
-	dest->index = idx;
-
-	if (dest->op == OP_OR || dest->op == OP_AND) {
-		right = __pop_pred_stack(stack);
-		left = __pop_pred_stack(stack);
-		if (!left || !right)
-			return -EINVAL;
-		/*
-		 * If both children can be folded
-		 * and they are the same op as this op or a leaf,
-		 * then this op can be folded.
-		 */
-		if (left->index & FILTER_PRED_FOLD &&
-		    ((left->op == dest->op && !left->not) ||
-		     left->left == FILTER_PRED_INVALID) &&
-		    right->index & FILTER_PRED_FOLD &&
-		    ((right->op == dest->op && !right->not) ||
-		     right->left == FILTER_PRED_INVALID))
-			dest->index |= FILTER_PRED_FOLD;
-
-		dest->left = left->index & ~FILTER_PRED_FOLD;
-		dest->right = right->index & ~FILTER_PRED_FOLD;
-		left->parent = dest->index & ~FILTER_PRED_FOLD;
-		right->parent = dest->index | FILTER_PRED_IS_RIGHT;
-	} else {
-		/*
-		 * Make dest->left invalid to be used as a quick
-		 * way to know this is a leaf node.
-		 */
-		dest->left = FILTER_PRED_INVALID;
-
-		/* All leafs allow folding the parent ops. */
-		dest->index |= FILTER_PRED_FOLD;
-	}
-
-	return __push_pred_stack(stack, dest);
-}
-
-static void __free_preds(struct event_filter *filter)
+static void free_prog(struct event_filter *filter)
 {
+	struct prog_entry *prog;
 	int i;
 
-	if (filter->preds) {
-		for (i = 0; i < filter->n_preds; i++)
-			kfree(filter->preds[i].ops);
-		kfree(filter->preds);
-		filter->preds = NULL;
-	}
-	filter->a_preds = 0;
-	filter->n_preds = 0;
+	prog = rcu_access_pointer(filter->prog);
+	if (!prog)
+		return;
+
+	for (i = 0; prog[i].pred; i++)
+		kfree(prog[i].pred);
+	kfree(prog);
 }
 
 static void filter_disable(struct trace_event_file *file)
@@ -834,7 +1009,7 @@ static void __free_filter(struct event_filter *filter)
 	if (!filter)
 		return;
 
-	__free_preds(filter);
+	free_prog(filter);
 	kfree(filter->filter_string);
 	kfree(filter);
 }
@@ -844,30 +1019,6 @@ void free_event_filter(struct event_filter *filter)
 	__free_filter(filter);
 }
 
-static int __alloc_preds(struct event_filter *filter, int n_preds)
-{
-	struct filter_pred *pred;
-	int i;
-
-	if (filter->preds)
-		__free_preds(filter);
-
-	filter->preds = kcalloc(n_preds, sizeof(*filter->preds), GFP_KERNEL);
-
-	if (!filter->preds)
-		return -ENOMEM;
-
-	filter->a_preds = n_preds;
-	filter->n_preds = 0;
-
-	for (i = 0; i < n_preds; i++) {
-		pred = &filter->preds[i];
-		pred->fn = filter_pred_none;
-	}
-
-	return 0;
-}
-
 static inline void __remove_filter(struct trace_event_file *file)
 {
 	filter_disable(file);
@@ -898,812 +1049,466 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 	struct trace_event_file *file;
 
 	list_for_each_entry(file, &tr->events, list) {
-		if (file->system != dir)
-			continue;
-		__free_subsystem_filter(file);
-	}
-}
-
-static int filter_add_pred(struct filter_parse_state *ps,
-			   struct event_filter *filter,
-			   struct filter_pred *pred,
-			   struct pred_stack *stack)
-{
-	int err;
-
-	if (WARN_ON(filter->n_preds == filter->a_preds)) {
-		parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-		return -ENOSPC;
-	}
-
-	err = filter_set_pred(filter, filter->n_preds, stack, pred);
-	if (err)
-		return err;
-
-	filter->n_preds++;
-
-	return 0;
-}
-
-int filter_assign_type(const char *type)
-{
-	if (strstr(type, "__data_loc") && strstr(type, "char"))
-		return FILTER_DYN_STRING;
-
-	if (strchr(type, '[') && strstr(type, "char"))
-		return FILTER_STATIC_STRING;
-
-	return FILTER_OTHER;
-}
-
-static bool is_legal_op(struct ftrace_event_field *field, enum filter_op_ids op)
-{
-	if (is_string_field(field) &&
-	    (op != OP_EQ && op != OP_NE && op != OP_GLOB))
-		return false;
-	if (!is_string_field(field) && op == OP_GLOB)
-		return false;
-
-	return true;
-}
-
-static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
-					    int field_size, int field_is_signed)
-{
-	filter_pred_fn_t fn = NULL;
-	int pred_func_index = -1;
-
-	switch (op) {
-	case OP_EQ:
-	case OP_NE:
-		break;
-	default:
-		if (WARN_ON_ONCE(op < PRED_FUNC_START))
-			return NULL;
-		pred_func_index = op - PRED_FUNC_START;
-		if (WARN_ON_ONCE(pred_func_index > PRED_FUNC_MAX))
-			return NULL;
-	}
-
-	switch (field_size) {
-	case 8:
-		if (pred_func_index < 0)
-			fn = filter_pred_64;
-		else if (field_is_signed)
-			fn = pred_funcs_s64[pred_func_index];
-		else
-			fn = pred_funcs_u64[pred_func_index];
-		break;
-	case 4:
-		if (pred_func_index < 0)
-			fn = filter_pred_32;
-		else if (field_is_signed)
-			fn = pred_funcs_s32[pred_func_index];
-		else
-			fn = pred_funcs_u32[pred_func_index];
-		break;
-	case 2:
-		if (pred_func_index < 0)
-			fn = filter_pred_16;
-		else if (field_is_signed)
-			fn = pred_funcs_s16[pred_func_index];
-		else
-			fn = pred_funcs_u16[pred_func_index];
-		break;
-	case 1:
-		if (pred_func_index < 0)
-			fn = filter_pred_8;
-		else if (field_is_signed)
-			fn = pred_funcs_s8[pred_func_index];
-		else
-			fn = pred_funcs_u8[pred_func_index];
-		break;
-	}
-
-	return fn;
-}
-
-static int init_pred(struct filter_parse_state *ps,
-		     struct ftrace_event_field *field,
-		     struct filter_pred *pred)
-
-{
-	filter_pred_fn_t fn = filter_pred_none;
-	unsigned long long val;
-	int ret;
-
-	pred->offset = field->offset;
-
-	if (!is_legal_op(field, pred->op)) {
-		parse_error(ps, FILT_ERR_ILLEGAL_FIELD_OP, 0);
-		return -EINVAL;
-	}
-
-	if (field->filter_type == FILTER_COMM) {
-		filter_build_regex(pred);
-		fn = filter_pred_comm;
-		pred->regex.field_len = TASK_COMM_LEN;
-	} else if (is_string_field(field)) {
-		filter_build_regex(pred);
-
-		if (field->filter_type == FILTER_STATIC_STRING) {
-			fn = filter_pred_string;
-			pred->regex.field_len = field->size;
-		} else if (field->filter_type == FILTER_DYN_STRING)
-			fn = filter_pred_strloc;
-		else
-			fn = filter_pred_pchar;
-	} else if (is_function_field(field)) {
-		if (strcmp(field->name, "ip")) {
-			parse_error(ps, FILT_ERR_IP_FIELD_ONLY, 0);
-			return -EINVAL;
-		}
-	} else {
-		if (field->is_signed)
-			ret = kstrtoll(pred->regex.pattern, 0, &val);
-		else
-			ret = kstrtoull(pred->regex.pattern, 0, &val);
-		if (ret) {
-			parse_error(ps, FILT_ERR_ILLEGAL_INTVAL, 0);
-			return -EINVAL;
-		}
-		pred->val = val;
-
-		if (field->filter_type == FILTER_CPU)
-			fn = filter_pred_cpu;
-		else
-			fn = select_comparison_fn(pred->op, field->size,
-					  field->is_signed);
-		if (!fn) {
-			parse_error(ps, FILT_ERR_INVALID_OP, 0);
-			return -EINVAL;
-		}
-	}
-
-	if (pred->op == OP_NE)
-		pred->not ^= 1;
-
-	pred->fn = fn;
-	return 0;
-}
-
-static void parse_init(struct filter_parse_state *ps,
-		       struct filter_op *ops,
-		       char *infix_string)
-{
-	memset(ps, '\0', sizeof(*ps));
-
-	ps->infix.string = infix_string;
-	ps->infix.cnt = strlen(infix_string);
-	ps->ops = ops;
-
-	INIT_LIST_HEAD(&ps->opstack);
-	INIT_LIST_HEAD(&ps->postfix);
-}
-
-static char infix_next(struct filter_parse_state *ps)
-{
-	if (!ps->infix.cnt)
-		return 0;
-
-	ps->infix.cnt--;
-
-	return ps->infix.string[ps->infix.tail++];
-}
-
-static char infix_peek(struct filter_parse_state *ps)
-{
-	if (ps->infix.tail == strlen(ps->infix.string))
-		return 0;
-
-	return ps->infix.string[ps->infix.tail];
-}
-
-static void infix_advance(struct filter_parse_state *ps)
-{
-	if (!ps->infix.cnt)
-		return;
-
-	ps->infix.cnt--;
-	ps->infix.tail++;
-}
-
-static inline int is_precedence_lower(struct filter_parse_state *ps,
-				      int a, int b)
-{
-	return ps->ops[a].precedence < ps->ops[b].precedence;
-}
-
-static inline int is_op_char(struct filter_parse_state *ps, char c)
-{
-	int i;
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (ps->ops[i].string[0] == c)
-			return 1;
-	}
-
-	return 0;
-}
-
-static int infix_get_op(struct filter_parse_state *ps, char firstc)
-{
-	char nextc = infix_peek(ps);
-	char opstr[3];
-	int i;
-
-	opstr[0] = firstc;
-	opstr[1] = nextc;
-	opstr[2] = '\0';
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (!strcmp(opstr, ps->ops[i].string)) {
-			infix_advance(ps);
-			return ps->ops[i].id;
-		}
-	}
-
-	opstr[1] = '\0';
-
-	for (i = 0; strcmp(ps->ops[i].string, "OP_NONE"); i++) {
-		if (!strcmp(opstr, ps->ops[i].string))
-			return ps->ops[i].id;
-	}
-
-	return OP_NONE;
-}
-
-static inline void clear_operand_string(struct filter_parse_state *ps)
-{
-	memset(ps->operand.string, '\0', MAX_FILTER_STR_VAL);
-	ps->operand.tail = 0;
-}
-
-static inline int append_operand_char(struct filter_parse_state *ps, char c)
-{
-	if (ps->operand.tail == MAX_FILTER_STR_VAL - 1)
-		return -EINVAL;
-
-	ps->operand.string[ps->operand.tail++] = c;
-
-	return 0;
-}
-
-static int filter_opstack_push(struct filter_parse_state *ps,
-			       enum filter_op_ids op)
-{
-	struct opstack_op *opstack_op;
-
-	opstack_op = kmalloc(sizeof(*opstack_op), GFP_KERNEL);
-	if (!opstack_op)
-		return -ENOMEM;
-
-	opstack_op->op = op;
-	list_add(&opstack_op->list, &ps->opstack);
-
-	return 0;
-}
-
-static int filter_opstack_empty(struct filter_parse_state *ps)
-{
-	return list_empty(&ps->opstack);
-}
-
-static int filter_opstack_top(struct filter_parse_state *ps)
-{
-	struct opstack_op *opstack_op;
-
-	if (filter_opstack_empty(ps))
-		return OP_NONE;
-
-	opstack_op = list_first_entry(&ps->opstack, struct opstack_op, list);
-
-	return opstack_op->op;
-}
-
-static int filter_opstack_pop(struct filter_parse_state *ps)
-{
-	struct opstack_op *opstack_op;
-	enum filter_op_ids op;
-
-	if (filter_opstack_empty(ps))
-		return OP_NONE;
-
-	opstack_op = list_first_entry(&ps->opstack, struct opstack_op, list);
-	op = opstack_op->op;
-	list_del(&opstack_op->list);
-
-	kfree(opstack_op);
-
-	return op;
-}
-
-static void filter_opstack_clear(struct filter_parse_state *ps)
-{
-	while (!filter_opstack_empty(ps))
-		filter_opstack_pop(ps);
-}
-
-static char *curr_operand(struct filter_parse_state *ps)
-{
-	return ps->operand.string;
-}
-
-static int postfix_append_operand(struct filter_parse_state *ps, char *operand)
-{
-	struct postfix_elt *elt;
-
-	elt = kmalloc(sizeof(*elt), GFP_KERNEL);
-	if (!elt)
-		return -ENOMEM;
-
-	elt->op = OP_NONE;
-	elt->operand = kstrdup(operand, GFP_KERNEL);
-	if (!elt->operand) {
-		kfree(elt);
-		return -ENOMEM;
-	}
-
-	list_add_tail(&elt->list, &ps->postfix);
-
-	return 0;
-}
-
-static int postfix_append_op(struct filter_parse_state *ps, enum filter_op_ids op)
-{
-	struct postfix_elt *elt;
-
-	elt = kmalloc(sizeof(*elt), GFP_KERNEL);
-	if (!elt)
-		return -ENOMEM;
-
-	elt->op = op;
-	elt->operand = NULL;
-
-	list_add_tail(&elt->list, &ps->postfix);
-
-	return 0;
-}
-
-static void postfix_clear(struct filter_parse_state *ps)
-{
-	struct postfix_elt *elt;
-
-	while (!list_empty(&ps->postfix)) {
-		elt = list_first_entry(&ps->postfix, struct postfix_elt, list);
-		list_del(&elt->list);
-		kfree(elt->operand);
-		kfree(elt);
-	}
-}
-
-static int filter_parse(struct filter_parse_state *ps)
-{
-	enum filter_op_ids op, top_op;
-	int in_string = 0;
-	char ch;
-
-	while ((ch = infix_next(ps))) {
-		if (ch == '"') {
-			in_string ^= 1;
-			continue;
-		}
-
-		if (in_string)
-			goto parse_operand;
-
-		if (isspace(ch))
-			continue;
-
-		if (is_op_char(ps, ch)) {
-			op = infix_get_op(ps, ch);
-			if (op == OP_NONE) {
-				parse_error(ps, FILT_ERR_INVALID_OP, 0);
-				return -EINVAL;
-			}
-
-			if (strlen(curr_operand(ps))) {
-				postfix_append_operand(ps, curr_operand(ps));
-				clear_operand_string(ps);
-			}
-
-			while (!filter_opstack_empty(ps)) {
-				top_op = filter_opstack_top(ps);
-				if (!is_precedence_lower(ps, top_op, op)) {
-					top_op = filter_opstack_pop(ps);
-					postfix_append_op(ps, top_op);
-					continue;
-				}
-				break;
-			}
-
-			filter_opstack_push(ps, op);
-			continue;
-		}
-
-		if (ch == '(') {
-			filter_opstack_push(ps, OP_OPEN_PAREN);
-			continue;
-		}
-
-		if (ch == ')') {
-			if (strlen(curr_operand(ps))) {
-				postfix_append_operand(ps, curr_operand(ps));
-				clear_operand_string(ps);
-			}
-
-			top_op = filter_opstack_pop(ps);
-			while (top_op != OP_NONE) {
-				if (top_op == OP_OPEN_PAREN)
-					break;
-				postfix_append_op(ps, top_op);
-				top_op = filter_opstack_pop(ps);
-			}
-			if (top_op == OP_NONE) {
-				parse_error(ps, FILT_ERR_UNBALANCED_PAREN, 0);
-				return -EINVAL;
-			}
+		if (file->system != dir)
 			continue;
-		}
-parse_operand:
-		if (append_operand_char(ps, ch)) {
-			parse_error(ps, FILT_ERR_OPERAND_TOO_LONG, 0);
-			return -EINVAL;
-		}
+		__free_subsystem_filter(file);
 	}
+}
 
-	if (strlen(curr_operand(ps)))
-		postfix_append_operand(ps, curr_operand(ps));
+int filter_assign_type(const char *type)
+{
+	if (strstr(type, "__data_loc") && strstr(type, "char"))
+		return FILTER_DYN_STRING;
 
-	while (!filter_opstack_empty(ps)) {
-		top_op = filter_opstack_pop(ps);
-		if (top_op == OP_NONE)
-			break;
-		if (top_op == OP_OPEN_PAREN) {
-			parse_error(ps, FILT_ERR_UNBALANCED_PAREN, 0);
-			return -EINVAL;
-		}
-		postfix_append_op(ps, top_op);
-	}
+	if (strchr(type, '[') && strstr(type, "char"))
+		return FILTER_STATIC_STRING;
 
-	return 0;
+	return FILTER_OTHER;
 }
 
-static struct filter_pred *create_pred(struct filter_parse_state *ps,
-				       struct trace_event_call *call,
-				       enum filter_op_ids op,
-				       char *operand1, char *operand2)
+static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
+					    int field_size, int field_is_signed)
 {
-	struct ftrace_event_field *field;
-	static struct filter_pred pred;
-
-	memset(&pred, 0, sizeof(pred));
-	pred.op = op;
-
-	if (op == OP_AND || op == OP_OR)
-		return &pred;
+	filter_pred_fn_t fn = NULL;
+	int pred_func_index = -1;
 
-	if (!operand1 || !operand2) {
-		parse_error(ps, FILT_ERR_MISSING_FIELD, 0);
-		return NULL;
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
 	}
 
-	field = trace_find_event_field(call, operand1);
-	if (!field) {
-		parse_error(ps, FILT_ERR_FIELD_NOT_FOUND, 0);
-		return NULL;
+	switch (field_size) {
+	case 8:
+		if (pred_func_index < 0)
+			fn = filter_pred_64;
+		else if (field_is_signed)
+			fn = pred_funcs_s64[pred_func_index];
+		else
+			fn = pred_funcs_u64[pred_func_index];
+		break;
+	case 4:
+		if (pred_func_index < 0)
+			fn = filter_pred_32;
+		else if (field_is_signed)
+			fn = pred_funcs_s32[pred_func_index];
+		else
+			fn = pred_funcs_u32[pred_func_index];
+		break;
+	case 2:
+		if (pred_func_index < 0)
+			fn = filter_pred_16;
+		else if (field_is_signed)
+			fn = pred_funcs_s16[pred_func_index];
+		else
+			fn = pred_funcs_u16[pred_func_index];
+		break;
+	case 1:
+		if (pred_func_index < 0)
+			fn = filter_pred_8;
+		else if (field_is_signed)
+			fn = pred_funcs_s8[pred_func_index];
+		else
+			fn = pred_funcs_u8[pred_func_index];
+		break;
 	}
 
-	strcpy(pred.regex.pattern, operand2);
-	pred.regex.len = strlen(pred.regex.pattern);
-	pred.field = field;
-	return init_pred(ps, field, &pred) ? NULL : &pred;
+	return fn;
 }
 
-static int check_preds(struct filter_parse_state *ps)
+/* Called when a predicate is encountered by predicate_parse() */
+static int parse_pred(const char *str, void *data,
+		      int pos, struct filter_parse_error *pe,
+		      struct filter_pred **pred_ptr)
 {
-	int n_normal_preds = 0, n_logical_preds = 0;
-	struct postfix_elt *elt;
-	int cnt = 0;
+	struct trace_event_call *call = data;
+	struct ftrace_event_field *field;
+	struct filter_pred *pred = NULL;
+	char num_buf[24];	/* Big enough to hold an address */
+	char *field_name;
+	char q;
+	u64 val;
+	int len;
+	int ret;
+	int op;
+	int s;
+	int i = 0;
 
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE) {
-			cnt++;
-			continue;
-		}
+	/* First find the field to associate to */
+	while (isspace(str[i]))
+		i++;
+	s = i;
 
-		if (elt->op == OP_AND || elt->op == OP_OR) {
-			n_logical_preds++;
-			cnt--;
-			continue;
-		}
-		if (elt->op != OP_NOT)
-			cnt--;
-		n_normal_preds++;
-		/* all ops should have operands */
-		if (cnt < 0)
-			break;
-	}
+	while (isalnum(str[i]) || str[i] == '_')
+		i++;
+
+	len = i - s;
+
+	if (!len)
+		return -1;
+
+	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
+	if (!field_name)
+		return -ENOMEM;
+
+	/* Make sure that the field exists */
 
-	if (cnt != 1 || !n_normal_preds || n_logical_preds >= n_normal_preds) {
-		parse_error(ps, FILT_ERR_INVALID_FILTER, 0);
+	field = trace_find_event_field(call, field_name);
+	kfree(field_name);
+	if (!field) {
+		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + i);
 		return -EINVAL;
 	}
 
-	return 0;
-}
+	while (isspace(str[i]))
+		i++;
 
-static int count_preds(struct filter_parse_state *ps)
-{
-	struct postfix_elt *elt;
-	int n_preds = 0;
+	/* Make sure this op is supported */
+	for (op = 0; ops[op]; op++) {
+		/* This is why '<=' must come before '<' in ops[] */
+		if (strncmp(str + i, ops[op], strlen(ops[op])) == 0)
+			break;
+	}
 
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE)
-			continue;
-		n_preds++;
+	if (!ops[op]) {
+		parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+		goto err_free;
 	}
 
-	return n_preds;
-}
+	i += strlen(ops[op]);
 
-struct check_pred_data {
-	int count;
-	int max;
-};
+	while (isspace(str[i]))
+		i++;
 
-static int check_pred_tree_cb(enum move_type move, struct filter_pred *pred,
-			      int *err, void *data)
-{
-	struct check_pred_data *d = data;
+	s = i;
 
-	if (WARN_ON(d->count++ > d->max)) {
-		*err = -EINVAL;
-		return WALK_PRED_ABORT;
-	}
-	return WALK_PRED_DEFAULT;
-}
+	pred = kzalloc(sizeof(*pred), GFP_KERNEL);
+	if (!pred)
+		return -ENOMEM;
 
-/*
- * The tree is walked at filtering of an event. If the tree is not correctly
- * built, it may cause an infinite loop. Check here that the tree does
- * indeed terminate.
- */
-static int check_pred_tree(struct event_filter *filter,
-			   struct filter_pred *root)
-{
-	struct check_pred_data data = {
+	pred->field = field;
+	pred->offset = field->offset;
+	pred->op = op;
+
+	if (ftrace_event_is_function(call)) {
 		/*
-		 * The max that we can hit a node is three times.
-		 * Once going down, once coming up from left, and
-		 * once coming up from right. This is more than enough
-		 * since leafs are only hit a single time.
+		 * Perf does things different with function events.
+		 * It only allows an "ip" field, and expects a string.
+		 * But the string does not need to be surrounded by quotes.
+		 * If it is a string, the assigned function as a nop,
+		 * (perf doesn't use it) and grab everything.
 		 */
-		.max   = 3 * filter->n_preds,
-		.count = 0,
-	};
+		if (strcmp(field->name, "ip") != 0) {
+			 parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			 goto err_free;
+		 }
+		 pred->fn = filter_pred_none;
+
+		 /*
+		  * Quotes are not required, but if they exist then we need
+		  * to read them till we hit a matching one.
+		  */
+		 if (str[i] == '\'' || str[i] == '"')
+			 q = str[i];
+		 else
+			 q = 0;
+
+		 for (i++; str[i]; i++) {
+			 if (q && str[i] == q)
+				 break;
+			 if (!q && (str[i] == ')' || str[i] == '&' ||
+				    str[i] == '|'))
+				 break;
+		 }
+		 /* Skip quotes */
+		 if (q)
+			 s++;
+		len = i - s;
+		if (len >= MAX_FILTER_STR_VAL) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-	return walk_pred_tree(filter->preds, root,
-			      check_pred_tree_cb, &data);
-}
+		pred->regex.len = len;
+		strncpy(pred->regex.pattern, str + s, len);
+		pred->regex.pattern[len] = 0;
+
+	/* This is either a string, or an integer */
+	} else if (str[i] == '\'' || str[i] == '"') {
+		char q = str[i];
+
+		/* Make sure the op is OK for strings */
+		switch (op) {
+		case OP_NE:
+			pred->not = 1;
+			/* Fall through */
+		case OP_GLOB:
+		case OP_EQ:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
 
-static int count_leafs_cb(enum move_type move, struct filter_pred *pred,
-			  int *err, void *data)
-{
-	int *count = data;
+		/* Make sure the field is OK for strings */
+		if (!is_string_field(field)) {
+			parse_error(pe, FILT_ERR_EXPECT_DIGIT, pos + i);
+			goto err_free;
+		}
 
-	if ((move == MOVE_DOWN) &&
-	    (pred->left == FILTER_PRED_INVALID))
-		(*count)++;
+		for (i++; str[i]; i++) {
+			if (str[i] == q)
+				break;
+		}
+		if (!str[i]) {
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
+			goto err_free;
+		}
 
-	return WALK_PRED_DEFAULT;
-}
+		/* Skip quotes */
+		s++;
+		len = i - s;
+		if (len >= MAX_FILTER_STR_VAL) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-static int count_leafs(struct filter_pred *preds, struct filter_pred *root)
-{
-	int count = 0, ret;
+		pred->regex.len = len;
+		strncpy(pred->regex.pattern, str + s, len);
+		pred->regex.pattern[len] = 0;
 
-	ret = walk_pred_tree(preds, root, count_leafs_cb, &count);
-	WARN_ON(ret);
-	return count;
-}
+		filter_build_regex(pred);
 
-struct fold_pred_data {
-	struct filter_pred *root;
-	int count;
-	int children;
-};
+		if (field->filter_type == FILTER_COMM) {
+			pred->fn = filter_pred_comm;
 
-static int fold_pred_cb(enum move_type move, struct filter_pred *pred,
-			int *err, void *data)
-{
-	struct fold_pred_data *d = data;
-	struct filter_pred *root = d->root;
+		} else if (field->filter_type == FILTER_STATIC_STRING) {
+			pred->fn = filter_pred_string;
+			pred->regex.field_len = field->size;
 
-	if (move != MOVE_DOWN)
-		return WALK_PRED_DEFAULT;
-	if (pred->left != FILTER_PRED_INVALID)
-		return WALK_PRED_DEFAULT;
+		} else if (field->filter_type == FILTER_DYN_STRING)
+			pred->fn = filter_pred_strloc;
+		else
+			pred->fn = filter_pred_pchar;
+		/* go past the last quote */
+		i++;
 
-	if (WARN_ON(d->count == d->children)) {
-		*err = -EINVAL;
-		return WALK_PRED_ABORT;
-	}
+	} else if (isdigit(str[i])) {
 
-	pred->index &= ~FILTER_PRED_FOLD;
-	root->ops[d->count++] = pred->index;
-	return WALK_PRED_DEFAULT;
-}
+		/* Make sure the field is not a string */
+		if (is_string_field(field)) {
+			parse_error(pe, FILT_ERR_EXPECT_STRING, pos + i);
+			goto err_free;
+		}
 
-static int fold_pred(struct filter_pred *preds, struct filter_pred *root)
-{
-	struct fold_pred_data data = {
-		.root  = root,
-		.count = 0,
-	};
-	int children;
+		if (op == OP_GLOB) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
 
-	/* No need to keep the fold flag */
-	root->index &= ~FILTER_PRED_FOLD;
+		/* We allow 0xDEADBEEF */
+		while (isalnum(str[i]))
+			i++;
 
-	/* If the root is a leaf then do nothing */
-	if (root->left == FILTER_PRED_INVALID)
-		return 0;
+		len = i - s;
+		/* 0xfeedfacedeadbeef is 18 chars max */
+		if (len >= sizeof(num_buf)) {
+			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+			goto err_free;
+		}
 
-	/* count the children */
-	children = count_leafs(preds, &preds[root->left]);
-	children += count_leafs(preds, &preds[root->right]);
+		strncpy(num_buf, str + s, len);
+		num_buf[len] = 0;
 
-	root->ops = kcalloc(children, sizeof(*root->ops), GFP_KERNEL);
-	if (!root->ops)
-		return -ENOMEM;
+		/* Make sure it is a value */
+		if (field->is_signed)
+			ret = kstrtoll(num_buf, 0, &val);
+		else
+			ret = kstrtoull(num_buf, 0, &val);
+		if (ret) {
+			parse_error(pe, FILT_ERR_ILLEGAL_INTVAL, pos + s);
+			goto err_free;
+		}
 
-	root->val = children;
-	data.children = children;
-	return walk_pred_tree(preds, root, fold_pred_cb, &data);
-}
+		pred->val = val;
 
-static int fold_pred_tree_cb(enum move_type move, struct filter_pred *pred,
-			     int *err, void *data)
-{
-	struct filter_pred *preds = data;
+		if (field->filter_type == FILTER_CPU)
+			pred->fn = filter_pred_cpu;
+		else {
+			pred->fn = select_comparison_fn(pred->op, field->size,
+							field->is_signed);
+			if (pred->op == OP_NE)
+				pred->not = 1;
+		}
 
-	if (move != MOVE_DOWN)
-		return WALK_PRED_DEFAULT;
-	if (!(pred->index & FILTER_PRED_FOLD))
-		return WALK_PRED_DEFAULT;
+	} else {
+		parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+		goto err_free;
+	}
 
-	*err = fold_pred(preds, pred);
-	if (*err)
-		return WALK_PRED_ABORT;
+	*pred_ptr = pred;
+	return i;
 
-	/* eveyrhing below is folded, continue with parent */
-	return WALK_PRED_PARENT;
+err_free:
+	kfree(pred);
+	return -EINVAL;
 }
 
+enum {
+	TOO_MANY_CLOSE		= -1,
+	TOO_MANY_OPEN		= -2,
+	MISSING_QUOTE		= -3,
+};
+
 /*
- * To optimize the processing of the ops, if we have several "ors" or
- * "ands" together, we can put them in an array and process them all
- * together speeding up the filter logic.
+ * Read the filter string once to calculate the number of predicates
+ * as well as how deep the parentheses go.
+ *
+ * Returns:
+ *   0 - everything is fine (err is undefined)
+ *  -1 - too many ')'
+ *  -2 - too many '('
+ *  -3 - No matching quote
  */
-static int fold_pred_tree(struct event_filter *filter,
-			   struct filter_pred *root)
-{
-	return walk_pred_tree(filter->preds, root, fold_pred_tree_cb,
-			      filter->preds);
-}
-
-static int replace_preds(struct trace_event_call *call,
-			 struct event_filter *filter,
-			 struct filter_parse_state *ps,
-			 bool dry_run)
-{
-	char *operand1 = NULL, *operand2 = NULL;
-	struct filter_pred *pred;
-	struct filter_pred *root;
-	struct postfix_elt *elt;
-	struct pred_stack stack = { }; /* init to NULL */
-	int err;
-	int n_preds = 0;
-
-	n_preds = count_preds(ps);
-	if (n_preds >= MAX_FILTER_PRED) {
-		parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-		return -ENOSPC;
-	}
-
-	err = check_preds(ps);
-	if (err)
-		return err;
+static int calc_stack(const char *str, int *parens, int *preds, int *err)
+{
+	bool is_pred = false;
+	int nr_preds = 0;
+	int open = 1; /* Count the expression as "(E)" */
+	int last_quote = 0;
+	int max_open = 1;
+	int quote = 0;
+	int i;
 
-	if (!dry_run) {
-		err = __alloc_pred_stack(&stack, n_preds);
-		if (err)
-			return err;
-		err = __alloc_preds(filter, n_preds);
-		if (err)
-			goto fail;
-	}
+	*err = 0;
 
-	n_preds = 0;
-	list_for_each_entry(elt, &ps->postfix, list) {
-		if (elt->op == OP_NONE) {
-			if (!operand1)
-				operand1 = elt->operand;
-			else if (!operand2)
-				operand2 = elt->operand;
-			else {
-				parse_error(ps, FILT_ERR_TOO_MANY_OPERANDS, 0);
-				err = -EINVAL;
-				goto fail;
-			}
+	for (i = 0; str[i]; i++) {
+		if (isspace(str[i]))
+			continue;
+		if (quote) {
+			if (str[i] == quote)
+			       quote = 0;
 			continue;
 		}
 
-		if (elt->op == OP_NOT) {
-			if (!n_preds || operand1 || operand2) {
-				parse_error(ps, FILT_ERR_ILLEGAL_NOT_OP, 0);
-				err = -EINVAL;
-				goto fail;
+		switch (str[i]) {
+		case '\'':
+		case '"':
+			quote = str[i];
+			last_quote = i;
+			break;
+		case '|':
+		case '&':
+			if (str[i+1] != str[i])
+				break;
+			is_pred = false;
+			continue;
+		case '(':
+			is_pred = false;
+			open++;
+			if (open > max_open)
+				max_open = open;
+			continue;
+		case ')':
+			is_pred = false;
+			if (open == 1) {
+				*err = i;
+				return TOO_MANY_CLOSE;
 			}
-			if (!dry_run)
-				filter->preds[n_preds - 1].not ^= 1;
+			open--;
 			continue;
 		}
-
-		if (WARN_ON(n_preds++ == MAX_FILTER_PRED)) {
-			parse_error(ps, FILT_ERR_TOO_MANY_PREDS, 0);
-			err = -ENOSPC;
-			goto fail;
+		if (!is_pred) {
+			nr_preds++;
+			is_pred = true;
 		}
+	}
 
-		pred = create_pred(ps, call, elt->op, operand1, operand2);
-		if (!pred) {
-			err = -EINVAL;
-			goto fail;
-		}
+	if (quote) {
+		*err = last_quote;
+		return MISSING_QUOTE;
+	}
 
-		if (!dry_run) {
-			err = filter_add_pred(ps, filter, pred, &stack);
-			if (err)
-				goto fail;
-		}
+	if (open != 1) {
+		int level = open;
 
-		operand1 = operand2 = NULL;
+		/* find the bad open */
+		for (i--; i; i--) {
+			if (quote) {
+				if (str[i] == quote)
+					quote = 0;
+				continue;
+			}
+			switch (str[i]) {
+			case '(':
+				if (level == open) {
+					*err = i;
+					return TOO_MANY_OPEN;
+				}
+				level--;
+				break;
+			case ')':
+				level++;
+				break;
+			case '\'':
+			case '"':
+				quote = str[i];
+				break;
+			}
+		}
+		/* First character is the '(' with missing ')' */
+		*err = 0;
+		return TOO_MANY_OPEN;
 	}
 
-	if (!dry_run) {
-		/* We should have one item left on the stack */
-		pred = __pop_pred_stack(&stack);
-		if (!pred)
-			return -EINVAL;
-		/* This item is where we start from in matching */
-		root = pred;
-		/* Make sure the stack is empty */
-		pred = __pop_pred_stack(&stack);
-		if (WARN_ON(pred)) {
-			err = -EINVAL;
-			filter->root = NULL;
-			goto fail;
+	/* Set the size of the required stacks */
+	*parens = max_open;
+	*preds = nr_preds;
+	return 0;
+}
+
+static int process_preds(struct trace_event_call *call,
+			 const char *filter_string,
+			 struct event_filter *filter,
+			 struct filter_parse_error *pe)
+{
+	struct prog_entry *prog;
+	int nr_parens;
+	int nr_preds;
+	int index;
+	int ret;
+
+	ret = calc_stack(filter_string, &nr_parens, &nr_preds, &index);
+	if (ret < 0) {
+		switch (ret) {
+		case MISSING_QUOTE:
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, index);
+			break;
+		case TOO_MANY_OPEN:
+			parse_error(pe, FILT_ERR_TOO_MANY_OPEN, index);
+			break;
+		default:
+			parse_error(pe, FILT_ERR_TOO_MANY_CLOSE, index);
 		}
-		err = check_pred_tree(filter, root);
-		if (err)
-			goto fail;
-
-		/* Optimize the tree */
-		err = fold_pred_tree(filter, root);
-		if (err)
-			goto fail;
-
-		/* We don't set root until we know it works */
-		barrier();
-		filter->root = root;
+		return ret;
 	}
 
-	err = 0;
-fail:
-	__free_pred_stack(&stack);
-	return err;
+	if (!nr_preds) {
+		prog = NULL;
+	} else {
+		prog = predicate_parse(filter_string, nr_parens, nr_preds,
+			       parse_pred, call, pe);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+	rcu_assign_pointer(filter->prog, prog);
+	return 0;
 }
 
 static inline void event_set_filtered_flag(struct trace_event_file *file)
@@ -1753,9 +1558,9 @@ struct filter_list {
 	struct event_filter	*filter;
 };
 
-static int replace_system_preds(struct trace_subsystem_dir *dir,
+static int process_system_preds(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
-				struct filter_parse_state *ps,
+				struct filter_parse_error *pe,
 				char *filter_string)
 {
 	struct trace_event_file *file;
@@ -1766,29 +1571,11 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 	bool fail = true;
 	int err;
 
-	list_for_each_entry(file, &tr->events, list) {
-		if (file->system != dir)
-			continue;
-
-		/*
-		 * Try to see if the filter can be applied
-		 *  (filter arg is ignored on dry_run)
-		 */
-		err = replace_preds(file->event_call, NULL, ps, true);
-		if (err)
-			event_set_no_set_filter_flag(file);
-		else
-			event_clear_no_set_filter_flag(file);
-	}
-
 	list_for_each_entry(file, &tr->events, list) {
 
 		if (file->system != dir)
 			continue;
 
-		if (event_no_set_filter_flag(file))
-			continue;
-
 		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
 		if (!filter)
 			goto fail_mem;
@@ -1797,11 +1584,11 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter->filter_string)
 			goto fail_mem;
 
-		err = replace_preds(file->event_call, filter, ps, false);
+		err = process_preds(file->event_call, filter_string, filter, pe);
 		if (err) {
 			filter_disable(file);
-			parse_error(ps, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-			append_filter_err(ps, filter);
+			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
+			append_filter_err(pe, filter);
 		} else
 			event_set_filtered_flag(file);
 
@@ -1843,7 +1630,7 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 		list_del(&filter_item->list);
 		kfree(filter_item);
 	}
-	parse_error(ps, FILT_ERR_BAD_SUBSYS_FILTER, 0);
+	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
 	kfree(filter);
@@ -1859,16 +1646,16 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 }
 
 static int create_filter_start(char *filter_string, bool set_str,
-			       struct filter_parse_state **psp,
+			       struct filter_parse_error **pse,
 			       struct event_filter **filterp)
 {
 	struct event_filter *filter;
-	struct filter_parse_state *ps = NULL;
+	struct filter_parse_error *pe = NULL;
 	int err = 0;
 
-	WARN_ON_ONCE(*psp || *filterp);
+	if (WARN_ON_ONCE(*pse || *filterp))
+		return -EINVAL;
 
-	/* allocate everything, and if any fails, free all and fail */
 	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
 	if (filter && set_str) {
 		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
@@ -1876,32 +1663,24 @@ static int create_filter_start(char *filter_string, bool set_str,
 			err = -ENOMEM;
 	}
 
-	ps = kzalloc(sizeof(*ps), GFP_KERNEL);
+	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
 
-	if (!filter || !ps || err) {
-		kfree(ps);
+	if (!filter || !pe || err) {
+		kfree(pe);
 		__free_filter(filter);
 		return -ENOMEM;
 	}
 
 	/* we're committed to creating a new filter */
 	*filterp = filter;
-	*psp = ps;
+	*pse = pe;
 
-	parse_init(ps, filter_ops, filter_string);
-	err = filter_parse(ps);
-	if (err && set_str)
-		append_filter_err(ps, filter);
-	return err;
+	return 0;
 }
 
-static void create_filter_finish(struct filter_parse_state *ps)
+static void create_filter_finish(struct filter_parse_error *pe)
 {
-	if (ps) {
-		filter_opstack_clear(ps);
-		postfix_clear(ps);
-		kfree(ps);
-	}
+	kfree(pe);
 }
 
 /**
@@ -1921,24 +1700,20 @@ static void create_filter_finish(struct filter_parse_state *ps)
  * freeing it.
  */
 static int create_filter(struct trace_event_call *call,
-			 char *filter_str, bool set_str,
+			 char *filter_string, bool set_str,
 			 struct event_filter **filterp)
 {
+	struct filter_parse_error *pe = NULL;
 	struct event_filter *filter = NULL;
-	struct filter_parse_state *ps = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, set_str, &ps, &filter);
-	if (!err) {
-		err = replace_preds(call, filter, ps, false);
-		if (err && set_str)
-			append_filter_err(ps, filter);
-	}
-	if (err && !set_str) {
-		free_event_filter(filter);
-		filter = NULL;
-	}
-	create_filter_finish(ps);
+	err = create_filter_start(filter_string, set_str, &pe, &filter);
+	if (err)
+		return err;
+
+	err = process_preds(call, filter_string, filter, pe);
+	if (err && set_str)
+		append_filter_err(pe, filter);
 
 	*filterp = filter;
 	return err;
@@ -1965,21 +1740,21 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 				char *filter_str, struct event_filter **filterp)
 {
 	struct event_filter *filter = NULL;
-	struct filter_parse_state *ps = NULL;
+	struct filter_parse_error *pe = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, true, &ps, &filter);
+	err = create_filter_start(filter_str, true, &pe, &filter);
 	if (!err) {
-		err = replace_system_preds(dir, tr, ps, filter_str);
+		err = process_system_preds(dir, tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
 			kfree(filter->filter_string);
 			filter->filter_string = NULL;
 		} else {
-			append_filter_err(ps, filter);
+			append_filter_err(pe, filter);
 		}
 	}
-	create_filter_finish(ps);
+	create_filter_finish(pe);
 
 	*filterp = filter;
 	return err;
@@ -2162,66 +1937,79 @@ static int __ftrace_function_set_filter(int filter, char *buf, int len,
 	return ret;
 }
 
-static int ftrace_function_check_pred(struct filter_pred *pred, int leaf)
+static int ftrace_function_check_pred(struct filter_pred *pred)
 {
 	struct ftrace_event_field *field = pred->field;
 
-	if (leaf) {
-		/*
-		 * Check the leaf predicate for function trace, verify:
-		 *  - only '==' and '!=' is used
-		 *  - the 'ip' field is used
-		 */
-		if ((pred->op != OP_EQ) && (pred->op != OP_NE))
-			return -EINVAL;
+	/*
+	 * Check the predicate for function trace, verify:
+	 *  - only '==' and '!=' is used
+	 *  - the 'ip' field is used
+	 */
+	if ((pred->op != OP_EQ) && (pred->op != OP_NE))
+		return -EINVAL;
 
-		if (strcmp(field->name, "ip"))
-			return -EINVAL;
-	} else {
-		/*
-		 * Check the non leaf predicate for function trace, verify:
-		 *  - only '||' is used
-		*/
-		if (pred->op != OP_OR)
-			return -EINVAL;
-	}
+	if (strcmp(field->name, "ip"))
+		return -EINVAL;
 
 	return 0;
 }
 
-static int ftrace_function_set_filter_cb(enum move_type move,
-					 struct filter_pred *pred,
-					 int *err, void *data)
+static int ftrace_function_set_filter_pred(struct filter_pred *pred,
+					   struct function_filter_data *data)
 {
+	int ret;
+
 	/* Checking the node is valid for function trace. */
-	if ((move != MOVE_DOWN) ||
-	    (pred->left != FILTER_PRED_INVALID)) {
-		*err = ftrace_function_check_pred(pred, 0);
-	} else {
-		*err = ftrace_function_check_pred(pred, 1);
-		if (*err)
-			return WALK_PRED_ABORT;
-
-		*err = __ftrace_function_set_filter(pred->op == OP_EQ,
-						    pred->regex.pattern,
-						    pred->regex.len,
-						    data);
-	}
+	ret = ftrace_function_check_pred(pred);
+	if (ret)
+		return ret;
+
+	return __ftrace_function_set_filter(pred->op == OP_EQ,
+					    pred->regex.pattern,
+					    pred->regex.len,
+					    data);
+}
+
+static bool is_or(struct prog_entry *prog, int i)
+{
+	int target;
 
-	return (*err) ? WALK_PRED_ABORT : WALK_PRED_DEFAULT;
+	/*
+	 * Only "||" is allowed for function events, thus,
+	 * all true branches should jump to true, and any
+	 * false branch should jump to false.
+	 */
+	target = prog[i].target + 1;
+	/* True and false have NULL preds (all prog entries should jump to one */
+	if (prog[target].pred)
+		return false;
+
+	/* prog[target].target is 1 for TRUE, 0 for FALSE */
+	return prog[i].when_to_branch == prog[target].target;
 }
 
 static int ftrace_function_set_filter(struct perf_event *event,
 				      struct event_filter *filter)
 {
+	struct prog_entry *prog = filter->prog;
 	struct function_filter_data data = {
 		.first_filter  = 1,
 		.first_notrace = 1,
 		.ops           = &event->ftrace_ops,
 	};
+	int i;
+
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
+
+		if (!is_or(prog, i))
+			return -EINVAL;
 
-	return walk_pred_tree(filter->preds, filter->root,
-			      ftrace_function_set_filter_cb, &data);
+		if (ftrace_function_set_filter_pred(pred, &data) < 0)
+			return -EINVAL;
+	}
+	return 0;
 }
 #else
 static int ftrace_function_set_filter(struct perf_event *event,
@@ -2364,26 +2152,27 @@ static int test_pred_visited_fn(struct filter_pred *pred, void *event)
 	return 1;
 }
 
-static int test_walk_pred_cb(enum move_type move, struct filter_pred *pred,
-			     int *err, void *data)
+static void update_pred_fn(struct event_filter *filter, char *fields)
 {
-	char *fields = data;
+	struct prog_entry *prog = filter->prog;
+	int i;
 
-	if ((move == MOVE_DOWN) &&
-	    (pred->left == FILTER_PRED_INVALID)) {
+	for (i = 0; prog[i].pred; i++) {
+		struct filter_pred *pred = prog[i].pred;
 		struct ftrace_event_field *field = pred->field;
 
+		WARN_ON_ONCE(!pred->fn);
+
 		if (!field) {
-			WARN(1, "all leafs should have field defined");
-			return WALK_PRED_DEFAULT;
+			WARN_ONCE(1, "all leafs should have field defined %d", i);
+			continue;
 		}
+
 		if (!strchr(fields, *field->name))
-			return WALK_PRED_DEFAULT;
+			continue;
 
-		WARN_ON(!pred->fn);
 		pred->fn = test_pred_visited_fn;
 	}
-	return WALK_PRED_DEFAULT;
 }
 
 static __init int ftrace_test_event_filter(void)
@@ -2413,9 +2202,7 @@ static __init int ftrace_test_event_filter(void)
 		 */
 		preempt_disable();
 		if (*d->not_visited)
-			walk_pred_tree(filter->preds, filter->root,
-				       test_walk_pred_cb,
-				       d->not_visited);
+			update_pred_fn(filter, d->not_visited);
 
 		test_pred_visited = 0;
 		err = filter_match_preds(filter, &d->rec);
-- 
2.15.1

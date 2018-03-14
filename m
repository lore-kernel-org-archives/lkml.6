Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCNQzv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeCNQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:55:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215DA2077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180314165401.530128930@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 12:54:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 0/3 v2] tracing: Rewrite the function filter code
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro reviewed the ftrace event filter logic and was horrified. He wrote
Tom and I a lengthy private email with a formal proof on how to do it
simpler as well as more efficient.

Currently the filter logic creates a binary search tree (with some
optimizations), and walks it to get a result.

Say we had the following filter: a && !(!b || c) || d && !e
Where each letter is a predicate. A tree would be made to look something
like:

             ||
            /  \
          &&    &&
         /  |   | \
        a  !||  d  !e
           /  \
          !b   c

If a == 1, b == 1, c == 1, d == 1, e == 0, then all nodes would be walked.

 || -> && -> a -> && -> !|| -> !b -> !|| -> c -> !|| -> && -> || -> && ->
 d -> && -> !e -> && -> || -> return TRUE!

That's 16 steps across vertices.

Al's method would create a program using an array that denotes the predicate
function, when to branch, and a target to branch to if the value is the same
as when to branch. Storing the array as:

 prog[0] = { a, 0, 2}; // predicate, when_to_branch, target
 prog[1] = { b, 0, 2};
 prog[2] = { c, 0, 4};
 prog[3] = { d, 0, 5};
 prog[4] = { e, 1, 5};
 prog[5] = { NULL, 0, 1}; // TRUE
 prog[6] = { NULL, 0, 0}; // FALSE

Where the code to execute the above looks like:

	for (i = 0; prog[i].pred; i++) {
		struct filter_pred *pred = prog[i].pred;
		int match = pred->fn(pred, rec);
		if (match == prog[i].when_to_branch)
			i = prog[i].target;
	}
	return prog[i].target;

Which translates the above program array into:

 n0: if (!a) goto n3;
 n1: if (!b) goto n3;
 n2: if (!c) goto T;
 n3: if (!d) goto F;
 n4: if (e) goto F;
 T: return TRUE;
 F: return FALSE;

And the above example only takes 6 steps to return TRUE.

Special thanks goes out to Al for his patience and his time that he spent in
educating us in a proper logical parser.

Two patches were added to do some initial clean up. The last patch
implements Al's suggestions. I wrote up a very lengthy comment describing
what Al taught us in my own words (hopefully I got it right), and the
implementation is similar to what Al showed with a few changes (again,
hopefully I got that right too). I tested this with lots of different
filters and it looks to be holding up.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

Head SHA1: 80765597bc587feae8dbc8ce97a0f32e12a6e625


Steven Rostedt (VMware) (3):
      tracing: Combine enum and arrays into single macro in filter code
      tracing: Clean up and document pred_funcs_##type creation and use
      tracing: Rewrite filter logic to be simpler and faster

----
 kernel/trace/trace.h               |   15 +-
 kernel/trace/trace_events_filter.c | 2337 ++++++++++++++++--------------------
 2 files changed, 1068 insertions(+), 1284 deletions(-)

Changes from v1:
 - Fixed echoing nothing into the filter (the tests echoed '0')
    (I fixed my tests)
 - Added better RCU annotations.
    (Thanks to zero day bot for pointing this out)

Diff from v1:

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e6f82f74ad65..6fb46a06c9dc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1219,7 +1219,7 @@ struct ftrace_event_field {
 struct prog_entry;
 
 struct event_filter {
-	struct prog_entry	*prog;
+	struct prog_entry __rcu	*prog;
 	char			*filter_string;
 };
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 8d7da0ded43b..703a416aa5c2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -982,14 +982,16 @@ void print_subsystem_event_filter(struct event_subsystem *system,
 
 static void free_prog(struct event_filter *filter)
 {
-	struct prog_entry *prog = filter->prog;
+	struct prog_entry *prog;
 	int i;
 
+	prog = rcu_access_pointer(filter->prog);
 	if (!prog)
 		return;
 
 	for (i = 0; prog[i].pred; i++)
 		kfree(prog[i].pred);
+	kfree(prog);
 }
 
 static void filter_disable(struct trace_event_file *file)
@@ -1497,12 +1499,15 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	prog = predicate_parse(filter_string, nr_parens, nr_preds,
+	if (!nr_preds) {
+		prog = NULL;
+	} else {
+		prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
-
-	filter->prog = prog;
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+	rcu_assign_pointer(filter->prog, prog);
 	return 0;
 }
 

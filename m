Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCJCjL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeCJCjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:39:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102221771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180310023442.791997138@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Mar 2018 21:34:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 0/3] tracing: Rewrite the function filter code
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


 Jiri,

This affects perf as well. I ran some tests and I believe I got
it woking as it does today.

Steven Rostedt (VMware) (3):
      tracing: Combine enum and arrays into single macro in filter code
      tracing: Clean up and document pred_funcs_##type creation and use
      tracing: Rewrite filter logic to be simpler and faster

----
 kernel/trace/trace.h               |   15 +-
 kernel/trace/trace_events_filter.c | 2372 ++++++++++++++++--------------------
 2 files changed, 1083 insertions(+), 1304 deletions(-)

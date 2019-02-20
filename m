Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D457C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37DD21B24
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfBTSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfBTSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB342190C;
        Wed, 20 Feb 2019 18:38:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkv-0006fC-6r; Wed, 20 Feb 2019 13:38:05 -0500
Message-Id: <20190220183805.098563076@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 11/29] ftrace: Allow enabling of filters via index of
 available_filter_functions
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Enabling of large number of functions by echoing in a large subset of the
functions in available_filter_functions can take a very long time. The
process requires testing all functions registered by the function tracer
(which is in the 10s of thousands), and doing a kallsyms lookup to convert
the ip address into a name, then comparing that name with the string passed
in.

When a function causes the function tracer to crash the system, a binary
bisect of the available_filter_functions can be done to find the culprit.
But this requires passing in half of the functions in
available_filter_functions over and over again, which makes it basically a
O(n^2) operation. With 40,000 functions, that ends up bing 1,600,000,000
opertions! And enabling this can take over 20 minutes.

As a quick speed up, if a number is passed into one of the filter files,
instead of doing a search, it just enables the function at the corresponding
line of the available_filter_functions file. That is:

 # echo 50 > set_ftrace_filter
 # cat set_ftrace_filter
 x86_pmu_commit_txn

 # head -50 available_filter_functions | tail -1
 x86_pmu_commit_txn

This allows setting of half the available_filter_functions to take place in
less than a second!

 # time seq 20000 > set_ftrace_filter
 real    0m0.042s
 user    0m0.005s
 sys     0m0.015s

 # wc -l set_ftrace_filter
 20000 set_ftrace_filter

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst     | 38 ++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c              | 30 +++++++++++++++++++++++
 kernel/trace/trace.h               |  1 +
 kernel/trace/trace_events_filter.c |  5 ++++
 4 files changed, 74 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 6ce2763a2a3e..7c5e6d6ab5d1 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -233,6 +233,12 @@ of ftrace. Here is a list of some of the key files:
 	This interface also allows for commands to be used. See the
 	"Filter commands" section for more details.
 
+	As a speed up, since processing strings can't be quite expensive
+	and requires a check of all functions registered to tracing, instead
+	an index can be written into this file. A number (starting with "1")
+	written will instead select the same corresponding at the line position
+	of the "available_filter_functions" file.
+
   set_ftrace_notrace:
 
 	This has an effect opposite to that of
@@ -2835,6 +2841,38 @@ Produces::
 
 We can see that there's no more lock or preempt tracing.
 
+Selecting function filters via index
+------------------------------------
+
+Because processing of strings is expensive (the address of the function
+needs to be looked up before comparing to the string being passed in),
+an index can be used as well to enable functions. This is useful in the
+case of setting thousands of specific functions at a time. By passing
+in a list of numbers, no string processing will occur. Instead, the function
+at the specific location in the internal array (which corresponds to the
+functions in the "available_filter_functions" file), is selected.
+
+::
+
+  # echo 1 > set_ftrace_filter
+
+Will select the first function listed in "available_filter_functions"
+
+::
+
+  # head -1 available_filter_functions
+  trace_initcall_finish_cb
+
+  # cat set_ftrace_filter
+  trace_initcall_finish_cb
+
+  # head -50 available_filter_functions | tail -1
+  x86_pmu_commit_txn
+
+  # echo 1 50 > set_ftrace_filter
+  # cat set_ftrace_filter
+  trace_initcall_finish_cb
+  x86_pmu_commit_txn
 
 Dynamic ftrace with the function graph tracer
 ---------------------------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index aac7847c0214..fa79323331b2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3701,6 +3701,31 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 	return ret;
 }
 
+static int
+add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
+		 int clear_filter)
+{
+	long index = simple_strtoul(func_g->search, NULL, 0);
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec;
+
+	/* The index starts at 1 */
+	if (--index < 0)
+		return 0;
+
+	do_for_each_ftrace_rec(pg, rec) {
+		if (pg->index <= index) {
+			index -= pg->index;
+			/* this is a double loop, break goes to the next page */
+			break;
+		}
+		rec = &pg->records[index];
+		enter_record(hash, rec, clear_filter);
+		return 1;
+	} while_for_each_ftrace_rec();
+	return 0;
+}
+
 static int
 ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 		struct ftrace_glob *mod_g, int exclude_mod)
@@ -3769,6 +3794,11 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 	if (unlikely(ftrace_disabled))
 		goto out_unlock;
 
+	if (func_g.type == MATCH_INDEX) {
+		found = add_rec_by_index(hash, &func_g, clear_filter);
+		goto out_unlock;
+	}
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a34fa5e76abb..ae7df090b93e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1459,6 +1459,7 @@ enum regex_type {
 	MATCH_MIDDLE_ONLY,
 	MATCH_END_ONLY,
 	MATCH_GLOB,
+	MATCH_INDEX,
 };
 
 struct regex {
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index f052ecb085e9..ade606c33231 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -825,6 +825,9 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 
 	*search = buff;
 
+	if (isdigit(buff[0]))
+		return MATCH_INDEX;
+
 	for (i = 0; i < len; i++) {
 		if (buff[i] == '*') {
 			if (!i) {
@@ -862,6 +865,8 @@ static void filter_build_regex(struct filter_pred *pred)
 	}
 
 	switch (type) {
+	/* MATCH_INDEX should not happen, but if it does, match full */
+	case MATCH_INDEX:
 	case MATCH_FULL:
 		r->match = regex_match_full;
 		break;
-- 
2.20.1



Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE54120866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeLSU1J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLSU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:27:09 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE0B2075B;
        Wed, 19 Dec 2018 20:27:06 +0000 (UTC)
Date:   Wed, 19 Dec 2018 15:27:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219152705.292eda25@gandalf.local.home>
In-Reply-To: <1545248809.2396.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 13:46:49 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> Yeah, I had considered it but wasn't sure it was worth it.  Since
> you're suggesting it is, I can send another patch on top of these, or
> feel free if you want to too.  ;-)
> 

Here, want to ack/review it?

-- Steve


From 664457f5cc776aa624502bc628285ea6d70ac8c9 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 19 Dec 2018 15:13:33 -0500
Subject: [PATCH] tracing: Add strncmp_const() macro to prevent typos and cut
 paste errors

The trace_events_hist.c file has a lot of strncmp()s of the form:

   if (strncmp(str, "constant", sizeof("constant") - 1) == 0)

To prevent typos and errors with the constant string being different from
the string use in sizeof(), and also to condense the code, add a macro that
does this:

 #define strncmp_const(str, str_const) \
   strncmp(str, str_const, sizeof(str_const) - 1)

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c5448c103770..40e76053d3d7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -22,6 +22,10 @@
 
 #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
 
+/* Safe way to compare string constants (from typos and cut and paste errors) */
+#define strncmp_const(str, str_const)			\
+	strncmp(str, str_const, sizeof(str_const) - 1)
+
 struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
@@ -1881,8 +1885,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
-	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
+	if ((strncmp_const(str, "onmatch(") == 0) ||
+	    (strncmp_const(str, "onmax(") == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1899,34 +1903,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
-	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
+	if ((strncmp_const(str, "key=") == 0) ||
+	    (strncmp_const(str, "keys=") == 0)) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
-		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
-		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
+	} else if ((strncmp_const(str, "val=") == 0) ||
+		   (strncmp_const(str, "vals=") == 0) ||
+		   (strncmp_const(str, "values=") == 0)) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
+	} else if (strncmp_const(str, "sort=") == 0) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
+	} else if (strncmp_const(str, "name=") == 0) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
+	} else if (strncmp_const(str, "clock=") == 0) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1939,7 +1943,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
+	} else if (strncmp_const(str, "size=") == 0) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -3558,7 +3562,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
+	if (strncmp_const(onmax_fn_name, "save") == 0) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -4346,7 +4350,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
+		if (strncmp_const(str, "onmatch(") == 0) {
 			char *action_str = str + sizeof("onmatch(") - 1;
 
 			data = onmatch_parse(tr, action_str);
@@ -4355,7 +4359,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
+		} else if (strncmp_const(str, "onmax(") == 0) {
 			char *action_str = str + sizeof("onmax(") - 1;
 
 			data = onmax_parse(action_str);
-- 
2.19.1


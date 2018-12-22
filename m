Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87D2197D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbeLVQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeLVQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:47:14 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8F621C5E;
        Sat, 22 Dec 2018 16:28:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gak92-0001Fo-U4; Sat, 22 Dec 2018 11:28:56 -0500
Message-Id: <20181222162856.822332549@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 22 Dec 2018 11:20:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [for-next][PATCH 3/5] tracing: Use str_has_prefix() instead of using fixed sizes
References: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There are several instances of strncmp(str, "const", 123), where 123 is the
strlen of the const string to check if "const" is the prefix of str. But
this can be error prone. Use str_has_prefix() instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events.c      | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/trace_probe.c       | 4 ++--
 kernel/trace/trace_stack.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5afcfecb4bc2..eac2824a18ab 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4411,7 +4411,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	cmp = strstrip(option);
 
-	if (strncmp(cmp, "no", 2) == 0) {
+	if (str_has_prefix(cmp, "no")) {
 		neg = 1;
 		cmp += 2;
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index bd0162c0467c..5b3b0c3c8a47 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1251,7 +1251,7 @@ static int f_show(struct seq_file *m, void *v)
 	 */
 	array_descriptor = strchr(field->type, '[');
 
-	if (!strncmp(field->type, "__data_loc", 10))
+	if (str_has_prefix(field->type, "__data_loc"))
 		array_descriptor = NULL;
 
 	if (!array_descriptor)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d590138f870..0d878dcd1e4b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -518,7 +518,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
 
 static bool synth_field_signed(char *type)
 {
-	if (strncmp(type, "u", 1) == 0)
+	if (str_has_prefix(type, "u"))
 		return false;
 
 	return true;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ff86417c0149..541375737403 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -194,7 +194,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			code->op = FETCH_OP_RETVAL;
 		else
 			ret = -EINVAL;
-	} else if (strncmp(arg, "stack", 5) == 0) {
+	} else if (str_has_prefix(arg, "stack")) {
 		if (arg[5] == '\0') {
 			code->op = FETCH_OP_STACKP;
 		} else if (isdigit(arg[5])) {
@@ -213,7 +213,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	} else if (((flags & TPARG_FL_MASK) ==
 		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
-		   strncmp(arg, "arg", 3) == 0) {
+		   str_has_prefix(arg, "arg")) {
 		if (!isdigit(arg[3]))
 			return -EINVAL;
 		ret = kstrtoul(arg + 3, 10, &param);
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index e2a153fc1afc..3641f28c343f 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -448,7 +448,7 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
 {
-	if (strncmp(str, "_filter=", 8) == 0)
+	if (str_has_prefix(str, "_filter="))
 		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
-- 
2.19.2



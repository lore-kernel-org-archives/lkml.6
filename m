Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441EC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CDF2197D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeLVQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeLVQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:47:14 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E90421D53;
        Sat, 22 Dec 2018 16:28:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gak93-0001Gs-7N; Sat, 22 Dec 2018 11:28:57 -0500
Message-Id: <20181222162857.116914355@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 22 Dec 2018 11:20:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 5/5] tracing: Use the return of str_has_prefix() to remove open coded
 numbers
References: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There are several locations that compare constants to the beginning of
string variables to determine what commands should be done, then the
constant length is used to index into the string. This is error prone as the
hard coded numbers have to match the size of the constants. Instead, use the
len returned from str_has_prefix() and remove the open coded string length
sizes.

Cc: Joe Perches <joe@perches.com>
Cc: Masami  Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c       |  8 +++++---
 kernel/trace/trace_probe.c | 17 +++++++++--------
 kernel/trace/trace_stack.c |  6 ++++--
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eac2824a18ab..18b86c3974e1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4408,13 +4408,15 @@ static int trace_set_options(struct trace_array *tr, char *option)
 	int neg = 0;
 	int ret;
 	size_t orig_len = strlen(option);
+	int len;
 
 	cmp = strstrip(option);
 
-	if (str_has_prefix(cmp, "no")) {
+	len = str_has_prefix(cmp, "no");
+	if (len)
 		neg = 1;
-		cmp += 2;
-	}
+
+	cmp += len;
 
 	mutex_lock(&trace_types_lock);
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 541375737403..9962cb5da8ac 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -186,19 +186,20 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			    struct fetch_insn *code, unsigned int flags)
 {
-	int ret = 0;
 	unsigned long param;
+	int ret = 0;
+	int len;
 
 	if (strcmp(arg, "retval") == 0) {
 		if (flags & TPARG_FL_RETURN)
 			code->op = FETCH_OP_RETVAL;
 		else
 			ret = -EINVAL;
-	} else if (str_has_prefix(arg, "stack")) {
-		if (arg[5] == '\0') {
+	} else if ((len = str_has_prefix(arg, "stack"))) {
+		if (arg[len] == '\0') {
 			code->op = FETCH_OP_STACKP;
-		} else if (isdigit(arg[5])) {
-			ret = kstrtoul(arg + 5, 10, &param);
+		} else if (isdigit(arg[len])) {
+			ret = kstrtoul(arg + len, 10, &param);
 			if (ret || ((flags & TPARG_FL_KERNEL) &&
 				    param > PARAM_MAX_STACK))
 				ret = -EINVAL;
@@ -213,10 +214,10 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	} else if (((flags & TPARG_FL_MASK) ==
 		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
-		   str_has_prefix(arg, "arg")) {
-		if (!isdigit(arg[3]))
+		   (len = str_has_prefix(arg, "arg"))) {
+		if (!isdigit(arg[len]))
 			return -EINVAL;
-		ret = kstrtoul(arg + 3, 10, &param);
+		ret = kstrtoul(arg + len, 10, &param);
 		if (ret || !param || param > PARAM_MAX_STACK)
 			return -EINVAL;
 		code->op = FETCH_OP_ARG;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3641f28c343f..eec648a0d673 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -448,8 +448,10 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
 {
-	if (str_has_prefix(str, "_filter="))
-		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
+	int len;
+
+	if ((len = str_has_prefix(str, "_filter=")))
+		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
 	last_stack_tracer_enabled = 1;
-- 
2.19.2



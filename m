Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvQcqX7qkpLbGXgmzymAPxbB+gXY2xzE2+Mp6vY1FSwx60gMX9hbznGCozziU4pbu0vchYq
ARC-Seal: i=1; a=rsa-sha256; t=1520498787; cv=none;
        d=google.com; s=arc-20160816;
        b=abo2OOcEc3fBVWgcBQclBLzctXOPeB1NX05It409p16FAuOkKFyPrNLjAngAzzfWN4
         dDsdZQPBVl7bmTqfWhLJP+takjmi24DDAiOCdjRnSkY5MJWdGQQ+nQcH8pHpAeseEATn
         NI2QZDjWNNMcJkJfKOZaSHp3Yz6nzclcFQCueKR6SdY7ESxsR51tyhfyy9/TDFQzMdX3
         KHmRJfjs6F3uaBWBy3lOgR5o3aRDxK92wk/eNNicYkDj8C1B9HrthyLclk9OqOAYaru8
         PacOomq1HUB397sHWcT+s0JwoNS0ZBWrE1n5NF7HTKFIlDz9p2pLg0KyUPgRkta/VjvI
         u/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=90XgKAxpVpMV9HgYIdvfQrs0rSaa+pxCZaNw+E0JqUQ=;
        b=s6nvY+1qclMq1WNHn/PkK0OdMMtmlpFg/XF3f1yTJs9NVJZ/XFArxDGs2nENXPs2Kx
         qe7WQdDwm7Z86CL7m4jXCgRtzXuI251juvYz9ZKTTudb5o0BF/NBhpxfvgxVjsJo214o
         0vacGytFKt76Yoo9ruyUGbrQEeb5WVOc1mEOt/cl7/Me2AR9xs14HFK8F8Sg3pcUAQEz
         MqGwuL2azMv620gY6gnC86St98sRuMR8Uoxk1RpdRqOIkxg0oQ3EqENqz8sHqdHFGpIj
         x0jz+wDZZvu20xYyU0DcE7WyaGgiQC+gkeZrI2WbbtJT2aKp1YZ9XF7IZoZC/teIj+Lf
         VLEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbeCHIq0 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:46:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755224AbeCHIqZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:46:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B632172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v5 05/19] tracing: probeevent: Cleanup print argument functions
Date: Thu,  8 Mar 2018 17:46:01 +0900
Message-Id: <152049876156.7289.14806674758348309502.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152049860385.7289.14079393589900496424.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358536215239677?=
X-GMAIL-MSGID: =?utf-8?q?1594358536215239677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current print argument functions prints the argument
name too. It is not good for printing out multiple
values for one argument. This change it to just print
out the value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   20 ++++++--------------
 kernel/trace/trace_probe.c  |   12 +++++-------
 kernel/trace/trace_probe.h  |   19 ++++++++++++++++---
 kernel/trace/trace_uprobe.c |    9 ++-------
 4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1cd3fb4d70f8..81e2eb5a1566 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1090,8 +1090,6 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 	struct kprobe_trace_entry_head *field;
 	struct trace_seq *s = &iter->seq;
 	struct trace_probe *tp;
-	u8 *data;
-	int i;
 
 	field = (struct kprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
@@ -1103,11 +1101,9 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	data = (u8 *)&field[1];
-	for (i = 0; i < tp->nr_args; i++)
-		if (!tp->args[i].type->print(s, tp->args[i].name,
-					     data + tp->args[i].offset, field))
-			goto out;
+	if (print_probe_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
  out:
@@ -1121,8 +1117,6 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 	struct kretprobe_trace_entry_head *field;
 	struct trace_seq *s = &iter->seq;
 	struct trace_probe *tp;
-	u8 *data;
-	int i;
 
 	field = (struct kretprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
@@ -1139,11 +1133,9 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	data = (u8 *)&field[1];
-	for (i = 0; i < tp->nr_args; i++)
-		if (!tp->args[i].type->print(s, tp->args[i].name,
-					     data + tp->args[i].offset, field))
-			goto out;
+	if (print_probe_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index daf54bda4dc8..8894b81e29b0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -38,10 +38,9 @@ const char *reserved_field_names[] = {
 
 /* Printing  in basic type function template */
 #define DEFINE_BASIC_PRINT_TYPE_FUNC(tname, type, fmt)			\
-int PRINT_TYPE_FUNC_NAME(tname)(struct trace_seq *s, const char *name,	\
-				void *data, void *ent)			\
+int PRINT_TYPE_FUNC_NAME(tname)(struct trace_seq *s, void *data, void *ent)\
 {									\
-	trace_seq_printf(s, " %s=" fmt, name, *(type *)data);		\
+	trace_seq_printf(s, fmt, *(type *)data);			\
 	return !trace_seq_has_overflowed(s);				\
 }									\
 const char PRINT_TYPE_FMT_NAME(tname)[] = fmt;				\
@@ -61,15 +60,14 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
 
 /* Print type function for string type */
-int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, const char *name,
-				 void *data, void *ent)
+int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 {
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_printf(s, " %s=(fault)", name);
+		trace_seq_puts(s, "(fault)");
 	else
-		trace_seq_printf(s, " %s=\"%s\"", name,
+		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
 	return !trace_seq_has_overflowed(s);
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 75daff22ccea..0c8e66f9c855 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -94,7 +94,7 @@ static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
 /* Data fetch function type */
 typedef	void (*fetch_func_t)(struct pt_regs *, void *, void *);
 /* Printing function type */
-typedef int (*print_type_func_t)(struct trace_seq *, const char *, void *, void *);
+typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 
 /* Fetch types */
 enum {
@@ -136,8 +136,7 @@ typedef u32 string_size;
 
 /* Printing  in basic type function template */
 #define DECLARE_BASIC_PRINT_TYPE_FUNC(type)				\
-int PRINT_TYPE_FUNC_NAME(type)(struct trace_seq *s, const char *name,	\
-				void *data, void *ent);			\
+int PRINT_TYPE_FUNC_NAME(type)(struct trace_seq *s, void *data, void *ent);\
 extern const char PRINT_TYPE_FMT_NAME(type)[]
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(u8);
@@ -415,6 +414,20 @@ store_trace_args(int ent_size, struct trace_probe *tp, struct pt_regs *regs,
 	}
 }
 
+static inline int
+print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field)
+{
+	int i;
+
+	for (i = 0; i < nr_args; i++) {
+		trace_seq_printf(s, " %s=", args[i].name);
+		if (!args[i].type->print(s, data + args[i].offset, field))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 extern int set_print_fmt(struct trace_probe *tp, bool is_return);
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f4351ae0..4c006a693663 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -864,7 +864,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	struct trace_seq *s = &iter->seq;
 	struct trace_uprobe *tu;
 	u8 *data;
-	int i;
 
 	entry = (struct uprobe_trace_entry_head *)iter->ent;
 	tu = container_of(event, struct trace_uprobe, tp.call.event);
@@ -881,12 +880,8 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	for (i = 0; i < tu->tp.nr_args; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		if (!parg->type->print(s, parg->name, data + parg->offset, entry))
-			goto out;
-	}
+	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
 


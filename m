Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+GN6wXgnK6ZA/VRlFw+nwsf9cSupt1HSp1LOT7imLsB4tKcWXgwcsexyYd5hvMHi1HKgNY
ARC-Seal: i=1; a=rsa-sha256; t=1524658622; cv=none;
        d=google.com; s=arc-20160816;
        b=GW476EtXIgXLty0ZC/0S536FQTuaPuIB+8YK0smg+i3eqvKwUNzWOyIcdlrvvoFxFW
         F3bsTh3e4UPU4v/f8zi+bkaG3dsIhvhJHYq24Nc6Zd2nVNVNtF/QYElQuz87Z82Y4d+9
         CDwriY+P1q2BxdLgUovlG56cSAg2pqlJHRS/P5HkHjZtuy6l8VI/7GlthN/C2gpjSApa
         gP5N9Du0yFiXG5zNqU+yLZqNoPrR/xucFAD0iyXABF6x69/wib5JPqioFe2nrHbNJEll
         H3JwgKzPKD7w1cAG0Ylyt1kBmyEBK7l0FTHM1teGXriFsrC5E/AtRIgfZhXW5IetLLIh
         4u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=bSp25PnA5BNbgfhT9ExFCVOMa0raZYDNbrpP3RsSpRI=;
        b=XTdiXOFxOP74sV0H2biSD2IjmpsmkC/cvQ9jdHhllYvau8LUrJw98zMtCX13itC3OZ
         12VHEKfxNu5c377VBEl4iL6SS1DFxEppm1lcGDMwqDC72KfRp+HrTLsVYeS4oU8EWRAI
         WJyrBXgVVhc5iXnrzWV3CCc1Yb33J5C2c/24U/pwHt5w+qKe6rj+l43v9RXplNUb3vcJ
         tL2T0hGv/a7WbcLUCFGxoxFzMwgI/c6chOtEP55Uwo3sCavNCLtzi3MNAlWYiIR8W3nB
         UlHvhVMrB1knaeXggbR0X2wnS75NV5mAmlF4/oES3/pIMtAX/wJkCObXGWEKc/qvmfFc
         t7Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDYMRB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752949AbeDYMRA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:17:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152421748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 01/16] tracing: probeevent: Cleanup print argument functions
Date: Wed, 25 Apr 2018 21:16:36 +0900
Message-Id: <152465859635.26224.13452846788717102315.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720439549360394?=
X-GMAIL-MSGID: =?utf-8?q?1598720439549360394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup the print-argument function to decouple it into
print-name and print-value, so that it can support more
flexible expression, like array type.

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
index 34fd0e0ec51d..d5e7d84e375a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -851,7 +851,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	struct trace_seq *s = &iter->seq;
 	struct trace_uprobe *tu;
 	u8 *data;
-	int i;
 
 	entry = (struct uprobe_trace_entry_head *)iter->ent;
 	tu = container_of(event, struct trace_uprobe, tp.call.event);
@@ -868,12 +867,8 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
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
 


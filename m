Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226AW6OtmTY3Eu4jOJGBQInWD2g5K784nbEuF22MVd37km/L+a5mNTYzgR8yh50XOjfyuAvx
ARC-Seal: i=1; a=rsa-sha256; t=1519224995; cv=none;
        d=google.com; s=arc-20160816;
        b=Upd/b2tkE/+gpFBAh1OPDEhpEG8yaq8SIeIC3damSHUuoK9gndb8LcqHIOx0ltUAaV
         EjD15KItCpZLn8wvG66cSkMh6+HOCSYjKl2Q/FA2TgJK+Xxc19CL8nsCT0cMPfVsnbIr
         WPIH7lGpIJ+KWSvfy29+QwBiDmO1xZYJH6b0iPfUO8nr+LleV945uktXzGYn5LIA6hMT
         eoj14x5odRJkpJRnx5zKKTQzezA66tuuQXf9L0cAwcv0nk9yu1HrNStZdXtVzwLFR8PC
         tSDhC0LwgxBsUwqDRmySUIuQGNLUbbdkMSU7A6ComoTnIfi7qGu++TojJ2n4nkHNbSZa
         QlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=a/iZhwpZDBJBPUzAfQtC+ZS3oy3/edDr6xjlVgsEWeE=;
        b=ZyycN9hDhT08dbZPrz21PT6PXFphbAvtCJwJ3ohEq301AefjxxE6TBPiBLKtlxqdci
         3PDofuBa8TYuFjEenTfXpgNCpeyk7JYFUV9Nz5y5hOI0Nr4H3kckp71mqZDroWPtQd34
         ENYOEsZCuH6PBGmZmUGN0v8kjUDWQvlFoHUW1AXStk1SO8Ru5s1ja/ebVP5AMzwk91Wf
         7Gz8hRSuTveIri9q9OwSvAApbYHAmouODowv+mS6kRq/rX+Jb0fRlBNiPbrHHwrDtrZo
         dXsVg/TCX0oEv/xgC6B53VJQ474qRlFPn31C1IOXAweEDRf3y+PfxMNvYpMnnQgJcT+m
         rIAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936893AbeBUO4f (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933065AbeBUO4d (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:56:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3395217B3
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
Subject: [PATCH v2 04/17] tracing: probeevent: Cleanup print argument functions
Date: Wed, 21 Feb 2018 23:56:09 +0900
Message-Id: <151922496947.6217.1534758330504842169.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151922484560.6217.1143686155616343906.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022869077124583?=
X-GMAIL-MSGID: =?utf-8?q?1593022869077124583?=
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
index dab4a5b54269..59882393fc1b 100644
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
index 3e291a754862..59b0f76fb4a5 100644
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
 


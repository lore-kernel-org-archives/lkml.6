Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeBARqR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBARqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:46:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4841220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 1 Feb 2018 12:46:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 4.16
Message-ID: <20180201124613.12876325@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Mostly clean ups and small fixes

There's not many changes for the tracing system this release.
Mostly small clean ups and fixes.

The biggest change is to how bprintf works. bprintf is used by
trace_printk() to just save the format and args of a printf call,
and the formatting is done when the trace buffer is read. This is
done to keep the formatting out of the fast path (this was recommended
by you). The issue is when arguments are de-referenced.

If a pointer is saved, and the format has something like "%*pbl",
when the buffer is read, it will de-reference the argument then.
The problem is if the data no longer exists. This can cause the
kernel to oops.

The fix for this was to make these de-reference pointers do
the formatting at the time it is called (the fast path), as
this guarantees that the data exists (and doesn't change later)


Please pull the latest trace-v4.16 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.16

Tag SHA1: abf4488ea90617170e962e901ed9506fc3411a5c
Head SHA1: 841a915d20c7b22fc4f36f12368daf94d9f8cb10


Andi Kleen (1):
      ftrace: Mark function tracer test functions noinline/noclone

Changbin Du (3):
      tracing: Detect the string nul character when parsing user input string
      tracing: Clear parser->idx if only spaces are read
      tracing: Make sure the parsed string always terminates with '\0'

Ravi Bangoria (1):
      trace_uprobe: Display correct offset in uprobe_events

Steven Rostedt (VMware) (1):
      vsprintf: Do not have bprintf dereference pointers

----
 kernel/trace/ftrace.c                 |  2 -
 kernel/trace/trace.c                  | 14 +++---
 kernel/trace/trace_events.c           |  2 -
 kernel/trace/trace_selftest_dynamic.c |  5 ++-
 kernel/trace/trace_uprobe.c           |  2 +-
 lib/vsprintf.c                        | 82 +++++++++++++++++++++++++++++------
 6 files changed, 80 insertions(+), 27 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 554b517c61a0..dabd9d167d42 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5015,7 +5015,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 	parser = &iter->parser;
 	if (trace_parser_loaded(parser)) {
-		parser->buffer[parser->idx] = 0;
 		ftrace_match_records(iter->hash, parser->buffer, parser->idx);
 	}
 
@@ -5329,7 +5328,6 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		parser = &fgd->parser;
 
 		if (trace_parser_loaded((parser))) {
-			parser->buffer[parser->idx] = 0;
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e3f20a18a06..58de825df19c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -530,8 +530,6 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		ubuf += ret;
 		cnt -= ret;
 
-		parser.buffer[parser.idx] = 0;
-
 		ret = -EINVAL;
 		if (kstrtoul(parser.buffer, 0, &val))
 			break;
@@ -1236,18 +1234,18 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 			cnt--;
 		}
 
+		parser->idx = 0;
+
 		/* only spaces were written */
-		if (isspace(ch)) {
+		if (isspace(ch) || !ch) {
 			*ppos += read;
 			ret = read;
 			goto out;
 		}
-
-		parser->idx = 0;
 	}
 
 	/* read the non-space input */
-	while (cnt && !isspace(ch)) {
+	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
 		else {
@@ -1262,12 +1260,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	}
 
 	/* We either got finished input or we have to wait for another call. */
-	if (isspace(ch)) {
+	if (isspace(ch) || !ch) {
 		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
 	} else if (parser->idx < parser->size - 1) {
 		parser->cont = true;
 		parser->buffer[parser->idx++] = ch;
+		/* Make sure the parsed string always terminates with '\0'. */
+		parser->buffer[parser->idx] = 0;
 	} else {
 		ret = -EINVAL;
 		goto out;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1b87157edbff..05c7172c6667 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -885,8 +885,6 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 		if (*parser.buffer == '!')
 			set = 0;
 
-		parser.buffer[parser.idx] = 0;
-
 		ret = ftrace_set_clr_event(tr, parser.buffer + !set, set);
 		if (ret)
 			goto out_put;
diff --git a/kernel/trace/trace_selftest_dynamic.c b/kernel/trace/trace_selftest_dynamic.c
index 8cda06a10d66..c364cf777e1a 100644
--- a/kernel/trace/trace_selftest_dynamic.c
+++ b/kernel/trace/trace_selftest_dynamic.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
 #include "trace.h"
 
-int DYN_FTRACE_TEST_NAME(void)
+noinline __noclone int DYN_FTRACE_TEST_NAME(void)
 {
 	/* used to call mcount */
 	return 0;
 }
 
-int DYN_FTRACE_TEST_NAME2(void)
+noinline __noclone int DYN_FTRACE_TEST_NAME2(void)
 {
 	/* used to call mcount */
 	return 0;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 40592e7b3568..268029ae1be6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
 
 	/* Don't print "0x  (null)" when offset is 0 */
 	if (tu->offset) {
-		seq_printf(m, "0x%p", (void *)tu->offset);
+		seq_printf(m, "0x%px", (void *)tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 01c3957b2de6..c0c3542d92fa 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2516,29 +2516,34 @@ int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 {
 	struct printf_spec spec = {0};
 	char *str, *end;
+	int width;
 
 	str = (char *)bin_buf;
 	end = (char *)(bin_buf + size);
 
 #define save_arg(type)							\
-do {									\
+({									\
+	unsigned long long value;					\
 	if (sizeof(type) == 8) {					\
-		unsigned long long value;				\
+		unsigned long long val8;				\
 		str = PTR_ALIGN(str, sizeof(u32));			\
-		value = va_arg(args, unsigned long long);		\
+		val8 = va_arg(args, unsigned long long);		\
 		if (str + sizeof(type) <= end) {			\
-			*(u32 *)str = *(u32 *)&value;			\
-			*(u32 *)(str + 4) = *((u32 *)&value + 1);	\
+			*(u32 *)str = *(u32 *)&val8;			\
+			*(u32 *)(str + 4) = *((u32 *)&val8 + 1);	\
 		}							\
+		value = val8;						\
 	} else {							\
-		unsigned long value;					\
+		unsigned int val4;					\
 		str = PTR_ALIGN(str, sizeof(type));			\
-		value = va_arg(args, int);				\
+		val4 = va_arg(args, int);				\
 		if (str + sizeof(type) <= end)				\
-			*(typeof(type) *)str = (type)value;		\
+			*(typeof(type) *)str = (type)(long)val4;	\
+		value = (unsigned long long)val4;			\
 	}								\
 	str += sizeof(type);						\
-} while (0)
+	value;								\
+})
 
 	while (*fmt) {
 		int read = format_decode(fmt, &spec);
@@ -2554,7 +2559,10 @@ do {									\
 
 		case FORMAT_TYPE_WIDTH:
 		case FORMAT_TYPE_PRECISION:
-			save_arg(int);
+			width = (int)save_arg(int);
+			/* Pointers may require the width */
+			if (*fmt == 'p')
+				set_field_width(&spec, width);
 			break;
 
 		case FORMAT_TYPE_CHAR:
@@ -2576,7 +2584,27 @@ do {									\
 		}
 
 		case FORMAT_TYPE_PTR:
-			save_arg(void *);
+			/* Dereferenced pointers must be done now */
+			switch (*fmt) {
+			/* Dereference of functions is still OK */
+			case 'S':
+			case 's':
+			case 'F':
+			case 'f':
+				save_arg(void *);
+				break;
+			default:
+				if (!isalnum(*fmt)) {
+					save_arg(void *);
+					break;
+				}
+				str = pointer(fmt, str, end, va_arg(args, void *),
+					      spec);
+				if (str + 1 < end)
+					*str++ = '\0';
+				else
+					end[-1] = '\0'; /* Must be nul terminated */
+			}
 			/* skip all alphanumeric pointer suffixes */
 			while (isalnum(*fmt))
 				fmt++;
@@ -2728,11 +2756,39 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			break;
 		}
 
-		case FORMAT_TYPE_PTR:
-			str = pointer(fmt, str, end, get_arg(void *), spec);
+		case FORMAT_TYPE_PTR: {
+			bool process = false;
+			int copy, len;
+			/* Non function dereferences were already done */
+			switch (*fmt) {
+			case 'S':
+			case 's':
+			case 'F':
+			case 'f':
+				process = true;
+				break;
+			default:
+				if (!isalnum(*fmt)) {
+					process = true;
+					break;
+				}
+				/* Pointer dereference was already processed */
+				if (str < end) {
+					len = copy = strlen(args);
+					if (copy > end - str)
+						copy = end - str;
+					memcpy(str, args, copy);
+					str += len;
+					args += len;
+				}
+			}
+			if (process)
+				str = pointer(fmt, str, end, get_arg(void *), spec);
+
 			while (isalnum(*fmt))
 				fmt++;
 			break;
+		}
 
 		case FORMAT_TYPE_PERCENT_CHAR:
 			if (str < end)

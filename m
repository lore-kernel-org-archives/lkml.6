Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeBBXNC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbeBBXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E91217A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231019.131055399@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 14/18] tracing: Have char arrays be strings for function based events
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0014-tracing-Have-char-arrays-be-strings-for-function-bas.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a field in a function based event is defined with type "char[##]" then it
will be considered a static string. If a user wants an actual byte array
they should use one of u8, s8, or x8.

Now we can get strings from events:

 # echo 'SyS_openat(int dfd, char[64] buf, x32 flags, x32 mode)' > function_events
 # grep xxx /etc/*
 # cat trace
  grep-1745  [001] .... 346135.431364: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/adjtime, flags=100, mode=0)
  grep-1745  [001] .... 346135.431734: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/aliases, flags=100, mode=0)
  grep-1745  [001] .... 346135.618765: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/alternatives, flags=100, mode=0)
  grep-1745  [001] .... 346135.619063: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/anacrontab, flags=100, mode=0)
  grep-1745  [001] .... 346135.619134: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/asciidoc, flags=100, mode=0)
  grep-1745  [001] .... 346135.619390: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/asound.conf, flags=100, mode=0)
  grep-1745  [001] .... 346135.624350: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/audisp, flags=100, mode=0)
  grep-1745  [001] .... 346135.624565: entry_SYSCALL_64_fastpath->SyS_openat(dfd=-100, buf=/etc/audit, flags=100, mode=0)

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 17 +++++++++++++++++
 kernel/trace/trace_event_ftrace.c             | 21 +++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 4a8a6fb16a0a..99ae77cd59e6 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -325,3 +325,20 @@ To get the net_device perm_addr, from the dev parameter.
     <idle>-0     [003] ..s3   219.813595: __netif_receive_skb_core->ip_rcv(skb=ffff880118195e00, perm_addr=b4,b5,2f,ce,18,65)
     <idle>-0     [003] ..s3   220.115053: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)
     <idle>-0     [003] ..s3   220.115293: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)
+
+
+Static strings
+==============
+
+An array of type 'char' or 'unsigned char' will be processed as a string using
+the format "%s". If a nul is found, the output will stop. Use another type
+(x8, u8, s8) if this is not desired.
+
+  # echo 'link_path_walk(char[64] name)' > function_events
+
+  # echo 1 > events/functions/link_path_walk/enable
+  # cat trace
+      bash-1470  [003] ...2   980.678664: path_openat->link_path_walk(name=/usr/bin/cat)
+      bash-1470  [003] ...2   980.678715: path_openat->link_path_walk(name=/lib64/ld-linux-x86-64.so.2)
+      bash-1470  [003] ...2   980.678721: path_openat->link_path_walk(name=ld-2.24.so)
+      bash-1470  [003] ...2   980.678978: path_lookupat->link_path_walk(name=/etc/ld.so.preload)
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 64e2d7dcfd18..dd24b840329d 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -610,6 +610,14 @@ static void make_fmt(struct func_arg *arg, char *fmt)
 
 	fmt[c++] = '%';
 
+	if (arg->func_type == FUNC_TYPE_char) {
+		if (arg->array)
+			fmt[c++] = 's';
+		else
+			fmt[c++] = 'c';
+		goto out;
+	}
+
 	if (arg->size == 8) {
 		fmt[c++] = 'l';
 		fmt[c++] = 'l';
@@ -622,6 +630,7 @@ static void make_fmt(struct func_arg *arg, char *fmt)
 	else
 		fmt[c++] = 'u';
 
+ out:
 	fmt[c++] = '\0';
 }
 
@@ -639,7 +648,10 @@ static void write_data(struct trace_seq *s, const struct func_arg *arg, const ch
 		trace_seq_printf(s, fmt, *(unsigned short *)data);
 		break;
 	case 1:
-		trace_seq_printf(s, fmt, *(unsigned char *)data);
+		if (arg->array && arg->func_type == FUNC_TYPE_char)
+			trace_seq_printf(s, fmt, (char *)data);
+		else
+			trace_seq_printf(s, fmt, *(unsigned char *)data);
 		break;
 	}
 }
@@ -672,7 +684,7 @@ func_event_print(struct trace_iterator *iter, int flags,
 
 		make_fmt(arg, fmt);
 
-		if (arg->array) {
+		if (arg->array && arg->func_type != FUNC_TYPE_char) {
 			comma = false;
 			for (a = 0; a < arg->array; a++, data += arg->size) {
 				if (comma)
@@ -821,7 +833,7 @@ static int __set_print_fmt(struct func_event *func_event,
 
 		make_fmt(arg, fmt);
 
-		if (arg->array) {
+		if (arg->array && arg->func_type != FUNC_TYPE_char) {
 			bool colon = false;
 
 			for (a = 0; a < arg->array; a++) {
@@ -846,7 +858,8 @@ static int __set_print_fmt(struct func_event *func_event,
 	len = update_len(len, i);
 
 	list_for_each_entry(arg, &func_event->args, list) {
-		if (arg->array) {
+		/* Don't iterate for strings */
+		if (arg->array && arg->func_type != FUNC_TYPE_char) {
 			for (a = 0; a < arg->array; a++) {
 				i = snprintf(buf + r, len, ", REC->%s[%d]", arg->name, a);
 				r += i;
-- 
2.15.1

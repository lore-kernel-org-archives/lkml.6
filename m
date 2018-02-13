Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934625AbeBMPih (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933686AbeBMPif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:38:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B58E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org
Subject: [RFC PATCH 5/8] tracing: probeevent: Add symbol type
Date: Wed, 14 Feb 2018 00:38:11 +0900
Message-Id: <151853629096.31487.12627249657683189992.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151853614489.31487.10683006682475678487.stgit@devbox>
References: <151853614489.31487.10683006682475678487.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "symbol" type to probeevent, which is an alias of u32 or u64
(depends on BITS_PER_LONG). This shows the result value in
symbol+offset style. This type is only available with kprobe
events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.txt |    3 +++
 kernel/trace/trace_probe.c          |    8 ++++++++
 kernel/trace/trace_probe.h          |   12 +++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
index 1a3a3d6bc2a8..d49381f2e411 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -62,6 +62,7 @@ respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
 or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
+
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out.
@@ -70,6 +71,8 @@ offset, and container-size (usually 32). The syntax is;
 
  b<bit-width>@<bit-offset>/<container-size>
 
+Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
+which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 52b4931864d6..f56dfadd29d5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -58,6 +58,13 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
 
+int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
+{
+	trace_seq_printf(s, "%pS", (void *)*(unsigned long *)data);
+	return !trace_seq_has_overflowed(s);
+}
+const char PRINT_TYPE_FMT_NAME(symbol)[] = "%pS";
+
 /* Print type function for string type */
 int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 {
@@ -103,6 +110,7 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
 
 	ASSIGN_FETCH_TYPE_END
 };
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index b22792a6f889..2234586b9942 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -171,6 +171,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
+DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
 /* Default (unsigned long) fetch type */
 #define __DEFAULT_FETCH_TYPE(t) x##t
@@ -178,6 +179,10 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 #define DEFAULT_FETCH_TYPE _DEFAULT_FETCH_TYPE(BITS_PER_LONG)
 #define DEFAULT_FETCH_TYPE_STR __stringify(DEFAULT_FETCH_TYPE)
 
+#define __ADDR_FETCH_TYPE(t) u##t
+#define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
+#define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
+
 #define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
 	{.name = _name,				\
 	 .size = _size,					\
@@ -186,13 +191,14 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
 	 .fmttype = _fmttype,				\
 	}
-
+#define _ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
+	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, #_fmttype)
 #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
-	__ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, #ptype)
+	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, ptype)
 
 /* If ptype is an alias of atype, use this macro (show atype in format) */
 #define ASSIGN_FETCH_TYPE_ALIAS(ptype, atype, ftype, sign)		\
-	__ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, #atype)
+	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, atype)
 
 #define ASSIGN_FETCH_TYPE_END {}
 

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224vFKFrcJCrxwGki8TEse+EpHhG3MSuF9WZ4h8dsTrnKxyyOm/LiFKknsf1m4JNYmtmUQ0/
ARC-Seal: i=1; a=rsa-sha256; t=1519225198; cv=none;
        d=google.com; s=arc-20160816;
        b=TeM/lUysTV0fVt2NsmnpJ5nr9S2tfvBq3qyNLaJfful8MGPrzWKW6zmyl7Iyb4Hs68
         fiWFLymxtC7igtrEDLMc7wDuElPfHCTt+WzfUguoFWuNrUsms+nntFHVhGild5t3Ojuy
         eVJTVsrX3w1cD7mMV/foovXkWzh/G9JxsxQigdgMQRKT8khHYC8e1KkHZnvhh2Y6BYQU
         YKovzw5V+qsoOsLp/lzLXi73V7mLdhEEfZ6IadQ4tXG6JtlNvBG3gitsh3jm8kDJ7rSk
         bnwhmu50+jta4uviWO4CTXxQ5jVmc6Fe9sDzlPKlBd69hT6Q/pvjYbWXodQvHu08FuCC
         UIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=OEtPJiwEjLmXi46ul8vuFvpUQcywBgE9Y+AuejgTY3Q=;
        b=MYK8WBxhwwuuDzAe3soVaCTuHqQXJ3ZuL5zkCqcnilp8Nk5Nv17k5h5BjohMVdSPyX
         XY/KruuV8Xo/hY25x2nC80l8miDRslKQLIdqUe97kV2zMXYqS0m7XZk1bW3CQePQ50bM
         ulUsVO0+7H4NvIOH/PtbuLLQNorJ+SQhFm2PzMlMNdpzzvHDJ6k7qRxdZvtna2oP4z1q
         cB+Y9zGujYjby56RrKnSzldKREb29gfPjATyNijXC+P201JkSkJsloSRcoG/6Qt27EPa
         mixbgeXRocnOVgCDixCLmV2wEgbPlr2Qrt9S+X/5Vlih1gwWEUH3NaVR9BKvMPSDz5NF
         N89w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935439AbeBUO76 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935389AbeBUO75 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:59:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6606D2178E
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
Subject: [PATCH v2 11/17] tracing: probeevent: Add symbol type
Date: Wed, 21 Feb 2018 23:59:33 +0900
Message-Id: <151922517338.6217.2368173659499080069.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593023082310087212?=
X-GMAIL-MSGID: =?utf-8?q?1593023082310087212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add "symbol" type to probeevent, which is an alias of u32 or u64
(depends on BITS_PER_LONG). This shows the result value in
symbol+offset style. This type is only available with kprobe
events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add symbol type to README file.
---
 Documentation/trace/kprobetrace.txt |    3 +++
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |    8 ++++++++
 kernel/trace/trace_probe.h          |   12 +++++++++---
 4 files changed, 21 insertions(+), 4 deletions(-)

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
 
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300ae4e8..8f08811d15b8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4609,7 +4609,7 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
 	"\t           $stack<index>, $stack, $retval, $comm\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string,\n"
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8d43f377143d..f41a2989130c 100644
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
@@ -91,6 +98,7 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
 
 	ASSIGN_FETCH_TYPE_END
 };
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 3bc43c1ce628..ef477bd8468a 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -157,6 +157,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
+DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
 /* Default (unsigned long) fetch type */
 #define __DEFAULT_FETCH_TYPE(t) x##t
@@ -164,6 +165,10 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 #define DEFAULT_FETCH_TYPE _DEFAULT_FETCH_TYPE(BITS_PER_LONG)
 #define DEFAULT_FETCH_TYPE_STR __stringify(DEFAULT_FETCH_TYPE)
 
+#define __ADDR_FETCH_TYPE(t) u##t
+#define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
+#define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
+
 #define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
 	{.name = _name,				\
 	 .size = _size,					\
@@ -172,13 +177,14 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
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
 


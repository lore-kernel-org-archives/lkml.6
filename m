Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49JGF09lGHJGfA1zmzBbMaLzydPngygIv+ccBgxebo+/Mvfbef3rnMe1NXfGpK/QDK9lCuV
ARC-Seal: i=1; a=rsa-sha256; t=1524658855; cv=none;
        d=google.com; s=arc-20160816;
        b=AYQ/APMr2oSZrS3PLr1rkUHA1TC1s+Tp5mZ452y/zFrDPKB9CW6WMX0y6k7DEnVNN0
         0uikc8Cw5bvrJ8lZazdQ+Ffoi0tQUn9qaq0oMLpRTSIGp+XJwTNDEHsaU68DYfi3uOk3
         34H4Bw/wpXIdvOgpbBsMD3GWoHKcwhvqiVvnM90bYbmzo+S07Hrt4JQ4OnWpqwZgRt2G
         puLMLdgpA5xZbFpDHL538qSe4RIY4Fj8ffZCmZoYE7HJtcrn0Z82SOCjrMPtsxckjR0J
         SzxoGR2ddr+LT2OgNAcqv+0HnjaUOl4JOl6X1BOV4G0DznZtZTy90jgPqdI25eQC5Yte
         uJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=VzlGiJ96zGANaq9GX3nkdKhIQwkP/IWGcO0bSdnsLjM=;
        b=RBN2tufCgYMk6xxk3YYpuEU/k4z5e3NRhdIZVyXF92cJo1I8qGyOAf3HtlHQx40vND
         LzD6WykX9QWiv9cHX9R6eqnfxXQ5MwCarG0DSFKv94ALzpmI1zZH/p4cbV/M6Cur8pwn
         m5mgsTfH1S5glAJw3UPMzNzPIOzpsvWnWtbZgJketLHxa1wley2FhqaqbrSG3CTPCY7b
         QTtMZ1CdEZsjS2ZI/W71vZJAmq8qPYsrTFxi9STkzaoH7nIRgaxlcQOG0lIQlEnVF+40
         f5yg2xgbAtyB4Q8UxnMdQ1ZlafeQTmWYoo+hHt/mFf8V8fIIs+QACPRyTldMSXVoT4cP
         km9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeDYMUy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753538AbeDYMUw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:20:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8496B21849
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
Subject: [PATCH v7 09/16] tracing: probeevent: Add symbol type
Date: Wed, 25 Apr 2018 21:20:28 +0900
Message-Id: <152465882860.26224.14779072294412467338.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1598720683962768045?=
X-GMAIL-MSGID: =?utf-8?q?1598720683962768045?=
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
 Documentation/trace/kprobetrace.rst |    2 ++
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_probe.c          |    8 ++++++++
 kernel/trace/trace_probe.h          |   12 +++++++++---
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3e0f971b12de..c920c9be221a 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -72,6 +72,8 @@ offset, and container-size (usually 32). The syntax is::
 
  b<bit-width>@<bit-offset>/<container-size>
 
+Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
+which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dfbcf9ee1447..4812ae046f43 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4621,7 +4621,7 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
 	"\t           $stack<index>, $stack, $retval, $comm\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string,\n"
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fff3ccfcdbb6..e2a31087f1f8 100644
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
 


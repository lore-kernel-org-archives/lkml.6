Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A9ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D1220843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D1220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeJ1QP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeJ1QPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5AF20882;
        Sun, 28 Oct 2018 07:31:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXq-00085f-SQ; Sun, 28 Oct 2018 03:31:34 -0400
Message-Id: <20181028073134.782040559@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:29:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/18] tracing: probeevent: Add symbol type
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add "symbol" type to probeevent, which is an alias of u32 or u64
(depends on BITS_PER_LONG). This shows the result value in
symbol+offset style. This type is only available with kprobe
events.

Link: http://lkml.kernel.org/r/152465882860.26224.14779072294412467338.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst |  2 ++
 kernel/trace/trace.c                |  2 +-
 kernel/trace/trace_probe.c          |  8 ++++++++
 kernel/trace/trace_probe.h          | 12 +++++++++---
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 8bfc75c90806..6224ddf34508 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -72,6 +72,8 @@ offset, and container-size (usually 32). The syntax is::
 
  b<bit-width>@<bit-offset>/<container-size>
 
+Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
+which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 147be8523560..1e3f28b1fa07 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4626,7 +4626,7 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
 	"\t           $stack<index>, $stack, $retval, $comm\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string,\n"
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d119bf8c3b4f..1e7e0618577d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -46,6 +46,13 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
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
@@ -79,6 +86,7 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
 	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
 
 	ASSIGN_FETCH_TYPE_END
 };
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c4e9d3d3216d..469110e0790b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -145,6 +145,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
+DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
 /* Default (unsigned long) fetch type */
 #define __DEFAULT_FETCH_TYPE(t) x##t
@@ -152,6 +153,10 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
 #define DEFAULT_FETCH_TYPE _DEFAULT_FETCH_TYPE(BITS_PER_LONG)
 #define DEFAULT_FETCH_TYPE_STR __stringify(DEFAULT_FETCH_TYPE)
 
+#define __ADDR_FETCH_TYPE(t) u##t
+#define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
+#define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
+
 #define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
 	{.name = _name,				\
 	 .size = _size,					\
@@ -160,13 +165,14 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(string);
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
 
-- 
2.19.0



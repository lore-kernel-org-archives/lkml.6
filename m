Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E54C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7259D218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbeLUR5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391161AbeLUR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:57:00 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9735F21970;
        Fri, 21 Dec 2018 17:56:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2g-0002Qa-LS; Fri, 21 Dec 2018 12:56:58 -0500
Message-Id: <20181221175658.549887587@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [for-next][PATCH 19/24] tracing: Merge seq_print_sym_short() and seq_print_sym_offset()
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

These two functions are nearly identical, so we can avoid some code
duplication by moving the conditional into a common implementation.

Link: http://lkml.kernel.org/r/20181029223542.26175-2-linux@rasmusvillemoes.dk

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 6e6cc64faa38..85ecd061c7be 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -339,34 +339,17 @@ static inline const char *kretprobed(const char *name)
 #endif /* CONFIG_KRETPROBES */
 
 static void
-seq_print_sym_short(struct trace_seq *s, const char *fmt, unsigned long address)
+seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
+	      bool offset)
 {
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
 	const char *name;
 
-	kallsyms_lookup(address, NULL, NULL, NULL, str);
-
-	name = kretprobed(str);
-
-	if (name && strlen(name)) {
-		trace_seq_printf(s, fmt, name);
-		return;
-	}
-#endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, fmt, str);
-}
-
-static void
-seq_print_sym_offset(struct trace_seq *s, const char *fmt,
-		     unsigned long address)
-{
-	char str[KSYM_SYMBOL_LEN];
-#ifdef CONFIG_KALLSYMS
-	const char *name;
-
-	sprint_symbol(str, address);
+	if (offset)
+		sprint_symbol(str, address);
+	else
+		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
@@ -424,10 +407,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
 		goto out;
 	}
 
-	if (sym_flags & TRACE_ITER_SYM_OFFSET)
-		seq_print_sym_offset(s, "%s", ip);
-	else
-		seq_print_sym_short(s, "%s", ip);
+	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
 
 	if (sym_flags & TRACE_ITER_SYM_ADDR)
 		trace_seq_printf(s, " <" IP_FMT ">", ip);
-- 
2.19.2



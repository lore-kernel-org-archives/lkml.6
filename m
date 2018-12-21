Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9A7218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbeLUR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391164AbeLUR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:57:00 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99CB21920;
        Fri, 21 Dec 2018 17:56:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2h-0002Re-09; Fri, 21 Dec 2018 12:56:59 -0500
Message-Id: <20181221175658.872681406@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [for-next][PATCH 21/24] tracing: Simplify printfing in seq_print_sym
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

trace_seq_printf(..., "%s", ...) can be done with trace_seq_puts()
instead, avoiding printf overhead. In the second instance, the string
we're copying was just created from an snprintf() to a stack buffer, so
we might as well do that printf directly. This naturally leads to moving
the declaration of the str buffer inside the CONFIG_KALLSYMS guard,
which in turn will make gcc inline the function for !CONFIG_KALLSYMS (it
only has a single caller, but the huge stack frame seems to make gcc not
inline it for CONFIG_KALLSYMS).

Link: http://lkml.kernel.org/r/20181029223542.26175-4-linux@rasmusvillemoes.dk

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index f06fb899b746..54373d93e251 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -341,8 +341,8 @@ static inline const char *kretprobed(const char *name)
 static void
 seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 {
-	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_KALLSYMS
+	char str[KSYM_SYMBOL_LEN];
 	const char *name;
 
 	if (offset)
@@ -352,12 +352,11 @@ seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	name = kretprobed(str);
 
 	if (name && strlen(name)) {
-		trace_seq_printf(s, "%s", name);
+		trace_seq_puts(s, name);
 		return;
 	}
 #endif
-	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
-	trace_seq_printf(s, "%s", str);
+	trace_seq_printf(s, "0x%08lx", address);
 }
 
 #ifndef CONFIG_64BIT
-- 
2.19.2



Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAEA20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAEA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeJ1QP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbeJ1QPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CC720843;
        Sun, 28 Oct 2018 07:31:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXr-00088s-Ru; Sun, 28 Oct 2018 03:31:35 -0400
Message-Id: <20181028073135.762987515@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:30:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 15/18] tracing/kprobes: Allow kprobe-events to record module symbol
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Allow kprobe-events to record module symbols.

Since data symbols in a non-loaded module doesn't exist, it fails to
define such symbol as an argument of kprobe-event. But if the kprobe
event is defined on that module, we can defer to resolve the symbol
address.

Note that if given symbol is not found, the event is kept unavailable.
User can enable it but the event is not recorded.

Link: http://lkml.kernel.org/r/153547312336.26502.11432902826345374463.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 12 ++++++-
 kernel/trace/trace_probe.c  | 62 ++++++++++++++++++++++++++++++++-----
 kernel/trace/trace_probe.h  |  4 ++-
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4727a13824f0..fec67188c4d2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -366,7 +366,7 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
-	int ret;
+	int i, ret;
 
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
@@ -377,6 +377,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < tk->tp.nr_args; i++) {
+		ret = traceprobe_update_arg(&tk->tp.args[i]);
+		if (ret)
+			return ret;
+	}
+
 	/* Set/clear disabled flag according to tp->flag */
 	if (trace_probe_is_enabled(&tk->tp))
 		tk->rp.kp.flags &= ~KPROBE_FLAG_DISABLED;
@@ -928,6 +934,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 {
 	unsigned long val;
 
+retry:
 	/* 1st stage: get value from context */
 	switch (code->op) {
 	case FETCH_OP_REG:
@@ -953,6 +960,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 		val = regs_get_kernel_argument(regs, code->param);
 		break;
 #endif
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
 	default:
 		return -EILSEQ;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 333cda6d2633..5b3d573b3dcf 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -251,16 +251,16 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			if (!(flags & TPARG_FL_KERNEL))
 				return -EINVAL;
 
-			ret = traceprobe_split_symbol_offset(arg + 1, &offset);
-			if (ret)
-				break;
+			/* Preserve symbol for updating */
+			code->op = FETCH_NOP_SYMBOL;
+			code->data = kstrdup(arg + 1, GFP_KERNEL);
+			if (!code->data)
+				return -ENOMEM;
+			if (++code == end)
+				return -E2BIG;
 
 			code->op = FETCH_OP_IMM;
-			code->immediate =
-				(unsigned long)kallsyms_lookup_name(arg + 1);
-			if (!code->immediate)
-				return -ENOENT;
-			code->immediate += offset;
+			code->immediate = 0;
 		}
 		/* These are fetching from memory */
 		if (++code == end)
@@ -480,6 +480,11 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		memcpy(parg->code, tmp, sizeof(*code) * (code - tmp + 1));
 
 fail:
+	if (ret) {
+		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
+			if (code->op == FETCH_NOP_SYMBOL)
+				kfree(code->data);
+	}
 	kfree(tmp);
 
 	return ret;
@@ -504,12 +509,53 @@ int traceprobe_conflict_field_name(const char *name,
 
 void traceprobe_free_probe_arg(struct probe_arg *arg)
 {
+	struct fetch_insn *code = arg->code;
+
+	while (code && code->op != FETCH_OP_END) {
+		if (code->op == FETCH_NOP_SYMBOL)
+			kfree(code->data);
+		code++;
+	}
 	kfree(arg->code);
 	kfree(arg->name);
 	kfree(arg->comm);
 	kfree(arg->fmt);
 }
 
+int traceprobe_update_arg(struct probe_arg *arg)
+{
+	struct fetch_insn *code = arg->code;
+	long offset;
+	char *tmp;
+	char c;
+	int ret = 0;
+
+	while (code && code->op != FETCH_OP_END) {
+		if (code->op == FETCH_NOP_SYMBOL) {
+			if (code[1].op != FETCH_OP_IMM)
+				return -EINVAL;
+
+			tmp = strpbrk("+-", code->data);
+			if (tmp)
+				c = *tmp;
+			ret = traceprobe_split_symbol_offset(code->data,
+							     &offset);
+			if (ret)
+				return ret;
+
+			code[1].immediate =
+				(unsigned long)kallsyms_lookup_name(code->data);
+			if (tmp)
+				*tmp = c;
+			if (!code[1].immediate)
+				return -ENOENT;
+			code[1].immediate += offset;
+		}
+		code++;
+	}
+	return 0;
+}
+
 /* When len=0, we just calculate the needed length */
 #define LEN_OR_ZERO (len ? len - pos : 0)
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 09f62171cc23..974afc1a3e73 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -100,6 +100,7 @@ enum fetch_op {
 	// Stage 5 (loop) op
 	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
 	FETCH_OP_END,
+	FETCH_NOP_SYMBOL,	/* Unresolved Symbol holder */
 };
 
 struct fetch_insn {
@@ -116,6 +117,7 @@ struct fetch_insn {
 			unsigned char rshift;
 		};
 		unsigned long immediate;
+		void *data;
 	};
 };
 
@@ -276,7 +278,7 @@ extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 extern int traceprobe_conflict_field_name(const char *name,
 			       struct probe_arg *args, int narg);
 
-extern void traceprobe_update_arg(struct probe_arg *arg);
+extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
-- 
2.19.0



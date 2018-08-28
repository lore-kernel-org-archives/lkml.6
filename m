Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCECA20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="usAD0yAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCECA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH1ULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeH1ULb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:11:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA6920894;
        Tue, 28 Aug 2018 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535473146;
        bh=CmZolGxa2zu2RGVWpSoqiXlMzgVne4iIZ2WrRSkLhZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usAD0yACXNA4jvYMHGok64dhx9P43Q+uaEn9lBMkEjRrD7CLFp221IEomFH+UIn3K
         nK+WIFFC1i4R1/DB7SyKiz3WUbGI91jwXMzKU4RzS+W56ggsVD23zvaoxbSGxwwzuq
         OEuLBRWX7feYtbss/rpKBEawgGCljl7DnadI8vzk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [ftrace/kprobes PATCH 3/3] tracing/kprobes: Allow kprobe-events to record module symbol
Date:   Wed, 29 Aug 2018 01:18:43 +0900
Message-Id: <153547312336.26502.11432902826345374463.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153547303754.26502.5265242979168613920.stgit@devbox>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow kprobe-events to record module symbols.

Since data symbols in a non-loaded module doesn't exist, it fails to
define such symbol as an argument of kprobe-event. But if the kprobe
event is defined on that module, we can defer to resolve the symbol
address.

Note that if given symbol is not found, the event is kept unavailable.
User can enable it but the event is not recorded.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   12 ++++++++
 kernel/trace/trace_probe.c  |   62 +++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace_probe.h  |    4 ++-
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fbf609cbeac2..920985fae8c0 100644
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
@@ -925,6 +931,7 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 {
 	unsigned long val;
 
+retry:
 	/* 1st stage: get value from context */
 	switch (code->op) {
 	case FETCH_OP_REG:
@@ -950,6 +957,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
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
index 613e7b823452..052adce1388e 100644
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


Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A277ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF79720870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF79720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeJ1QP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbeJ1QPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA56121479;
        Sun, 28 Oct 2018 07:31:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXr-00088K-MW; Sun, 28 Oct 2018 03:31:35 -0400
Message-Id: <20181028073135.599927177@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:30:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 14/18] tracing/kprobes: Check the probe on unloaded module correctly
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Current kprobe event doesn't checks correctly whether the
given event is on unloaded module or not. It just checks
the event has ":" in the name.

That is not enough because if we define a probe on non-exist
symbol on loaded module, it allows to define that (with
warning message)

To ensure it correctly, this searches the module name on
loaded module list and only if there is not, it allows to
define it. (this event will be available when the target
module is loaded)

Link: http://lkml.kernel.org/r/153547309528.26502.8300278470528281328.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3faaadbddf54..4727a13824f0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -62,9 +62,23 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
 }
 
-static nokprobe_inline bool trace_kprobe_is_on_module(struct trace_kprobe *tk)
+static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
-	return !!strchr(trace_kprobe_symbol(tk), ':');
+	char *p;
+	bool ret;
+
+	if (!tk->symbol)
+		return false;
+	p = strchr(tk->symbol, ':');
+	if (!p)
+		return true;
+	*p = '\0';
+	mutex_lock(&module_mutex);
+	ret = !!find_module(tk->symbol);
+	mutex_unlock(&module_mutex);
+	*p = ':';
+
+	return ret;
 }
 
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
@@ -374,19 +388,13 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		ret = register_kprobe(&tk->rp.kp);
 
-	if (ret == 0)
+	if (ret == 0) {
 		tk->tp.flags |= TP_FLAG_REGISTERED;
-	else {
-		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
-			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
-			ret = 0;
-		} else if (ret == -EILSEQ) {
-			pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
-				tk->rp.kp.addr);
-			ret = -EINVAL;
-		}
+	} else if (ret == -EILSEQ) {
+		pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
+			tk->rp.kp.addr);
+		ret = -EINVAL;
 	}
-
 	return ret;
 }
 
@@ -449,6 +457,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 
 	/* Register k*probe */
 	ret = __register_trace_kprobe(tk);
+	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
+		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
+		ret = 0;
+	}
+
 	if (ret < 0)
 		unregister_kprobe_event(tk);
 	else
-- 
2.19.0



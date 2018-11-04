Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D76ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149A2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc0vsn8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E149A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeKDXHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbeKDXHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E616204FD;
        Sun,  4 Nov 2018 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339525;
        bh=D7MEvnKmYygvDR6ngqCQunnaJSTv0vQPyO+z41kwuJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fc0vsn8N0v+K/v5EL64g7bY9WYuJaIE3tR7Gdb30pd2fiQVy8tF4aZZmiA81O7Fus
         1RADBaOUkzV3ZRR1BDp/A3Y4aTy6tV7SEKQxoqG9Tkqmecw0Mb51o9h+q1MJPpnUtR
         rc6cCK9LczlbDP/SNGEBNsuWene1k6pcdtgeg9xo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 19/57] tracing/kprobes: Check the probe on unloaded module correctly
Date:   Sun,  4 Nov 2018 08:51:06 -0500
Message-Id: <20181104135144.88324-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 59158ec4aef7d44be51a6f3e7e17fc64c32604eb ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c30032367aab..f9a0cd094b81 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -61,9 +61,23 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
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
@@ -554,19 +568,13 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
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
 
@@ -629,6 +637,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 
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
2.17.1


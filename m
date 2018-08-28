Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322E20898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adp2ybHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D322E20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeH1ULC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeH1ULC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:11:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410F920894;
        Tue, 28 Aug 2018 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535473118;
        bh=frzhmBhao4AsoWkDIulBoguRmteUfCuJ5I9qSw81r9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Adp2ybHqjwUwX47TB85uTJNms1OE7f8RWO/PJfu+7QYkz/NWxtW5wcNt/yWXxqsSh
         Pz09+HQzXeGTyNp/aqgOfHUcKZ1rbJY0YEbmSxe4kseP+rZhJ2cfA6n5cHh82ssS4g
         d/ms+j5pkTZkZqOaLfFXVmBUhlLvbwiHVw6ujWOo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [ftrace/kprobes PATCH 2/3] tracing/kprobes: Check the probe on unloaded module correctly
Date:   Wed, 29 Aug 2018 01:18:15 +0900
Message-Id: <153547309528.26502.8300278470528281328.stgit@devbox>
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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b006aaeceb92..fbf609cbeac2 100644
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


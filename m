Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954CDC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3nXayv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbeKTDDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbeKTDDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164CD208E4;
        Mon, 19 Nov 2018 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645577;
        bh=wpfjTEmnGavpfF5DPxclt65swzBle/Hxk8IPR/yGWDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3nXayv8WHKXXX01upU78uoBGImnVM78/EPGmF+LbYUp8/8686mveDdMDjHO6f/b7
         PDDL4ubC7iT9dumJSQ3JxVDyzW5+kR7LzEvM0c3z8DYNRcFNFZ2mJFmnlg8VBtQI0T
         P/Ubn54y5rt1pWPR+4nI/2PgxDpP5mKsb4gwa/FE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 010/171] tracing/kprobes: Check the probe on unloaded module correctly
Date:   Mon, 19 Nov 2018 17:26:46 +0100
Message-Id: <20181119162620.957441339@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_kprobe.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -71,9 +71,23 @@ static nokprobe_inline bool trace_kprobe
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
@@ -520,19 +534,13 @@ static int __register_trace_kprobe(struc
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
 
@@ -595,6 +603,11 @@ static int register_trace_kprobe(struct
 
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



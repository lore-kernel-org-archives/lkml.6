Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791302087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547786691;
	bh=mw3nME0qApRJLMHYDdox9GFSvvlegsr6Kb6TUq7uNjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVBI6aM3kTLbx+r8Dw7rfjGpim0jpCnkQcYEP2GnLS1H3XNSd9Nr687WkEQY+s+wC
	 PzKPwTO6XL2uT13MRG7UvqdjgU9ybbwCnKfXKTwnwIveed9gMD4PJF7YVUNJnOrcgQ
	 r6Vl20nZMT/9ulJuf/ngz0IS0dOmwBEsR51lAxFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfAREot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfAREot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:44:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B999D2086D;
        Fri, 18 Jan 2019 04:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547786688;
        bh=mw3nME0qApRJLMHYDdox9GFSvvlegsr6Kb6TUq7uNjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCDQLy6yHuEveEOaHoZgA3zqW+EN5xKJjqRy4XzLIrRw02qd2Z8PDqgtUxcCV+q0T
         +Nu7Ze08vz4gnrCiBYOMPtoIwZzhCw0IZG5jJ0TasXXZlfLE5EtfuKwZ2Tu0O4DmSK
         vWJGC2F0Qd6wJKKRlYJCR2uUedJvrMAiRtY1P86c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for uprobe events
Date:   Fri, 18 Jan 2019 13:44:25 +0900
Message-Id: <154778666570.19927.5960654930869453736.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154778663676.19927.12774448308165809570.stgit@devbox>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 533059281ee5 ("tracing: probeevent: Introduce new
argument fetching code") dropped the $comm support from uprobe
events, this re-enables it.

For $comm support, uses strlcpy() instead of strncpy_from_user()
to copy current task's comm. Because it is in the kernel space,
strncpy_from_user() always fails to copy the comm.
This also uses strlen() instead of strnlen_user() to measure the
length of the comm.

Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 kernel/trace/trace_uprobe.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3a1d5ab6b4ba..b07e498ccbc6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	if (unlikely(!maxlen))
 		return -ENOMEM;
 
-	ret = strncpy_from_user(dst, src, maxlen);
+	if (addr == (unsigned long)current->comm)
+		ret = strlcpy(dst, current->comm, maxlen);
+	else
+		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
 		if (ret == maxlen)
 			dst[ret - 1] = '\0';
@@ -180,7 +183,12 @@ fetch_store_strlen(unsigned long addr)
 	int len;
 	void __user *vaddr = (void __force __user *) addr;
 
-	len = strnlen_user(vaddr, MAX_STRING_SIZE);
+	if (addr == (unsigned long)current->comm) {
+		len = strlen(current->comm);
+		if (len)
+			len++;
+	} else
+		len = strnlen_user(vaddr, MAX_STRING_SIZE);
 
 	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
@@ -220,6 +228,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	case FETCH_OP_IMM:
 		val = code->immediate;
 		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
 	case FETCH_OP_FOFFS:
 		val = translate_user_vaddr(code->immediate);
 		break;


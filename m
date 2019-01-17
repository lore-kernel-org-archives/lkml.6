Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547732933;
	bh=P8abKQboCqQs/NKQc04HrKn1Ps5onlccIWvXB+RiKS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouu7rCPfxEbxdqrLooLoBoy+fbmjrHiW3VVK+laxogFeJdcVSK1AYC5O9i4cc+Dy4
	 hUgBl0cfcUTCC2KHC7e/hnsw5lA1WvjBllhpwSZ9rQQNr2t8lUgeyyy5z56TIBsQG1
	 1oPPo1S+OqWJw6EbYmTFj3Bg2Ie2l4KFDLYwiLxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfAQNsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQNsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:48:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7544C20851;
        Thu, 17 Jan 2019 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547732930;
        bh=P8abKQboCqQs/NKQc04HrKn1Ps5onlccIWvXB+RiKS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMwDx/moKFxls+H4PxETJdtJcDt6O+cmwY2ZBTofjrcxVLLewMeV1ckMBvV21RkJA
         xaF205M+oKks2QploR/y+67znVDqnlKHrEhx3ytoVIA73+XNU8FOA+1JFNqmo0f2Ij
         ORjvdXhVRL9xREtGOcuBf0tZUFe1qJKVxn5G59Ws=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: uprobes: Re-enable $comm support for uprobe events
Date:   Thu, 17 Jan 2019 22:48:27 +0900
Message-Id: <154773290754.2285.5010503242234518226.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154773287750.2285.5509629487576876823.stgit@devbox>
References: <154773287750.2285.5509629487576876823.stgit@devbox>
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


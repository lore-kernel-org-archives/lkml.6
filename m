Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7321CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8FC2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytHwPkWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8FC2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeLDK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeLDK7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17542087F;
        Tue,  4 Dec 2018 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921179;
        bh=rvDwJBwKE4jaHTdbpyWFnbkKBHR+ghP/r6U2bHMk2kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytHwPkWEjI90BRsTHvBzPrN2UYBaK+NvwxhCA+088cLKYtKmV3b4mKT6nKLJCPf44
         yyJ5mQCV1FeON3pO4uffgJ6xCsmH+avoCCITm0BKL/pT8c4s7y2f4+nQYJvSy72Zxz
         OS+QlFaH7Oy5BGsoBsu3kLp4RQ27PwWfMhVwfWuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        stable@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 110/139] MIPS: function_graph: Simplify with function_graph_enter()
Date:   Tue,  4 Dec 2018 11:49:51 +0100
Message-Id: <20181204103655.111327626@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 8712b27c5723c26400a2b350faf1d6d9fd7ffaad upstream.

The function_graph_enter() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have MIPS use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ftrace.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -322,7 +322,6 @@ void prepare_ftrace_return(unsigned long
 			   unsigned long fp)
 {
 	unsigned long old_parent_ra;
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
 	int faulted, insns;
@@ -369,12 +368,6 @@ void prepare_ftrace_return(unsigned long
 	if (unlikely(faulted))
 		goto out;
 
-	if (ftrace_push_return_trace(old_parent_ra, self_ra, &trace.depth, fp,
-				     NULL) == -EBUSY) {
-		*parent_ra_addr = old_parent_ra;
-		return;
-	}
-
 	/*
 	 * Get the recorded ip of the current mcount calling site in the
 	 * __mcount_loc section, which will be used to filter the function
@@ -382,13 +375,10 @@ void prepare_ftrace_return(unsigned long
 	 */
 
 	insns = core_kernel_text(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
-	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
+	self_ra -= (MCOUNT_INSN_SIZE * insns);
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
+	if (function_graph_enter(old_parent_ra, self_ra, fp, NULL))
 		*parent_ra_addr = old_parent_ra;
-	}
 	return;
 out:
 	ftrace_graph_stop();



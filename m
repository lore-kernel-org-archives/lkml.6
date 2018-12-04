Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81DF2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAmTktTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81DF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeLDK7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbeLDK7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE9A2087F;
        Tue,  4 Dec 2018 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921150;
        bh=H1TWguv+DMajJTFb9kOb9pphIz78VkeuJ0deYrJTy5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAmTktTzuWBnGf9aplv1yYKgJHiiMxJSzcZOqEqcaJDXJ1XcYDypiUNyUE874F1+j
         IcFxQx93k2wVCOTE7HyxmIVfDQkgpRn9g6RFBrY538kC3+ibUubsAyqc9E1SfXqBr7
         CL+9g7DkLjE32cZG9vLWdzE4cF+fiXhAUVvH7BuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        stable@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 100/139] microblaze: function_graph: Simplify with function_graph_enter()
Date:   Tue,  4 Dec 2018 11:49:41 +0100
Message-Id: <20181204103654.587164492@linuxfoundation.org>
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

commit 556763e5a500d71879d632867b75826551acd49c upstream.

The function_graph_enter() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have microblaze use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Michal Simek <monstr@monstr.eu>
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/microblaze/kernel/ftrace.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/arch/microblaze/kernel/ftrace.c
+++ b/arch/microblaze/kernel/ftrace.c
@@ -22,8 +22,7 @@
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	int faulted, err;
-	struct ftrace_graph_ent trace;
+	int faulted;
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
@@ -63,18 +62,8 @@ void prepare_ftrace_return(unsigned long
 		return;
 	}
 
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0, NULL);
-	if (err == -EBUSY) {
+	if (function_graph_enter(old, self_addr, 0, NULL))
 		*parent = old;
-		return;
-	}
-
-	trace.func = self_addr;
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
-		*parent = old;
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 



Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151892087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhe1/Yag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151892087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeLDLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeLDLA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0054F2087F;
        Tue,  4 Dec 2018 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921228;
        bh=SD8ewxyqnCW6QSTI3FRkwJKErbc1Px5MPs+uoV8V6hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhe1/YagMR8Z1M/laXvvlfh4pbpSgyA1AJ3XrF8I5jnVl8j4KaWGxky5Bg0xmm4qO
         TDsRAU82JTEzL6lSJ/rT7cMbpAhda+bTZ4cgiRAzGTyscgpxmP42qIDmbcOXF+nEIc
         dxM7BwfeHpEfwFcy3XRsEqBzaAzfU7YriaKm/2OQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 113/139] function_graph: Have profiler use curr_ret_stack and not depth
Date:   Tue,  4 Dec 2018 11:49:54 +0100
Message-Id: <20181204103655.266906477@linuxfoundation.org>
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

commit b1b35f2e218a5b57d03bbc3b0667d5064570dc60 upstream.

The profiler uses trace->depth to find its entry on the ret_stack, but the
depth may not match the actual location of where its entry is (if an
interrupt were to preempt the processing of the profiler for another
function, the depth and the curr_ret_stack will be different).

Have it use the curr_ret_stack as the index to find its ret_stack entry
instead of using the depth variable, as that is no longer guaranteed to be
the same.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -817,7 +817,7 @@ function_profile_call(unsigned long ip,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
-	int index = trace->depth;
+	int index = current->curr_ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -852,7 +852,7 @@ static void profile_graph_return(struct
 	if (!fgraph_graph_time) {
 		int index;
 
-		index = trace->depth;
+		index = current->curr_ret_stack;
 
 		/* Append this call time to the parent time to subtract */
 		if (index)



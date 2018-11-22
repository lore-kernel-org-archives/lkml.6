Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86675206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86675206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbeKVLLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390896AbeKVLKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:10:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1CC21582;
        Thu, 22 Nov 2018 00:33:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPcw2-0004Yd-3l; Wed, 21 Nov 2018 19:33:34 -0500
Message-Id: <20181122003334.014794329@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 19:28:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
Subject: [for-next][PATCH 18/18] function_graph: Have profiler use curr_ret_stack and not depth
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The profiler uses trace->depth to find its entry on the ret_stack, but the
depth may not match the actual location of where its entry is (if an
interrupt were to preempt the processing of the profiler for another
function, the depth and the curr_ret_stack will be different).

Have it use the curr_ret_stack as the index to find its ret_stack entry
instead of using the depth variable, as that is no longer guaranteed to be
the same.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 48513954713c..77734451cb05 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -817,7 +817,7 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
-	int index = trace->depth;
+	int index = current->curr_ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -852,7 +852,7 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	if (!fgraph_graph_time) {
 		int index;
 
-		index = trace->depth;
+		index = current->curr_ret_stack;
 
 		/* Append this call time to the parent time to subtract */
 		if (index)
-- 
2.19.1



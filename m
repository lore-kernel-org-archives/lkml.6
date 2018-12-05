Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86610C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2520645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeLEXsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbeLEXsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:31 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C44F223CA;
        Wed,  5 Dec 2018 23:48:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu5-0000A0-LP; Wed, 05 Dec 2018 18:48:29 -0500
Message-Id: <20181205234829.565579141@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [for-next][PATCH 08/30] function_graph: Do not expose the graph_time option when profiler is
 not configured
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When the function profiler is not configured, the "graph_time" option is
meaningless, as the function profiler is the only thing that makes use of
it. Do not expose it if the profiler is not configured.

Link: http://lkml.kernel.org/r/20181123061133.GA195223@google.com

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                 | 5 +++++
 kernel/trace/trace_functions_graph.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f67060a75f38..ab16eca76e59 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -862,7 +862,12 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
 extern void ftrace_graph_sleep_time_control(bool enable);
+
+#ifdef CONFIG_FUNCTION_PROFILER
 extern void ftrace_graph_graph_time_control(bool enable);
+#else
+static inline void ftrace_graph_graph_time_control(bool enable) { }
+#endif
 
 extern enum print_line_t
 print_graph_function_flags(struct trace_iterator *iter, u32 flags);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index eaf9b1629956..855c13c61e77 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -60,8 +60,12 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(funcgraph-tail, TRACE_GRAPH_PRINT_TAIL) },
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
+
+#ifdef CONFIG_FUNCTION_PROFILER
 	/* Include time within nested functions */
 	{ TRACER_OPT(graph-time, TRACE_GRAPH_GRAPH_TIME) },
+#endif
+
 	{ } /* Empty entry */
 };
 
-- 
2.19.1



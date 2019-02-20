Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5044AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E3E21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBTSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfBTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DEB21917;
        Wed, 20 Feb 2019 18:38:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWku-0006dg-Aq; Wed, 20 Feb 2019 13:38:04 -0500
Message-Id: <20190220183804.220178010@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 08/29] tracing: Show stacktrace for wakeup tracers
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

This align the behavior of wakeup tracers with irqsoff latency tracer
that we record stacktrace at the beginning and end of waking up. The
stacktrace shows us what is happening in the kernel.

Link: http://lkml.kernel.org/r/20190116160249.7554-1-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index da5b6e012840..f4fe7d1781e9 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -475,6 +475,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 
 	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
 	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
+	__trace_stack(wakeup_trace, flags, 0, pc);
 
 	T0 = data->preempt_timestamp;
 	T1 = ftrace_now(cpu);
@@ -586,6 +587,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
 	data->preempt_timestamp = ftrace_now(cpu);
 	tracing_sched_wakeup_trace(wakeup_trace, p, current, flags, pc);
+	__trace_stack(wakeup_trace, flags, 0, pc);
 
 	/*
 	 * We must be careful in using CALLER_ADDR2. But since wake_up
-- 
2.20.1



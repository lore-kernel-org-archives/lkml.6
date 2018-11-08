Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE0ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7899120818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur5xhDQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKIHg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbeKIHgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:24 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5002133D;
        Thu,  8 Nov 2018 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714336;
        bh=5LMhdRRLzeBnCtPhpVS6D4IrFPclTwkSS/sRQvz2qEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ur5xhDQpMTGPum7vSY9B/FQFfvRtgdclGV3svJLz9oRqi0ImLw5VJO27zy2119fsg
         uuYMKqlVWI80mswePMa6FKNi4ij973eTIijECvmw5XeiBAoW2AN5a7qjPxo2OOINx+
         QAxzHwiHCMAvI2/t8R7qDjja4j4uxxGH8nRiXlzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 023/114] tracing: Skip more functions when doing stack tracing of events
Date:   Thu,  8 Nov 2018 13:50:38 -0800
Message-Id: <20181108215101.247647473@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit be54f69c26193de31053190761e521903b89d098 ]

 # echo 1 > options/stacktrace
 # echo 1 > events/sched/sched_switch/enable
 # cat trace
          <idle>-0     [002] d..2  1982.525169: <stack trace>
 => save_stack_trace
 => __ftrace_trace_stack
 => trace_buffer_unlock_commit_regs
 => event_trigger_unlock_commit
 => trace_event_buffer_commit
 => trace_event_raw_event_sched_switch
 => __schedule
 => schedule
 => schedule_preempt_disabled
 => cpu_startup_entry
 => start_secondary

The above shows that we are seeing 6 functions before ever making it to the
caller of the sched_switch event.

 # echo stacktrace > events/sched/sched_switch/trigger
 # cat trace
          <idle>-0     [002] d..3  2146.335208: <stack trace>
 => trace_event_buffer_commit
 => trace_event_raw_event_sched_switch
 => __schedule
 => schedule
 => schedule_preempt_disabled
 => cpu_startup_entry
 => start_secondary

The stacktrace trigger isn't as bad, because it adds its own skip to the
stacktracing, but still has two events extra.

One issue is that if the stacktrace passes its own "regs" then there should
be no addition to the skip, as the regs will not include the functions being
called. This was an issue that was fixed by commit 7717c6be6999 ("tracing:
Fix stacktrace skip depth in trace_buffer_unlock_commit_regs()" as adding
the skip number for kprobes made the probes not have any stack at all.

But since this is only an issue when regs is being used, a skip should be
added if regs is NULL. Now we have:

 # echo 1 > options/stacktrace
 # echo 1 > events/sched/sched_switch/enable
 # cat trace
          <idle>-0     [000] d..2  1297.676333: <stack trace>
 => __schedule
 => schedule
 => schedule_preempt_disabled
 => cpu_startup_entry
 => rest_init
 => start_kernel
 => x86_64_start_reservations
 => x86_64_start_kernel

 # echo stacktrace > events/sched/sched_switch/trigger
 # cat trace
          <idle>-0     [002] d..3  1370.759745: <stack trace>
 => __schedule
 => schedule
 => schedule_preempt_disabled
 => cpu_startup_entry
 => start_secondary

And kprobes are not touched.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e409ddce8754..1a47a64d623f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1757,7 +1757,17 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 {
 	__buffer_unlock_commit(buffer, event);
 
-	ftrace_trace_stack(tr, buffer, flags, 0, pc, regs);
+	/*
+	 * If regs is not set, then skip the following callers:
+	 *   trace_buffer_unlock_commit_regs
+	 *   event_trigger_unlock_commit
+	 *   trace_event_buffer_commit
+	 *   trace_event_raw_event_sched_switch
+	 * Note, we can still get here via blktrace, wakeup tracer
+	 * and mmiotrace, but that's ok if they lose a function or
+	 * two. They are that meaningful.
+	 */
+	ftrace_trace_stack(tr, buffer, flags, regs ? 0 : 4, pc, regs);
 	ftrace_trace_userstack(buffer, flags, pc);
 }
 EXPORT_SYMBOL_GPL(trace_buffer_unlock_commit_regs);
@@ -1815,6 +1825,13 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	trace.nr_entries	= 0;
 	trace.skip		= skip;
 
+	/*
+	 * Add two, for this function and the call to save_stack_trace()
+	 * If regs is set, then these functions will not be in the way.
+	 */
+	if (!regs)
+		trace.skip += 2;
+
 	/*
 	 * Since events can happen in NMIs there's no safe way to
 	 * use the per cpu ftrace_stacks. We reserve it and if an interrupt
-- 
2.17.1




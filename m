Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB42075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbeIFUa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbeIFUa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:30:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75F920857;
        Thu,  6 Sep 2018 15:54:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxwbr-0000In-0x; Thu, 06 Sep 2018 11:54:19 -0400
Message-Id: <20180906155418.924762390@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 06 Sep 2018 11:52:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86-ml <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 1/2] tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
 tracepoints
References: <20180906155217.201016180@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Borislav reported the following splat:

 =============================
 WARNING: suspicious RCU usage
 4.19.0-rc1+ #1 Not tainted
 -----------------------------
 ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
 other info that might help us debug this:

 RCU used illegally from idle CPU!
 rcu_scheduler_active = 2, debug_locks = 1
 RCU used illegally from extended quiescent state!
 1 lock held by swapper/0/0:
  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130

 stack backtrace:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
 Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
 Call Trace:
  dump_stack+0x85/0xcb
  perf_event_output_forward+0xf6/0x130
  __perf_event_overflow+0x52/0xe0
  perf_swevent_overflow+0x91/0xb0
  perf_tp_event+0x11a/0x350
  ? find_held_lock+0x2d/0x90
  ? __lock_acquire+0x2ce/0x1350
  ? __lock_acquire+0x2ce/0x1350
  ? retint_kernel+0x2d/0x2d
  ? find_held_lock+0x2d/0x90
  ? tick_nohz_get_sleep_length+0x83/0xb0
  ? perf_trace_cpu+0xbb/0xd0
  ? perf_trace_buf_alloc+0x5a/0xa0
  perf_trace_cpu+0xbb/0xd0
  cpuidle_enter_state+0x185/0x340
  do_idle+0x1eb/0x260
  cpu_startup_entry+0x5f/0x70
  start_kernel+0x49b/0x4a6
  secondary_startup_64+0xa4/0xb0

This is due to the tracepoints moving to SRCU usage which does not require
RCU to be "watching". But perf uses these tracepoints with RCU and expects
it to be. Hence, we still need to add in the rcu_irq_enter/exit_irqson()
calls for "rcuidle" tracepoints. This is a temporary fix until we have SRCU
working in NMI context, and then perf can be converted to use that instead
of normal RCU.

Link: http://lkml.kernel.org/r/20180904162611.6a120068@gandalf.local.home

Cc: x86-ml <x86@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 7f2e16e76ac4..041f7e56a289 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -158,8 +158,10 @@ extern void syscall_unregfunc(void);
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle)						\
+		if (rcuidle) {						\
 			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+			rcu_irq_enter_irqson();				\
+		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -171,8 +173,10 @@ extern void syscall_unregfunc(void);
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle)						\
+		if (rcuidle) {						\
+			rcu_irq_exit_irqson();				\
 			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
-- 
2.18.0



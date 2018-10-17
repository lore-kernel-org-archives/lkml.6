Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C84ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E113C20644
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E113C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeJRDrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeJRDrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:47:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BEA32148E;
        Wed, 17 Oct 2018 19:50:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gCrpX-0007Q4-4g; Wed, 17 Oct 2018 15:50:07 -0400
Message-Id: <20181017195007.043977240@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 17 Oct 2018 15:49:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/2] tracing: Use trace_clock_local() for looping in
 preemptirq_delay_test.c
References: <20181017194939.044060850@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The preemptirq_delay_test module is used for the ftrace selftest code that
tests the latency tracers. The problem is that it uses ktime for the delay
loop, and then checks the tracer to see if the delay loop is caught, but the
tracer uses trace_clock_local() which uses various different other clocks to
measure the latency. As ktime uses the clock cycles, and the code then
converts that to nanoseconds, it causes rounding errors, and the preemptirq
latency tests are failing due to being off by 1 (it expects to see a delay
of 500000 us, but the delay is only 499999 us). This is happening due to a
rounding error in the ktime (which is totally legit). The purpose of the
test is to see if it can catch the delay, not to test the accuracy between
trace_clock_local() and ktime_get(). Best to use apples to apples, and have
the delay loop use the same clock as the latency tracer does.

Cc: stable@vger.kernel.org
Fixes: f96e8577da102 ("lib: Add module for testing preemptoff/irqsoff latency tracers")
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/preemptirq_delay_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index f704390db9fc..d8765c952fab 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -5,12 +5,12 @@
  * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
  */
 
+#include <linux/trace_clock.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/string.h>
@@ -25,13 +25,13 @@ MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default ir
 
 static void busy_wait(ulong time)
 {
-	ktime_t start, end;
-	start = ktime_get();
+	u64 start, end;
+	start = trace_clock_local();
 	do {
-		end = ktime_get();
+		end = trace_clock_local();
 		if (kthread_should_stop())
 			break;
-	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
+	} while ((end - start) < (time * 1000));
 }
 
 static int preemptirq_delay_run(void *data)
-- 
2.19.0



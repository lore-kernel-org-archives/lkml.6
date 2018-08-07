Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E33C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B882151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B882151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbeHGVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404231AbeHGVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:03 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A63F6D07;
        Tue,  7 Aug 2018 18:54:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 07/21] nohz: Fix missing tick reprogram when interrupting an inline softirq
Date:   Tue,  7 Aug 2018 20:51:21 +0200
Message-Id: <20180807172331.279605578@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit 0a0e0829f990120cef165bbb804237f400953ec2 upstream.

The full nohz tick is reprogrammed in irq_exit() only if the exit is not in
a nesting interrupt. This stands as an optimization: whether a hardirq or a
softirq is interrupted, the tick is going to be reprogrammed when necessary
at the end of the inner interrupt, with even potential new updates on the
timer queue.

When soft interrupts are interrupted, it's assumed that they are executing
on the tail of an interrupt return. In that case tick_nohz_irq_exit() is
called after softirq processing to take care of the tick reprogramming.

But the assumption is wrong: softirqs can be processed inline as well, ie:
outside of an interrupt, like in a call to local_bh_enable() or from
ksoftirqd.

Inline softirqs don't reprogram the tick once they are done, as opposed to
interrupt tail softirq processing. So if a tick interrupts an inline
softirq processing, the next timer will neither be reprogrammed from the
interrupting tick's irq_exit() nor after the interrupted softirq
processing. This situation may leave the tick unprogrammed while timers are
armed.

To fix this, simply keep reprogramming the tick even if a softirq has been
interrupted. That can be optimized further, but for now correctness is more
important.

Note that new timers enqueued in nohz_full mode after a softirq gets
interrupted will still be handled just fine through self-IPIs triggered by
the timer code.

Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: stable@vger.kernel.org # 4.14+
Link: https://lkml.kernel.org/r/1533303094-15855-1-git-send-email-frederic@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -382,7 +382,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_interrupt())
+		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
 #endif



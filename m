Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9421763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZiGxlvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF9421763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeHCP2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbeHCP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:28:03 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED642175D;
        Fri,  3 Aug 2018 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533303101;
        bh=fCL5j3+tw3RUYD3W/HoTXh8+6LLKrjvvt0XHt7qaLgI=;
        h=From:To:Cc:Subject:Date:From;
        b=SZiGxlvT15dHhl/UAvrgYF6L4nboZia6HvZ8o7x10gxi5h8MHsUWSKew6iCDAfYO0
         KGiVDUzZB9BWLntdCMQ5EpVJGrRgFBtKvDBlxUFfK/AvmFP9JVxRRxESTeBSf8qUra
         rH2GOt6oIBbtYdYHvG/ey3nLO5StIC3HGpOjt5l0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2] nohz: Fix missing tick reprog while interrupting inline timer softirq
Date:   Fri,  3 Aug 2018 15:31:34 +0200
Message-Id: <1533303094-15855-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full nohz tick is reprogrammed on IRQ exit only if we are not in
a nesting interrupt. This stands as an optimization: whether we are
interrupting a hardirq or a softirq, the tick is going to be
reprogrammed eventually in the end of the inner IRQ, with even potential
new updates on the timer queue.

Now when we are interrupting softirqs, we always assume that they are
executing on IRQ-tail. Indeed in that case tick_nohz_irq_exit() is
called after softirq processing to take care of the tick reprogramming.
But the assumption is wrong: softirqs can be processed inline as well,
ie: outside of an IRQ, like in a call to local_bh_enable() or from
ksoftirqd.

Inline softirqs don't reprogram the tick once they are done, as opposed
to IRQ-tail softirq processing. So if a tick interrupts an inline
softirq processing, the next timer will neither be reprogrammed from
the interrupting tick's irq_exit() nor after the interrupted softirq
processing. This situation may leave us later in userspace with the tick
unprogrammed while we can have timers in the queue.

To fix this, simply keep reprogramming the tick if we are in a hardirq
interrupting softirq. We can still figure out a way later to restore
this optimization while excluding inline softirq processing.

Note that new timers enqueued in nohz_full mode after a softirq gets
interrupted will still be handled just fine through self-IPIs triggered
by the timer code.

Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 900dcfe..0980a81 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -386,7 +386,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_interrupt())
+		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
 #endif
-- 
2.7.4


Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F127DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918C220894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMTnbAey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918C220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbeHAAfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbeHAAfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:35:32 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BCC2083F;
        Tue, 31 Jul 2018 22:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533077578;
        bh=ZHeUqo/pMRqtkBIfDJ6t955UFCTuaX94qZUvrx2j0x8=;
        h=From:To:Cc:Subject:Date:From;
        b=DMTnbAeyCrbnu9urwrl91xNw3X2OGW7ap3uscOumq1HpNX86aLYmaCSjVYoFU3H/k
         TUcb4rNfgwxdXMub1oeYgqLn9qAz5XcLLrlDfqMMsjgeqCTERB0njCzMuenMvO/7k1
         AebREKisqar2d5mkoeYAwRycH5VJwpFRTcuv8df8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] nohz: Fix missing tick reprog while interrupting inline timer softirq
Date:   Wed,  1 Aug 2018 00:52:50 +0200
Message-Id: <1533077570-9169-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before updating the full nohz tick or the idle time on IRQ exit, we
check first if we are not in a nesting interrupt, whether the inner
interrupt is a hard or a soft IRQ.

There is a historical reason for that: the dyntick idle mode used to
reprogram the tick on IRQ exit, after softirq processing, and there was
no point in doing that job in the outer nesting interrupt because the
tick update will be performed through the end of the inner interrupt
eventually, with even potential new timer updates.

One corner case could show up though: if an idle tick interrupts a softirq
executing inline in the idle loop (through a call to local_bh_enable())
after we entered in dynticks mode, the IRQ won't reprogram the tick
because it assumes the softirq executes on an inner IRQ-tail. As a
result we might put the CPU in sleep mode with the tick completely
stopped whereas a timer can still be enqueued. Indeed there is no tick
reprogramming in local_bh_enable(). We probably asssumed there was no bh
disabled section in idle, although there didn't seem to be debug code
ensuring that.

Nowadays the nesting interrupt optimization still stands but only concern
full dynticks. The tick is stopped on IRQ exit in full dynticks mode
and we want to wait for the end of the inner IRQ to reprogramm the tick.
But in_interrupt() doesn't make a difference between softirqs executing
on IRQ tail and those executing inline. What was to be considered a
corner case in dynticks-idle mode now becomes a serious opportunity for
a bug in full dynticks mode: if a tick interrupts a task executing
softirq inline, the tick reprogramming will be ignored and we may exit
to userspace after local_bh_enable() with an enqueued timer that will
never fire.

To fix this, simply keep reprogramming the tick if we are in a hardirq
interrupting softirq. We can still figure out a way later to restore
this optimization while excluding inline softirq processing.

Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
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


Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDCD21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDCD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJRVX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:23:58 -0400
Received: from mailout2.hostsharing.net ([83.223.90.233]:49321 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJRVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:23:58 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 17:23:56 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id F07DF10189CB7;
        Thu, 18 Oct 2018 15:15:37 +0200 (CEST)
Received: from localhost (p57BD76CD.dip0.t-ipconnect.de [87.189.118.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9445A6106F5B;
        Thu, 18 Oct 2018 15:15:37 +0200 (CEST)
X-Mailbox-Line: From 1dfd8bbd16163940648045495e3e9698e63b50ad Mon Sep 17 00:00:00 2001
Message-Id: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 18 Oct 2018 15:15:05 +0200
Subject: [PATCH] genirq: Fix race on spurious interrupt detection
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of
threaded irqs") made detection of spurious interrupts work for threaded
handlers by:

a) incrementing a counter every time the thread returns IRQ_HANDLED, and
b) checking whether that counter has increased every time the thread is
   woken.

However for oneshot interrupts, the commit unmasks the interrupt before
incrementing the counter.  If another interrupt occurs right after
unmasking but before the counter is incremented, that interrupt is
incorrectly considered spurious:

time
 |  irq_thread()
 |    irq_thread_fn()
 |      action->thread_fn()
 |      irq_finalize_oneshot()
 |        unmask_threaded_irq()            /* interrupt is unmasked */
 |
 |                  /* interrupt fires, incorrectly deemed spurious */
 |
 |    atomic_inc(&desc->threads_handled); /* counter is incremented */
 v

I am seeing this with a hi3110 CAN controller receiving data at high
volume (from a separate machine sending with "cangen -g 0 -i -x"):
The controller signals a huge number of interrupts (hundreds of millions
per day) and every second there are about a dozen which are deemed
spurious.  The issue is benign in this case, mostly just an irritation,
but I'm worrying that at high CPU load and in the presence of higher
priority tasks, the number of incorrectly detected spurious interrupts
might increase beyond the 99,900 threshold and cause disablement of the
IRQ.

Fix by moving the incrementation of the counter from irq_thread() to
irq_thread_fn() and irq_forced_thread_fn(), before the invocation of
irq_finalize_oneshot().

Fixes: 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of threaded irqs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.16+
---
 kernel/irq/manage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fb86146037a7..9dbdccab3b6a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -927,6 +927,9 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 
 	local_bh_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
@@ -943,6 +946,9 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	irqreturn_t ret;
 
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	return ret;
 }
@@ -1020,8 +1026,6 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
 
 		action_ret = handler_fn(desc, action);
-		if (action_ret == IRQ_HANDLED)
-			atomic_inc(&desc->threads_handled);
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
-- 
2.19.1


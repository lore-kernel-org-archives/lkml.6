Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D942084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfBCOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:23:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730552AbfBCOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:33 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeK-0006S7-5S; Sun, 03 Feb 2019 14:21:32 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006yT-Hv; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lukas Wunner" <lukas@wunner.de>,
        "Mathias Duckeck" <m.duckeck@kunbus.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Casey Fitzpatrick" <casey.fitzpatrick@timesys.com>,
        "Akshay Bhat" <akshay.bhat@timesys.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.947971597@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 105/305] genirq: Fix race on spurious interrupt detection
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 746a923b863a1065ef77324e1e43f19b1a3eab5c upstream.

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

This is observed with a hi3110 CAN controller receiving data at high volume
(from a separate machine sending with "cangen -g 0 -i -x"): The controller
signals a huge number of interrupts (hundreds of millions per day) and
every second there are about a dozen which are deemed spurious.

In theory with high CPU load and the presence of higher priority tasks, the
number of incorrectly detected spurious interrupts might increase beyond
the 99,900 threshold and cause disablement of the interrupt.

In practice it just increments the spurious interrupt count. But that can
cause people to waste time investigating it over and over.

Fix it by moving the accounting before the invocation of
irq_finalize_oneshot().

[ tglx: Folded change log update ]

Fixes: 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of threaded irqs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Link: https://lkml.kernel.org/r/1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/irq/manage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -805,6 +805,9 @@ irq_forced_thread_fn(struct irq_desc *de
 
 	local_bh_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
@@ -821,6 +824,9 @@ static irqreturn_t irq_thread_fn(struct
 	irqreturn_t ret;
 
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	return ret;
 }
@@ -886,8 +892,6 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
 
 		action_ret = handler_fn(desc, action);
-		if (action_ret == IRQ_HANDLED)
-			atomic_inc(&desc->threads_handled);
 
 		wake_threads_waitq(desc);
 	}


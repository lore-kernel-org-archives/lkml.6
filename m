Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6619822353
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIS9AiVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6619822353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404993AbeKTDYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405346AbeKTDYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C973223CA;
        Mon, 19 Nov 2018 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646823;
        bh=bN2onHJMQco2aXdrf1fFnVmIkYyoWOJiH6Q4yfrg44w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIS9AiVUCCNnPrXUPCJFHeo7M/BEcNR1pbJ0lUT6PCvOkqL8wgi3vnbs3pMJfC9C9
         NysmFLopZxNWorQYJRHY2ON6RoF+eJNUDPTaN8BHXt/e8BT6RZxkI6LZEguiduvjmH
         QuNHJXX9cvoauEwFWdZBKchQYKOCXrtPzEJSlFX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Subject: [PATCH 4.4 067/160] genirq: Fix race on spurious interrupt detection
Date:   Mon, 19 Nov 2018 17:28:26 +0100
Message-Id: <20181119162637.842707470@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
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
Cc: stable@vger.kernel.org # v3.16+
Link: https://lkml.kernel.org/r/1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -864,6 +864,9 @@ irq_forced_thread_fn(struct irq_desc *de
 
 	local_bh_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
@@ -880,6 +883,9 @@ static irqreturn_t irq_thread_fn(struct
 	irqreturn_t ret;
 
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	return ret;
 }
@@ -957,8 +963,6 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
 
 		action_ret = handler_fn(desc, action);
-		if (action_ret == IRQ_HANDLED)
-			atomic_inc(&desc->threads_handled);
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 



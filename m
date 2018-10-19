Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C9ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA92083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DA92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJSXkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:40:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSXkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:40:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9JFXo0C1288783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 08:33:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9JFXoI51288780;
        Fri, 19 Oct 2018 08:33:50 -0700
Date:   Fri, 19 Oct 2018 08:33:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lukas Wunner <tipbot@zytor.com>
Message-ID: <tip-746a923b863a1065ef77324e1e43f19b1a3eab5c@git.kernel.org>
Cc:     mingo@kernel.org, casey.fitzpatrick@timesys.com, lukas@wunner.de,
        akshay.bhat@timesys.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, m.duckeck@kunbus.de,
        tglx@linutronix.de
Reply-To: casey.fitzpatrick@timesys.com, lukas@wunner.de, mingo@kernel.org,
          tglx@linutronix.de, m.duckeck@kunbus.de, hpa@zytor.com,
          akshay.bhat@timesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Fix race on spurious interrupt detection
Git-Commit-ID: 746a923b863a1065ef77324e1e43f19b1a3eab5c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  746a923b863a1065ef77324e1e43f19b1a3eab5c
Gitweb:     https://git.kernel.org/tip/746a923b863a1065ef77324e1e43f19b1a3eab5c
Author:     Lukas Wunner <lukas@wunner.de>
AuthorDate: Thu, 18 Oct 2018 15:15:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Oct 2018 17:31:00 +0200

genirq: Fix race on spurious interrupt detection

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
 

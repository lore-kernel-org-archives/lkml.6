Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF46AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF12D2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF12D2172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbeHGVJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404151AbeHGVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:32 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01785D01;
        Tue,  7 Aug 2018 18:53:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 05/21] genirq: Make force irq threading setup more robust
Date:   Tue,  7 Aug 2018 20:51:19 +0200
Message-Id: <20180807172331.188506120@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit d1f0301b3333eef5efbfa1fe0f0edbea01863d5d upstream.

The support of force threading interrupts which are set up with both a
primary and a threaded handler wreckaged the setup of regular requested
threaded interrupts (primary handler == NULL).

The reason is that it does not check whether the primary handler is set to
the default handler which wakes the handler thread. Instead it replaces the
thread handler with the primary handler as it would do with force threaded
interrupts which have been requested via request_irq(). So both the primary
and the thread handler become the same which then triggers the warnon that
the thread handler tries to wakeup a not configured secondary thread.

Fortunately this only happens when the driver omits the IRQF_ONESHOT flag
when requesting the threaded interrupt, which is normaly caught by the
sanity checks when force irq threading is disabled.

Fix it by skipping the force threading setup when a regular threaded
interrupt is requested. As a consequence the interrupt request which lacks
the IRQ_ONESHOT flag is rejected correctly instead of silently wreckaging
it.

Fixes: 2a1d3ab8986d ("genirq: Handle force threading of irqs with primary and thread handler")
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1030,6 +1030,13 @@ static int irq_setup_forced_threading(st
 	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
 		return 0;
 
+	/*
+	 * No further action required for interrupts which are requested as
+	 * threaded interrupts already
+	 */
+	if (new->handler == irq_default_primary_handler)
+		return 0;
+
 	new->flags |= IRQF_ONESHOT;
 
 	/*
@@ -1037,7 +1044,7 @@ static int irq_setup_forced_threading(st
 	 * thread handler. We force thread them as well by creating a
 	 * secondary action.
 	 */
-	if (new->handler != irq_default_primary_handler && new->thread_fn) {
+	if (new->handler && new->thread_fn) {
 		/* Allocate the secondary action */
 		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
 		if (!new->secondary)



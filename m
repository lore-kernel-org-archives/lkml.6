Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE9C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D87821782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D87821782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeHENZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:25:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHENZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:25:45 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fmH6H-00012d-6g; Sun, 05 Aug 2018 13:21:29 +0200
Date:   Sun, 5 Aug 2018 13:21:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq fixes for 4.18
Message-ID: <alpine.DEB.2.21.1808051319320.17359@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A single bugfix for the irq core to prevent silent data corruption and
malfunction of threaded interrupts under certain conditions.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      genirq: Make force irq threading setup more robust


 kernel/irq/manage.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index daeabd791d58..9a8b7ba9aa88 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1068,6 +1068,13 @@ static int irq_setup_forced_threading(struct irqaction *new)
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
@@ -1075,7 +1082,7 @@ static int irq_setup_forced_threading(struct irqaction *new)
 	 * thread handler. We force thread them as well by creating a
 	 * secondary action.
 	 */
-	if (new->handler != irq_default_primary_handler && new->thread_fn) {
+	if (new->handler && new->thread_fn) {
 		/* Allocate the secondary action */
 		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
 		if (!new->secondary)

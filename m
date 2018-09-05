Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8D8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070520861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A070520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIEQ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIEQ6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8348620878;
        Wed,  5 Sep 2018 12:28:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxWvE-0002CP-Iq; Wed, 05 Sep 2018 08:28:36 -0400
Message-Id: <20180905122836.475141226@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Sep 2018 08:28:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 13/22] x86/ioapic: Dont let setaffinity unmask threaded EOI interrupt too
 early
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit ac14002317721910204b82b9d8611dadb1cec2bb ]

There is an issue with threaded interrupts which are marked ONESHOT
and using the fasteoi handler.

    if (IS_ONESHOT())
        mask_irq();

    ....
    ....

    cond_unmask_eoi_irq()
        chip->irq_eoi();

So if setaffinity is pending then the interrupt will be moved and then
unmasked, which is wrong as it should be kept masked up to the point where
the threaded handler finished. It's not a real problem, the interrupt will
just be able to fire before the threaded handler has finished, though the irq
masked state will be wrong for a bit.

The patch below should cure the issue. It also renames the horribly
misnomed functions so it becomes clear what they are supposed to do.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: add the body of the patch, use the same functions in both
          ifdef paths (spotted by Andy Shevchenko)]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5832a9d657f2..c9af5afebc4a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1688,20 +1688,20 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
-	if (unlikely(irqd_is_setaffinity_pending(data) &&
-		     !irqd_irq_inprogress(data))) {
-		mask_ioapic_irq(data);
+	if (unlikely(irqd_is_setaffinity_pending(data))) {
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
 }
 
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
-	if (unlikely(masked)) {
+	if (unlikely(moveit)) {
 		/* Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
@@ -1730,15 +1730,17 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the irq is masked in the core, leave it */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 }
 #endif
@@ -1747,11 +1749,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 {
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	unsigned long v;
-	bool masked;
+	bool moveit;
 	int i;
 
 	irq_complete_move(cfg);
-	masked = ioapic_irqd_mask(irq_data);
+	moveit = ioapic_prepare_move(irq_data);
 
 	/*
 	 * It appears there is an erratum which affects at least version 0x11
@@ -1806,7 +1808,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)
-- 
2.18.0



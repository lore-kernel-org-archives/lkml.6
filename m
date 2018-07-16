Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F013ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B467208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B467208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPRJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:09:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52302 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:09:47 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ff6Z1-0000TM-M7; Mon, 16 Jul 2018 18:41:31 +0200
Date:   Mon, 16 Jul 2018 18:41:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/ioapic: Do not unmask io_apic when interrupt is in
 progress
In-Reply-To: <20180302130436.uxv7hjruung6m5x7@linutronix.de>
Message-ID: <alpine.DEB.2.21.1807161829090.1693@nanos.tec.linutronix.de>
References: <20180302130436.uxv7hjruung6m5x7@linutronix.de>
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

On Fri, 2 Mar 2018, Sebastian Andrzej Siewior wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Fri, 3 Jul 2009 08:29:27 -0500
> 
> With threaded interrupts we might see an interrupt in progress on
> migration. Do not unmask it when this is the case.

It took me quite a while to wrap my head around this one.

> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1690,7 +1690,8 @@ static bool io_apic_level_ack_pending(st
>  static inline bool ioapic_irqd_mask(struct irq_data *data)
>  {
>  	/* If we are moving the irq we need to mask it */
> -	if (unlikely(irqd_is_setaffinity_pending(data))) {
> +	if (unlikely(irqd_is_setaffinity_pending(data) &&
> +		     !irqd_irq_inprogress(data))) {

I really don't see how that is preventing anything. The point is that
chip->eoi_irq() is always called _after_ the INPROGRESS flag has been
cleared. And if that's not the case then the interrupt would be never
moved.

But, that patch is almost 10 years old and I didn't find the exact
context. So it might have been valid back then, but I doubt it.

Though there is an issue with threaded interrupts which are marked ONESHOT
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

Thanks,

	tglx

8<-------------------
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 3982f79d2377..23667451e44e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1721,19 +1721,20 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
-		mask_ioapic_irq(data);
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
@@ -1762,15 +1763,17 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
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
+static inline bool ioapic_move_prepare(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_move_irq(struct irq_data *data, bool masked)
 {
 }
 #endif
@@ -1779,11 +1782,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
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
@@ -1838,7 +1841,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)


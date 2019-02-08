Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB018C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0821927
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfBHNyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:54:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:54:00 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gs6bK-000293-AE; Fri, 08 Feb 2019 14:53:54 +0100
Message-Id: <20190208135020.925487496@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 08 Feb 2019 14:48:03 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch V2 1/2] genriq: Avoid summation loops for /proc/stat
References: <20190208134802.218483159@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman reported that on large systems with a large amount of interrupts the
readout of /proc/stat takes a long time to sum up the interrupt
statistics. In principle this is not a problem. but for unknown reasons
some enterprise quality software reads /proc/stat with a high frequency.

The reason for this is that interrupt statistics are accounted per cpu. So
the /proc/stat logic has to sum up the interrupt stats for each interrupt.

This can be largely avoided for interrupts which are not marked as
'PER_CPU' interrupts by simply adding a per interrupt summation counter
which is incremented along with the per interrupt per cpu counter.

The PER_CPU interrupts need to avoid that and use only per cpu accounting
because they share the interrupt number and the interrupt descriptor and
concurrent updates would conflict or require unwanted synchronization.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

8<-------------

v2: Undo the unintentional layout change of struct irq_desc.

 include/linux/irqdesc.h |    1 +
 kernel/irq/chip.c       |   12 ++++++++++--
 kernel/irq/internals.h  |    8 +++++++-
 kernel/irq/irqdesc.c    |    7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)


--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -65,6 +65,7 @@ struct irq_desc {
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
 	unsigned int		wake_depth;	/* nested wake enables */
+	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -855,7 +855,11 @@ void handle_percpu_irq(struct irq_desc *
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -884,7 +888,11 @@ void handle_percpu_devid_irq(struct irq_
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -242,12 +242,18 @@ static inline void irq_state_set_masked(
 
 #undef __irqd_to_state
 
-static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
 	__this_cpu_inc(*desc->kstat_irqs);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
+static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+{
+	__kstat_incr_irqs_this_cpu(desc);
+	desc->tot_count++;
+}
+
 static inline int irq_desc_get_node(struct irq_desc *desc)
 {
 	return irq_common_data_get_node(&desc->irq_common_data);
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -119,6 +119,7 @@ static void desc_set_defaults(unsigned i
 	desc->depth = 1;
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
+	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
@@ -919,11 +920,15 @@ unsigned int kstat_irqs_cpu(unsigned int
 unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	int cpu;
 	unsigned int sum = 0;
+	int cpu;
 
 	if (!desc || !desc->kstat_irqs)
 		return 0;
+	if (!irq_settings_is_per_cpu_devid(desc) &&
+	    !irq_settings_is_per_cpu(desc))
+	    return desc->tot_count;
+
 	for_each_possible_cpu(cpu)
 		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
 	return sum;



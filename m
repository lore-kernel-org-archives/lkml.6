Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECBC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9CB2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBJUzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:55:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfBJUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:55:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1AKt4SA3235652
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 12:55:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1AKt1MU3235592;
        Sun, 10 Feb 2019 12:55:01 -0800
Date:   Sun, 10 Feb 2019 12:55:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1136b0728969901a091f0471968b2b76ed14d9ad@git.kernel.org>
Cc:     marc.zyngier@arm.com, akpm@linux-foundation.org, mingo@kernel.org,
        dbueso@suse.de, david@fromorbit.com, willy@infradead.org,
        miklos@szeredi.hu, rdunlap@infradead.org, tglx@linutronix.de,
        dave@stgolabs.net, adobriyan@gmail.com, dancol@google.com,
        keescook@chromium.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, akpm@linux-foundation.org,
          marc.zyngier@arm.com, dbueso@suse.de, david@fromorbit.com,
          willy@infradead.org, miklos@szeredi.hu, rdunlap@infradead.org,
          tglx@linutronix.de, adobriyan@gmail.com, dave@stgolabs.net,
          linux-kernel@vger.kernel.org, dancol@google.com,
          keescook@chromium.org, longman@redhat.com, hpa@zytor.com
In-Reply-To: <20190208135020.925487496@linutronix.de>
References: <20190208135020.925487496@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Avoid summation loops for /proc/stat
Git-Commit-ID: 1136b0728969901a091f0471968b2b76ed14d9ad
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

Commit-ID:  1136b0728969901a091f0471968b2b76ed14d9ad
Gitweb:     https://git.kernel.org/tip/1136b0728969901a091f0471968b2b76ed14d9ad
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 8 Feb 2019 14:48:03 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 21:34:45 +0100

genirq: Avoid summation loops for /proc/stat

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
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Colascione <dancol@google.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/20190208135020.925487496@linutronix.de


8<-------------

v2: Undo the unintentional layout change of struct irq_desc.

 include/linux/irqdesc.h |    1 +
 kernel/irq/chip.c       |   12 ++++++++++--
 kernel/irq/internals.h  |    8 +++++++-
 kernel/irq/irqdesc.c    |    7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)


---
 include/linux/irqdesc.h |  1 +
 kernel/irq/chip.c       | 12 ++++++++++--
 kernel/irq/internals.h  |  8 +++++++-
 kernel/irq/irqdesc.c    |  7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40ddac7d..875c41b23f20 100644
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
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 34e969069488..e960c4f46ee0 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -855,7 +855,11 @@ void handle_percpu_irq(struct irq_desc *desc)
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
@@ -884,7 +888,11 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
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
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa267070..e74e7eea76cf 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -242,12 +242,18 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
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
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ee062b7939d3..f98293d0e173 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -119,6 +119,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->depth = 1;
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
+	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
@@ -919,11 +920,15 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
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

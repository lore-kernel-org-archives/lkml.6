Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8859C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F50420663
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfAKVC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:02:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfAKVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:02:56 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi3x3-0004k3-Ck; Fri, 11 Jan 2019 22:02:49 +0100
Date:   Fri, 11 Jan 2019 22:02:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
In-Reply-To: <20190111192357.GK6310@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1901112146180.1661@nanos.tec.linutronix.de>
References: <1547061648-16080-1-git-send-email-longman@redhat.com> <1547061648-16080-5-git-send-email-longman@redhat.com> <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
 <20190111192357.GK6310@bombadil.infradead.org>
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

On Fri, 11 Jan 2019, Matthew Wilcox wrote:
> On Fri, Jan 11, 2019 at 08:19:33PM +0100, Thomas Gleixner wrote:
> > On Fri, 11 Jan 2019, Thomas Gleixner wrote:
> > > --- a/kernel/irq/internals.h
> > > +++ b/kernel/irq/internals.h
> > > @@ -246,6 +246,7 @@ static inline void kstat_incr_irqs_this_
> > >  {
> > >  	__this_cpu_inc(*desc->kstat_irqs);
> > >  	__this_cpu_inc(kstat.irqs_sum);
> > > +	desc->tot_count++;
> > 
> > There is one issue here. True percpu interrupts, like the timer interrupts
> > on ARM(64), will access that in parallel. But that's not rocket science to
> > fix.
> 
> I was wondering about that from an efficiency point of view.  Since
> interrupts are generally targetted to a single CPU, there's no cacheline
> bouncing to speak of, except for interrupts like TLB shootdown on x86.
> It might make sense for the percpu interrupts to still sum them at read
> time, and not sum them at interrupt time.

Yes, for regular interrupts the stats are properly serialized and the patch
works just fine. For true percpu interrupts we just can avoid the update of
tot_count and sum them up as before. The special vectors on x86 are
accounted separately anyway and not part of the problem here. That
show_all_irqs() code only deals with device interrupts which are backed by
irq descriptors. TLB/IPI/.... are different beasts and handled low level in
the architecture code. Though ARM and some others have these interrupts as
regular Linux interrupt numbers. That's why we need to care.

Updated untested patch below.

Thanks,

	tglx

8<-------------

 fs/proc/stat.c          |   28 +++++++++++++++++++++++++---
 include/linux/irqdesc.h |    3 ++-
 kernel/irq/chip.c       |   12 ++++++++++--
 kernel/irq/internals.h  |    8 +++++++-
 kernel/irq/irqdesc.c    |    7 ++++++-
 5 files changed, 50 insertions(+), 8 deletions(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,6 +79,30 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
+static void show_irq_gap(struct seq_file *p, int gap)
+{
+	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
+
+	while (gap > 0) {
+		int inc = min_t(int, gap, ARRAY_SIZE(zeros) / 2);
+
+		seq_write(p, zeros, 2 * inc);
+		gap -= inc;
+	}
+}
+
+static void show_all_irqs(struct seq_file *p)
+{
+	int i, next = 0;
+
+	for_each_active_irq(i) {
+		show_irq_gap(p, i - next);
+		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
+		next = i + 1;
+	}
+	show_irq_gap(p, nr_irqs - next);
+}
+
 static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
@@ -156,9 +180,7 @@ static int show_stat(struct seq_file *p,
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
 
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+	show_all_irqs(p);
 
 	seq_printf(p,
 		"\nctxt %llu\n"
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -65,9 +65,10 @@ struct irq_desc {
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
 	unsigned int		wake_depth;	/* nested wake enables */
+	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
-	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
+	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	atomic_t		threads_handled;
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
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



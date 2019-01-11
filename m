Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77576C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535EB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfAKRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbfAKRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:23:30 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi0Wi-0005S4-NL; Fri, 11 Jan 2019 18:23:24 +0100
Date:   Fri, 11 Jan 2019 18:23:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
In-Reply-To: <1547061648-16080-5-git-send-email-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de>
References: <1547061648-16080-1-git-send-email-longman@redhat.com> <1547061648-16080-5-git-send-email-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Waiman Long wrote:
> ---
>  fs/proc/stat.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

and the total diffstat of that patch series is:

   4 files changed, 125 insertions(+), 12 deletions(-)

>  static void show_stat_irqs(struct seq_file *p)
> @@ -100,9 +119,74 @@ static void show_stat_irqs(struct seq_file *p)
>  	int i;
>  
>  	seq_put_decimal_ull(p, "intr ", compute_stat_irqs_sum());
> +
> +	if (IS_ENABLED(CONFIG_SMP) && (nr_cpu_ids >= 10) && (nr_irqs >= 256)) {
> +		/*
> +		 * On systems with 10 or more CPUs and 256 or more IRQs,
> +		 * we used a bitmap to keep track of the number of active
> +		 * IRQs and call kstat_irqs_usr() only for those IRQs.
> +		 * The bitmap will be refreshed whenever nr_active_irqs
> +		 * changes.
> +		 */
> +		extern atomic_t nr_active_irqs;
> +		static DEFINE_MUTEX(irqs_mutex);
> +		static int last_irq = -1;
> +		static int bitmap_size, active_irqs;
> +		static unsigned long *bitmap;
> +		int current_irqs = atomic_read(&nr_active_irqs);

This is completely overengineered. The simple patch below does not need
conditionals and atomics, is unconditional and completely avoids this
bitmap hackery.

On a VM with 144 VCPUs and nr_irqs=1576 and a loop of 5000 readouts of
/proc/stat (python):

  Before       	       After
  real	0m1.331s       0m0.728s	 -45.3%
  user	0m0.415s       0m0.359s  -13.5%
  sys	0m0.914s       0m0.356s  -61.1%

Hmm?

Thanks,

	tglx

8<------------------

 fs/proc/stat.c          |   28 +++++++++++++++++++++++++---
 include/linux/irqdesc.h |    3 ++-
 kernel/irq/internals.h  |    1 +
 kernel/irq/irqdesc.c    |    7 ++-----
 4 files changed, 30 insertions(+), 9 deletions(-)

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
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -246,6 +246,7 @@ static inline void kstat_incr_irqs_this_
 {
 	__this_cpu_inc(*desc->kstat_irqs);
 	__this_cpu_inc(kstat.irqs_sum);
+	desc->tot_count++;
 }
 
 static inline int irq_desc_get_node(struct irq_desc *desc)
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
@@ -919,14 +920,10 @@ unsigned int kstat_irqs_cpu(unsigned int
 unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	int cpu;
-	unsigned int sum = 0;
 
 	if (!desc || !desc->kstat_irqs)
 		return 0;
-	for_each_possible_cpu(cpu)
-		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
-	return sum;
+	return desc->tot_count;
 }
 
 /**



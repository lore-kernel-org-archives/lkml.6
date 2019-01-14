Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBEFC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfANTEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:04:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANTEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:04:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B0E03680B;
        Mon, 14 Jan 2019 19:04:20 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA1B819C7C;
        Mon, 14 Jan 2019 19:04:18 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1547061648-16080-1-git-send-email-longman@redhat.com>
 <1547061648-16080-5-git-send-email-longman@redhat.com>
 <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
 <20190111192357.GK6310@bombadil.infradead.org>
 <alpine.DEB.2.21.1901112146180.1661@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <3b863edf-1a3e-1436-93e7-717550c7256f@redhat.com>
Date:   Mon, 14 Jan 2019 14:04:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901112146180.1661@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 14 Jan 2019 19:04:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 04:02 PM, Thomas Gleixner wrote:
> On Fri, 11 Jan 2019, Matthew Wilcox wrote:
>> On Fri, Jan 11, 2019 at 08:19:33PM +0100, Thomas Gleixner wrote:
>>> On Fri, 11 Jan 2019, Thomas Gleixner wrote:
>>>> --- a/kernel/irq/internals.h
>>>> +++ b/kernel/irq/internals.h
>>>> @@ -246,6 +246,7 @@ static inline void kstat_incr_irqs_this_
>>>>  {
>>>>  	__this_cpu_inc(*desc->kstat_irqs);
>>>>  	__this_cpu_inc(kstat.irqs_sum);
>>>> +	desc->tot_count++;
>>> There is one issue here. True percpu interrupts, like the timer interrupts
>>> on ARM(64), will access that in parallel. But that's not rocket science to
>>> fix.
>> I was wondering about that from an efficiency point of view.  Since
>> interrupts are generally targetted to a single CPU, there's no cacheline
>> bouncing to speak of, except for interrupts like TLB shootdown on x86.
>> It might make sense for the percpu interrupts to still sum them at read
>> time, and not sum them at interrupt time.
> Yes, for regular interrupts the stats are properly serialized and the patch
> works just fine. For true percpu interrupts we just can avoid the update of
> tot_count and sum them up as before. The special vectors on x86 are
> accounted separately anyway and not part of the problem here. That
> show_all_irqs() code only deals with device interrupts which are backed by
> irq descriptors. TLB/IPI/.... are different beasts and handled low level in
> the architecture code. Though ARM and some others have these interrupts as
> regular Linux interrupt numbers. That's why we need to care.
>
> Updated untested patch below.
>
> Thanks,
>
> 	tglx
>
> 8<-------------
>
>  fs/proc/stat.c          |   28 +++++++++++++++++++++++++---
>  include/linux/irqdesc.h |    3 ++-
>  kernel/irq/chip.c       |   12 ++++++++++--
>  kernel/irq/internals.h  |    8 +++++++-
>  kernel/irq/irqdesc.c    |    7 ++++++-
>  5 files changed, 50 insertions(+), 8 deletions(-)
>
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -79,6 +79,30 @@ static u64 get_iowait_time(int cpu)
>  
>  #endif
>  
> +static void show_irq_gap(struct seq_file *p, int gap)
> +{
> +	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
> +
> +	while (gap > 0) {
> +		int inc = min_t(int, gap, ARRAY_SIZE(zeros) / 2);
> +
> +		seq_write(p, zeros, 2 * inc);
> +		gap -= inc;
> +	}
> +}
> +
> +static void show_all_irqs(struct seq_file *p)
> +{
> +	int i, next = 0;
> +
> +	for_each_active_irq(i) {
> +		show_irq_gap(p, i - next);
> +		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
> +		next = i + 1;
> +	}
> +	show_irq_gap(p, nr_irqs - next);
> +}
> +
>  static int show_stat(struct seq_file *p, void *v)
>  {
>  	int i, j;
> @@ -156,9 +180,7 @@ static int show_stat(struct seq_file *p,
>  	}
>  	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
>  
> -	/* sum again ? it could be updated? */
> -	for_each_irq_nr(j)
> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
> +	show_all_irqs(p);
>  
>  	seq_printf(p,
>  		"\nctxt %llu\n"
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -65,9 +65,10 @@ struct irq_desc {
>  	unsigned int		core_internal_state__do_not_mess_with_it;
>  	unsigned int		depth;		/* nested irq disables */
>  	unsigned int		wake_depth;	/* nested wake enables */
> +	unsigned int		tot_count;
>  	unsigned int		irq_count;	/* For detecting broken IRQs */
> -	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
>  	unsigned int		irqs_unhandled;
> +	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
>  	atomic_t		threads_handled;
>  	int			threads_handled_last;
>  	raw_spinlock_t		lock;
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -855,7 +855,11 @@ void handle_percpu_irq(struct irq_desc *
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> -	kstat_incr_irqs_this_cpu(desc);
> +	/*
> +	 * PER CPU interrupts are not serialized. Do not touch
> +	 * desc->tot_count.
> +	 */
> +	__kstat_incr_irqs_this_cpu(desc);
>  
>  	if (chip->irq_ack)
>  		chip->irq_ack(&desc->irq_data);
> @@ -884,7 +888,11 @@ void handle_percpu_devid_irq(struct irq_
>  	unsigned int irq = irq_desc_get_irq(desc);
>  	irqreturn_t res;
>  
> -	kstat_incr_irqs_this_cpu(desc);
> +	/*
> +	 * PER CPU interrupts are not serialized. Do not touch
> +	 * desc->tot_count.
> +	 */
> +	__kstat_incr_irqs_this_cpu(desc);
>  
>  	if (chip->irq_ack)
>  		chip->irq_ack(&desc->irq_data);
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -242,12 +242,18 @@ static inline void irq_state_set_masked(
>  
>  #undef __irqd_to_state
>  
> -static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
> +static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
>  {
>  	__this_cpu_inc(*desc->kstat_irqs);
>  	__this_cpu_inc(kstat.irqs_sum);
>  }
>  
> +static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
> +{
> +	__kstat_incr_irqs_this_cpu(desc);
> +	desc->tot_count++;
> +}
> +
>  static inline int irq_desc_get_node(struct irq_desc *desc)
>  {
>  	return irq_common_data_get_node(&desc->irq_common_data);
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -119,6 +119,7 @@ static void desc_set_defaults(unsigned i
>  	desc->depth = 1;
>  	desc->irq_count = 0;
>  	desc->irqs_unhandled = 0;
> +	desc->tot_count = 0;
>  	desc->name = NULL;
>  	desc->owner = owner;
>  	for_each_possible_cpu(cpu)
> @@ -919,11 +920,15 @@ unsigned int kstat_irqs_cpu(unsigned int
>  unsigned int kstat_irqs(unsigned int irq)
>  {
>  	struct irq_desc *desc = irq_to_desc(irq);
> -	int cpu;
>  	unsigned int sum = 0;
> +	int cpu;
>  
>  	if (!desc || !desc->kstat_irqs)
>  		return 0;
> +	if (!irq_settings_is_per_cpu_devid(desc) &&
> +	    !irq_settings_is_per_cpu(desc))
> +	    return desc->tot_count;
> +
>  	for_each_possible_cpu(cpu)
>  		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
>  	return sum;
>
>
That looks good to me. Thanks for providing a more simple solution.

BTW, if the percpu IRQ is known at allocation time, maybe we should just
not allocate a percpu count for the corresponding descriptor.

Cheers,
Longman



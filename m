Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeDZUYN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:24:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDZUYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:24:12 -0400
Date: Thu, 26 Apr 2018 22:24:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/irq/proc: /proc/interrupts irq-off latency
 reduction
In-Reply-To: <20180405115313.29821-1-npiggin@gmail.com>
Message-ID: <alpine.DEB.2.21.1804262216130.1596@nanos.tec.linutronix.de>
References: <20180405115313.29821-1-npiggin@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018, Nicholas Piggin wrote:
> Reading /proc/interrupts shows up as a latency source of several
> hundred microseconds on a 2 socket 176 thread system, because it
> iterates twice over all CPUs under an irq lock pulling in remote
> cachelines, doing lots of seq_printf, etc.
> 
> On a 16 socket system with higher latencies to remote cachelines,
> latencies around 10ms would be seen here. irqbalanced periodically
> reads this file, and the latency spikes are noticed on smaller
> systems. Also the file is unprivileged, so it's important to reduce
> this latency.
> 
> Avoid holding the lock while iterating over CPUs to get their stats.
> The desc should be protected with irq_lock_sparse().

s/should/_IS_/

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/irq/proc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index e8f374971e37..bbc4004b74bc 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -544,17 +544,22 @@ int show_interrupts(struct seq_file *p, void *v)
>  	if (!desc)
>  		goto outsparse;
>  
> -	raw_spin_lock_irqsave(&desc->lock, flags);
>  	for_each_online_cpu(j)
>  		any_count |= kstat_irqs_cpu(i, j);
> +
>  	action = desc->action;

This is a bad idea. The action can vanish between here and the code further
below which derefences it.

You need to take desc->request_mutex for protection. That serializes
against concurrent request/free_irq().

> -	if ((!action || irq_desc_is_chained(desc)) && !any_count)
> -		goto out;
> +	if (!any_count) {
> +		raw_spin_lock_irqsave(&desc->lock, flags);
> +		if (!action || irq_desc_is_chained(desc))
> +			goto out;
> +		raw_spin_unlock_irqrestore(&desc->lock, flags);
> +	}
>  
>  	seq_printf(p, "%*d: ", prec, i);
>  	for_each_online_cpu(j)
>  		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
>  
> +	raw_spin_lock_irqsave(&desc->lock, flags);
>  	if (desc->irq_data.chip) {
>  		if (desc->irq_data.chip->irq_print_chip)
>  			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);

And if you hold request_mutex you can drop the spinlock right before
printing desc->name.

Thanks,

	tglx

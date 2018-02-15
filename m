Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163667AbeBOUHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162820AbeBOUHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:07:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DBF217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Feb 2018 15:07:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180215150707.49cc2332@gandalf.local.home>
In-Reply-To: <20180215172042.31573-2-bigeasy@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
        <20180215172042.31573-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 18:20:41 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> -void __tasklet_schedule(struct tasklet_struct *t)
> +static void __tasklet_schedule_common(struct tasklet_struct *t,
> +				      struct tasklet_head *head,
> +				      unsigned int softirq_nr)
>  {
>  	unsigned long flags;
>  
>  	local_irq_save(flags);

If you look at the original patch, it did not move local_irq_save()
into the common function.

>  	t->next = NULL;
> -	*__this_cpu_read(tasklet_vec.tail) = t;
> -	__this_cpu_write(tasklet_vec.tail, &(t->next));
> -	raise_softirq_irqoff(TASKLET_SOFTIRQ);
> +	*head->tail = t;
> +	head->tail = &(t->next);
> +	raise_softirq_irqoff(softirq_nr);
>  	local_irq_restore(flags);
>  }
> +
> +void __tasklet_schedule(struct tasklet_struct *t)
> +{
> +	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),

What can happen is, we reference (tasklet_vec) on one CPU, get
preempted (running in ksoftirqd), scheduled on another CPU, then when
inside the common code, we are executing on a different CPU than the
tasklet is for. The rasise_softirq() is happening on the wrong CPU.

The local_irq_save() can't be moved to the common function. It must be
done by each individual function.

-- Steve


> +				  TASKLET_SOFTIRQ);
> +}
>  EXPORT_SYMBOL(__tasklet_schedule);

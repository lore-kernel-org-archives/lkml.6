Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165006AbeBOUI0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164595AbeBOUIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:08:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2B5217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Feb 2018 15:08:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] kernel/sofirq: consolidate common code in
 tasklet_action() + tasklet_hi_action()
Message-ID: <20180215150822.5021eb05@gandalf.local.home>
In-Reply-To: <20180215172042.31573-3-bigeasy@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
        <20180215172042.31573-3-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 18:20:42 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> tasklet_action() + tasklet_hi_action() are almost identical.
> Move the common code from both function into __tasklet_schedule_common()
> and let both functions invoke it with different arguments.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: splitted out from RT's "tasklet: Prevent tasklets from going
> into infinite spin in RT" and added commit message]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/softirq.c | 54 +++++++++++++++---------------------------------------
>  1 file changed, 15 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 145cf6a2e7c9..fa7ed89a9fcf 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -488,14 +488,16 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
>  }
>  EXPORT_SYMBOL(__tasklet_hi_schedule);
>  
> -static __latent_entropy void tasklet_action(struct softirq_action *a)
> +static void tasklet_action_common(struct softirq_action *a,
> +				  struct tasklet_head *tl_head,
> +				  unsigned int softirq_nr)
>  {
>  	struct tasklet_struct *list;
>  
>  	local_irq_disable();

Same issues with this code.

-- Steve

> -	list = __this_cpu_read(tasklet_vec.head);
> -	__this_cpu_write(tasklet_vec.head, NULL);
> -	__this_cpu_write(tasklet_vec.tail, this_cpu_ptr(&tasklet_vec.head));
> +	list = tl_head->head;
> +	tl_head->head = NULL;
> +	tl_head->tail = &tl_head->head;
>  	local_irq_enable();
>  
>

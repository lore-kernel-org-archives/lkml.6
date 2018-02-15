Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756233AbeBOWbZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:31:25 -0500
Received: from eso.teric.us ([69.164.192.171]:60378 "EHLO eso.teric.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756203AbeBOWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:31:23 -0500
Date: Thu, 15 Feb 2018 16:31:23 -0600
From: Julia Cartwright <juliac@eso.teric.us>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180215223123.GB1924@kryptos.localdomain>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
 <20180215172042.31573-2-bigeasy@linutronix.de>
 <20180215150707.49cc2332@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215150707.49cc2332@gandalf.local.home>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:07:07PM -0500, Steven Rostedt wrote:
> On Thu, 15 Feb 2018 18:20:41 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > -void __tasklet_schedule(struct tasklet_struct *t)
> > +static void __tasklet_schedule_common(struct tasklet_struct *t,
> > +				      struct tasklet_head *head,
> > +				      unsigned int softirq_nr)
> >  {
> >  	unsigned long flags;
> >  
> >  	local_irq_save(flags);
> 
> If you look at the original patch, it did not move local_irq_save()
> into the common function.
> 
> >  	t->next = NULL;
> > -	*__this_cpu_read(tasklet_vec.tail) = t;
> > -	__this_cpu_write(tasklet_vec.tail, &(t->next));
> > -	raise_softirq_irqoff(TASKLET_SOFTIRQ);
> > +	*head->tail = t;
> > +	head->tail = &(t->next);
> > +	raise_softirq_irqoff(softirq_nr);
> >  	local_irq_restore(flags);
> >  }
> > +
> > +void __tasklet_schedule(struct tasklet_struct *t)
> > +{
> > +	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),
> 
> What can happen is, we reference (tasklet_vec) on one CPU, get
> preempted (running in ksoftirqd), scheduled on another CPU, then when
> inside the common code, we are executing on a different CPU than the
> tasklet is for. The rasise_softirq() is happening on the wrong CPU.
> 
> The local_irq_save() can't be moved to the common function. It must be
> done by each individual function.

Well, it can be, but the percpu access needs to go with it; so an
alternative solution would be the below.

I'm also wondering whether the t->next = NULL assignment could be lifted
out from irqs-disabled region.

   Julia

diff --git a/kernel/softirq.c b/kernel/softirq.c
index fa7ed89a9fcf..177de3640c78 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -461,12 +461,14 @@ static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec);
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec);
 
 static void __tasklet_schedule_common(struct tasklet_struct *t,
-				      struct tasklet_head *head,
+				      struct tasklet_head __percpu *headp,
 				      unsigned int softirq_nr)
 {
+	struct tasklet_head *head;
 	unsigned long flags;
 
 	local_irq_save(flags);
+	head = this_cpu_ptr(headp);
 	t->next = NULL;
 	*head->tail = t;
 	head->tail = &(t->next);
@@ -476,14 +478,14 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
-	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),
+	__tasklet_schedule_common(t, &tasklet_vec,
 				  TASKLET_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_schedule);
 
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
-	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_hi_vec),
+	__tasklet_schedule_common(t, &tasklet_hi_vec,
 				  HI_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);

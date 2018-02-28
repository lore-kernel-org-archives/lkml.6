Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935629AbeB1XM5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935525AbeB1XM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:12:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D847214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 28 Feb 2018 18:12:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Message-ID: <20180228181252.55e0590c@vmware.local.home>
In-Reply-To: <20180227153646.GD3777@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
        <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180224151240.0d63a059@vmware.local.home>
        <20180225174927.GC2855@linux.vnet.ibm.com>
        <20180225181730.GA3963@linux.vnet.ibm.com>
        <20180225183944.GA8840@linux.vnet.ibm.com>
        <20180226212920.43e25d6e@vmware.local.home>
        <20180227153646.GD3777@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 07:36:46 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> > >   */
> > >  #ifndef CONFIG_PREEMPT
> > >  extern int _cond_resched(void);
> > > +#elif defined(CONFIG_TASKS_RCU)
> > > +static inline int _cond_resched(void)
> > > +{
> > > +	rcu_note_voluntary_context_switch(current);
> > > +	return 0;
> > > +}
> > >  #else
> > >  static inline int _cond_resched(void) { return 0; }
> > >  #endif  
> > 
> > 
> > This does work, but so does the below, without causing cond_resched()
> > from being something other than a nop of CONFIG_PREEMPT.  
> 
> True, but based on the cond_resched_rcu_qs() experience, I bet that
> trace_benchmark.c won't be the only place needing help.

Perhaps, still think this is a special case. That said, perhaps
cond_resched isn't done in critical locations as it's a place that is
explicitly stating that it's OK to schedule.

-- Steve

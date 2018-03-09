Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeCIO61 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:58:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeCIO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:58:25 -0500
Date: Fri, 9 Mar 2018 15:58:20 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Corey Minyard <cminyard@mvista.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180309145819.af2546nfa4z6qqxm@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <08aa9f8a-afe5-e1d3-5301-d196beb665b5@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <08aa9f8a-afe5-e1d3-5301-d196beb665b5@mvista.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-09 07:29:31 [-0600], Corey Minyard wrote:
> From what I can tell, wake_up_q() is unbounded, and you have undone what
> the previous code had tried to accomplish.  In the scenario I'm talking
> about,
> interrupts are still disabled here.  That's why I was asking about where to
> put
> wake_up_q(), I knew you could put it here, but it didn't seem to me to help
> at all.

So you are worried about unbound latencies on !RT. Okay. So for !RT this
does not help but it is not worse then before (before the RT patch was
applied and changed things). 
In fact it is better now (with RT patch and this one) because before
that patch you would not only open interrupts between the wake up but you
would leave the function with interrupts open which is wrong. Any
interrupt (or a context switch due to need-resched() that would invoke
percpu_ref_put() would freeze the CPU/system.
Also, every user that invoked swake_up_all() with enabled interrupts
will still perform the wake up with enabled interrupts. So nothing
changes here.

> > > I had another idea.  This is only occurring if RT is not enabled, because
> > > with
> > > RT all the irq disable things go away and you are generally running in task
> > > context.  So why not have a different version of swake_up_all() for non-RT
> > > that does work from irqs-off context?
> > With the patch above I have puzzle part which would allow to use swait
> > based completions upstream. That ifdef would probably not help.
> 
> I agree that having a bounded time way to wake up a bunch of threads while
> interrupts are disabled would solve a bunch of issues.  I just don't see how
> it
> can be done without pushing it off to a softirq or workqueue.

true but this is a different story. We started with a WARN_ON() which
triggered correctly and the problem it pointed to looks solved to me.

This "unbounded runtime during the wake up of many tasks with interrupts
disabled via percpu_ref_kill() -> blk_queue_usage_counter_release()"
thing exists already in the vanilla kernel and does not exist
with the RT patch applied and RT enabled. If you are affected by this
and you don't like it - fine. Using a workqueue is one way of getting
around it (the softirq is not preemptible in !RT so it wouldn't change
much). However, I see no benefit in carrying such a patch because as I
said only !RT is affected by this.

> -corey

Sebastian
